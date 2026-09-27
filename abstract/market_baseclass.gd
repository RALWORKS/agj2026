# Baseclass for Market
class_name market_base
extends Control
	

#signal cast_signal(soul_amount, price, crowbar, item2, item3)

enum {CROWBAR = 10, ITEM2 = 20, ITEM3 = 30}

var PRICES = {
	"crowbar": 10,
	"flush-handle": 10,
	"bad-key": 50,
	"puzzle-box": 10,
}

var market_called = false
var soul_amount = 0
#var crowbar = 100
#var item2 = 200
#var item3 = 300
