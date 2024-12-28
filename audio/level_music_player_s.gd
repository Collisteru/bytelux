extends AudioStreamPlayer

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
