extends Node

signal lens_changed(c: LensColor.LENS_COLOR)

var lens = LENS_COLOR.WHITE

enum LENS_COLOR {
	RED, 
	BLUE, 
	GREEN,
	WHITE
}

static func translate_color(c: LENS_COLOR) -> Color:
	match c:
		LENS_COLOR.RED:
			return Color(255, 0, 0)
		LENS_COLOR.GREEN:
			return Color(0, 255, 0)
		LENS_COLOR.BLUE:
			return Color(0, 0, 255)
		LENS_COLOR.WHITE:
			return Color(255,255,255)
	push_error("Unrecognized color")
	return Color(0, 0, 0)

func change_lens(c: LENS_COLOR):
	print("Sending signal")
	lens_changed.emit(c)
	lens = c
