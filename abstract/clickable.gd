@tool
class_name Item
extends Area2D

signal clicked

var _hovering: bool = false
@onready var icon = $InvIcon
@onready var preview = $InvIcon/Texture

@export var item_id: String

@export var hide_for_dialogue_id: Array[String]
@export var disable_for_dialogue: Array[Node]

@export var disabled = false

var is_icon = false

@export var takeable = false
var taken = false
var inv_item = false
@export var shop_item = false:
	set(new_value):
		shop_item  = new_value
		if new_value:
			as_icon()
@export var dialogue: Resource

signal icon_pressed

var debounce = 0.2
var _click = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	check_gone()
	if shop_item:
		as_icon()

func check_gone():
	if inv_item:
		return
	if item_id in Status.gone:
		queue_free()

func as_icon():
	$Texture.modulate = "#ffffff00"
	$InvIcon.visible = true
	is_icon = true
	$InvIcon.process_mode = Node.PROCESS_MODE_ALWAYS
	$InvIcon.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Status.cur_dialogue and Status.cur_dialogue.dialogue_id in hide_for_dialogue_id:
		for n in disable_for_dialogue:
			if not n:
				continue
			n.process_mode = Node.PROCESS_MODE_DISABLED
		visible = false
	elif hide_for_dialogue_id:
		visible = true
		for n in disable_for_dialogue:
			if not n:
				continue
			n.process_mode = Node.PROCESS_MODE_INHERIT

func take():
	if taken:
		return
	taken = true
	Status.gone.push_back(self.item_id)
	var data = load(scene_file_path)
	MyInventory.add(data)
	await get_tree().create_timer(0.1).timeout
	self.queue_free()

func _on_mouse_entered() -> void:
	if is_icon:
		return
	_hovering = true


func _on_mouse_exited() -> void:
	if is_icon:
		return


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if is_icon:
		return
	if not _hovering:
		return
	if disabled:
		return
	if event.is_action("click") and not _click:
		emit_signal("clicked")
		_click = true
		#await get_tree().create_timer(debounce).timeout
		_click = false


func _on_clicked() -> void:
	if disabled:
		return
	if item_id in Status.locks and Status.locks[item_id]:
		return
	if takeable:
		take()
		return
	if dialogue:
		Status.start_dialogue(dialogue)


func _on_inv_icon_pressed() -> void:
	emit_signal("icon_pressed", item_id)
