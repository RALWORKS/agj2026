extends Node

var _toggling = false
@export var debounce = 0.4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inv") and not _toggling:
		_toggling = true
		toggle()
		await get_tree().create_timer(debounce).timeout
		_toggling = false
	
func toggle():
	if Status.paused:
		return
	if $"..".active:
		$"../AnimationPlayer".play_backwards("SlideIn")
		$"..".active = false
		return
	$"../AnimationPlayer".play("SlideIn")
	$"..".active = true
