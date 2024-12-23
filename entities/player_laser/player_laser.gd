extends RayCast2D

@onready var laser_line = $LaserLine2D
@onready var hit_circle = $HitCircle


# TODO: This is a placeholder until wall collision code is programmed
@onready var laser_max_length = 1000  # Max length of the laser

func _ready():
	laser_line.visible = false  # Initially hidden
	hit_circle.visible = false
	self.enabled = true # Enable Raycast 2D


func fire_laser(laser_position, screen_player_position, node):
	#print("laser_position:  ", laser_position)
	#print("Player Position: ", player_position)
	# Calculate angle
	var x_diff = laser_position.x
	var y_diff = laser_position.y
	
	# Find the laser's direction
	var vec_norm = sqrt(pow(x_diff,2) + pow(y_diff, 2));
	var direction_norm = Vector2(x_diff / vec_norm, y_diff / vec_norm)
	
	# Raycast in this direction	
	self.target_position = direction_norm * laser_max_length
	#self.target_position = laser_position * laser_max_length
	self.force_raycast_update()  # Ensure RayCast2D updates immediately
	
	# Check for collision
	if self.is_colliding():
		print("Is colliding!")
		# Get global collision point
		var global_collision_point = self.get_collision_point()
		print("coord: ",global_collision_point)
		
		
		print("Global collision point: ", global_collision_point)
		
		
		# Transform global to camera point
		
		#print("Global player position: ", global_player_position)

		var refplayer_col_point = node.to_local(global_collision_point);
		
		# TODO: For debugging. Make circle appear for collision point
		hit_circle.position = refplayer_col_point;
		hit_circle.visible = true

		laser_line.points = [Vector2.ZERO, refplayer_col_point]
	else:
		print("Is not colliding!")
		laser_line.points = [Vector2.ZERO, laser_max_length * Vector2(laser_position.x, laser_position.y +3)]

	laser_line.visible = true  # Show the laser line
	
	laser_line.modulate.a = 1.0;
	laser_line.visible = true  # Show the laser line
	
	fade()

func fade():
	
	# Total time for the laser to disappear in seconds
	var fade_time = 0.1
	
	var millisecond = 0.01
	
	# Make the laser line fade otu
	while (laser_line.modulate.a > 0.0):
		await get_tree().create_timer(millisecond).timeout;
		laser_line.modulate.a -= (millisecond/(fade_time));
	
	laser_line.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
