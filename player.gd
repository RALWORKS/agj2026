class_name Player extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	StatusBar.connect("soul_changed", soul_changed)
	#var test = get_tree().current_scene.get_name()
	#play footsteps after the hospital
	if get_tree().current_scene.get_name() != "Hospital": 
		$player_walk_sound.play()
		await get_tree().create_timer(2.0).timeout
		$player_walk_sound.stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func soul_changed(from: float, to: float):
	if to >= from:
		return
	$Player/Ghost/AnimationPlayer.play("depart")
