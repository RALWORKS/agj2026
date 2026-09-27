extends Node

@export var give_cheese_scene: Resource

var Cheese = preload("res://room_1/cheese.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func check_if_cheese_given():
	if "cheese" in Status.item_ids_given:
		return
	print("!!!")
	Status.start_dialogue(give_cheese_scene)

func give_cheese():
	Status.item_ids_given.push_back("cheese")
	MyInventory.add(Cheese)
