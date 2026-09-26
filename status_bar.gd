@tool
extends Control

@export_range(0, 100, 0.01) var soul_percent: float = 100:
	set(new_value):
		soul_percent = new_value
		if soul_bar:
			soul_bar.set_value_no_signal(new_value)

@export_range(0, 100, 0.01) var vitality_percent: float = 100:
	set(new_value):
		vitality_percent = new_value
		if vitality_bar:
			vitality_bar.set_value_no_signal(new_value)

@export_range(0, 100, 0.01) var wealth_percent: float = 100:
	set(new_value):
		wealth_percent = new_value
		if wealth_bar:
			wealth_bar.set_value_no_signal(new_value)

@export var status_debug = false:
	set(new_value):
		status_debug = new_value
		if soul_bar:
			soul_bar.set("show_percentage", status_debug)
			vitality_bar.set("show_percentage", status_debug)
			wealth_bar.set("show_percentage", status_debug)

var soul_bar: ProgressBar
var vitality_bar: ProgressBar
var wealth_bar: ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint() and get_viewport() is Window: 
		get_parent().remove_child(self)
	return
	soul_bar = get_node("VBoxContainer/SoulProgressBar")
	soul_bar.set("show_percentage", status_debug)
	soul_percent = soul_bar.get("value")

	vitality_bar = get_node("VBoxContainer2/VitalityProgressBar")
	vitality_bar.set("show_percentage", status_debug)
	vitality_percent = vitality_bar.get("value")

	wealth_bar = get_node("VBoxContainer3/WealthProgressBar")
	wealth_bar.set("show_percentage", status_debug)
	wealth_percent = wealth_bar.get("value")

func _process(_delta: float) -> void:
	visible = not Status.paused

# # Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass
