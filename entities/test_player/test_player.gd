extends CharacterBody2D

const SPEED = 300.0
enum LENS_COLOR {RED, BLUE, GREEN, WHITE}
var lens = LENS_COLOR.WHITE

# Import child nodes
@onready var laser = $PlayerLaser
@onready var sprite = $PlayerSprite

func translate_to_center(position: Vector2) -> Vector2:
		# Get the size of the viewport
		var screen_size = get_viewport().get_visible_rect().size
		# Calculate the center of the screen
		var screen_center = screen_size / 2
		# Translate the position to be relative to the center
		return position - screen_center


func _input(event: InputEvent) -> void:
	# Get player's response to mouse events
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# By default, the click position is done with reference to the screen. We want it to be done with reference to the player position

		# Get positions
		# Get the player's global position
		var global_position = self.to_global(Vector2.ZERO)

		# Convert the global position to screen space
		var player_pos = self.get_global_transform_with_canvas()
		var player_position = player_pos.get_origin()
		
		var click_position: Vector2;
		# Get position w/ ref to player
		click_position.x = event.position.x - player_position.x
		click_position.y = event.position.y + 30 - player_position.y
		
		laser.fire_laser(click_position, player_position)
		
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
