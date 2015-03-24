uniform float iOvertoneVolume;
float pi = 3.1415;
void main(void)
{
    vec2 uv = 2.0*(gl_FragCoord.xy/iResolution.xy) - 1.0;
    float col = 0.0;
    float vol = iOvertoneVolume;

    col += 1 - abs((uv.x + 0.1 * sin(iGlobalTime + (uv.y * 13))) * 20);

    gl_FragColor = vec4(col,col,col,1.0);
}
