extends Panel

@export var item: Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func close():
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED

func open():
	process_mode = Node.PROCESS_MODE_INHERIT
	visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_yes_pressed() -> void:
	Cursor.use(item)
	close()


func _on_no_pressed() -> void:
	close()
