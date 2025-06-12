extends Node2D

@onready var player = $Player
@onready var door = $Door

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	LensColor.change_lens(LensColor.LENS_COLOR.RED)
	$Background/StaticSprite/StaticAnim.play("static")
	LastLevelUpdater.set_last_level("res://levels/Level2_5.tscn")
	LastLevelUpdater.update_progress(3)

	door.set_next_level("res://levels/Level3.tscn")
