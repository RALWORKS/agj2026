extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#load("res://room.gd")
	#load("res://abstract/clickable.gd")
	#load("res://toggle_inventory.gd")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	load("res://room.gd")
	load("res://abstract/clickable.gd")
	load("res://toggle_inventory.gd")
	
	
