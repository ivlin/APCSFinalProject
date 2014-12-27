import java.util.*;
import static java.lang.Math.*;
class Shape {
  float rad, xpos, ypos;

  Shape(float radius, float startx, float starty) {
    rad = radius;
    xpos = startx;
    ypos = starty;
  }

  void stamp() {
    ellipse(xpos, ypos, 2 * rad, 2 * rad);
  }

  void correction() {
    if (xpos - rad < 0) {
      xpos = 0 + rad;
    } else if (xpos + rad > width) {
      xpos = width - rad;
    }    
    if (ypos + rad <= height) {
      ypos += 1;
    }
  }

  void checkCollision(ArrayList<Shape> otherballs) {
    for (Shape a : otherballs) {
      if (a.ypos != ypos && a.xpos != xpos && sqrt(pow(a.xpos - xpos, 2) + pow(a.ypos - ypos, 2)) < 50) {
        xpos = 0;
        ypos = 0;
      }
    }
  }
}



ArrayList<Shape> balls = new ArrayList<Shape>();
Random rand = new Random();
//Ball a = new Ball(25, 55, 55);

void setup() {
  size(1000, 500);
  background(#6BB9F0);
  drawTerrain();
  frameRate(60);
  for (int i = 0; i < 2; i++) {
    balls.add(new Shape(25, 25 + rand.nextInt(width - 25), 25));
  }
}

void draw() {
  /*
  for (Shape a : balls) {
   a.correction();
   a.checkCollision(balls);
   a.stamp();
   }*/
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
}

