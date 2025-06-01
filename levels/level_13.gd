extends Node2D

@onready var player = $Player
@onready var door = $Door

@onready var level_label = $Player/LevelCanvasLayer/Control/Level


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LensColor.change_lens(LensColor.LENS_COLOR.RED)
	$Background/StaticSprite/StaticAnim.play("static")
	LastLevelUpdater.set_last_level("res://levels/Level13.tscn")
	door.set_next_level("res://screens/win/win.tscn")
	
	level_label.text = "Level 19"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
