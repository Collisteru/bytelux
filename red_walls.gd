extends TileMapLayer

@onready var player = $'../Player'
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player:
		if LensColor.lens == LensColor.LENS_COLOR.RED:
			collision_enabled = false
			visible = false
		else:
			collision_enabled = true
			visible = true
