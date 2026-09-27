
class_name Inventory
extends Panel

@export var data: Array[Resource]

var inv: Array[Node2D] = []

@export var active = true

var Slot = preload("res://abstract/inventory/slot.tscn")
var UseDialogue = preload("res://abstract/inventory/use.tscn")

@export var trigger_reload = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reload()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if trigger_reload:
		trigger_reload = false
		reload()

func add(item_resource: Resource):
	data.push_back(item_resource)
	reload()

func remove(item_resource: Resource):
	var i = data.find(item_resource)
	data.remove_at(i)
	reload()

func reload():
	for c in inv:
		c.free()
	inv.clear()
	while data.size() > $GridContainer.get_children().size():
		var s = Slot.instantiate()
		$GridContainer.add_child(s)
	var i = 0
	while i < data.size():
		var c = data[i].instantiate()
		c.as_icon()
		c.inv_item = true
		$GridContainer.get_child(i).add_child(c)
		inv.push_back(c)
		var u = UseDialogue.instantiate()
		u.item = c
		u.close()
		c.icon.add_child(u)
		c.icon.connect("pressed", u.open)
		i += 1
