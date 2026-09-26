extends Node

@export var required_item_id: String

@export var lock: Item

@export var lock_id: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lock.connect("clicked", clicked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func unlock():
	Status.locks[lock_id] = false
	lock.queue_free()
	Status.gone.push_back(lock.item_id)
	
func clicked():
	if Cursor.item_id() == required_item_id:
		unlock()
