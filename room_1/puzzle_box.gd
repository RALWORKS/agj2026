extends Node2D

@export var found_color: Color

@export var hide_bg = false
@export var icon = false

var symbols = [
	preload("res://assets/puzzlebox/puzzlebox_triangle.png"),
	preload("res://assets/puzzlebox/puzzlebox_circle.png"),
	preload("res://assets/puzzlebox/puzzlebox_star.png")
]

var trace = 0

var code = []

var display = [null, null, null, null]

var found = [null, null, null, null]

func close():
	queue_free()

func refresh_input():
	if not Status.locks["puzzle-box"]:
		return
	var i = 0
	for c in $Shut/Code.get_children():
		c.get_node("symbol").texture = null
	while i < display.size():
		if display[i] != null:
			$Shut/Code.get_child(i).get_node("symbol").texture = symbols[display[i]]
			if display[i] == found[i]:
				$Shut/Code.get_child(i).get_node("symbol").modulate = found_color
		i += 1
	await get_tree().create_timer(0.2).timeout
		
func jump_trace_if_needed():
	while trace < 4 and found[trace] != null:
		trace += 1

func unlock():
	Status.locks["puzzle-box"] = false
	if get_node_or_null("Shut"):
		$Shut.queue_free()

func submit():
	await get_tree().create_timer(0.5).timeout
	var i = 0
	var n_found = 0
	while i < code.size():
		if display[i] == code[i]:
			found[i] = code[i]
			n_found += 1
		i += 1
	if n_found == 4:
		unlock()
	trace = 0
	jump_trace_if_needed()
	display = found.duplicate()
	refresh_input()

func type_symbol(i):
	if trace > 3:
		return
	display[trace] = i
	refresh_input()
	trace += 1
	jump_trace_if_needed()
	
	if trace > 3:
		submit()

func randomize_code():
	if Status.puzzle_box_code.size():
		code = Status.puzzle_box_code.duplicate()
		return
	for _i in range(4):
		code.push_back(randi_range(0,2))
	Status.puzzle_box_code = code.duplicate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if hide_bg:
		$bg.visible = false
	if icon:
		$Shut/Blocker.mouse_filter = 1
		$bg.mouse_filter = 1
		$Shut.process_mode = Node.PROCESS_MODE_DISABLED
		$Open.process_mode = Node.PROCESS_MODE_DISABLED
		$bg.process_mode = Node.PROCESS_MODE_DISABLED

	if not Status.locks["puzzle-box"]:
		unlock()
	randomize_code()
	var i = 0
	while i < 3:
		$Shut/Keys.get_child(i).connect("pressed", func(): type_symbol(i))
		i += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
