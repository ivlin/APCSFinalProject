import java.util.*;
import static java.lang.Math.*;

abstract class Thing {
  float rad, xpos, ypos;

  Thing (float radius, float startx, float starty) {
    rad = radius;
    xpos = startx;
    ypos = starty;
  }

  void fall() {
    if (ypos + rad <= height) {
      ypos += 1;
    }
  }

  void stamp() {
    ellipse(xpos, ypos, 2 * rad, 2 * rad);
  }
}


class Shape extends Thing {
int angle;
  
  Shape(float radius, float startx, float starty) {
    super(radius, startx, starty);
  }

  void correction() {
    if (xpos - rad < 0) {
      xpos = 0 + rad;
    } else if (xpos + rad > width) {
      xpos = width - rad;
    }    
    fall();
  }

  void checkCollision(ArrayList<Shape> otherballs) {
    for (Shape a : otherballs) {
      if (a.ypos != ypos && a.xpos != xpos && sqrt(pow(a.xpos - xpos, 2) + pow(a.ypos - ypos, 2)) < 50) {
        xpos = 0;
        ypos = 0;
      }
    }
  }

  void launch(float xMag, float yMag) {
    bullets.add(new Bullet(xpos, ypos, xMag, yMag));
    bullets.get(bullets.size() - 1).id = bullets.size() - 1;
  }
  
  void drawAngle (){
   
  }
}

class Bullet extends Thing {
  int id;
  float life, yMag, xMag;

  Bullet (float startx, float starty, float xMagStart, float yMagStart) {
    super(2, startx, starty);
    life = 0;
    xMag = xMagStart;
    yMag = yMagStart;
  }

  void fall () {
    yMag += life * 0.003;
    ypos += yMag;
    xpos += xMag;
    life ++;
  }

  void correction() {
    if (xpos < 0 || xpos > width || ypos > height) {
      bullets.remove(0);
    }
  }
}



ArrayList<Shape> balls = new ArrayList<Shape>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
Random rand = new Random();
//Ball a = new Ball(25, 55, 55);

void setup() {
  size(1000, 500);
  background(#6BB9F0);
  drawTerrain();
  frameRate(60);
  for (int i = 0; i < 1; i++) {
    balls.add(new Shape(25, 25 + rand.nextInt(width - 25), 25));
  }
}

void draw() {
  background(#6BB9F0);
  for (Shape a : balls) {
    a.correction();
    a.checkCollision(balls);
    a.stamp();
  }
  for (int i = bullets.size() - 1; i >= 0; i--) {
    bullets.get(i).fall();
    bullets.get(i).stamp();
    bullets.get(i).correction();
  }
  System.out.println(bullets.toString());
}

void keyPressed() {
  if (key == 'w' || key == 'W') {
    balls.get(0).ypos -= 5;
  }
  if (key == 's' || key == 'S') {
    balls.get(0).ypos += 5;
  }
  if (key == 'a' || key == 'A') {
    balls.get(0).xpos -= 5;
  }
  if (key == 'd' || key == 'D') {
    balls.get(0).xpos += 5;
  }
  if (key == ' ') {
    balls.get(0).launch(5, -9);
  }
}

void drawTerrain() {
  float startx = 0;
  float starty = height * 3 / 4;
  float nexty;
  while (startx < width) {
    stroke(#2ECC71);
    line (startx, starty, startx, height);
    nexty = starty + -3 + rand.nextInt(7);
    line(startx + 1, nexty, startx, starty);
    startx += 1;
    starty = nexty;
  }
  stroke(#FFFFFF);
}

