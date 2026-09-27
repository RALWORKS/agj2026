extends Control

# variables
var price #
var data: Resource #
var current_item # indicates what item is pressed
var player_souls #= MarketBaseclass.soul_amount
var item_position # position of item
var marker = preload("res://abstract/purchase_marker.tscn")

#var items: Array[Node]

@export var anims: AnimationPlayer

var _is_mounted = false
var loading = true
var _is_ready = false


func _mounted():
	_is_mounted = true
	if _is_ready:
		onload()
	

func onload():
	for c: Item in $market_box/background/item_container.get_children():
		var r = load(c.scene_file_path)
		if r in Status.purchased_items:
			c.queue_free()
			continue
		c.connect("icon_pressed", func (item_id): on_item_pressed(c, item_id))

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
	

func on_item_pressed(item: Item, item_id: String):
	price = MarketBaseclass.PRICES[item_id]
	$market_box/bottom/HBoxContainer/purchase.disabled = false # reset button
	$market_box/background/souls_label.text = str(player_souls) + " Souls"
	$market_box/background/price_label.text = "Price: " + str(price) + "% of your soul"
	current_item = 1
	item_position = item
	var d = item.scene_file_path
	data = load(d)
	
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
