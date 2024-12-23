extends RayCast2D

func fire_laser(laser_position, player_position):
	#
	#print("laser_position:  ", laser_position)
	#print("Player Position: ", player_position)
	# Calculate angle
	var x_diff = laser_position.x
	var y_diff = laser_position.y
	
	var angle;
	
	# X increases left to right, y increases top to bottom
	# We need to resolve the angle for each quadrant to make the trig work
	
	
	# Quadrant I (top-right, pos x_diff, neg y_diff)
	print("X_diff: ", x_diff, "Y diff: ", y_diff)
	if (x_diff >= 0 and y_diff < 0):
		angle = atan(y_diff / x_diff)
	# Quadrant II (top-left, neg x_diff, neg y_diff
	elif (x_diff < 0 and y_diff < 0):
		print("Quad 2!")
		angle = atan(y_diff / x_diff)
	
	print("Laser fired from ", player_position, " at angle ", angle)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
