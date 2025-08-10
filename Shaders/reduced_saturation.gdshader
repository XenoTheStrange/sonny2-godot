shader_type canvas_item;

uniform float saturation : hint_range(0.0, 1.0) = 1.0;

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
    vec3 desat = vec3(gray);
    COLOR = vec4(mix(desat, color.rgb, saturation), color.a);
}
