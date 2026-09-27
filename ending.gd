extends Node2D

var kiddo_not_following = preload("res://prevent_ending_missing_son.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Status.son_following:
		var c = kiddo_not_following.instantiate()
		add_child(c)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
