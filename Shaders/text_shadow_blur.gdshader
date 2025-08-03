shader_type canvas_item;

uniform float blur_radius = 2.0;

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	if (col.rgb == vec3(0.0)) {
		vec4 sum = vec4(0.0);
		for (int x = -2; x <= 2; x++) {
			for (int y = -2; y <= 2; y++) {
				vec2 offset = vec2(float(x), float(y)) * blur_radius / 100.0;
				vec4 sample = texture(TEXTURE, UV + offset);
				sum += sample;
			}
		}
		COLOR = sum / 25.0; // 5x5 kernel
	} else {
		COLOR = col;
	}
}
