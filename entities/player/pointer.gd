extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func move(click_pos, global_position):
	position.x = click_pos.x
	position.y = click_pos.y
	print("\nclick_pos: ", click_pos)
	print("pos: ", self.position)
