shader_type canvas_item;

uniform float scroll_y = 0.0;

void fragment() {
	vec2 uv = UV;
	uv.y += scroll_y * 0.001; // velocidad de desplazamiento
	COLOR = texture(TEXTURE, uv);
}