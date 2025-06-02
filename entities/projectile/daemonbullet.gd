
# Subclass of projectile

extends "res://entities/projectile/projectile.gd"

func _ready(inlife=4.0):
	
	set_color()
	# initialize the timer
	SPEED = 300
	direction = Vector2(0.0,1.0)
	lifespan = inlife
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
	if area == self:
		return  # Ignore self
	queue_free()

func _on_area_2d_body_entered(_body: Node2D) -> void:
	if _body == self:
		return  # Ignore self
	queue_free()
