extends Node

var LastLevel = "res://levels/Level1.tscn"

var level_dict = {
	 0: "res://levels/Level1.tscn",
	 1: "res://levels/Level2.tscn",
	 2: "res://levels/Level2_5.tscn",
	 3: "res://levels/Level3.tscn",
	 4: "res://levels/Level4.tscn",
	 5: "res://levels/Level5.tscn",
	 6: "res://levels/Level6.5.tscn",
	 7: "res://levels/Level6.tscn",
	 8: "res://levels/Level6_5.tscn",
	 9: "res://levels/Level7.tscn",
	10: "res://levels/Level7_5.tscn",
	11: "res://levels/Level8.tscn",
	12: "res://levels/Level8_5.tscn",
	13: "res://levels/Level9.tscn",
	14: "res://levels/Level9_5.tscn",
	15: "res://levels/Level10.tscn",
	16: "res://levels/Level11.tscn",
	17: "res://levels/Level12.tscn",
	18: "res://levels/Level18.tscn",
}
# To be used in unlocking levels
var progress : int = 1

func get_level_dict():
	return level_dict

func get_last_level():
	return LastLevel

func set_last_level(name: String):
	LastLevel = name

func get_progress():
	return progress

func update_progress(current_level: int):
	progress = max(progress, current_level)
	print("UPDATED!!! ", progress)
