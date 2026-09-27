@tool
extends Node

var paused = true

var cur_dialogue: Dialogue

@export var locks: Dictionary[String, bool]

@export var gone: Array[String]

@export var char_colors: Dictionary[String, Color]

@export var discovered_rooms: Array[String]

@export var purchased_items: Array[Resource]

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
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func end_dialogue():
	emit_signal("dialogue_ended", cur_dialogue.dialogue_id)
	cur_dialogue.queue_free()

func start_dialogue(dialogue: Resource):
	if cur_dialogue:
		return
	cur_dialogue = dialogue.instantiate()
	get_tree().get_root().add_child(cur_dialogue)
	cur_dialogue.connect("done", end_dialogue)
	
func puchased(bought: Resource):
	# Add items to array
	purchased_items.append(bought)
	
	
