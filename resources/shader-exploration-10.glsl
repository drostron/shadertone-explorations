// shadertoy, spinning, https://www.shadertoy.com/view/lsfGDB

// Created by inigo quilez - iq/2013
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

uniform float iOvertoneVolume;

#if 1
//
// Elegant way to intersect a planar coordinate system (3x3 linear system)
//
vec3 intersectCoordSys( in vec3 o, in vec3 d, vec3 c, vec3 u, vec3 v )
{
	vec3 q = o - c;
	return vec3(
              dot( cross(u,v), q ),
              dot( cross(q,u), d ),
              dot( cross(v,q), d ) ) /
    dot( cross(v,u), d );
}

#else
//
// Ugly (but faster) way to intersect a planar coordinate system: plane + projection
//
vec3 intersectCoordSys( in vec3 o, in vec3 d, vec3 c, vec3 u, vec3 v )
{
	vec3  q = o - c;
	vec3  n = cross(u,v);
  float t = -dot(n,q)/dot(d,n);
  float r =  dot(u,q + d*t);
  float s =  dot(v,q + d*t);
  return vec3(t,s,r);
}

#endif

vec3 hash3( float n )
{
  return fract(sin(vec3(n,n+1.0,n+2.0))*vec3(43758.5453123,12578.1459123,19642.3490423));
}

vec3 shade( in vec4 res )
{
  float ra = length(res.yz);
  float an = atan(res.y,res.z) + 3.0*iGlobalTime;
  float pa = sin(3.0*an);

  vec3 cola = (-7.0+(15.0*iOvertoneVolume)) + 0.5*sin( (res.w/64.0)*3.5 + vec3(0.0,1.0,2.0) );

  vec3 col = vec3(0.0);
  col += cola*0.4*(1.0-smoothstep( 0.90, 1.00, ra) );
  col += cola*1.0*(1.0-smoothstep( 0.00, 0.03, abs(ra-0.8)))*(0.5+0.5*pa);
  col += cola*1.0*(1.0-smoothstep( 0.00, 0.20, abs(ra-0.8)))*(0.5+0.5*pa);
  col += cola*0.5*(1.0-smoothstep( 0.05, 0.10, abs(ra-0.5)))*(0.5+0.5*pa);
  col += cola*0.7*(1.0-smoothstep( 0.00, 0.30, abs(ra-0.5)))*(0.5+0.5*pa);

  return col*0.3;
}

void main( void )
{
  float vol = iOvertoneVolume;

	vec2 q = gl_FragCoord.xy / iResolution.xy;
  vec2 p = -1.0 + 2.0 * q;
  p.x *= iResolution.x/iResolution.y;

  // camera
  // vec3 ro = 1.0*vec3(cos(0.3*iGlobalTime),1.0*sin(0.7*iGlobalTime),1.0+2.0*sin(1.1*iGlobalTime));
  vec3 ro = vec3(1.0,1.0,3.0);
  vec3 ta = vec3(0.5,0.6,0.2);
  // camera matrix
  vec3 ww = normalize(ta - ro);
  vec3 uu = normalize(cross(ww, vec3((10.0*vol),1.0,0.0)));
  vec3 vv = normalize(cross(uu, ww));
	// create view ray
	vec3 rd = normalize(p.x*uu + p.y*vv + 1.0*ww);

	// raytrace
  vec3 col = vec3(0.0);
	for( int i=0; i<1; i++ )
    {
      // position disk
      vec3 r = vec3(1.0);

      // orientate disk
      vec3 u = normalize( r.zxy );
      vec3 v = normalize( cross( r, vec3(0.0,1.0,5.0 ) ) );

      // intersect coord sys
      vec3 tmp = intersectCoordSys( ro, rd, r, u, v );

      if( dot(tmp.yz,tmp.yz)<1.0 && tmp.x>0.0 )
        {
          // shade
          col += shade( vec4(tmp,float(i)) );
        }
    }

  gl_FragColor = vec4( col, 1.0 );
}
