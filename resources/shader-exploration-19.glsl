uniform float iOvertoneVolume;

void main(void)
{
  float t = iGlobalTime;

  float vol = iOvertoneVolume;

	vec2 uv = gl_FragCoord.xy / iResolution.xy;

  float u, v, w, i = 0.0;

  vec4 z;

  i = vol * 10 * pow(pow(0.5 - sin(uv.x * 111.0 * sin(t * 0.2)), 2.0) + pow(0.5 - sin(uv.y * 77.0), 11.0), 0.5) * 13.0;

  v = pow(0.5 - uv.x, 3.0 * (vol * 0.3)) + (i * sin(t * 0.3));

  w = pow(0.5 - uv.y, 3.0 * (vol * 0.3)) + (i * sin(t * 0.5));

  u = pow(0.5 - uv.x, 2.0) + pow(0.5 - uv.y, 2.0) + (i * sin(t * 0.7));

  z = vec4(v * sin(t), w * sin(t * 0.3), u * sin(t * 0.7), 1.0);

  gl_FragColor = z;

}
