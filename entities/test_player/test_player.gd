extends CharacterBody2D

const SPEED = 300.0
enum LENS_COLOR {RED, BLUE, GREEN, WHITE}
var lens = LENS_COLOR.WHITE

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_1:
				print("Player pressed 1")
				self.lens = LENS_COLOR.RED
			KEY_2:
				print("Player pressed 2")
				self.lens = LENS_COLOR.BLUE
			KEY_3:
				print("Player pressed 3")
				self.lens = LENS_COLOR.GREEN

func _physics_process(delta: float) -> void:
	# Get the input direction for left/right and up/down
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
