extends CharacterBody2D

const SPEED = 300.0
const ACCELERATION = 30.0
var player_is_alive

# Import child nodes
#@onready var sprite = $PlayerSprite # TODO: remove when done debugging
#@onready var pointer = $Pointer # TODO: remove when done debugging
@onready var body = $BodySprite
@onready var player_camera = $Camera2D
@onready var color_hud = $HUDCanvasLayer/HUD/HBoxContainer/HudSprite
@onready var hitbox = $Area2D/Hitbox

# Import Player SFX
@onready var death_sfx = $DeathSFX
@onready var lens_sfx = $LensShiftSFX
@onready var laser_sfx = $LaserSFX
@onready var walk_sfx = $WalkSFX

@onready var eyes = [] # eyes right to left
@onready var eye_trail_scene = load("res://entities/player/eye_trail.tscn")
@onready var eye_trails = [] # eyes right to left
@onready var laser_scene = load("res://entities/player_laser/playerLaser.tscn")

# Preload HUD textures
@onready var hud_red = preload('res://assets/hud_color_r.png')
@onready var hud_blue = preload('res://assets/hud_color_b.png')
@onready var hud_green = preload('res://assets/hud_color_g.png')

# Preload HUD inverse textures
@onready var hud_iblue = preload('res://assets/hud_inverse_b.png')
@onready var hud_ired = preload('res://assets/hud_inverse_r.png')
@onready var hud_igreen = preload('res://assets/hud_inverse_g.png')

# Preload HUD tilted textures
@onready var hud_ltilt_r = preload('res://assets/hud_ltilrt_r.png')
@onready var hud_rtilt_r = preload('res://assets/hud_rtilt_r.png')
@onready var hud_ltilt_g = preload('res://assets/hud_ltilt_g.png')
@onready var hud_rtilt_g = preload('res://assets/hud_rtilt_g.png')
@onready var hud_ltilt_b = preload('res://assets/hud_ltilt_b.png')
@onready var hud_rtilt_b = preload('res://assets/hud_rtilt_b.png')


func _ready():
	# Set player living/death flag
	player_is_alive = true
	LensColor.connect("lens_changed", _on_lens_changed)
	eyes.append($HeadSprite/Eyes/EyeGlowAmbient_R)
	eyes.append($HeadSprite/Eyes/EyeGlowAmbient_L)
	
	walk_sfx.playing = false
	
	# eye trails
	for n in eyes.size():
		var trail = eye_trail_scene.instantiate()
		eye_trails.append(trail)
		add_child(trail)
		
	body.rotation = self.rotation
	self.rotation = 0
		
func create_laser():
	
	laser_sfx.playing = true
	
	var newLaser = laser_scene.instantiate()
	var laser_length = 1000
	
	newLaser.name = str(2)
	newLaser.position = self.position
	newLaser.target_position = laser_length * (get_parent().get_local_mouse_position() - self.position).normalized()
	newLaser.bounces = 2
	get_parent().add_child(newLaser)

func is_default_color_locked() -> bool:
	if LensColor.lens == LensColor.LENS_COLOR.WHITE:
		return true
	else:
		return false

func _input(event: InputEvent) -> void:
	if player_is_alive:
		# Get player's response to mouse events
		if event is InputEventMouseButton and event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:

				create_laser()
				
			elif event.button_index == MOUSE_BUTTON_RIGHT:
				rotate_right()

			elif event.button_index == MOUSE_BUTTON_MIDDLE:
				rotate_left()

			
		# Get player's response to key events
		if event is InputEventKey and event.pressed:
			# Handle changing lens colors
			match event.keycode:
				KEY_META, KEY_ALT, KEY_SHIFT: # (blue to green, green to red, red to blue
					rotate_left()
				KEY_SPACE, KEY_CAPSLOCK: # (blue to red, red to green, green to blue
					rotate_right()
					
func rotate_left():
	# Rotates lens triangle counterclockwise
	if not is_default_color_locked():
		lens_sfx.playing = true
		if (LensColor.lens == LensColor.LENS_COLOR.BLUE):
			LensColor.change_lens(LensColor.LENS_COLOR.GREEN)
			change_hud('B', 'G')
		elif (LensColor.lens == LensColor.LENS_COLOR.GREEN):
			LensColor.change_lens(LensColor.LENS_COLOR.RED)
			change_hud('G', 'R')
		elif (LensColor.lens == LensColor.LENS_COLOR.RED):
			LensColor.change_lens(LensColor.LENS_COLOR.BLUE)
			change_hud('R', 'B')
			
func rotate_right():
	# Rotates lens triangle clockwise
	if not is_default_color_locked():
		lens_sfx.playing = true
		if (LensColor.lens == LensColor.LENS_COLOR.BLUE):
			LensColor.change_lens(LensColor.LENS_COLOR.RED)
			change_hud('B', 'R')
		elif (LensColor.lens == LensColor.LENS_COLOR.RED):
			LensColor.change_lens(LensColor.LENS_COLOR.GREEN)
			change_hud('R', 'G')
		elif (LensColor.lens == LensColor.LENS_COLOR.GREEN):
			LensColor.change_lens(LensColor.LENS_COLOR.BLUE)
			change_hud('G', 'B')

	

func change_hud(old_color, new_color):
	# True tick is 0.07
	var tick = 0.09
	if old_color == 'R':
		if new_color == 'G':
			color_hud.set_texture(hud_rtilt_r)
			await get_tree().create_timer(tick).timeout
			color_hud.set_texture(hud_iblue)
			await get_tree().create_timer(tick).timeout
			color_hud.set_texture(hud_ltilt_g)
			await get_tree().create_timer(tick).timeout
			color_hud.set_texture(hud_green)
		elif new_color == 'B':
			color_hud.set_texture(hud_ltilt_r)
			await get_tree().create_timer(tick).timeout
			color_hud.set_texture(hud_igreen)
			await get_tree().create_timer(tick).timeout
			color_hud.set_texture(hud_rtilt_b)
			await get_tree().create_timer(tick).timeout
			color_hud.set_texture(hud_blue)
	if old_color == 'G':
		if new_color == 'R':
			color_hud.set_texture(hud_ltilt_g)
			await get_tree().create_timer(tick).timeout
			color_hud.set_texture(hud_iblue)
			await get_tree().create_timer(tick).timeout
			color_hud.set_texture(hud_rtilt_r)
			await get_tree().create_timer(tick).timeout
			color_hud.set_texture(hud_red)
		elif new_color == 'B':
			color_hud.set_texture(hud_rtilt_g)
			await get_tree().create_timer(tick).timeout
			color_hud.set_texture(hud_ired)
			await get_tree().create_timer(tick).timeout
			color_hud.set_texture(hud_ltilt_b)
			await get_tree().create_timer(tick).timeout
			color_hud.set_texture(hud_blue)
	if old_color == 'B':
		if new_color == 'G':
			color_hud.set_texture(hud_ltilt_b)
			await get_tree().create_timer(tick).timeout
			color_hud.set_texture(hud_ired)
			await get_tree().create_timer(tick).timeout
			color_hud.set_texture(hud_rtilt_g)
			await get_tree().create_timer(tick).timeout
			color_hud.set_texture(hud_green)
		elif new_color == 'R':
			color_hud.set_texture(hud_rtilt_b)
			await get_tree().create_timer(tick).timeout
			color_hud.set_texture(hud_igreen)
			await get_tree().create_timer(tick).timeout
			color_hud.set_texture(hud_ltilt_r)
			await get_tree().create_timer(tick).timeout
			color_hud.set_texture(hud_red)


func die(_camera = player_camera) -> void:
	
	# Set player_is_alive flag to false, making it impossible to perform player actions
	player_is_alive = false
	
	# Stop level music
	LevelMusicPlayerS.playing = false
	
	# Play Death sound
	death_sfx.playing = true
	
	# Remove walking sound
	walk_sfx.playing = false
	
	# Spawn playerdeathparticles
	# Instance the particle scene
	var particle_scene = preload("res://entities/particles/player_explosion_node.tscn").instantiate()
	
	# Make player invisible.
	self.visible = false
	
	# Remove player hitbox
	hitbox.queue_free()
	
	# Assign position of the particles to be the same as the player
	particle_scene.position = self.position
	
	# Add the particle scene to the parent
	get_parent().add_child(particle_scene)
	
	# Clear player from scene
	# Wait for a time equal to the duration of the particle effect then 
	
	var tree = get_tree()
	
	await tree.create_timer(3.3).timeout

	tree.change_scene_to_file("res://screens/lose/lose.tscn")
	#tree.change_scene_to_file("res://levels/Shield Intro Vic/Shielder Intro.tscn")
	

func _physics_process(_delta: float) -> void:
	# Get the input direction
	if player_is_alive:
		var direction_x := Input.get_axis("ui_left", "ui_right")
		var direction_y := Input.get_axis("ui_up", "ui_down")

		# Handle diagonal (xy) movement
		if direction_x != 0 and direction_y != 0:
			velocity.x = move_toward(velocity.x,direction_x * SPEED/sqrt(2),ACCELERATION/sqrt(2))
			velocity.y = move_toward(velocity.y,direction_y * SPEED/sqrt(2),ACCELERATION/sqrt(2))
		# Handles single direction (x or y) movement
		else:
			# Handle horizontal (x) movement
			if direction_x != 0:
				#velocity.x = direction_x * SPEED
				velocity.x = move_toward(velocity.x,direction_x * SPEED,ACCELERATION)
			else:
				velocity.x = move_toward(velocity.x, 0, ACCELERATION)
			# Handle vertical (y) movement
			if direction_y != 0:
				#velocity.y = direction_y * SPEED
				velocity.y = move_toward(velocity.y,direction_y * SPEED,ACCELERATION)
			else:
				velocity.y = move_toward(velocity.y, 0, ACCELERATION)
		
		var is_moving = false
		if(velocity.length() != 0):
			if (!walk_sfx.playing): 
				walk_sfx.playing = true
			is_moving = true
			body.pointForwards(velocity.angle())
			body.play("walk")
		else:
			walk_sfx.playing = false
			body.tryStop()

		move_and_slide()
		
		for n in eye_trails.size():
			eye_trails[n].tick(eyes[n].global_position, is_moving)

func change_eye_color(lens):
	var cPrime
	match lens:
		LensColor.LENS_COLOR.RED:
			cPrime = Color(255, 0, 0)
		LensColor.LENS_COLOR.GREEN:
			cPrime = Color(0, 255, 0)
		LensColor.LENS_COLOR.BLUE:
			cPrime = Color(0, 0, 255)
		LensColor.LENS_COLOR.WHITE:
			cPrime = Color(255, 255, 255)
	
	for n in eyes.size():
		eyes[n].self_modulate = cPrime
		eye_trails[n].default_color = cPrime

# Handle bullet death
# TODO: rename function?
func _on_area_2d_area_entered(_area: Area2D) -> void:
	self.die()

func _on_area_2d_body_entered(_body: Node2D) -> void:
	self.die()


func _on_lens_changed(lens: LensColor.LENS_COLOR) -> void:
	#print("Signal received")
	change_eye_color(lens)
	match lens:
		LensColor.LENS_COLOR.RED:
			color_hud.set_texture(hud_red)
		LensColor.LENS_COLOR.GREEN:
			color_hud.set_texture(hud_green)
		LensColor.LENS_COLOR.BLUE:
			color_hud.set_texture(hud_blue)
	pass # Replace with function body.
