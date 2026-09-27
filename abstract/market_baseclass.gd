# Baseclass for Market
class_name market_base
extends Control
	

#signal cast_signal(soul_amount, price, crowbar, item2, item3)

enum {CROWBAR = 100, ITEM2 = 200, ITEM3 = 300}

var market_called = false
var soul_amount = 0
#var crowbar = 100
#var item2 = 200
#var item3 = 300
