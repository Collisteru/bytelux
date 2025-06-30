extends Node2D

@onready var player = $Player

@onready var level_label = $Player/LevelCanvasLayer/Control/Level

@onready var door = $Door

@onready var level_dict = LastLevelUpdater.get_level_dict()

# the level path
@onready var my_scene_path = get_tree().current_scene.scene_file_path

# the level number
var my_level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LensColor.change_lens(LensColor.LENS_COLOR.RED)
	$Background/StaticSprite/StaticAnim.play("static")
	my_level = level_dict.find_key(my_scene_path)
	level_flag()
	
# Should update the last level, next level, set the level_label, and update the progress. If not implemented, the push_error() will be called
func level_flag() -> void:
	#get_tree().quit()
	#push_error("implement level_flag")
	
	door.set_next_level(level_dict[my_level+1])
	LastLevelUpdater.set_last_level(level_dict[my_level])
	LastLevelUpdater.update_progress(my_level+1)
	level_label.text = "Level "+str(my_level+1)
