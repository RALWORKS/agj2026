extends Node2D

@export var using: Item
@export var item_cursor: Node2D

@export var reset_delay = 0.2

var switch = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func item_id():
	if not using:
		return null
	return using.item_id

func use(new_item: Item):
	switch = true
	using = new_item
	
	item_cursor = using.preview.duplicate()
	add_child(item_cursor)


func reset():
	if item_cursor:
		item_cursor.free()
	using = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = get_global_mouse_position() - Vector2(100, 100)
	if Input.is_action_just_pressed("click"):
		await get_tree().create_timer(reset_delay).timeout
		if switch:
			switch = false
			return
		reset()
