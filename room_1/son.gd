extends Node
var healed_dialogue = preload("res://room_1/son_says_healed.tscn")

func _ready() -> void:
	if not Status.locks["son"]:
		$"..".dialogue = healed_dialogue

func unlock():
	Status.son_following = true
	Status.start_dialogue(healed_dialogue)
	$"..".dialogue = healed_dialogue
