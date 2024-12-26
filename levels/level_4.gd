@onready var door = $Door

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	door.set_next_level("res://levels/Level5.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
