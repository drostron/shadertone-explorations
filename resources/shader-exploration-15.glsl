void main(void)
{
  float t = iGlobalTime;

  vec2 p = -1.0 + 2.0 * gl_FragCoord.xy / iResolution.xy;

  float w, z, i, m, n, o, j = 0.0;

  z = 1.0 - pow(p.x,0.4);

  i = pow(pow(p.x,2.0)+pow(p.y,2.0),0.5);

  m = 0.5 + (sin(t)*0.5);

  n = 0.5 + (sin(t/7.0)*0.5);

  o = smoothstep(m, n, z);

  j = smoothstep(m, n, i);

  w = mix(o, j, 0.5);

  gl_FragColor = vec4(w, w, w, 1.0);
}
