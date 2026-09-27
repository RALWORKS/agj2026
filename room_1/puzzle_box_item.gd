@tool
extends Item

var PuzzleBox = preload("res://room_1/puzzle_box.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func use():
	var p = PuzzleBox.instantiate()
	get_tree().get_root().add_child(p)
