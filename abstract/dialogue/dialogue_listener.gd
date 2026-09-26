extends Node

signal found

@export var dialogue_id: String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Status.connect("dialogue_ended", hear_dialogue)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hear_dialogue(id):
	if id == dialogue_id:
		emit_signal("found")
