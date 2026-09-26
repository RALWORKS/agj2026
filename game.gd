extends Node2D

@export var starting_room = "res://room_1/room.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file(starting_room)


func _on_quit_pressed() -> void:
	get_tree().quit()
