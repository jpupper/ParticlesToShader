
class ParticleSystem {

  Particle [] particles = new Particle[50];

  boolean drawParticles;

  //MANEJAR LOS DISTINTOS TIPOS DE MOVIMIENTO DEL SISTEMA DE PARTICULAS.
  int movimiento = 1; 

  int CANTMOV = 3;
  ParticleSystem() {

    for (int i =0; i< particles.length; i++) {
      particles[i] = initParticle();
    }

    drawParticles = false;
  }

  void run() {

    if (drawParticles) {
      display();
    }
    update();
  }

  void display() {
    for (int i=0; i<particles.length; i++) {
      particles[i].display();
    }
  }

  void update() {

    if (movimiento != 2) {
      for (int i=0; i<particles.length; i++) {
        particles[i].update();
        if (particles[i].isDead()) {
          particles[i] = initParticle();
        }
      }
    } else {
      for (int i=0; i<particles.length; i++) {

        float a = map(i, 0, particles.length, 0, TWO_PI);
        float a2 = map(i, 0, particles.length, 0, TWO_PI*10);

        float amp = sin(a2+millis()*0.0001) * 300;
        float oscx = sin(millis()*0.001+a) * amp;
        float oscy = cos(millis()*0.001+a) * amp;

        particles[i].pos.x = mouseX+oscx;
        particles[i].pos.y = mouseY+oscy;
      }
    }
  }


  Particle initParticle() {
    Particle p = new Particle(mouseX, mouseY);
    if (movimiento == 0) {
      PVector pos = new PVector(mouseX, mouseY);

      float STspeed = 2;
      PVector speed = new PVector(random(-STspeed, STspeed), random(-STspeed, STspeed));
      float STaccel = 0.04;
      PVector accel = new PVector(random(-STaccel, STaccel), random(-STaccel, STaccel));
      p = new Particle(pos, speed, accel);
    }
    if (movimiento == 1) {
      PVector pos = new PVector(random(width), random(height));

      float STspeed = 2;
      PVector speed = new PVector(random(-STspeed, STspeed), random(-STspeed, STspeed));
      float STaccel = 0.04;
      PVector accel = new PVector(random(-STaccel, STaccel), random(-STaccel, STaccel));
      p = new Particle(pos, speed, accel, random(3, 5));
    }



    return p;
  }


  float [] xs () {
    float [] xs = new float [particles.length]; 
    for (int i=0; i<particles.length; i++) {
      xs[i] = particles[i].pos.x;
    }
    return xs;
  }

  float [] ys () {
    float [] ys = new float [particles.length]; 
    for (int i=0; i<particles.length; i++) {
      ys[i] = particles[i].pos.y;
    }
    return ys;
  }
}


class Particle {

  PVector pos;
  PVector speed;
  PVector accel;

  float x, y;
  float speedx, speedy;
  float accelx, accely;

  float life;
  float lifespeed;

  color col;
  float size; 
  float rotangle;

  Particle(PVector _pos, PVector _speed, PVector _accel) {

    pos   = _pos;
    speed = _speed;
    accel = _accel;

    life = 255;
    lifespeed = random(1, 3);


    float k1 =  random(50, 150);
    col = color(random(220, 250), k1, k1, 200);
    size = 30;
  }
  Particle(PVector _pos, PVector _speed, PVector _accel, float _lifespeed) {

    pos   = _pos;
    speed = _speed;
    accel = _accel;

    life = 255;
    lifespeed = random(1, 3);


    float k1 =  random(50, 150);
    col = color(random(220, 250), k1, k1, 200);
    size = 30;
  }

  Particle(float _x, float _y) {

    pos = new PVector(_x, _y);
    speed = new PVector(random(-0, 0), random(-0, 0));
    accel = new PVector(random(-0.1, 0.1), random(-0.1, 0.1));

    life = 255;
    lifespeed = random(1, 3);


    float k1 =  random(50, 150);
    col = color(random(220, 250), k1, k1, 200);
    size = 30;
  }

  void display() {
    noStroke();
    fill(col);
    pushMatrix();
    translate(pos.x, pos.y);
    ellipse(0, 0, size, size);
    popMatrix();
  }


  void update() {
    life-=lifespeed;

    speed.add(accel);
    speed.limit(10);
    pos.add(speed);

    checkEdges();
  }

  void checkEdges() {
    if (y > height) {
      y = 0;
    }
    if (y < 0) {
      y = height;
    }
    if (x > width ) {
      x =0;
    }
    if (x < 0) {
      x = width;
    }
  }
  boolean isDead() {
    if (life < 0) {
      return true;
    } else {
      return false;
    }
  }
}
