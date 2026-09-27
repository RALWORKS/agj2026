extends Node

var handle = preload("res://room_1/handle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not Status.locks["toilet"]:
		$"../Unlocked".visible = true

func on_unlock():
	MyInventory.remove(handle)
	#play toilet flush sound
	$"../toilet_flush".play()
	await get_tree().create_timer(6.0).timeout
	$"../toilet_flush".stop()
