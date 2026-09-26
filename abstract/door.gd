extends Button

@export_file("*.tscn") var destination: String

@export var lock_id: String

var _locked = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	check_lock()
	refresh_lock()

func hover():
	modulate = "#ffffffff"

func unhover():
	modulate = "#ffffff00"

func check_lock():
	if not lock_id:
		return
	var locked = Status.locks[lock_id]
	if locked == _locked:
		return
	_locked = locked
	refresh_lock()

func refresh_lock():
	if _locked:
		lock()
		return
	unlock()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	check_lock()

func lock():
	disabled = true
	visible = false

func unlock():
	visible = true
	disabled = false

func go():
	if disabled:
		return
	get_tree().change_scene_to_file(destination)

func _on_mouse_entered() -> void:
	hover()


func _on_mouse_exited() -> void:
	unhover()


func _on_pressed() -> void:
	go()
