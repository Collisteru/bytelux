extends RigidBody2D

const SPEED: float = 100.0
@export var lifespan: float = 3.0

# direction of projectile
var direction: Vector2 = Vector2.ZERO

# timer to track projectile's lifespan
var life_timer: float = 0.0

func _ready():
	# initialize the timer
	life_timer = lifespan

func _process(delta):
	# reduce the lifespan timer
	life_timer -= delta
	if life_timer <= 0:
		queue_free()

	# Maintain constant velocity in the given direction
	if direction != Vector2.ZERO:
		linear_velocity = direction * SPEED

func _on_area_2d_area_entered(_area: Area2D) -> void:
	#print("HITTT area")
	queue_free()

func _on_area_2d_body_entered(_body: Node2D) -> void:
	#print("HITTT body")
	queue_free()
