uniform float iOvertoneVolume;
float pi = 3.1415;
void main(void)
{
    vec2 uv = 2.0*(gl_FragCoord.xy/iResolution.xy) - 1.0;
    float i,j,k,l = 0.0;
    float r,g,b = 0.0;
    float t = iGlobalTime;
    float vol = iOvertoneVolume;

    i += 1 - abs(
                 (3.4 * uv.x + (
                                sin(0.1 * (t + (vol*100)) + (uv.y * (7 + (vol*7)))) +
                                sin(t + (sin(t) * 10) + (uv.y * 13)))) *
                 (1 + (vol * 50)));

    j += abs(sin(t * 0.3 * (cos(0.7 * t + uv.x * uv.x) + sin(t + uv.y * uv.y)))) * 11;

    k += sin(uv.x + t * 3);
    l += sin(uv.y + t * 2.3);

    r += i;
    g += j + i;
    b += j + k + i;
    r += (j * abs(sin(1.0*t)) * 0.3) + i;
    g += (j * abs(sin(0.7*t)) * 0.3) + l + i;
    b += (j * abs(sin(0.3*t)) * 0.3) + k + i;

    gl_FragColor = vec4(r,g,b,1.0);
}
