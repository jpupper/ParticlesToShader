
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
		float k1 = sin(a*50.0+time*5.0);
		e2+= cir(uv,vec2(XS[i],1.0-YS[i]),0.0,abs(sin(r*30.0+time*0.25+sin(a*20.0)))*0.04);
		 e+= cir(uv,vec2(XS[i],1.0-YS[i]),0.,0.01*sin(a*50.0+time)+0.01);
	}
	
	/*vec4 dib = vec4(e*0.2+e2*0.0,
					e*0.0+e2*0.05,
					e*0.2+e2*0.05,
					1.0);*/
					
	vec4 dib = vec4(e+e2*0.9,
					e*0.7+e2,
					e+e2*0.7,
					1.0);
	
	vec2 coords = uv;
	
	
	coords.y += smoothstep(0.5,-0.5,uv.y);
	vec4 prev = texture2DRect(prevFrame,coords);
	
	
	//MASK 1;
	dib = step(0.2,dib);
	gl_FragColor = dib+ prev*0.7;
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

