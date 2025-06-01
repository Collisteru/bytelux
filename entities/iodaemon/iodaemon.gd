extends CharacterBody2D

@onready var projectile_scene = load("res://entities/projectile/daemonbullet.tscn")
@onready var spawnNode = $"bullet_spawn"

const AMPLITUDE = 200.0  # Peak horizontal speed (px/sec)
const FREQUENCY = 0.1    # Oscillations per second (0.5 Hz = one cycle in 2s)

var move_type = "oscillate"

var bullet_pattern = "direct_aim, star, sweep"

var time := 0.0

func _ready():
	velocity = Vector2.ZERO

func fire():
	var projectile = projectile_scene.instantiate()
	projectile.global_position = spawnNode.global_position
	projectile.direction = Vector2(-1, -1)
	projectile.global_rotation = global_rotation
	get_parent().add_child(projectile)

func _physics_process(delta: float) -> void:
	time += delta
	if move_type == "Oscillating":
		velocity.x = sin(time * TAU * FREQUENCY) * AMPLITUDE
	move_and_slide()
