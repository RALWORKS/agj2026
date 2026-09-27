shader_type canvas_item;
uniform float desaturate;

void fragment() {
	vec4 sample = texture(TEXTURE, UV);
	float gray = 0.21 * sample.r + 0.71 * sample.g + 0.07 * sample.b;
	COLOR = vec4(sample.rgb * (1.0 - desaturate) + (gray * desaturate), sample.a);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
