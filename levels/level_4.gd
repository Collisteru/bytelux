
extends Node2D

@onready var door = $Door

@onready var level_label = $Player/LevelCanvasLayer/Control/Level


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LensColor.change_lens(LensColor.LENS_COLOR.BLUE)
	$Background/StaticSprite/StaticAnim.play("static")
	LastLevelUpdater.set_last_level("res://levels/Level4.tscn")

	door.set_next_level("res://levels/Level5.tscn")
	
	level_label.text = "Level 5"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
