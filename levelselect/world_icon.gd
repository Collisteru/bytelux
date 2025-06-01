@tool
extends Control
class_name LevelSelect

@export var world_index: int = 1

func _ready() -> void:
	$Label.text = "Level " + str(world_index)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		$Label.text = "Level " + str(world_index)
