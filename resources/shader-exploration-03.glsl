uniform float iOvertoneVolume;
float pi = 3.1415;
void main(void)
{
    vec2 uv = 2.0*(gl_FragCoord.xy/iResolution.xy) - 1.0;
    float col = 0.0;

    // col += ((abs(sin(uv.x * pi * 2)) + abs(sin(uv.y * pi * 2))) / 2) + iOvertoneVolume;

    // col += sin(sin(iGlobalTime * uv.x * 4.0) * pi * 2.0);
    col += sin((sin(uv.x * 3) * (17 + 100 * iOvertoneVolume)) + (5 * sin(iGlobalTime * 2)));

    gl_FragColor = vec4(col,col,col,1.0);
}
