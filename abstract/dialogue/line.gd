extends Node2D

@export var line: String:
	set(new_value):
		$Line.text = new_value

@export var tag: String:
	set(new_value):
		$Tag.text = new_value

@export var char_color: Color:
	set(new_value):
		$Tag.modulate = new_value

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
