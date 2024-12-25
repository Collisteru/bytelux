extends Area2D

@onready var player = $'../Player'
@onready var door = $DoorCollision

# TODO: reset this as game over or other screen
var pscene = load('res://levels/test_level.tscn')

# reference this door within your level scene
# and then pass the next level scene into this function
# all you have to do is just position the door!
func set_next_level(scene_path: String) -> void:
	pscene = load(scene_path)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func onSwitchScene():
	# this will delete 
	get_tree().change_scene_to_packed(pscene)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'):
		body.visible = false
		await get_tree().create_timer(0.5).timeout  # wait for 2 seconds
		onSwitchScene()
