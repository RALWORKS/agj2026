extends Node

@export var required_item_id: String

@export var lock: Item

@export var lock_id: String

@export var remove_key_resource: Resource

signal unlocked

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if lock:
		lock.connect("clicked", clicked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func unlock():
	Status.locks[lock_id] = false
	if lock:
		lock.queue_free()
		Status.gone.push_back(lock.item_id)
	emit_signal("unlocked")
	if remove_key_resource:
		MyInventory.remove(remove_key_resource)
	
func clicked():
	if Cursor.item_id() == required_item_id:
		unlock()


func _on_toilet_clicked() -> void:
	pass # Replace with function body.
