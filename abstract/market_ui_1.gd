#extends "res://abstract/inventory/market_baseclass.gd"
extends Control

# variables
#var market_base.item1 = 100
var price1 
var price2 
var price3 
var current_item # indicates what item is pressed
var player_souls # = market_baseclass soul_amount
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Want to get souls
	price1 = 100
	price2 = 200
	price3 = 300
	player_souls = 500
	pass # Replace with function body.


# When item 1
func _on_item_1_pressed() -> void:
	$market_box/bottom/HBoxContainer/purchase.disabled = false # reset button
	$market_box/background/souls_label.text = str(player_souls) + " Souls"
	$market_box/background/price_label.text = "Price: " + str(price1)
	current_item = 1
	$market_box/bottom/expensive.hide() # hide label
	pass # Replace with function body.
	
#When item 2
func _on_item_2_pressed() -> void:
	$market_box/bottom/HBoxContainer/purchase.disabled = false # reset button
	$market_box/background/souls_label.text = str(player_souls) + " Souls"
	$market_box/background/price_label.text = "Price: " + str(price2)
	current_item = 2
	$market_box/bottom/expensive.hide() # hide label
	pass

#When item 3 pressed
func _on_item_3_pressed() -> void:
	$market_box/bottom/HBoxContainer/purchase.disabled = false # reset button
	$market_box/background/souls_label.text = str(player_souls) + " Souls"
	$market_box/background/price_label.text = "Price: " + str(price3)
	current_item = 3
	$market_box/bottom/expensive.hide() # hide label
	pass # Replace with function body.
	
#purchase
func _on_purchase_pressed() -> void:
	# Item 1
	if player_souls >= price1 && current_item == 1:
		player_souls -= price1
		$market_box/background/item_container/item1.text = "PURCHASED!"
		$market_box/background/item_container/item1.disabled = true
		$market_box/bottom/HBoxContainer/purchase.disabled = true
		#Functions to give item
		
	# Item 2
	elif player_souls >= price2 && current_item == 2:
		player_souls -= price2
		$market_box/background/item_container/item2.text = "PURCHASED!"
		$market_box/background/item_container/item2.disabled = true
		$market_box/bottom/HBoxContainer/purchase.disabled = true
		#Functions to give item
		
	#Item 3
	elif player_souls >= price3 && current_item == 3:
		player_souls -= price3
		$market_box/background/item_container/item3.text = "PURCHASED!"
		$market_box/background/item_container/item3.disabled = true
		$market_box/bottom/HBoxContainer/purchase.disabled = true
		#Functions to give item
		
	else: # not enough
		$market_box/bottom/expensive.show()
	#update current Souls
	$market_box/background/souls_label.text = str(player_souls) + " Souls" 
		
#Close
func _on_close_pressed() -> void:
	self.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
