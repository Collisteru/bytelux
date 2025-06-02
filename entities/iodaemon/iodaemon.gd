extends CharacterBody2D

@onready var projectile_scene = load("res://entities/projectile/daemonbullet.tscn")
@onready var spawnNode = $"bullet_spawn"

# Horizontal movement for oscillate
const AMPLITUDE = 400.0  # Peak horizontal speed (px/sec)
const FREQUENCY = 0.2    # Oscillations per second (0.5 Hz = one cycle in 2s)
var move_type = "oscillate"
const patterns = ["direct_aim", "star", "sweep"]
var curr_pattern
var time := 0.0
var fire_cooldown := 0.0
const FIRE_INTERVAL := 0.2

func _ready():
	velocity = Vector2.ZERO
	curr_pattern = patterns[0]

func fire():
	var projectile = projectile_scene.instantiate()
	projectile.global_position = spawnNode.global_position
	projectile.direction = Vector2(-1, -1)
	projectile.global_rotation = global_rotation
	get_parent().add_child(projectile)

func _physics_process(delta: float) -> void:
	time += delta
	fire_cooldown -= delta

	if curr_pattern == "direct_aim" and fire_cooldown <= 0.0:
		fire()
		fire_cooldown = FIRE_INTERVAL
	
	if move_type == "oscillate":
		velocity.x = sin(time * TAU * FREQUENCY) * AMPLITUDE
	move_and_slide()
