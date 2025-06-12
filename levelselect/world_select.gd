extends Control


@onready var worlds: Array = [$WorldIcon, $WorldIcon2, $WorldIcon3, $WorldIcon4, $WorldIcon5, $WorldIcon6, $WorldIcon7, $WorldIcon8, $WorldIcon9, $WorldIcon10, $WorldIcon11, $WorldIcon12, $WorldIcon13, $WorldIcon14, $WorldIcon15, $WorldIcon16]
var current_world: int = 0
var unlocked_world: int = 1

func _ready() -> void:
	$PlayerIcon.global_position = worlds[current_world].global_position
	unlocked_world = LastLevelUpdater.get_progress()-1

func _input(event):
	if event.is_action_pressed("ui_left") and current_world > 0:
		current_world -= 1
		
	if event.is_action_pressed("ui_right") and current_world < worlds.size()-1 and current_world < unlocked_world:
		current_world += 1
	
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file(worlds[current_world].level)
		print("GOING IN")
	
	$PlayerIcon.global_position = worlds[current_world].global_position
