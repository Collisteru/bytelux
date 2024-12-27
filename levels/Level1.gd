extends Node2D

@onready var player = $Player
@onready var door = $Door

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LensColor.change_lens(LensColor.LENS_COLOR.WHITE)
	door.set_next_level("res://levels/vic_level_design_for_funsies.tscn")
	$Background/StaticSprite/StaticAnim.play("static")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
