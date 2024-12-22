extends CharacterBody2D

const SPEED = 300.0
enum LENS_COLOR {RED, BLUE, GREEN, WHITE}
var lens = LENS_COLOR.WHITE

# Import child nodes
@onready var laser = $PlayerLaser



func _input(event: InputEvent) -> void:
	# Get player's response to mouse events
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var player_position = self.position
		laser.fire_laser(event.position, player_position)
		
	# Get player's response to key events
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_1:
				self.lens = LENS_COLOR.RED
				RenderingServer.set_default_clear_color('RED')
			KEY_2:
				self.lens = LENS_COLOR.BLUE
				RenderingServer.set_default_clear_color('BLUE')
			KEY_3:
				self.lens = LENS_COLOR.GREEN
				RenderingServer.set_default_clear_color('GREEN')

func _physics_process(delta: float) -> void:
	# Get the input direction 
	var direction_x := Input.get_axis("ui_left", "ui_right")
	var direction_y := Input.get_axis("ui_up", "ui_down")
	
	# Handle horizontal (x) movement
	if direction_x != 0:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Handle vertical (y) movement
	if direction_y != 0:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
