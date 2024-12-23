extends RayCast2D

@onready var laser_line = $LaserLine2D

# TODO: This is a placeholder until wall collision code is programmed
var laser_max_length = 1000  # Max length of the laser

func _ready():
	laser_line.visible = false  # Initially hidden


func fire_laser(laser_position, player_position):
	#print("laser_position:  ", laser_position)
	#print("Player Position: ", player_position)
	# Calculate angle
	var x_diff = laser_position.x
	var y_diff = laser_position.y
	
	var angle;
	
	# X increases left to right, y increases top to bottom
	# We need to resolve the angle for each quadrant to make the trig work

	# Create laser from that angle
	
	var vec_norm = sqrt(pow(x_diff,2) + pow(y_diff, 2));
	var dir_norm = Vector2(x_diff / vec_norm, y_diff / vec_norm)
	var laser_end: Vector2 = (laser_max_length * dir_norm)
	
	print("Laser end: ", laser_end)
	
	laser_line.points = [Vector2(0, -10), laser_end]

	laser_line.visible = true  # Show the laser line
	
	fade()

func fade():
	await get_tree().create_timer(0.05).timeout
	laser_line.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
