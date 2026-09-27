@tool
extends Control

signal soul_changed
signal vitality_changed
signal wealth_changed
signal no_soul
signal no_vitality
signal no_wealth

@export_range(0, 100, 0.01) var soul_percent: float = 100:
	set(new_value):
		if soul_bar:
			soul_bar.set_value_no_signal(new_value)
		soul_changed.emit(soul_percent, new_value)
		if new_value < 0:
			new_value = 0
		if new_value == 0:
			no_soul.emit()
		soul_percent = new_value

@export_range(0, 100, 0.01, "allow_greater") var wealth_percent: float = 100:
	set(new_value):
		if wealth_bar:
			wealth_bar.set_value_no_signal(new_value)
		wealth_changed.emit(wealth_percent, new_value)
		if new_value < 0:
			new_value = 0
		if new_value == 0:
			no_wealth.emit()
		wealth_percent = new_value

@export_range(0, 100, 0.01) var vitality_percent: float = 100:
	set(new_value):
		if vitality_bar:
			vitality_bar.set_value_no_signal(new_value)
		vitality_changed.emit(vitality_percent, new_value)
		if new_value < 0:
			new_value = 0
		if new_value == 0:
			no_vitality.emit()
		vitality_percent = new_value

var turn_counter_label: Label
@export var turn_counter:int = 0:
	set(new_value):
		if turn_counter_label:
			turn_counter_label.text = str(new_value)
		turn_counter = new_value

@export var status_debug = false:
	set(new_value):
		if soul_bar:
			soul_bar.set("show_percentage", status_debug)
			vitality_bar.set("show_percentage", status_debug)
			wealth_bar.set("show_percentage", status_debug)
		status_debug = new_value

var soul_bar: ProgressBar
var wealth_bar: ProgressBar
var vitality_bar: ProgressBar
enum Stat {Soul, Wealth, Vitality}
var counter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# if Engine.is_editor_hint() and get_viewport() is Window: 
	# 	get_parent().remove_child(self)
	# 	return
	var progress_bars = find_children("*ProgressBar", "ProgressBar")
	for bar in progress_bars:
		bar.set("show_percentage", status_debug)
		match bar.name:
			"SoulProgressBar":
				soul_bar = bar
				soul_percent = soul_bar.get("value")
			"VitalityProgressBar":
				vitality_bar = bar
				vitality_percent = vitality_bar.get("value")
			"WealthProgressBar":
				wealth_bar = bar
				wealth_percent = wealth_bar.get("value")
		
		turn_counter_label = find_child("TurnCounter")


# # Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	visible = Status.fallen and not Status.paused
