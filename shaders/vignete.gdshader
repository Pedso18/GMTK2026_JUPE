shader_type canvas_item;

// Exposed parameters to adjust in the Inspector or via GDScript
uniform vec4 tint_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform float vignette_intensity : hint_range(0.0, 5.0) = 0;
uniform float vignette_opacity : hint_range(0.0, 1.0) = 0;

void fragment() {
    // Measure distance from screen center (0.5, 0.5)
    vec2 uv = UV - vec2(0.5);
    float dist = length(uv);
    
    // Increase strength exponential towards the outer corners
    float factor = pow(dist * vignette_intensity, 2.0);
    factor = clamp(factor, 0.0, 1.0);
    
    // Apply red color with alpha fading out toward the center
    COLOR = vec4(tint_color.rgb, factor * vignette_opacity);
}