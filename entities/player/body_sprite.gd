extends AnimatedSprite2D

@onready var _tryStop = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _tryStop and self.is_playing():
		if self.frame == 5 or self.animation_finished:
			_tryStop = false
			self.stop()

func pointForwards(angle: float) -> void:
	rotation = lerp_angle(rotation, angle, 0.1)

func tryStop() -> void:
	if self.animation == "walk":
		_tryStop = true
