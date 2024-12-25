extends Node2D

@export var font_resource: Font


const FONT_SIZE = 16

var matrix = []
var upd: int = 0
var move: float = 0
var columns: int = 0
var rows: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var viewport_size = get_viewport_rect().size
	columns = int(viewport_size.x / FONT_SIZE)
	rows = int(viewport_size.y / FONT_SIZE)-8

	font_resource = load("res://font/CARBON-DROID.ttf")
	if not font_resource:
		push_error("Failed to load font resource")
		return

	for f in range(columns):
		matrix.append([])
		for y in range(rows):
			if y == 0:
				randomize()
				matrix[f].append(Vector2(randi() & 1, int(randi() % 11)))
			else:
				matrix[f].append(Vector2(0, 1))

func mtrx() -> void:
	if upd == 10:
		upd = 0
		for f in range(columns):
			matrix[f][0] = Vector2(int(randi_range(0, 9)), int(randi() % 11))

	for f in range(columns):
		if matrix[f][0].y > 0:
			matrix[f].insert(0, Vector2(matrix[f][0].x, matrix[f][0].y - 1))
			matrix[f].remove_at(rows)  # Ensure the array length remains constant
		elif matrix[f][upd].y <= 0:
			matrix[f].insert(0, Vector2(randi() & 1, int(randi() % 11)))
			matrix[f].remove_at(rows)  # Ensure the array length remains constant

	upd += 1

# called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move += delta
	if move > 0.15:
		mtrx()
		move = 0
	queue_redraw()

func _draw() -> void:
	if not font_resource:
		return

	for f in range(columns):
		for y in range(rows):
			var col: Color
			if matrix[f][y].y == 10:
				col = Color(1, 1, 1, matrix[f][y].y * 0.1)
			else:
				col = Color(0, 1, 0, matrix[f][y].y * 0.1)
			draw_string(font_resource, Vector2(f * 16, y * 16 + 16), str(matrix[f][y].x),-3,0,FONT_SIZE,col)


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_start_pressed() -> void:
	#TODO move to tutorial
	pass


func _on_settings_pressed() -> void:
	# TODO move to settings
	pass
