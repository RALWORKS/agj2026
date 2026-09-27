extends AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_child_exiting_tree(node: Node) -> void:
	self.stop()

func _on_finished() -> void:
	await get_tree().create_timer(0.5).timeout
	self.play() #loop audio
