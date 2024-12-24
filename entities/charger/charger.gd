extends CharacterBody2D

@onready var targetNode = $'../Player'
@onready var hitbox = $"Hitbox"
@onready var onSprite = $"On"
@onready var offSprite = $"Off"

# to be used for turning an enemy on/off
var mode = true
# enemies may care about the current lens
enum LENS_COLOR {RED, BLUE, GREEN, WHITE}
var lens = LENS_COLOR.RED

var health = 1
const SPEED = 0 #100.0
const ACCELERATION = 10.0
const ENGAGE_DIST = 150.0
const AGRO_RANGE = 300.0

var direction_x = 0
var direction_y = 0

var charging = false
const CHARGING_ACCELERATION = 4*ACCELERATION
const CHARGING_SPEED = 300.0

func death() -> void:
	#TODO animation
	queue_free()

func _physics_process(_delta: float) -> void:	
	reset_lens()
	if health == 0:
		death()

	if targetNode:
		if can_see(targetNode):
			custom_move(targetNode)
		else:
			velocity.x = move_toward(velocity.x, 0, ACCELERATION)
			velocity.y = move_toward(velocity.y, 0, ACCELERATION)
	else:
		print("AHHHHH, I DON'T KNOW WHAT I'M FOLLOWING")
		# Should only happen if you don't give this node a target node
	
	move_and_slide()

func reset_lens():
	lens = targetNode.lens

func change_activeness():
	mode = not mode
	if mode:
		set_on()
	else:
		set_off()
	
func set_off():
	onSprite.visible = false
	offSprite.visible = true
	
func set_on():
	onSprite.visible = true
	offSprite.visible = false

func can_see(target):
	return (self.position - target.position).length() < AGRO_RANGE
	
# note: this is called and a final move_and_slide() is called after
#       So this should just set velocity
# Default was ripped from guard enemy
func custom_move(target):
	look_at(target.position)
	if not charging:
		direction_x = sign(target.position.x - self.position.x)
		direction_y = sign(target.position.y - self.position.y)

	var currentAcceleration = ACCELERATION
	var topSpeed = SPEED
	
	if charging:
		currentAcceleration = CHARGING_ACCELERATION
		topSpeed = CHARGING_SPEED

	#Handle diagonal (xy) movement
	if direction_x != 0 and direction_y != 0:
		velocity.x = move_toward(velocity.x,direction_x * topSpeed/sqrt(2),currentAcceleration/sqrt(2))
		velocity.y = move_toward(velocity.y,direction_y * topSpeed/sqrt(2),currentAcceleration/sqrt(2))
	# Handles single direction (x or y) movement
	else:	
		# Handle horizontal (x) movement
		if direction_x != 0:
			#velocity.x = direction_x * SPEED
			velocity.x = move_toward(velocity.x,direction_x * SPEED,ACCELERATION)
		else:
			velocity.x = move_toward(velocity.x, 0, ACCELERATION)
		
		# Handle vertical (y) movement
		if direction_y != 0:
			#velocity.y = direction_y * SPEED
			velocity.y = move_toward(velocity.y,direction_y * SPEED,ACCELERATION)
		else:
			velocity.y = move_toward(velocity.y, 0, ACCELERATION)
			
	if velocity.length() == topSpeed:
		charging = false
	
func _on_hitbox_area_entered(_area: Area2D) -> void:
	print("HI")
	health -= 1

func _on_timer_timeout() -> void:
	charging = true
	pass
