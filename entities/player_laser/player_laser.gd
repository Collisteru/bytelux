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
	laser_line.default_color = set_laser_color(LensColor.lens)
	
	hit_circle.visible = false
	self.enabled = true # Enable Raycast 2D
	project()
	fade()

func project():
	self.force_raycast_update()
	
	# TODO: delete debugging	
	hit_circle.position = 0.001 * self.target_position
	#hit_circle.visible = true
	
	if self.is_colliding():
		# Get global collision point
		var collision_point = to_local(get_collision_point())
		var reach = 2  #how much the hurtbox should extend from the raycast
		laser_line.points = [Vector2.ZERO, collision_point]
		
		var newHurtLine = SegmentShape2D.new()
		newHurtLine.a = Vector2.ZERO
		newHurtLine.b = collision_point+reach*collision_point.normalized()
		laser_hurt.shape = newHurtLine
		
		var collided = self.get_collider()
		
		if (collided is EnemyBase) or ((collided is Area2D) and (not collided.get_collision_layer_value(1))):
			bounces = 0
		
	else:
		laser_line.points = [Vector2.ZERO, self.target_position]
		
		var newHurtLine = SegmentShape2D.new()
		newHurtLine.a = Vector2.ZERO
		newHurtLine.b = self.target_position
		laser_hurt.shape = newHurtLine
	laser_line.material.set_shader_parameter('vanishing_value', 0);
	laser_line.visible = true
			
	if bounces > 0:
		#print("bounced")
		create_laser()
	else:
		print("\n")

func set_laser_color(color):
	if color == LensColor.LENS_COLOR.WHITE:
		return Color(255, 255, 255)
	elif color == LensColor.LENS_COLOR.RED:
		return Color(255, 1, 1)
	elif color == LensColor.LENS_COLOR.BLUE:
		return Color(1, 1, 255)
	elif color == LensColor.LENS_COLOR.GREEN:
		return Color(1, 255, 1)
#

func create_laser():
	var laser = laser_scene.instantiate()
	var laser_length = 1000
	
	var pre_reflect = target_position.normalized()
	var normal = get_collision_normal()
	var post_reflect = pre_reflect.bounce(normal).normalized()
	
	#print("This laser is going to ", self.target_position, " and the normal seen is ", normal)
	
	var area_child_index = 1
	
	laser.get_child(area_child_index).set_collision_layer_value(5,true)
	#print("DANGER!!!", laser.get_child(area_child_index).get_collision_layer_value(5))
	
	
	laser.name = str(bounces-1)
	laser.position = self.get_collision_point()
	laser.target_position = laser_length * (post_reflect)
	laser.bounces = self.bounces-1
	get_parent().add_child(laser)

func fade():
	
	# Total time for the laser to disappear in seconds
	var fade_time = 0.1
	
	var millisecond = 0.01
	
	# Make the laser line fade out
	var current_invisibility = laser_line.material.get_shader_parameter('vanishing_value')
	while (current_invisibility < 1):
		await get_tree().create_timer(millisecond).timeout;
		var new_invisibility =  current_invisibility+millisecond/(fade_time)
		if new_invisibility > 1:
			current_invisibility = 1
		else:
			current_invisibility = new_invisibility
		laser_line.material.set_shader_parameter('vanishing_value', current_invisibility)
		#laser_line.material.shader_parameter/vanishing_value
		#laser_line.modulate.a -= (millisecond/(fade_time));
		
	free()
