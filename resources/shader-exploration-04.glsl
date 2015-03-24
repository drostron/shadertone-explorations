uniform float iOvertoneVolume;
float pi = 3.1415;
void main(void)
{
    vec2 uv = 2.0*(gl_FragCoord.xy/iResolution.xy) - 1.0;
    float col = 0.0;
    float vol = iOvertoneVolume;

    // col += (pow(sin(uv.x * 7), 2) + pow(cos(uv.y * 7), 2)) / 2;
    // col += pow(uv.x * 3, 3) - (3 * uv.x) + pow(uv.y * 3, 3) - (3 * uv.y);

    col += sin((17.0 - (100 * vol)) *
               (pow(uv.x * (13.0 + (10 * vol) + sin(iGlobalTime * 0.9)), 2.0) +
                pow(uv.y * (11.0 + (-10 * vol) + sin(iGlobalTime * 1.1)), 2.0)));

    gl_FragColor = vec4(col,col,col,1.0);
}
