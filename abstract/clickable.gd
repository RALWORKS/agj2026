@tool
class_name Item
extends Area2D

signal clicked

var _hovering: bool = false
@onready var icon = $InvIcon
@onready var preview = $InvIcon/Texture

@export var item_id: String

var is_icon = false

@export var takeable = false
var taken = false
var inv_item = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	check_gone()

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
	pass

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
	_hovering = false


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if is_icon:
		return
	if not _hovering:
		return
	if event.is_action("click"):
		emit_signal("clicked")


func _on_clicked() -> void:
	if takeable:
		take()
