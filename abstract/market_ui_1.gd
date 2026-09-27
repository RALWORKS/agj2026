extends Control

# variables
var price #
var data #
var current_item # indicates what item is pressed
var player_souls #= MarketBaseclass.soul_amount
var item_position # position of item
var marker = preload("res://abstract/purchase_marker.tscn")

#var items: Array[Node]

@export var anims: AnimationPlayer

@export var first_item: Item
@export var second_item: Item
@export var third_item: Item

var _is_mounted = false
var loading = true
var _is_ready = false


func _mounted():
	_is_mounted = true
	if _is_ready:
		onload()
	

func onload():
	first_item.connect("icon_pressed", _on_item_1_icon_pressed)#.bind(first_item))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#test
	_is_ready = true
	if _is_mounted:
		onload()
	if anims:
		anims.play_backwards("slide_down")
	
	#Get soul amount
	player_souls = int(StatusBar.soul_percent)
	
	#get children icons
	#for item in item_container.get_children(): #probably wrong
	#	item.icon_pressed.connect(_on_test_item_1_icon_pressed.bind(item))
	#first_item.connect("icon_pressed", _on_item_1_icon_pressed)#.bind(first_item))
	#second_item.icon_pressed.connect(_on_test_item_2_icon_pressed)#.bind(second_item))
	#third_item.icon_pressed.connect(_on_test_item_3_icon_pressed)#.bind(third_item))

#On Icon Pressed
func _on_item_1_icon_pressed(_id) -> void:
	price = market_base.CROWBAR
	$market_box/bottom/HBoxContainer/purchase.disabled = false # reset button
	$market_box/background/souls_label.text = str(player_souls) + " Souls"
	$market_box/background/price_label.text = "Price: " + str(price)
	current_item = 1
	item_position = $market_box/background/item_container/item1
	data = load("res://abstract/test_inventory.tscn")
	$market_box/bottom/expensive.hide() # hide label
	
func _on_test_item_2_icon_pressed(_id) -> void:
	price = market_base.ITEM2
	$market_box/bottom/HBoxContainer/purchase.disabled = false # reset button
	$market_box/background/souls_label.text = str(player_souls) + " Souls"
	$market_box/background/price_label.text = "Price: " + str(price)
	current_item = 2
	item_position = $market_box/background/item_container/item2
	data = load("res://abstract/test_inventory2.tscn")
	$market_box/bottom/expensive.hide() # hide label
	
func _on_test_item_3_icon_pressed(_id) -> void:
	price = market_base.ITEM3
	$market_box/bottom/HBoxContainer/purchase.disabled = false # reset button
	$market_box/background/souls_label.text = str(player_souls) + " Souls"
	$market_box/background/price_label.text = "Price: " + str(price)
	current_item = 3
	item_position = $market_box/background/item_container/item3
	data = load("res://abstract/test_inventory3.tscn")
	$market_box/bottom/expensive.hide() # hide label
	
	
#purchase
func _on_purchase_pressed() -> void:
	if player_souls >= price:
		player_souls -= price
		add_item(data)
		#purchase
		Status.puchased(data)
		$market_box/bottom/HBoxContainer/purchase.disabled = true
		#var new_marker = marker.instantiate()
		item_position.add_child(marker.instantiate())
		
	else: # not enough
		$market_box/bottom/expensive.show()
	#update current Souls
	StatusBar.soul_percent = float(player_souls)
	$market_box/background/souls_label.text = str(player_souls) + " Souls" 

#add item to inventory
func add_item(item):
	MyInventory.add(item) # Add purchased item to inventory
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass	
	
#Close
func _on_close_pressed() -> void:
	anims.play("slide_down")
	await get_tree().create_timer(1.0).timeout
	queue_free()
