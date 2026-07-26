shader_type canvas_item;

uniform vec4 glow_color : source_color = vec4(0.9, 0.9, 0.8, 0.1);
uniform float glow_thickness : hint_range(0.0, 10.0) = 1.0;
uniform float glow_intensity : hint_range(0.0, 5.0) = 1.5;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    vec2 size = TEXTURE_PIXEL_SIZE * glow_thickness;
    
    // Sample surrounding pixels to detect edges
    float alpha = 0.0;
    for (float x = -1.0; x <= 1.0; x += 1.0) {
        for (float y = -1.0; y <= 1.0; y += 1.0) {
            if (x == 0.0 && y == 0.0) continue;
            alpha += texture(TEXTURE, UV + vec2(x, y) * size).a;
        }
    }
    
    // Smooth and scale the halo outline
    alpha = clamp(alpha, 0.0, 1.0);
    vec4 glow = glow_color * alpha * glow_intensity;
    
    // Layer the original sprite on top of the glowing aura
    COLOR = mix(glow, tex_color, tex_color.a);
}