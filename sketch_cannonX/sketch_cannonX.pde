target[] target_list;
Cannon t2;

void setup() {
  size(1500, 900);
  noStroke();

  target_list = new target[13];


  for (int i = 0; i < target_list.length; i++) {
    target_list[i] = new target(random(80, 1400), random(-300, -500), 50, 50, random(1, 3));
  }

  t2 = new Cannon(0, 800, 100, 45, target_list);
}
void draw() {
  background(0);
  for (int y=0; y<height+35; y+=70) {
    fill(255, 167, 3); 
    ellipse(0, y, 70, 70); 
    ellipse(width, y, 70, 70);
  }
  for (int i = 0; i < target_list.length; i++) {
    target_list[i].display();
    target_list[i].update();
  }
  t2.mode();
  t2.easing();
  t2.shot();
  t2.gameover();
  t2.clear();
}


class target {
  float x, y;
  float w, h;
  float gravity_acceleration;
  boolean show;
  target(float a_x, float a_y, float a_w, float a_h, float g) {
    x = a_x;
    y = a_y;
    w = a_w;
    h = a_h;
    show=true;
    gravity_acceleration  =g;
  }
  void display() {
    if (show == true) {
      fill(0, 255, 249);
      rect(x, y, w, h);
    }
  }

  void update() {
    y += gravity_acceleration;
  }
}
class Cannon {
  target[] target_list;
  int x, y;
  int v, w;
  float easing=0.05;

  void easing() {
    int targetX = mouseX;
    x += (targetX - x) * easing;
  }
  Cannon(int a_x, int a_y, int a_v, int a_w, target[] t) {
    x=a_x;
    y=a_y;
    v=a_v;
    w=a_w;
    target_list=t;
  }
  void mode() {
    fill(255);
    rect(x, y, v, w);
    fill(255);
    rect(x+30, y-40, v-60, w);
  }
  void shot() {
    for ( int i=0; i<target_list.length; i+=1) {
      if (mousePressed) {
        if ((x+50>target_list[i].x)&&(target_list[i].x+50>x+50)) {
          target_list[i].show=false;
        }
      }
    }
  }
  void gameover() {
    for ( int i=0; i<target_list.length; i+=1) {
      if (target_list[i].show==true) {
        if ((target_list[i].y>900)) {
          fill(255, 0, 0);
          rect(200, 100, width-400, height-200);
          fill(0);
          textSize(100);
          textAlign(CENTER, CENTER);
          text("gameover", width/2, height/2);
        }
      }
    }
  }
  void clear() {
    for ( int i=0; i<target_list.length; i+=1) {
      if (target_list[i].show==true) {
        return;
      }
    }
    fill(255);
    rect(200, 100, width-400, height-200);
    fill(0, 0, 255);
    textSize(100);
    textAlign(CENTER, CENTER);
    text("clear!!", width/2, 300);
    text("congratulations", width/2, 500);
  }
}
