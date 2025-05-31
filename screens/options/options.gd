extends Node2D

@onready var sfx_slider = $SFX
@onready var music_slider = $Music
@onready var sfx_index
@onready var music_index

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sfx_slider.value = AudioSettings.sfx_volume
	music_slider.value = AudioSettings.music_volume
	sfx_index = AudioServer.get_bus_index("SFX")
	music_index = AudioServer.get_bus_index("Music")

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/title/title.tscn")

func slider_to_dB(slider_value: int) -> float:
	# Define the decibel range
	var min_dB = -80.0  # Decibels for slider value 0 (silent)
	var max_dB = 10.0    # Decibels for slider value 100 (maximum volume)
	var default_dB = 0.0 # Decibels for slider value 50 (default volume)

	# Map the slider value (0-100) to the dB range
	if slider_value == 50:
		return default_dB
	elif slider_value < 50:
		return lerp(min_dB, default_dB, slider_value / 50.0)
	else:
		return lerp(default_dB, max_dB, (slider_value - 50) / 50.0)

func _on_sfx_drag_ended(_value_changed: bool) -> void:
	print("SFX value changed: ", $SFX.value)
	AudioSettings.sfx_volume = $SFX.value
	AudioServer.set_bus_volume_db(sfx_index, slider_to_dB($SFX.value))

func _on_music_drag_ended(_value_changed: bool) -> void:
	print("Music value changed: ", $Music.value)
	AudioSettings.music_volume = $Music.value
	AudioServer.set_bus_volume_db(music_index, slider_to_dB($Music.value))
