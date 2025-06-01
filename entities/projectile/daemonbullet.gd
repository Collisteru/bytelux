
# Subclass of projectile
extends "res://entities/projectile/projectile.gd"



func _ready():
	set_color()
	# initialize the timer
	SPEED = 300
	direction = Vector2(0.0,1.0)
	lifespan = 4.0
	life_timer = lifespan
	


func _process(delta):
	# reduce the lifespan timer
	life_timer -= delta
	if life_timer <= 0:
		queue_free()

	# Maintain constant velocity in the given direction
	if direction != Vector2.ZERO:
		#print(direction)
		linear_velocity = direction * SPEED

func _on_area_2d_area_entered(area: Area2D) -> void:
	#print("HITTT area")
	if area.get_collision_layer_value(3):
		print("oops, area was a shield")
	else:
		queue_free()

func _on_area_2d_body_entered(_body: Node2D) -> void:
	#print("HITTT body")
	queue_free()
