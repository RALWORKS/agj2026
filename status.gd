@tool
extends Node

var paused = true

var cur_dialogue: Dialogue

@export var locks: Dictionary[String, bool]

@export var gone: Array[String]

@export var char_colors: Dictionary[String, Color]

@export var discovered_rooms: Array[String]

@export var purchased_items: Array[Resource]

@export var item_ids_given: Array[String]

var death_path = "res://death.tscn"

var fallen = false:
	set(new_value):
		fallen = new_value
		if fallen:
			emit_signal("show_health")

var _fallen = false

var player: Player

signal dialogue_ended

signal show_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	StatusBar.connect("no_soul", die)

func die():
	get_tree().change_scene_to_file(death_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func end_dialogue():
	cur_dialogue.queue_free()
	emit_signal("dialogue_ended", cur_dialogue.dialogue_id)

func start_dialogue(dialogue: Resource):
	if cur_dialogue and not cur_dialogue.is_queued_for_deletion():
		return
	cur_dialogue = dialogue.instantiate()
	get_tree().get_root().add_child(cur_dialogue)
	cur_dialogue.connect("done", end_dialogue)
	
func puchased(bought: Resource):
	# Add items to array
	purchased_items.append(bought)
	
	
