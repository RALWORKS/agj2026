@tool
extends Node

var paused = true

var cur_dialogue: Dialogue

@export var locks: Dictionary[String, bool]

@export var gone: Array[String]

@export var char_colors: Dictionary[String, Color]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_dialogue(dialogue: Resource):
	if cur_dialogue:
		return
	cur_dialogue = dialogue.instantiate()
	get_tree().get_root().add_child(cur_dialogue)
