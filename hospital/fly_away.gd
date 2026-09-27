extends Node2D

@export_file_path("*.tscn") var destination: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func go():
	get_tree().change_scene_to_file(destination)
