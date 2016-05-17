extern vec2  size    = vec2(800,600);
extern int   samples = 15;    // pixels per axis; higher = bigger glow, worse performance
extern float quality = 12.5; // lower = smaller glow, better quality

vec4 effect(vec4 colour, Image tex, vec2 tc, vec2 sc)
{
  vec4 source     = Texel(tex, tc);
  vec4 sum        = vec4(0);
  int  diff       = (samples - 1) / 2;
  vec2 sizeFactor = vec2(1) / size * quality;
  
  for (int x = -diff; x <= diff; x++)
  {
    for (int y = -diff; y <= diff; y++)
    {
      vec2 offset = vec2(x, y) * sizeFactor;
      sum += Texel(tex, tc + offset);
    }
  }
  
  return ((sum / (samples * samples)) + source) * colour;
}