MACRO vend_item
	db \1
	bcd3 \2
ENDM

VendingPrices:
	; item id, price
	vend_item FRESH_WATER, 250 ; 5 yen per HP - the drinks are still half the potions' price per HP; the roof machines are their only shop
	vend_item SODA_POP,    300
	vend_item LEMONADE,    350
