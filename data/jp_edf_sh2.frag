
uniform float time;
uniform vec2 resolution;
uniform sampler2D prevFrame;

const int cant = 50; //no encontre la manera para ponerlo en ambas.
uniform float [cant] XS;
uniform float [cant] YS;

float cir(vec2 uv, vec2 p,float s, float d );
void main(){
	
	vec2 uv = gl_FragCoord.xy/resolution;
	
	float e =0; 
	float e2 = 0;
	
	
	for (int i=0; i<cant; i++){
		
		vec2 p = vec2(XS[i],1.0-YS[i])-uv;
		float r = length(p);
		float a = atan(p.x,p.y);
		float k1 = sin(r*0.0+sin(a*10.0))*0.1;
		e2+= cir(uv,vec2(XS[i],1.0-YS[i]),0.0,0.2+k1*0.3);
		 e+= cir(uv,vec2(XS[i],1.0-YS[i]),0.0,0.1+k1);
	
	}
	
	vec4 dib = vec4(e*0.8+e2*0.0,
					e*0.8+e2*0.0,
					e*0.8+e2*0.0,
					1.0);
	
	
	
	vec4 prev = texture2DRect(prevFrame,uv);
	
	gl_FragColor = step(0.1,dib*0.1)+ prev*0.99;
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

