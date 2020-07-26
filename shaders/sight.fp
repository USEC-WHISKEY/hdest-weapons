uniform float timer;

float random (vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}


vec4 Process(vec4 color)
{
  vec2 texCoord = gl_TexCoord[0].st;
  const float pi = 3.14159265358979323846;
  vec2 offset = vec2(0,0);
  float rng = random(texCoord + vec2(timer, timer));
  //offset.y = cos(pi * (texCoord.y + timer * 10)) * 0.1;
  //offset.x = sin(pi * 2.0 * (rng)) * 0.1;
  color[0] *= rng;
  color[1] *= rng;
  color[2] *= rng;
  return getTexel(texCoord) * color;
}