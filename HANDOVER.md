# HANDOVER — Pokémon Purple Yellow v0.7

**Para o novo Claude que abrir este projeto.** Lê isto primeiro antes de fazer qualquer coisa.

## Quick-start
1. Working dir: `D:\Games\More Games\Pokemon\Pokemon Romhacks\Mine\Pokemon_Purple_Yellow`
2. Branch: **`dev-claude-work`** (NÃO `master` nem `dev` — tagging só quando v0.7 fechar)
3. Last commit: vê `git log` (handover original era `22739ad`; a auditoria de 2026-06-12 acrescentou uma wave de bugfixes — vê secção "Auditoria 2026-06-12" abaixo)
4. Build: `wsl bash -c 'cd "/mnt/d/Games/More Games/Pokemon/Pokemon Romhacks/Mine/Pokemon_Purple_Yellow" && make 2>&1 | tail -3'`
5. Confirma build verde antes de qualquer trabalho.

## O que é o projeto

Romhack de Pokémon Yellow em pokeyellow disassembly (RGBDS / GameBoy Z80 assembly). **Pokemon Purple Yellow**. Forte (Miguel) é o owner. Designer-led, opinionated, "realismo zoológico > balanceamento estrito".

Sessão de trabalho dura há ~6 meses, ~750 commits, branches `dev-claude-work`. Múltiplos refactors massivos completos.

## Versão actual

| Versão | Tema | Status |
|--------|------|--------|
| v0.5 | Move overhaul + TM rework + mart tiering | **DONE** |
| v0.6 | Per-mon learnset rebuild + calibration | **DONE** |
| v0.7 | "Difficulty Tuning" — engine fixes, Hard mode, anim review, **movepool Pass 3** | **IN PROGRESS** |

## Status v0.7 (o que falta)

### ✅ Done
- Todos os engine bugfixes (badge boost, burn/para compound, type-status immunity, AI infinite PP, paralysis /4→/2, freeze 3-6 turns, crit formula, etc.)
- 10 novos move effects (TRI_STATUS, CONFUSION_SIDE_EFFECT3, SPECIAL_UP1_HEAL, etc.)
- Hard mode infrastructure + 8/10 knobs (#1, #2, #5, #8, #10, #11, #12, #15)
- Type matchups overhaul (188 entries, 14 types)
- Move animations rework (~150/220 com mental images + comments)
- Bank reorganization (bank $1E 8× more headroom)
- ANIM TEST debug feature
- Pokedex-order refactor + Missingno consolidation
- 128/151 Pokemon Pass 3 movepool reviewed e finalizados
- GLARE removed + ROLLOUT added (recente)

### ⏳ Pending
1. **23 Pokemon Pass 3 reviews** — Forte ainda tem que rever (lista abaixo)
2. **TM/HM catchup (~18 mons)** — o batch `906988e` (Meowth/Persian, Psyduck/Golduck, Poliwag-line, Slowpoke/Slowbro, Magnemite/Magneton, Seel/Dewgong, Shellder/Cloyster, Gastly/Haunter/Gengar) tem levels feitos mas `tm_from_learnset.py`/`add_fun_moves.py` nunca correram → tmhm vazio. **EM ESPERA por decisão do Forte** (2026-06-12: "este capítulo dos movesets e tms vemos a seguir").
3. **Hard mode knobs #13 + #14** — boss screens + per-boss quirks
4. **Animation review batch 2** — Forte feedback POISON+PSYCHIC+ROCK+STEEL+WATER+BIRD post-Hyper-Fang
5. **Balance calibration** — quando tudo estiver feito, playthrough completo

### 23 Pokemon que faltam reviewar (grep marker)

```bash
grep -nE 'TODO: review moveset' data/pokemon/evos_moves.asm
```

Lista (23): Krabby, Kingler, Voltorb, Electrode, Kangaskhan, Tauros, Snorlax, Horsea, Seadra, Goldeen, Seaking, Staryu, Starmie, Scyther, Pinsir, Lapras, Ditto, Porygon, Articuno, Zapdos, Moltres, Mewtwo, Mew.

(Quando Forte editar mais, ele remove o `; TODO` da label — confirma sempre a contagem com o grep, não confies em números escritos.)

## Workflow Pass 3 (como funciona)

Para CADA família:
1. **Forte edita** o ficheiro `data/pokemon/evos_moves.asm` directamente — escolhe moves + ordem
2. **Claude** corre `.claude/assign_levels_v2.py` para atribuir níveis ascendentes monotónicos (mantém Forte's order, ajusta apenas LEVEL number)
3. **Claude** corre `.claude/tm_from_learnset.py` para derivar TMs auto do learnset + bonus anatomy + HMs
4. **Claude** corre `.claude/add_fun_moves.py` se for last-stage (adiciona MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME ao tmhm)
5. Build + commit

**Regra crítica de Forte (não esquecer!)**: 
> "Eu escolhi os moves E A ORDEM deles. Não mexas no file-order. Apenas atribui levels."

Se editares o file-order de Forte, ele queixa-se (já aconteceu, vê commit history). **Só corrige levels.**

**Outra regra crítica (anatomy gate)**:
> Para shared backbone moves (presentes em pre-evo E apex): MESMO nível em ambos. Apex-exclusives ficam em níveis separados (acrescem).

Isto está implementado em `assign_levels_v2.py` — apex calcula primeiro, pre-evo usa apex's level para moves comuns.

## Helper scripts (em `.claude/`, gitignored — sobrevivem mas não vão para git)

- **`assign_levels_v2.py`** — para CADA chain (pre-evo → apex), calcula apex levels com EVO LVL anchors auto-detectados, depois copia mesmo nível para shared moves no pre-evo. Pre/post-anchor distribuição uniforme. max_level: 60 normal, 65 para apex com anchor alto. **Tem CHAINS list dentro — adiciona novas chains quando reviewares novos mons.**
- **`tm_from_learnset.py`** — lê o learnset actual de cada mon, extrai moves que SÃO TMs (per item_constants.asm), adiciona bonus anatomy TMs (dict per-mon) + HMs (per-mon) + 4 fun moves se last-stage. Escreve o tmhm field em base_stats. **Tem dict MONS dentro com per-mon config.**
- **`add_fun_moves.py`** — adiciona MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME ao tmhm de last-stage Pass-3-reviewed mons. **Tem LAST_STAGE_FILES list dentro.**
- **`batch_final_pass3.py`** — initial drafts para os 41 mons restantes do Pass 3 (Forte's edits substituíram a maioria).
- **`assign_levels_chained.py`** — versão antiga do v2, mantida para referência.
- **`sort_levelups.py`** — versão antiga que reordenava file-order (Forte rejeitou — não usar).

## Ficheiros de spec do Forte (anexar à conversa)

Em `D:\Games\More Games\Pokemon\Pokemon Romhacks\Mine\Pokemon_Purple_Yellow - Notes\`:

- **`CHANGELIST.md`** — sumário completo de tudo o que mudou vs vanilla Yellow (engine fixes, Hard mode, mechanics, QoL, design framework, tooling)
- **`Movelist - after.asm`** — todas as 220 moves com effects/power/type/acc/PP
- **`TMs_HMs_before-after.txt`** — TM mapping completo + mart inventories
- **`Type matchups Pokemon Purple Yellow.asm`** — chart de tipos completo (188 entries)
- **`Poke Marts - before-after.txt`** — tier system + prices
- **`types_evolutions_stats.asm`** — per-Pokemon: type changes, evo levels/methods, BST changes, EXP curves
- **`Changes - Purple Yellow.asm`** — sprites, palettes, hidden items, future Pokemon ideas

**Para o novo chat: anexa todos estes via `@<path>` no primeiro prompt.**

## Memory files (auto-loaded se project dir for o mesmo)

Em `C:\Users\MiguelForte\.claude\projects\D--Games-More-Games-Pokemon-Pokemon-Romhacks-Mine-Pokemon-Purple-Yellow\memory\`:

- `MEMORY.md` — index file, lê primeiro
- `user_forte.md` — perfil de Forte: senior Java dev, 29, PT, "tu" informal, feedback direto, amador em ROM asm
- `project_overview.md` — overview do hack
- `project_release_plan.md` — v0.0→v1.0 roadmap
- `project_git_strategy.md` — master tagged only; dev integra; feature/* branches
- `reference_movepool_pattern.md` — **importante** — Forte's framework completo para Pass 3 reviews (anatomy rules, powder table, signature ownership, sister-line balance, HM lists, TM rule)
- `session_v05_progress.md` — v0.5 completo
- `session_v07_progress.md` — v0.7 atual em progresso
- `reference_hack_specifics.md` — mods já feitos (Smith/PureRGB/Shin), AI, constantes
- Outros files para referência específica

Estes files são AUTO-LOADED no novo chat (Claude Code lê automaticamente o memory folder do projeto). **NÃO precisas de anexar.**

## Auditoria 2026-06-12 (nova instância — onboarding audit)

Workflow de 18 agentes validou o CHANGELIST contra o código e reviu os 198 commits. Detalhes completos no memory file `session_onboarding_audit.md`. Resumo do que foi corrigido em código:

1. **Moves table desalinhada** — 7 move IDs entregavam dados de outro move em jogo (FAIRY: Moonblast/Lovely Kiss/Sing rodados; FIGHTING: Comet Punch↔Low Kick; GAS: Poison Gas↔Haze). Fix: constants+names+animations+sfx reordenados para a ordem do spec.
2. **Boss item bags nunca carregavam** (knob #10 morto) — farcall corria antes de `wIsInBattle=2`; movido para depois.
3. **UndoBurnParStats ×4 speed** — cura de paralisia pela AI deixava o mon a 2× speed real; agora duplica 1×.
4. **Toxic/PoisonPowder/Poison Gas envenenavam Steel-types** — STEEL check adicionado ao PoisonEffect.
5. **Will-O-Wisp/Ignite queimavam Magma-types** — MAGMA check adicionado ao BurnEffect.
6. **Badge boost perdia-se após level-up mid-battle** — experience.asm agora espelha LoadBattleMonFromParty.
7. **CheckStatusImmunity da AI** alinhado com o engine (FIRE/MAGMA, POISON/STEEL, ELECTRIC-para).
8. **OUTRAGE/HYPER_BEAM/MIND_BREAK** adicionados à HighCriticalMoves (spec marcava-os high-crit).
9. **Fresh Water vending 200→250** implementado (estava só no spec).
10. **Tiered mart overflow** (wMartExtras 12→13; Indigo elite tier nunca aparecia) — fix da sessão paralela validado e commitado.
11. Em-dashes fora do charmap em diálogos Blaine/Brock → `-`.
12. **Vending machine**: o gate de dinheiro era um Y200 hardcoded (vanilla) — Soda/Lemonade podiam ser "compradas" com menos dinheiro e o BCD clampava a carteira a Y0. Agora verifica o preço real da bebida seleccionada.

### Mind Break: RESOLVIDO (2026-06-12, decisão do Forte)
Era um Thunder Wave disfarçado (`PARALYZE_EFFECT` está em `ResidualEffects1` → engine saltava o damage calc). Forte decidiu: novo `PARALYZE_SIDE_EFFECT3` ($60, 45%, heaviest tier do ladder 15/30/45) atribuído ao MIND_BREAK — agora é um move de dano 125 BP / 90 acc / high-crit com 45% de paralisia. Na mesma decisão: POISON tiers 20/40/60 → **15/30/45**, CONFUSION tier 3 50% → **45%**, TRI_STATUS 33% → **30%** total (~10% cada).

### Gunk Shot: RESOLVIDO (2026-06-12, decisão do Forte)
Tinha a mesma doença do Mind Break (`POISON_EFFECT` em ResidualEffects1 = status puro). Forte decidiu: GUNK_SHOT → `POISON_SIDE_EFFECT2` (30% poison, lógica zoológica: lodo atirado envenena por contacto, menos certo que presas que injectam) + accuracy 80→85 (em linha com Fire Blast/Blizzard/Thunder a 115/85). Na mesma decisão, SLUDGE desceu para `POISON_SIDE_EFFECT1` (15%). Com isto, `POISON_EFFECT` só resta em moves 0 BP (Toxic/Poison Gas/Poisonpowder) — o problema da R1 dispatch deixou de ter vítimas; não é preciso power-gate.

### ⚠️ BANK $0F (Battle Core) NO LIMITE ABSOLUTO
Depois do PARALYZE_SIDE_EFFECT3, o debug build tem **1 byte livre** no bank $0F (release: 24B). Qualquer adição ao Battle Core estoura o build debug. Remediações possíveis quando acontecer: apagar o dead code do Counter (HandleCounterMove short-circuita em core.asm:4995-4998, o corpo vanilla abaixo é unreachable — ~100B), ou mover mais dados para o bank $30 (7.8KB livres).

### PITFALL NOVO (crítico): ordem das move tables é load-bearing
`moves.asm`, `names.asm`, `AttackAnimationPointers` e `sfx.asm` são indexadas por (move id − 1) dos constants. **Nunca trocar rows num ficheiro só** — o build passa mas os moves trocam de dados em jogo. Depois de qualquer reorder: `python .claude/check_move_alignment.py` (0 misalignments = OK). Foi assim que o commit `59ed008` partiu Comet Punch/Low Kick sem ninguém notar.

## Pitfalls / armadilhas conhecidas

### Build errors comuns
1. **`(EVO LVL)` annotations sem `;` prefix** — rgbasm vê paren como erro. Forte às vezes esquece-se. Fix:
   ```python
   import re
   with open('data/pokemon/evos_moves.asm', encoding='utf-8') as f: text = f.read()
   text = re.sub(r'(\tdb\s+\d+,\s*[A-Z][A-Z0-9_]*)\s+(\([^)]+\))', r'\1  ; \2', text)
   ```
2. **`PSYCHIC` vs `PSYCHIC_M`** — `PSYCHIC` sozinho é símbolo de TYPE; o MOVE chama-se `PSYCHIC_M`. Forte às vezes escreve só `PSYCHIC`. Replace:
   ```python
   text = re.sub(r', PSYCHIC\b(?!_)', ', PSYCHIC_M', text)
   ```
3. **Typos como `HEABUTT` em vez de `HEADBUTT`** — happens; grep + replace
4. **Moves que não existem** — verifica sempre com `grep -n "<MOVE_NAME>" constants/move_constants.asm` antes de usar
5. **TMs que não existem** — moves como FIRE_BLAST, BUBBLE, ROLLOUT (era — agora existe), STOMP (use GROUND_STOMP), MEGA_PUNCH/MEGA_KICK, BARRIER, SHARPEN, RAPID_SPIN não são TMs. Verifica `grep "add_tm" constants/item_constants.asm`
6. **WeezingEvosMoves label desaparece** — Forte já tirou 3× durante edits. Quando der erro "Unknown symbol WeezingEvosMoves", procura entre KoffingEvosMoves e RhyhornEvosMoves — provavelmente falta a label + Evolutions block.

### Edit tool quirks
- **"File has been modified since read"** — qualquer Bash que toque o file invalida o Read cache. Re-read antes de Edit se passou Bash entre eles.
- **CRLF warnings** — Windows file endings; normalize para LF com `newline='\n'` nos writes.

### Move-validation antes de usar
- TMs válidos: `grep "add_tm" constants/item_constants.asm | awk '{print $2}'`
- HMs válidos: CUT, FLY, SURF, STRENGTH, FLASH (no prefix HM_)
- Moves válidos: `grep "const " constants/move_constants.asm`

## Forte's design philosophy (resumo)

1. **Realismo zoológico > balanceamento estrito** — anatomia/biologia primeiro, raw power segundo
2. **Cross-mon consistency > optimization individual** — chains share backbone at same levels
3. **Generosity > restriction** — big movepools, mons aprendem tudo que faz sentido
4. **Bugs são bugs (fixed); difficulty é separada (Hard mode)** — vanilla bugs fixos para todos; difficulty opt-in
5. **TM/HM = "faz sentido anatomicamente/biologicamente"** — liberal, off-type OK
6. **Powder table per mon** (Forte's lore, ver `reference_movepool_pattern.md` section C)
7. **Same-level pairs allowed in apex** (Forte's rule)
8. **EVO LVL anchors** — moves com `; (EVO LVL)` comment ficam ao nível da evolução do stage

## Forte's preferences (não esquecer!)

- **NUNCA fazer `git push` — apenas commits locais.** O push é sempre o Forte que o faz.
- Fala em **português (PT)** e usa **"tu"** informal
- Stats múltiplos de 5 (ele odeia números não-redondos)
- Feedback direto, sem softening
- Quando ele clica "Deny" por engano, simplesmente repete a action
- **NÃO mexer em file-order que ele escolheu** — só ajustar levels
- Build error → arranjar fix mecânico (regex script) sem perguntar; só dizer depois
- Se moveset ficar com "drift" estranho, é porque Forte adicionou/removeu moves no meio — re-classificar com python script é o caminho

## Common API guardrails issue

A API Anthropic ocasionalmente faz **safety guardrails false-positive** em sessões muito longas com vocabulário tipo "gore_attack" / "explosion" / "toxic" / "brutal_swing" / "kill loop" / etc. (Pokemon move names + gaming context disparam o classifier). Não é nada de Forte.

**Quando acontece**: Forte vê "Request was blocked" / "violates Usage Policy". 
**Fix**: re-tentar (often passa à 2ª), reformular a mensagem, ou começar nova sessão. **Foi por isto que esta sessão acabou.**

## Outras coisas importantes a saber

### Encoding
- Forte está em Windows / Git Bash. Scripts Python devem usar `encoding='utf-8'` quando ler e `newline='\n'` quando escrever asm files.
- Console Windows default é cp1252 — evita emojis tipo `→` em prints (use `->`).

### WSL paths
- WSL acessa o projeto via `/mnt/d/Games/More Games/Pokemon/Pokemon Romhacks/Mine/Pokemon_Purple_Yellow`
- Para correr WSL command com paths: `wsl bash -c 'cd "..." && <comando>'`

### Build artifacts
- `pokeyellow.gbc` (release)
- `pokeyellow_debug.gbc` (com ANIM TEST debug menu)
- Build sempre verifica ambos

## Primeira mensagem para o novo chat (template)

> Olá. Continuação do projeto Pokemon Purple Yellow romhack v0.7. Branch `dev-claude-work` (último commit: vê `git log`). Working dir: `D:\Games\More Games\Pokemon\Pokemon Romhacks\Mine\Pokemon_Purple_Yellow`.
> 
> Lê `HANDOVER.md` (no working dir) e os memory files (auto-loaded). Anexo também os spec files das notes folder: @"D:\Games\More Games\Pokemon\Pokemon Romhacks\Mine\Pokemon_Purple_Yellow - Notes\CHANGELIST.md" @"D:\Games\More Games\Pokemon\Pokemon Romhacks\Mine\Pokemon_Purple_Yellow - Notes\Movelist - after.asm" @"D:\Games\More Games\Pokemon\Pokemon Romhacks\Mine\Pokemon_Purple_Yellow - Notes\TMs_HMs_before-after.txt" @"D:\Games\More Games\Pokemon\Pokemon Romhacks\Mine\Pokemon_Purple_Yellow - Notes\Type matchups Pokemon Purple Yellow.asm" @"D:\Games\More Games\Pokemon\Pokemon Romhacks\Mine\Pokemon_Purple_Yellow - Notes\Poke Marts - before-after.txt" @"D:\Games\More Games\Pokemon\Pokemon Romhacks\Mine\Pokemon_Purple_Yellow - Notes\types_evolutions_stats.asm" @"D:\Games\More Games\Pokemon\Pokemon Romhacks\Mine\Pokemon_Purple_Yellow - Notes\Changes - Purple Yellow.asm"
> 
> Resumo: estamos no meio do Pass 3 movepool review. 128/151 done, 23 mons ainda como Claude initial drafts à espera da minha revisão (grep `TODO: review moveset` para encontrar — confirma a contagem com o grep). Confirma que percebeste tudo (build, branch, workflow, regras) e diz-me que estás pronto.

---

**Pronto. Bom trabalho ao próximo Claude. 🫡**
