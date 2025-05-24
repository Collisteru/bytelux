extends Node2D
@onready var door = $Door

@onready var level_label = $Player/LevelCanvasLayer/Control/Level



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LensColor.change_lens(LensColor.LENS_COLOR.GREEN)
	$Background/StaticSprite/StaticAnim.play("static")
	door.set_next_level("res://levels/Level7.tscn")
	LastLevelUpdater.set_last_level("res://levels/Level6_5.tscn")

	level_label.text = "Level 8"
