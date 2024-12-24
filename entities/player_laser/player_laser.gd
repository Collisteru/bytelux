extends RayCast2D

@onready var laser_line = $"Laser area/LaserLine2D"
@onready var laser_hurt = $"Laser area/LaserHurtBox"
@onready var hit_circle = $HitCircle
@onready var laser_scene = load("res://entities/player_laser/playerLaser.tscn")


# TODO: This is a placeholder until wall collision code is programmed
var laser_max_length = 120  # Max length of the laser
var shooter = null
@export var bounces = 0

func initialize(player: Node2D) -> void:
	shooter = player

func _ready():
	print("hello world!")
	hit_circle.visible = false
	self.enabled = true # Enable Raycast 2D
	project()
	fade()

func project():
	self.force_raycast_update()
	
	hit_circle.position = 0.001 * self.target_position
	hit_circle.visible = true
	
	if self.is_colliding():
		# Get global collision point
		var collision_point = to_local(get_collision_point())
		var reach = 2#how much the hurtbox should extend from the raycast
		print("collision at ", collision_point)
		laser_line.points = [Vector2.ZERO, collision_point]
		laser_hurt.shape.a = Vector2.ZERO
		laser_hurt.shape.b = collision_point+reach*collision_point.normalized()
		
	else:
		print("Is not colliding!")
		laser_line.points = [Vector2.ZERO, self.target_position]
	laser_line.modulate.a = 1.0;
	laser_line.visible = true
			
	print("Bounces: ", bounces)
	if bounces > 0:
		create_laser()

#func recur(spawn):
#

#func fire_laser(shooter):
	##TODO: remove this
	#laser_line.default_color = Color('BLACK')
	#
	#var mouse_position = shooter.get_local_mouse_position()
	#var x_diff = mouse_position.x
	#var y_diff = mouse_position.y
	## Calculate angle
	## Find the laser's direction
	#var vec_norm = sqrt(pow(x_diff,2) + pow(y_diff, 2));
	#var direction_norm = Vector2(x_diff / vec_norm, y_diff / vec_norm)
	## Raycast in this direction	
	#self.target_position = direction_norm * laser_max_length
	##self.target_position = laser_position * laser_max_length
	#self.force_raycast_update()  # Ensure RayCast2D updates immediately
#
	## Check for collision
	#if self.is_colliding():
		## Get global collision point
		#var global_collision_point = self.get_collision_point()
		##print("coord: ",global_collision_point)
#
		##print("Global collision point: ", global_collision_point)
#
		## Transform global to camera point
		#
		##print("Global player position: ", global_player_position)
		#var refplayer_col_point = shooter.to_local(global_collision_point);
		## TODO: For debugging. Make circle appear for collision point
		##hit_circle.position = refplayer_col_point;
		##hit_circle.visible = true
		#laser_line.points = [Vector2.ZERO, refplayer_col_point]
		#laser_hurt.shape.a = Vector2.ZERO 
		#laser_hurt.shape.b = refplayer_col_point+2*refplayer_col_point.normalized()
		#
	#else:
		#print("Is not colliding!")
		#laser_line.points = [Vector2.ZERO, laser_max_length * Vector2(x_diff, y_diff).normalized()]
	#laser_line.modulate.a = 1.0;
	#laser_line.visible = true  # Show the laser line
	#
	#fade()

func create_laser():
	print("SELF REPLICATION!!!!")
	var laser = laser_scene.instantiate()
	var laser_length = 1000
	
	var pre_reflect = target_position.normalized()
	var normal = get_collision_normal()
	var post_reflect = pre_reflect.bounce(normal).normalized()
	
	laser.position = self.get_collision_point()
	laser.target_position = laser_length * (post_reflect)
	print("targetting: ", laser.target_position)
	laser.bounces = self.bounces-1
	get_parent().add_child(laser)

func fade():
	
	# Total time for the laser to disappear in seconds
	var fade_time = 0.1
	
	var millisecond = 0.01
	
	# Make the laser line fade otu
	while (laser_line.modulate.a > 0.0):
		await get_tree().create_timer(millisecond).timeout;
		laser_line.modulate.a -= (millisecond/(fade_time));
		
	free()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
