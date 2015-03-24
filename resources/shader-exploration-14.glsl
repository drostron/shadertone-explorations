uniform float iOvertoneVolume;

vec4 blue_lines() {
  float v = iOvertoneVolume;
  float t = iGlobalTime;

  vec2 uv = 2.0*(gl_FragCoord.xy/iResolution.xy) - 1.0;

  float r, g, b = 0.0;
  float i, j, k = 0.0;

  float z = 6 + 4*sin(t);

  i = sin(pow(uv.x*z,2)+ abs(sin(t*70)*pow(uv.y*z,2)));
  j = pow(i, 50*abs(sin(t*4*v)));
  b = j;

  return vec4(r, g, b, 1.0);
}

vec4 name_tbd() {
  float v = iOvertoneVolume;
  float t = iGlobalTime;

  vec2 uv = 2.0*(gl_FragCoord.xy/iResolution.xy) - 1.0;

  float r, g, b = 0.0;
  float h, i, j, k = 0.0;

  float vv = 1.0;
  float z = 2;
  float w = 1000 + (1000 * pow(sin(t*3),3));

  h = (w * pow(uv.x*z,2)) + pow(uv.y*z,2);
  i = sin(h);
  if (h > 4) {
    i = 0.0;
  }
  j = pow(i, 50*abs(sin(vv*4)));
  b = j;

  return vec4(r, g, b, 1.0);
}

void main(void)
{
  float t = iGlobalTime;

  gl_FragColor = mix(blue_lines(), name_tbd(), 1.0);
}
