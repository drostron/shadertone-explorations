uniform float iOvertoneVolume;
float pi = 3.1415;
void main(void)
{
    vec2 uv = 2.0*(gl_FragCoord.xy/iResolution.xy) - 1.0;
    float i,j,k = 0.0;
    float t = iGlobalTime;
    float vol = iOvertoneVolume;

    i += 1 - abs(
                 (2.4 * uv.x + (
                                sin(0.1 * (iGlobalTime + (vol*100)) + (uv.y * (7 + (vol*7)))) +
                                sin(iGlobalTime + (uv.y * 13)))) *
                 (1 + (vol * 50)));

    j += abs(sin(t * 10 * uv.x * uv.y)) * 10;

    k += sin(uv.x + t);


    gl_FragColor = vec4(i,j+k,k,1.0);
}
