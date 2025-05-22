extends Node2D

@onready var player = $Player
@onready var door = $Door

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LensColor.change_lens(LensColor.LENS_COLOR.WHITE)
	$Background/StaticSprite/StaticAnim.play("static")
	door.set_next_level("res://levels/Level2.tscn")
	LastLevelUpdater.set_last_level("res://levels/Level1.tscn")
