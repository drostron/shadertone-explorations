// Doodle based on Sound Visualizer https://www.shadertoy.com/view/Xds3Rr
// and http://vimeo.com/51993089 @ the 0min 44s mark
// For Shadertone, tap into Overtone's volume...
uniform float iOvertoneVolume;
void main(void)
{
    vec2 uv = 2.0*(gl_FragCoord.xy/iResolution.xy) - 1.0;
    float r,g,b = 0.0;
    r += 0.5 - (uv.x/10) - (uv.y * (7.0*iOvertoneVolume));
    g += 0.8 - (uv.x/2) - (uv.y * (2.0*iOvertoneVolume));
    b += 0.1 - (uv.x/50) - (uv.y * (10.0*iOvertoneVolume));
    gl_FragColor = vec4(b,r,g,1.0);
}
