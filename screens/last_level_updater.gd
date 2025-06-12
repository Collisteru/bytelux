extends Node

var LastLevel = "res://levels/Level1.tscn"

# To be used in unlocking levels
var progress : int = 1

func get_last_level():
	return LastLevel

func set_last_level(name: String):
	LastLevel = name

func update_progress(current_level: int):
	progress = max(progress, current_level)
