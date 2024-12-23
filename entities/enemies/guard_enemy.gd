extends CharacterBody2D

@export var targetNode:Node2D = null

const SPEED = 100.0
const ACCELERATION = 10.0
const ENGAGE_DIST = 150.0

func _physics_process(delta: float) -> void:
	if targetNode:
		look_at(targetNode.position)
		
		var dist = (self.position - targetNode.position).length()
		
		# -1 to retreat and 1 to approach. Used in figuring out which direction to go
		var approach = 2*int(dist > ENGAGE_DIST) - 1
		
		var direction_x = approach * sign(targetNode.position.x - self.position.x)
		var direction_y = approach * sign(targetNode.position.y - self.position.y)
		
		#print("x: ", direction_x)
		#print("y: ", direction_y)

		# Handle diagonal (xy) movement
		if direction_x != 0 and direction_y != 0:
			velocity.x = move_toward(velocity.x,direction_x * SPEED/sqrt(2),ACCELERATION/sqrt(2))
			velocity.y = move_toward(velocity.y,direction_y * SPEED/sqrt(2),ACCELERATION/sqrt(2))
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
		
		move_and_slide()
	else:
		print("AHHHHH, I DON'T KNOW WHAT I'M FOLLOWING")
		# Should only happen if you don't give this node a target node
