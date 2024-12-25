extends CanvasModulate

@onready var player = $'../Player'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player:
		match player.lens:
			LensColor.LENS_COLOR.RED:
				color = Color('PINK')
			LensColor.LENS_COLOR.GREEN:
				color = Color('PALE_GREEN')
			LensColor.LENS_COLOR.BLUE:
				color = Color('SKY_BLUE')
