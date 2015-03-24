//CBS
//Parallax scrolling fractal galaxy.
//Inspired by JoshP's Simplicity shader: https://www.shadertoy.com/view/lslGWr

uniform float iOvertoneVolume;

// http://www.fractalforums.com/new-theories-and-research/very-simple-formula-for-fractal-patterns/
float field(in vec3 p,float s) {
	float strength = 7. + .03 * log(1.e-6 + fract(sin(iGlobalTime) * 4373.11));
	float accum = s/4.;
	float prev = 0.;
	float tw = 0.;
	for (int i = 0; i < 26; ++i) {
		float mag = dot(p, p);
		p = abs(p) / mag + vec3(-.5, -.4, -1.5);
		float w = exp(-float(i) / 7.);
		accum += w * exp(-strength * pow(abs(mag - prev), 2.2));
		tw += w;
		prev = mag;
	}
	return max(0., 5. * accum / tw - .7);
}

// Less iterations for second layer
float field2(in vec3 p, float s) {
	float strength = 7. + .03 * log(1.e-6 + fract(sin(iGlobalTime) * 4373.11));
	float accum = s/4.;
	float prev = 0.;
	float tw = 0.;
	for (int i = 0; i < 18; ++i) {
		float mag = dot(p, p);
		p = abs(p) / mag + vec3(-.5, -.4, -1.5);
		float w = exp(-float(i) / 7.);
		accum += w * exp(-strength * pow(abs(mag - prev), 2.2));
		tw += w;
		prev = mag;
	}
	return max(0., 5. * accum / tw - .7);
}

vec3 nrand3( vec2 co )
{
	vec3 a = fract( cos( co.x*8.3e-3 + co.y )*vec3(1.3e5, 4.7e5, 2.9e5) );
	vec3 b = fract( sin( co.x*0.3e-3 + co.y )*vec3(8.1e5, 1.0e5, 0.1e5) );
	vec3 c = mix(a, b, 0.5);
	return c;
}

vec4 stars()
{
  vec2 uv = 2. * gl_FragCoord.xy / iResolution.xy - 1.;
	vec2 uvs = uv * iResolution.xy / max(iResolution.x, iResolution.y);

	vec3 p = vec3(uvs / 4., 0) + vec3(1., -1.3, 0.);
	p += .2 * vec3(sin(iGlobalTime / 16.), sin(iGlobalTime / 12.),  sin(iGlobalTime / 128.));

	float freqs[4];
	//Sound
	freqs[0] = iOvertoneVolume * 1.01;
	freqs[1] = iOvertoneVolume * 2.07;
	freqs[2] = iOvertoneVolume * 0.85;
	freqs[3] = iOvertoneVolume * 1.30;

	float t = field(p,freqs[2]);
	float v = (1. - exp((abs(uv.x) - 1.) * 6.)) * (1. - exp((abs(uv.y) - 1.) * 6.));

  //Second Layer
	vec3 p2 = vec3(uvs / (4.+sin(iGlobalTime*0.11)*0.2+0.2+sin(iGlobalTime*0.15)*0.3+0.4), 1.5) + vec3(2., -1.3, -1.);
	p2 += 0.25 * vec3(sin(iGlobalTime / 16.), sin(iGlobalTime / 12.),  sin(iGlobalTime / 128.));
	float t2 = field2(p2,freqs[3]);
	vec4 c2 = mix(.4, 1., v) * vec4(1.3 * t2 * t2 * t2 ,1.8  * t2 * t2 , t2* freqs[0], t2);

	//Let's add some stars
	//Thanks to http://glsl.heroku.com/e#6904.0
	vec2 seed = p.xy * 2.0;
	seed = floor(seed * iResolution.x);
	vec3 rnd = nrand3( seed );
	vec4 starcolor = vec4(pow(rnd.y,40.0));

	//Second Layer
	vec2 seed2 = p2.xy * 2.0;
	seed2 = floor(seed2 * iResolution.x);
	vec3 rnd2 = nrand3( seed2 );
	starcolor += vec4(pow(rnd2.y,40.0));

  vec4 i = mix(freqs[3]-.3, 1., v) * vec4(1.5*freqs[2] * t * t* t , 1.2*freqs[1] * t * t, freqs[3]*t, 1.0)+c2+starcolor;;

  return i;
}

vec4 fractalQuicksand()
{
  // Created by inigo quilez - iq/2013
  // License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
  float vol = iOvertoneVolume;
  vec2 uv = gl_FragCoord.xy/iResolution.xy;

  // shape (16 points)
	float time = iGlobalTime + 47.0;
	vec2 z = -1.0 + 2.0*uv;
	vec3 col = vec3(1.0);
	for( int j=0; j<16; j++ )
    {
      // deform
      float s = float(j)/16.0;
      float f = 0.2*(0.5 + 1.0*fract(sin(s*113.1)*43758.5453123));
      vec2 c = 0.5*vec2( cos(f*time+(17.0*vol)*s),sin(f*time+19.0*s) );
      z -= c;
      float zr = length( z );
	    float ar = atan( z.y, z.x ) + zr*0.6;
	    z  = vec2( cos(ar), sin(ar) )/zr;
      z += c;
      z += 0.05*sin(2.0*z.x);

      // color
      col -= 0.7*exp( -8.0*dot(z,z) )* (0.5+0.5*sin( 4.2*s + vec3(1.6,0.9,0.3) ));
    }
  col *= 0.75 + 0.25*clamp(length(z-uv)*0.6,0.0,1.0);

	// 3d effect
	float h = dot(col,vec3(0.333));
	vec3 nor = normalize( vec3( dFdx(h), dFdy(h), 1.0/iResolution.x ) );
	col -= 0.05*vec3(1.0,0.9,0.5)*dot(nor,vec3(0.8,0.4,0.2));;
	col += 0.25*(1.0-0.8*col)*nor.z*nor.z;

  // 2d postpro
	col *= 1.12;
  col = pow( clamp(col,0.0,1.0), vec3(0.8) );
	col *= 0.8 + 0.2*pow( 16.0*uv.x*uv.y*(1.0-uv.x)*(1.0-uv.y), 0.1 );
	vec4 r = vec4( col, 1.0 );

  return r;
}

void main() {

  float t = iGlobalTime;

  vec4 s = stars();
  vec4 q = fractalQuicksand();

	gl_FragColor = mix(s, q, 0.2 + (0.2*sin(t * 0.5)));
}
