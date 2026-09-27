extends AudioStreamPlayer2D

#var rat_active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_rat_clicked() -> void:
	#if rat_active == true:
	self.play()


func _on_unlock_with_item_unlocked() -> void:
	#rat_active = true
	pass
