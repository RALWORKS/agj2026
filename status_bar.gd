@tool
extends Control

signal soul_changed
signal vitality_changed
signal wealth_changed
signal no_soul
signal no_vitality
signal no_wealth
signal drain_timer_interupt
enum Stat {Soul, Wealth, Vitality}

@export_range(0.0, 100.0, 0.01) var soul_percent: float = 100.0:
	set(new_value):
		if soul_bar:
			soul_bar.set_value_no_signal(new_value)
		if new_value < 0:
			new_value = 0
		if new_value == 0:
			no_soul.emit()
		soul_changed.emit(soul_percent, new_value)
		soul_percent = new_value

@export_range(0.0, 100.0, 0.01, "allow_greater") var wealth_percent: float = 100.0:
	set(new_value):
		if wealth_bar:
			wealth_bar.set_value_no_signal(new_value)
		if new_value < 0:
			new_value = 0
		if new_value == 0:
			no_wealth.emit()
		wealth_changed.emit(wealth_percent, new_value)
		wealth_percent = new_value

@export_range(0.0, 100.0, 0.01) var vitality_percent: float = 100.0:
	set(new_value):
		if vitality_bar:
			vitality_bar.set_value_no_signal(new_value)
		if new_value < 0:
			new_value = 0
		vitality_changed.emit(vitality_percent, new_value)
		vitality_percent = new_value

@export var turn_counter:int = 0:
	set(new_value):
		if turn_counter_label:
			turn_counter_label.text = str(new_value)
		turn_counter = new_value

@export var rate_of_soul_loss_on_empty_vitality: float = 10.0
@export var delay_of_soul_delay_on_empty_vitality: float = 5.0

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
var is_draining: bool = false;
@onready var turn_counter_label: Label = get_node("StatusContainer/TurnsContainer/TurnCounter")

func turn_on():
	visible = true

func _init() -> void: 
	no_vitality.connect(_on_no_vitality)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_tree().current_scene == self:
		visible = true
	else:
		visible = false # wait to be turned on
	Status.connect("show_health", turn_on)

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
func _process(_delta: float) -> void: 
	if Engine.is_editor_hint():
		return

	if not is_draining:
		if vitality_percent == 0:
			is_draining = true
			no_vitality.emit()
	else:
		if vitality_percent != 0:
			is_draining = false
			drain_timer_interupt.emit()


func _on_button_pressed() -> void:
	Input.action_press("inv")


func _on_inventory_button_button_up() -> void:
	Input.action_release("inv")


func _on_no_vitality() -> void:
	var drain_timer: SceneTreeTimer = get_tree().create_timer(delay_of_soul_delay_on_empty_vitality, false)
	drain_timer.timeout.connect(func(): drain_timer_interupt.emit())
	await drain_timer_interupt
	print(drain_timer.time_left)
	if drain_timer.time_left <= 0:
		soul_percent -= rate_of_soul_loss_on_empty_vitality
		_on_no_vitality()
