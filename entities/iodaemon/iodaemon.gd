extends CharacterBody2D

@onready var projectile_scene = load("res://entities/projectile/daemonbullet.tscn")
@onready var spawnNode = $"bullet_spawn"

const SPEED = 100.0
const state_list = ["forward", "stars", "following_bullets"]

func _ready():
	velocity.x = SPEED

func fire():
	var projectile = projectile_scene.instantiate()
	projectile.global_position = spawnNode.global_position
	projectile.direction = Vector2(-1, -1)
	projectile.global_rotation = global_rotation
	get_parent().add_child(projectile)

func _physics_process(delta: float) -> void:
	print("Boss position: ", position.x)
	if position.x > 200:
		velocity.x = -1 * SPEED
	elif position.x < -400:
		velocity.x = SPEED
	
	move_and_slide()
