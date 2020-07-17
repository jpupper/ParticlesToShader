
boolean showGui;


int CANTEFECTOSPS = 2;

jp_shader sh;
ParticleSystem PS;

boolean debug;
void setup() {

  //size(600, 600, P2D);
  fullScreen(P2D);
  PS = new ParticleSystem();

  sh = new jp_shader();
  PS.drawParticles = true;
  
  sh.CANTSHADERS = 6;
  sh.activeShader = 4;
  PS.CANTMOV = 3;
}



void draw() {



  sh.renderShader();
  PS.run();

  if (debug) {
    
    float sep = 40;
    text("FRAMERATE : "+frameRate, 50, height-sep);
    text("Movimiento PS "+PS.movimiento, 50, height-sep*2);  
    text("Shader "+sh.activeShader, 50, height-sep*3);
  }
}



void keyPressed() {
  if (key == 's') {
    sh.activeShader++;
    if (sh.activeShader > sh.CANTSHADERS-1) {
      sh.activeShader = 0;
    }
    sh.reloadShader();
  }
  if (key == 'w') {
    sh.reloadShader();
  }

  if (key == 'a') {
    PS.movimiento++;
    if (PS.movimiento > PS.CANTMOV-1) {
      PS.movimiento = 0;
    }
  }
  if (key =='d') {
    debug = !debug;
  }


  if (key == 'g') {
    PS.drawParticles = !PS.drawParticles;
  }

  if (key == 'c') {
    sh.drawShader = !sh.drawShader;
    //drawShader = !drawShader;
  }
}
