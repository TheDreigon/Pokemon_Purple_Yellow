#!/usr/bin/env python3
"""Build, apply or check a BPS patch (the BPS1 format that RomPatcher.js and Floating IPS read), with the Python
standard library only. The release patch turns the retail English Pokemon Yellow into pokeyellow.gbc:

    make bps BASEROM=path/to/the/retail/rom.gbc          (runs `create` below with --base-sha1)

    python3 tools/make_bps.py create [--base-sha1 SHA1] BASE TARGET PATCH
        encode PATCH from BASE to TARGET, decode it again with the decoder below and compare the result with TARGET
        byte for byte; PATCH is written only when that round trip holds. --base-sha1 refuses any other BASE first.
    python3 tools/make_bps.py apply PATCH BASE OUT
        decode PATCH onto BASE and write OUT; refuses a PATCH or a BASE whose size or CRC32 is not the patch's.
    python3 tools/make_bps.py verify PATCH BASE TARGET
        decode PATCH onto BASE and compare the result with TARGET byte for byte; writes nothing.

The format: "BPS1", the source size, the target size and the metadata size (0 here) as variable-length numbers, the
actions (SourceRead, TargetRead, SourceCopy, TargetCopy), then the CRC32s of the source, the target and the patch.
The encoder is greedy: at each target position it takes the longest match among the same offset of the source, the
source positions and the earlier target positions that share the next 8 bytes, else one literal byte. It has no
randomness: the same BASE and TARGET always give the same PATCH."""
import hashlib
import os
import sys
import zlib

KEY = 8          # bytes hashed to find a match
CAP = 8          # positions kept per hash: the first 8 of the source, the last 8 of the target


def crc32(b):
    return zlib.crc32(b) & 0xFFFFFFFF


def put_num(out, n):
    while True:
        x = n & 0x7F
        n >>= 7
        if n == 0:
            out.append(0x80 | x)
            return
        out.append(x)
        n -= 1


def num_size(n):
    size = 1
    while True:
        n >>= 7
        if n == 0:
            return size
        n -= 1
        size += 1


def put_offset(out, n):
    put_num(out, (abs(n) << 1) | (1 if n < 0 else 0))


def offset_size(n):
    return num_size((abs(n) << 1) | (1 if n < 0 else 0))


def common(a, ai, b, bi, limit, known=0):
    """the length of the common prefix of a[ai:] and b[bi:], at most limit; the first `known` bytes are equal"""
    n = known
    step = 32
    while n < limit:
        m = min(step, limit - n)
        if a[ai + n:ai + n + m] == b[bi + n:bi + n + m]:
            n += m
            step *= 2
            continue
        lo, hi = 0, m
        while hi - lo > 1:
            mid = (lo + hi) // 2
            if a[ai + n + lo:ai + n + mid] == b[bi + n + lo:bi + n + mid]:
                lo = mid
            else:
                hi = mid
        return n + lo
    return limit


def encode(src, tgt):
    """the BPS1 patch from src to tgt (bytes)"""
    sv, tv = memoryview(src), memoryview(tgt)
    ssize, tsize = len(src), len(tgt)
    sindex = {}
    for i in range(ssize - KEY + 1):
        lst = sindex.setdefault(src[i:i + KEY], [])
        if len(lst) < CAP:
            lst.append(i)
    tindex = {}
    out = bytearray(b'BPS1')
    put_num(out, ssize)
    put_num(out, tsize)
    put_num(out, 0)
    srel = trel = 0
    literal = -1
    t = 0

    def seen(i):
        if i + KEY <= tsize:
            lst = tindex.setdefault(tgt[i:i + KEY], [])
            lst.append(i)
            if len(lst) > CAP:
                del lst[0]

    def flush(upto):
        nonlocal literal
        if literal >= 0:
            put_num(out, ((upto - literal - 1) << 2) | 1)
            out.extend(tgt[literal:upto])
            literal = -1

    while t < tsize:
        gain, best = 0, None
        if t < ssize and sv[t] == tv[t]:
            n = common(sv, t, tv, t, min(ssize, tsize) - t)
            g = n - num_size((n - 1) << 2)
            if n >= 4 and g > gain:
                gain, best = g, (0, n, t)
        if t + KEY <= tsize:
            key = tgt[t:t + KEY]
            cands = list(sindex.get(key, ()))
            if srel < ssize and srel not in cands and src[srel:srel + KEY] == key:
                cands.append(srel)
            for p in cands:
                n = common(sv, p, tv, t, min(ssize - p, tsize - t), KEY)
                g = n - num_size((n - 1) << 2) - offset_size(p - srel)
                if g > gain:
                    gain, best = g, (2, n, p)
            for p in tindex.get(key, ()):
                n = common(tv, p, tv, t, tsize - t, KEY)
                g = n - num_size((n - 1) << 2) - offset_size(p - trel)
                if g > gain:
                    gain, best = g, (3, n, p)
        if best is not None and gain >= 3:
            flush(t)
            kind, n, p = best
            put_num(out, ((n - 1) << 2) | kind)
            if kind == 2:
                put_offset(out, p - srel)
                srel = p + n
            elif kind == 3:
                put_offset(out, p - trel)
                trel = p + n
            for i in range(t, t + n):
                seen(i)
            t += n
        else:
            if literal < 0:
                literal = t
            seen(t)
            t += 1
    flush(tsize)
    out += crc32(src).to_bytes(4, 'little') + crc32(tgt).to_bytes(4, 'little')
    out += crc32(bytes(out)).to_bytes(4, 'little')
    return bytes(out)


class PatchError(Exception):
    pass


def decode(patch, src):
    """the target of a BPS1 patch applied to src; PatchError on a bad patch, a wrong source or a wrong result"""
    if len(patch) < 19 or patch[:4] != b'BPS1':
        raise PatchError('not a BPS1 patch')
    if crc32(patch[:-4]) != int.from_bytes(patch[-4:], 'little'):
        raise PatchError('the patch is damaged (its CRC32 does not match)')
    pos = 4

    def num():
        nonlocal pos
        data, shift = 0, 1
        while True:
            if pos >= len(patch) - 12:
                raise PatchError('the patch ends inside a number')
            x = patch[pos]
            pos += 1
            data += (x & 0x7F) * shift
            if x & 0x80:
                return data
            shift <<= 7
            data += shift

    ssize, tsize, msize = num(), num(), num()
    if ssize != len(src) or crc32(src) != int.from_bytes(patch[-12:-8], 'little'):
        raise PatchError('wrong base file: the patch expects %d bytes with CRC32 %08x, this one has %d bytes with '
                         'CRC32 %08x' % (ssize, int.from_bytes(patch[-12:-8], 'little'), len(src), crc32(src)))
    pos += msize
    out = bytearray()
    srel = trel = 0
    end = len(patch) - 12
    while pos < end:
        d = num()
        action, length = d & 3, (d >> 2) + 1
        if len(out) + length > tsize:
            raise PatchError('an action writes past the target size')
        if action == 0:
            out += src[len(out):len(out) + length]
        elif action == 1:
            out += patch[pos:pos + length]
            pos += length
        elif action == 2:
            d = num()
            srel += -(d >> 1) if d & 1 else d >> 1
            if srel < 0 or srel + length > len(src):
                raise PatchError('a source copy reads outside the base')
            out += src[srel:srel + length]
            srel += length
        else:
            d = num()
            trel += -(d >> 1) if d & 1 else d >> 1
            if trel < 0 or trel >= len(out):
                raise PatchError('a target copy reads outside what was written')
            for _ in range(length):
                out.append(out[trel])
                trel += 1
    if len(out) != tsize:
        raise PatchError('the result has %d bytes, the patch says %d' % (len(out), tsize))
    if crc32(out) != int.from_bytes(patch[-8:-4], 'little'):
        raise PatchError('the result has CRC32 %08x, the patch says %08x' % (crc32(out),
                                                                            int.from_bytes(patch[-8:-4], 'little')))
    return bytes(out)


def read(path):
    try:
        with open(path, 'rb') as fh:
            return fh.read()
    except OSError as e:
        raise PatchError('%s: %s' % (path, e.strerror or e))


def write(path, data):
    """write via a temporary file, so a failed run never leaves a partial file at path"""
    tmp = path + '.tmp'
    with open(tmp, 'wb') as fh:
        fh.write(data)
    os.replace(tmp, path)


def describe(name, data):
    return '%-7s %9d bytes  CRC32 %08x  SHA-1 %s' % (name, len(data), crc32(data), hashlib.sha1(data).hexdigest())


def main(argv):
    args = list(argv)
    sha1 = None
    if len(args) > 2 and args[0] == 'create' and args[1] == '--base-sha1':
        sha1 = args[2].lower()
        del args[1:3]
    if len(args) != 4 or args[0] not in ('create', 'apply', 'verify'):
        print(__doc__, file=sys.stderr)
        return 2
    mode = args[0]
    try:
        if mode == 'create':
            base, target = read(args[1]), read(args[2])
            if sha1 is not None and hashlib.sha1(base).hexdigest() != sha1:
                raise PatchError('%s has SHA-1 %s, not %s: the patch is built from the retail English Pokemon '
                                 'Yellow (USA, Europe)' % (args[1], hashlib.sha1(base).hexdigest(), sha1))
            patch = encode(base, target)
            if decode(patch, base) != target:
                raise PatchError('the patch does not decode back to %s' % args[2])
            write(args[3], patch)
            print(describe('base', base))
            print(describe('target', target))
            print(describe('patch', patch))
            print('%s: decodes back to %s byte for byte' % (args[3], args[2]))
        elif mode == 'apply':
            out = decode(read(args[1]), read(args[2]))
            write(args[3], out)
            print(describe('result', out))
        else:
            out = decode(read(args[1]), read(args[2]))
            target = read(args[3])
            if out != target:
                raise PatchError('%s applied to %s is not %s' % (args[1], args[2], args[3]))
            print(describe('result', out))
            print('%s applied to %s gives %s byte for byte' % (args[1], args[2], args[3]))
    except PatchError as e:
        print('make_bps.py: %s' % e, file=sys.stderr)
        return 1
    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
