extends AudioStreamPlayer2D

# Define the excluded scenes
var excluded_scenes = [
	"res://screens/title/title.tscn",
	"res://screens/options/options.tscn",
	"res://screens/lose/lose.tscn",
	"res://screens/win/win.tscn"
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playing = false
	pass
		
func _process(_delta: float) -> void:
	pass

#
#func _on_scene_change() -> void:
	#print("On scene changed called")
		## Check the current scene's path
	#var current_scene_path = get_tree().current_scene.scene_file_path
	#if current_scene_path in excluded_scenes:
		#stop()  # Stop the audio if the current scene is excluded
	#else:
		#print("Should play now!")
		#play()
	#pass
