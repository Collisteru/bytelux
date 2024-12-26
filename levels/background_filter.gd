extends CanvasModulate

@onready var player = $'../Player'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player:
		match player.lens:
			player.LENS_COLOR.RED:
				color = Color('PINK')
			player.LENS_COLOR.GREEN:
				color = Color('PALE_GREEN')
			player.LENS_COLOR.BLUE:
				color = Color('SKY_BLUE')
			player.LENS_COLOR.WHITE:
				visible = false
