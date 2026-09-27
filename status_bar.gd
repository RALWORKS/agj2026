@tool
extends Control

signal soul_changed
signal vitality_changed
signal wealth_changed
signal no_soul
signal no_vitality
signal no_wealth
enum Stat {Soul, Wealth, Vitality}

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

@export var turn_counter:int = 0:
	set(new_value):
		if turn_counter_label:
			turn_counter_label.text = str(new_value)
		turn_counter = new_value

@export var debug = false:
	set(new_value):
		if soul_bar and vitality_bar and wealth_bar:
			soul_bar.set("show_percentage", new_value)
			vitality_bar.set("show_percentage", new_value)
			wealth_bar.set("show_percentage", new_value)
		debug = new_value

var soul_bar: Range
var wealth_bar: Range
var vitality_bar: Range
var progress_bars: Array[Range]
@onready var turn_counter_label: Label = get_node("StatusContainer/TurnsContainer/TurnCounter")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for bar in find_children("*ProgressBar", "ProgressBar"):
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
		if bar.get_class() == "ProgressBar":
			bar.set("show_percentage", debug)
	progress_bars = [soul_bar, wealth_bar, vitality_bar]

	turn_counter_label.text = str(turn_counter)

	if Engine.is_editor_hint() and get_viewport() is Window: 
		get_parent().remove_child(self)


# # Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void: pass
	# visible = Status.fallen and not Status.paused


func _on_button_pressed() -> void:
	Input.action_press("inv")
	Input.action_release("inv")
