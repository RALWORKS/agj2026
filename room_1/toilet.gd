extends Node

var handle = preload("res://room_1/handle.tscn")
var fish_active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not Status.locks["toilet"]:
		$"../Unlocked".visible = true

func on_unlock():
	MyInventory.remove(handle)
	fish_active = true

func _on_toilet_clicked() -> void:
	if fish_active == true:
		$"../toilet_flush".play(0.5)
		await get_tree().create_timer(5.5).timeout
		$"../toilet_flush".stop()
