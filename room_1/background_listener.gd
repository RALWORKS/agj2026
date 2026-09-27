extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BackgroundThemeAll.play_music()
	#BackgroundThemeAll.change_music("res://abstract/audio/crowbar_sound.wav")
	BackgroundThemeAll.playing = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
