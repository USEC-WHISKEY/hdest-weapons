uniform float timer;

float random (vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

vec4 Process(vec4 color)
{
  vec2 texCoord = gl_TexCoord[0].st;
  const float pi = 3.14159265358979323846;
  vec2 offset = vec2(0,0);
  //float rng = random(texCoord);
  offset.y = cos(pi * (texCoord.x + timer)) * 0.1;
  offset.x = sin(pi * (texCoord.y + timer)) * 0.1;
  texCoord += offset;
  return getTexel(texCoord) * color;
}