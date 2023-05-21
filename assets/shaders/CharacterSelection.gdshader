shader_type canvas_item;

uniform vec4 color = vec4(0,0,0,1.0);
uniform float flashState : hint_range(0,1) = 0;

// runs for every pixel in a Sprite 2D and determines what color the pixel should be
void fragment() { 
	vec4 pixelColor = texture(TEXTURE, UV);
	COLOR = mix(pixelColor, color, flashState);
	COLOR.a *= pixelColor.a;
}
