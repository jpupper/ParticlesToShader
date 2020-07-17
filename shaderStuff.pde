class jp_shader {


  PShader sh;
  PGraphics pg;

  int activeShader = 0;
  int CANTSHADERS = 3;

  boolean drawShader;
  jp_shader() {

    sh = loadShader("jp_edf_sh0.frag");
    pg = createGraphics(width, height, P2D);
    sh.set("resolution", width, height);
    drawShader = true;
  }

  void reloadShader() {
    sh = loadShader ("jp_edf_sh"+str(activeShader)+".frag");
  }


  void renderShader() {
    sh.set("XS", normArray(PS.xs(), 0, width));
    sh.set("YS", normArray(PS.ys(), 0, height));
    sh.set("time",millis()*0.01);
    sh.set("mouse", map(mouseX, 0, width, 0, 1), map(mouseY, 0, height, 0, 1));
    sh.set("cant", 10);
    // background(0);
    pg.beginDraw();
    pg.shader(sh);
    pg.fill(255, 0, 0);
    pg.rect(0, 0, width, height);
    pg.endDraw();
    //shader(sh);

    if (drawShader) {
      image(pg, 0, 0);
    }

    sh.set("prevFrame", pg);
  }

  float [] normArray(float [] array_, float min, float max) {
    float [] normray = new float [array_.length]; 
    for (int i=0; i<array_.length; i++) {
      normray[i] = norm(array_[i], min, max);
    }
    return normray;
  }
}
