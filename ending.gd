extends Node2D

var kiddo_not_following = preload("res://prevent_ending_missing_son.tscn")
var good = preload("res://best_ending.tscn")
var medium = preload("res://medium_ending.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Status.son_following:
		var c = kiddo_not_following.instantiate()
		c.z_index = 1000
		add_child(c)
		#BackgroundThemeAll.change_music()
		return
	if StatusBar.soul_percent < 50:
		var c = medium.instantiate()
		c.z_index = 1000
		add_child(c)
		BackgroundThemeAll.change_music("res://abstract/audio/bad_end_wind.mp3")
		#BackgroundThemeAll.volume
		return
	var c = good.instantiate()
	c.z_index = 1000
	add_child(c)
	BackgroundThemeAll.change_music("res://assets/win_waves.wav")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
