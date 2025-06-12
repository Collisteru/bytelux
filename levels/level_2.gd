extends Node2D

@onready var player = $Player
@onready var door = $Door
@onready var level_label = $Player/LevelCanvasLayer/Control/Level

# Called when the node enters the scene tree for the first time.s
func _ready() -> void:	
	LensColor.change_lens(LensColor.LENS_COLOR.RED)
	$Background/StaticSprite/StaticAnim.play("static")
	LastLevelUpdater.set_last_level("res://levels/Level2.tscn")
	LastLevelUpdater.update_progress(2)

	door.set_next_level("res://levels/Level2_5.tscn")
	
	
	level_label.text = "Level 2"
