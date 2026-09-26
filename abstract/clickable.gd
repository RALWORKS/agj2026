extends Area2D

signal clicked

var _hovering: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _hovering:
		print("aaaaa")



func _on_mouse_entered() -> void:
	_hovering = true




func _on_mouse_exited() -> void:
	_hovering = false


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if not _hovering:
		return
	if event.is_action("click"):
		emit_signal("clicked")
