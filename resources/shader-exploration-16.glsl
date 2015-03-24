uniform float iOvertoneVolume;

void main(void)
{
  float t = iGlobalTime;

	vec2 uv = gl_FragCoord.xy / iResolution.xy;

  float w = 0.0;

  w = sin(
          sin(iGlobalTime * 13.5 + (3.0 * iOvertoneVolume)) *
          10.0 *
          pow(
              pow(uv.x, 1.0 + (2.0 * sin(iGlobalTime * 0.3))) + sin(uv.y *  + (19.0 * iOvertoneVolume)) / 10.0,
              (4.7 * sin(iGlobalTime * 0.2)) + (1.5 * sin(iGlobalTime * 0.2))
              )
          );

  gl_FragColor = vec4(w, w, w, 1.0);

}
