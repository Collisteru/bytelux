class_name LensColor

enum LENS_COLOR {
	RED, 
	BLUE, 
	GREEN
}

static func translate_color(c: LENS_COLOR) -> Color:
	match c:
		LENS_COLOR.RED:
			return Color(255, 0, 0)
		LENS_COLOR.GREEN:
			return Color(0, 255, 0)
		LENS_COLOR.BLUE:
			return Color(0, 0, 255)
	push_error("Unrecognized color")
	return Color(0, 0, 0)
