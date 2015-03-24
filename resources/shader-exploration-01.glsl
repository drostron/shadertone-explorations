// Doodle based on Sound Visualizer https://www.shadertoy.com/view/Xds3Rr
// and http://vimeo.com/51993089 @ the 0min 44s mark
// For Shadertone, tap into Overtone's volume...
uniform float iOvertoneVolume;
void main(void)
{
    vec2 uv = 2.0*(gl_FragCoord.xy/iResolution.xy) - 1.0;
    // equvalent to the video's spec.y, I think
    float spec_y = 0.5 + 5.0*iOvertoneVolume;
    float col, r, g, b = 0.0;
    // uv.x += sin(iGlobalTime * 1.3 + uv.y*1.5)*spec_y;
    // col += abs(0.005/uv.x) * spec_y;
    r += 0.5 + (0.4 * sin(iGlobalTime * 3.1 + uv.x)) + (iOvertoneVolume * 2);
    g += 0.5 + (0.4 * sin(iGlobalTime * 2.7 + uv.y)) - (iOvertoneVolume * 2);
    b += 0.5 + (0.4 * sin(iGlobalTime * 1.9));
    gl_FragColor = vec4(r, g, b, 1.0);
}
