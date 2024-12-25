shader_type canvas_item;

uniform vec4 Mask : source_color;
uniform float Clip : hint_range(0.0, 1.0);
uniform float ClipFeather : hint_range(0.0, 1.0);
uniform vec4 TargetColor : source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 px = texture(TEXTURE, UV);
	float diff = distance(px, Mask);
	if (diff < Clip) {
		COLOR = TargetColor;
	} else if (diff > Clip && diff < (Clip + ClipFeather)) {
		vec4 lineC = vec4(0, 0, 0, 0.5);
		vec4 outC = vec4(0, 0, 0, 0);
		outC.a = 1.0 - (lineC.a) * (1.0 - TargetColor.a);
		outC.r = lineC.r * lineC.a / outC.a + TargetColor.r * lineC.a * (1.0 - lineC.a) / outC.a;
		outC.g = lineC.g * lineC.a / outC.a + TargetColor.g * lineC.a * (1.0 - lineC.a) / outC.a;
		outC.b = lineC.b * lineC.a / outC.a + TargetColor.b * lineC.a * (1.0 - lineC.a) / outC.a;
		COLOR = outC;
	} else {
		COLOR = texture(TEXTURE, UV);
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
