const float RADIUS   = 0.95;
const float SOFTNESS = 0.45;
 
vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 texColor   = Texel(texture, texture_coords);
    vec2 position   = texture_coords - vec2(0.5);
    float len       = length(position);
    float vignette  = smoothstep(RADIUS, RADIUS-SOFTNESS, len);
    texColor.rgb    = mix(texColor.rgb, texColor.rgb * vignette, 1.0);
    return texColor;
}