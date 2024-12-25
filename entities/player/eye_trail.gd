extends Line2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# tick is called every frame in parent node physics process. draw pos tells it 
# where to draw a new point and is moving tells it whether to start killing the 
# trail or not
func tick(draw_pos: Vector2, is_moving: bool) -> void:
	#print(is_moving)
	pass
	if is_moving:
		add_point(to_local(draw_pos))
		if points.size() > 32:
			remove_point(0)
	elif points.size() > 0:
		remove_point(0)
