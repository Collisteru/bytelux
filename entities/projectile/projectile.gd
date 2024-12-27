extends RigidBody2D

const SPEED: float = 100.0
@export var lifespan: float = 3.0
@onready var light2D = $PointLight2D

# direction of projectile
var direction: Vector2 = Vector2.ZERO
var color

# timer to track projectile's lifespan
var life_timer: float = 0.0

func _ready():
	set_color()
	# initialize the timer
	life_timer = lifespan
	
func set_color():
	if color == LensColor.LENS_COLOR.RED:
		light2D.color = Color('RED')
	elif color == LensColor.LENS_COLOR.BLUE:
		light2D.color = Color('BLUE')
	elif color == LensColor.LENS_COLOR.GREEN:
		light2D.color = Color('GREEN')
	

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
