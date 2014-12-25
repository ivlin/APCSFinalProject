import java.util.*;
import static java.lang.Math.*;
class Ball {
  float rad, xpos, ypos;

  Ball(float radius, float startx, float starty) {
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
  
  void checkCollision(ArrayList<Ball> otherballs){
     for (Ball a: otherballs){
       float distx = a.xpos - xpos;
       float disty = a.ypos - ypos;
      if (a.ypos != ypos && a.xpos != xpos && sqrt(distx * distx + disty * disty) < 50){
       xpos = 0;
       ypos = 0;
      } 
     }
  }
}



ArrayList<Ball> balls = new ArrayList<Ball>();
Random rand = new Random();
//Ball a = new Ball(25, 55, 55);

void setup() {
  size(1000, 500);
  noStroke();
  frameRate(60);
  for (int i = 0; i < 2; i++) {
    balls.add(new Ball(25, 25 + rand.nextInt(width - 25), 25));
  }
}

void draw() {
  background(#8899FF);
  for (Ball a : balls) {
    a.correction();
    a.checkCollision(balls);
    a.stamp();
  }
  System.out.println(balls.get(0).xpos + " " + balls.get(0).ypos);
  System.out.println(balls.get(1).xpos + " " + balls.get(1).ypos);
  System.out.println(sqrt(pow(balls.get(0).xpos - balls.get(1).ypos + pow(balls.get(0).xpos - balls.get(1).xpos, 2), 2)));
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

