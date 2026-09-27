extends Control

var playing = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func play_music():
	if playing != true:
		$background_theme.play()

func stop_music():
	$background_theme.stop()

func _on_background_theme_finished() -> void:
	$background_theme.play()
