
uniform float time;
uniform vec2 resolution;
uniform sampler2D prevFrame;

const int cant = 50; //no encontre la manera para ponerlo en ambas.
uniform float [cant] XS;
uniform float [cant] YS;

float cir(vec2 uv, vec2 p,float s, float d );
void main(){
	
	vec2 uv = gl_FragCoord.xy/resolution;
	vec2 p = vec2(0.5) -uv;
	float r = length(p);
	float a = atan(p.x,p.y);
	
	float e =0; 
	float e2 = 0;
	
	for (int i=0; i<cant; i++){
		vec2 p = vec2(XS[i],1.0-YS[i]);
		float r = length(p);
		float a = atan(p.x,p.y);
		float k1 = sin(a*5.0+time*5.0);
		e2+= cir(uv,vec2(XS[i],1.0-YS[i]),0.0,abs(sin(r*3.0+time*0.25+sin(a*20.0)))*0.1);
		 e+= cir(uv,vec2(XS[i],1.0-YS[i]),0.,0.01*sin(a*5.0+time)+0.05);
	}
	
	/*vec4 dib = vec4(e*0.2+e2*0.0,
					e*0.0+e2*0.05,
					e*0.2+e2*0.05,
					1.0);*/
					
	vec4 dib = vec4(e*0.2+e2*0.0,
					e*0.0+e2*0.05,
					e*0.2+e2*0.05,
					1.0);
	
	
	vec4 prev = texture2DRect(prevFrame,uv);
	
	
	//MASK 1;
	//dib = step(0.7*r,dib);
	gl_FragColor = dib+ prev*0.97;
}

float cir(vec2 uv, vec2 p,float s, float d ){
		
	//vec2 p = 
	float r = length(p-uv);
	return 1.0-smoothstep(s,s+d,r) ;
}

/*float cir(vec2 uv,vec2 p, float s, float d){
    p = p - uv;
    float r = length(p);
    float e = 1.0- smoothstep(s,s+d,r);
    return e;
}*/

