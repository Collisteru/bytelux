extends Node2D

@onready var player = $Player
@onready var door = $Door

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.lens = player.LENS_COLOR.WHITE
	player.change_eye_color()
	
	door.set_next_level("res://levels/Level2.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
