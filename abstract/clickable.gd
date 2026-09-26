@tool
extends Area2D

signal clicked

var _hovering: bool = false
@onready var icon = $InvIcon

var is_icon = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func as_icon():
	$Texture.modulate = "#ffffff00"
	$InvIcon.visible = true
	is_icon = true
	$InvIcon.process_mode = Node.PROCESS_MODE_ALWAYS
	$InvIcon.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



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
