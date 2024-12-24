extends CharacterBody2D

@export var SPEED = 100

var dir : float
var spawnPos : Vector2
var spawnRot : float

# Called when the node enters the scene tree for the first time.
func _ready():
	global_position = spawnPos
	global_rotation = spawnRot

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
	velocity = Vector2(0,-SPEED).rotated(dir)
	move_and_slide()

func _on_life_timeout() -> void:
	print("I lived too long")
	queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	#print("HITTT area")
	queue_free()
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	#print("HITTT body")
	queue_free()
