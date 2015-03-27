uniform float iOvertoneVolume;

void main(void)
{
  float t = iGlobalTime;

  float vol = iOvertoneVolume;

	vec2 uv = gl_FragCoord.xy / iResolution.xy;

  float u, v, w, i = 0.0;

  vec4 z;

  i = pow(pow(0.5 - uv.x, 2.0) + pow(0.5 - uv.y, 11.0), 0.5) * 13.0 * vol;

  v = pow(0.5 - uv.x, 3.0 * (vol * 0.3)) + (i * sin(t * 0.3));

  z = vec4(i, v, i, 1.0);

  gl_FragColor = z;

}
