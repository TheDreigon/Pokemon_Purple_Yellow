MACRO vend_item
	db \1
	bcd3 \2
ENDM

VendingPrices:
	; item id, price
	vend_item FRESH_WATER, 250 ; vend_item FRESH_WATER, 250 ; keeps drinks from trivially dominating Super Potion on ¥/HP
	vend_item SODA_POP,    300
	vend_item LEMONADE,    350
