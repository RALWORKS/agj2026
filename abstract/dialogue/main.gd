class_name Dialogue
extends Button

signal done

@export var dialogue_id: String

@export var anims: AnimationPlayer

@onready var lines: Array[Node] = $DATA.get_children()

var i = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_released("next"):
		next()

func play():
	if not i < lines.size():
		emit_signal("done")
		queue_free()
		return
	var l = lines[i]
	$Text.line = l.line
	$Text.tag = l.tag
	$Text.char_color = "#ffffff"
	if l.tag in Status.char_colors:
		$Text.char_color = Status.char_colors[l.tag]
	if not anims:
		return
	if anims.has_animation(l.name):
		anims.play(l.name)
	
	
func next():
	i += 1
	play()


func _on_pressed() -> void:
	next()
