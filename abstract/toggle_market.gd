extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if MarketUi1.market_called == true:
		#activate_market()
	#var condition
	#if condition = true:
	#	$"../AnimationPlayer".playbackwards("slide down")
	pass

func activate_market():
	$"../AnimationPlayer".play_backwards("SlideIn")
	return
	
	
	
