extends CanvasModulate

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	match LensColor.lens:
		LensColor.LENS_COLOR.RED:
			color = Color('PINK')
		LensColor.LENS_COLOR.GREEN:
			color = Color('PALE_GREEN')
		LensColor.LENS_COLOR.BLUE:
			color = Color('SKY_BLUE')
		LensColor.LENS_COLOR.WHITE:
			visible = false
