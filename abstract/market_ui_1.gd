extends Control

# variables
#var market_base.item1 = 100
var price #= market_base.CROWBAR
#var price2 = market_base.ITEM2
#var price3 = market_base.ITEM3
var data# = load("res://abstract/test_inventory.tscn")
#var data3 = load("res://abstract/test_inventory2.tscn")
#var data2 = load("res://abstract/test_inventory3.tscn")
var current_item # indicates what item is pressed
var player_souls #= MarketBaseclass.soul_amount
#var market_called
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Want to get souls
	#test
	#load("res://toggle_inventory.gd")
	player_souls = 500


# When item 1
func _on_item_1_pressed() -> void:
	price = market_base.CROWBAR
	$market_box/bottom/HBoxContainer/purchase.disabled = false # reset button
	$market_box/background/souls_label.text = str(player_souls) + " Souls"
	$market_box/background/price_label.text = "Price: " + str(price)
	current_item = 1
	data = load("res://abstract/test_inventory.tscn")
	$market_box/bottom/expensive.hide() # hide label
	pass # Replace with function body.
	
#When item 2
func _on_item_2_pressed() -> void:	
	price = market_base.ITEM2
	$market_box/bottom/HBoxContainer/purchase.disabled = false # reset button
	$market_box/background/souls_label.text = str(player_souls) + " Souls"
	$market_box/background/price_label.text = "Price: " + str(price)
	current_item = 2
	data = load("res://abstract/test_inventory2.tscn")
	$market_box/bottom/expensive.hide() # hide label
	pass

#When item 3 pressed
func _on_item_3_pressed() -> void:
	price = market_base.ITEM3
	$market_box/bottom/HBoxContainer/purchase.disabled = false # reset button
	$market_box/background/souls_label.text = str(player_souls) + " Souls"
	$market_box/background/price_label.text = "Price: " + str(price)
	current_item = 3
	data = load("res://abstract/test_inventory3.tscn")
	$market_box/bottom/expensive.hide() # hide label
	pass # Replace with function body.
	
#purchase
func _on_purchase_pressed() -> void:
	# Item 1
	if player_souls >= price && current_item == 1:
		player_souls -= price
		$market_box/background/item_container/item1.text = "PURCHASED!"
		$market_box/background/item_container/item1.disabled = true
		$market_box/bottom/HBoxContainer/purchase.disabled = true
		#Functions to give item
		add_item(data)
		
	# Item 2
	elif player_souls >= price && current_item == 2:
		player_souls -= price
		$market_box/background/item_container/item2.text = "PURCHASED!"
		$market_box/background/item_container/item2.disabled = true
		$market_box/bottom/HBoxContainer/purchase.disabled = true
		#Functions to give item
		#var test
		add_item(data)
		
	#Item 3
	elif player_souls >= price && current_item == 3:
		player_souls -= price
		$market_box/background/item_container/item3.text = "PURCHASED!"
		$market_box/background/item_container/item3.disabled = true
		$market_box/bottom/HBoxContainer/purchase.disabled = true
		#Functions to give item
		add_item(data)
		
	else: # not enough
		$market_box/bottom/expensive.show()
	#update current Souls
	MarketBaseclass.soul_amount = player_souls
	$market_box/background/souls_label.text = str(player_souls) + " Souls" 

#add item to inventory
func add_item(item):
	# Not sure how to implement that
	#var data = load("res://abstract/test_inventory.tscn")
	MyInventory.add(item)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass	
	
#Close
func _on_close_pressed() -> void:
	$"market_box/market_slide".play()	

#test
func _on_button_pressed() -> void: #test
	$market_box/market_slide.play_section_backwards("slide_down")
	MarketBaseclass.market_called = false
