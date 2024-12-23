extends RayCast2D

@onready var laser_line = $LaserLine2D

# TODO: This is a placeholder until wall collision code is programmed
@onready var laser_max_length = 1000  # Max length of the laser

func _ready():
	laser_line.visible = false  # Initially hidden


func fire_laser(laser_position, player_position):
	#print("laser_position:  ", laser_position)
	#print("Player Position: ", player_position)
	# Calculate angle
	var x_diff = laser_position.x
	var y_diff = laser_position.y
	
	var vec_norm = sqrt(pow(x_diff,2) + pow(y_diff, 2));
	var dir_norm = Vector2(x_diff / vec_norm, y_diff / vec_norm)
	var laser_end: Vector2 = (laser_max_length * dir_norm)
	
	
	laser_line.points = [Vector2.ZERO, laser_max_length * Vector2(laser_position.x, laser_position.y +3)]

	laser_line.visible = true  # Show the laser line
	
	fade()

func fade():
	await get_tree().create_timer(0.05).timeout
	laser_line.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
