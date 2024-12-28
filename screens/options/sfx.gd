extends VSlider


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# TODO: Make it so that these are set by the SFX and Music volume globals
	self.value = 50
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
