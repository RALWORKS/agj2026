class_name Room
extends Node2D

var is_room = true

signal discover

var player: Player

@export var room_id: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_player()
	if room_id and not room_id in Status.discovered_rooms:
		Status.discovered_rooms.push_back(room_id)
		emit_signal("discover")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_player():
	var P = preload("res://player.tscn")
	player = P.instantiate()
	Status.player = player
	add_child(player)
