extends "res://entities/enemy_base/enemy_base.gd"

#@onready var hitbox = $Hitbox
#@onready hitbox.connect
###################
@onready var projectile_scene = load("res://entities/projectile/projectile.tscn")

enum frames {AIMING = 0, NEUTRAL = 1}

var readied = false
const RELOAD_TIME = 2.0
const AIM_TIME = 1.0

func _ready() -> void:
	sprites["bodySprite"] = $"BodySprite"
	sprites["legSprite"] = $"LegSprite"
	super()

#func applyColor(color: Color) -> void:
	#sprite.get_material().set_shader_parameter("TargetColor", Vector4(color.r, color.g, color.b, 1.0))

@onready var spawnNode = $"Bullet Spawn point"


func death() -> void:
	#TODO animation
	# Instance the particle scene
	var particle_scene = preload("res://entities/particles/enemy_explosion.tscn").instantiate()
	
	# Assign position of the particles to be the same as the enemy
	particle_scene.position = self.position
	
	# Add the particle scene to the parent
	get_parent().add_child(particle_scene)
	
	queue_free()

func _physics_process(_delta: float) -> void:	
	if health <= 0:
		death()

	if targetNode:
		if can_see(targetNode) and targetNode.player_is_alive:
			custom_move(targetNode)
			sprites["legSprite"].play('walk')
		else:
			velocity.x = move_toward(velocity.x, 0, ACCELERATION)
			velocity.y = move_toward(velocity.y, 0, ACCELERATION)
			sprites["legSprite"].stop()
	else:
		print("AHHHHH, I DON'T KNOW WHAT I'M FOLLOWING")
		# Should only happen if you don't give this node a target node
	
	move_and_slide()
	
# TODO: remove after debugging
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_4:
				fire()

func can_see(target):
	return (self.position - target.position).length() < AGRO_RANGE

func custom_move(target):
	look_at(target.position)
	var dist = (self.position - target.position).length()
	
	#-1 to retreat and 1 to approach. Used in figuring out which direction to go
	var approach = 2*int(dist > ENGAGE_DIST) - 1
	
	var direction_x = approach * sign(targetNode.position.x - self.position.x)
	var direction_y = approach * sign(targetNode.position.y - self.position.y)

	#Handle diagonal (xy) movement
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

func fire():
	var projectile = projectile_scene.instantiate()
	projectile.color = myColor
	projectile.global_position = spawnNode.global_position
	projectile.direction = Vector2.RIGHT.rotated(global_rotation)
	projectile.global_rotation = global_rotation
	get_parent().add_child(projectile)
	
func _on_timer_timeout() -> void:
	if targetNode.player_is_alive:
		if readied:
			fire()
			timer.start(RELOAD_TIME)
			readied = false
			sprites["bodySprite"].frame = frames.NEUTRAL
		else:
			timer.start(AIM_TIME)
			readied = true
			sprites["bodySprite"].frame = frames.AIMING

func try_stop():
	if sprites["legsSprite"].frame == 6 or sprites["legSprite"].frame == 0:
		sprites["legSprite"].stop()
