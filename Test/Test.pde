import java.util.*;
import static java.lang.Math.*;

abstract class Thing {
  float rad, xpos, ypos;

  Thing (float radius, float startx, float starty) {
    rad = radius;
    xpos = startx;
    ypos = starty;
  }

  //things fall while on screen - maybe unnecessary
  void fall() {
    boolean floating = true;
    for (Topsoil t : top) {
      if (t.xpos >= xpos - rad && t.xpos <= xpos + rad) {
        floating = floating && sqrt(pow(t.xpos - xpos, 2) + pow(t.ypos - ypos, 2)) > rad;
      }
    }
    if (ypos + rad <= height && floating) {
      ypos += 1;
    }
  }

  void stamp() {
    fill(#FFFFFF);
    ellipse(xpos, ypos, 2 * rad, 2 * rad);
  }
}


//This is the basic "Tank"
class Shape extends Thing {
  int angle;

  Shape(float radius, float startx, float starty) {
    super(radius, startx, starty);
  }

  //Keeps within screen boundaries, applies gravity
  void correction() {
    if (xpos - rad < 0) {
      xpos = 0 + rad;
    } else if (xpos + rad > width) {
      xpos = width - rad;
    }    
    fall();
  }

  //Checks collisions with other objects
  //INCOMPLETE : only resets position, need to think of way to do actual interaction, does not interact with bullets or terrain
  void checkCollision(ArrayList<Shape> other) {
    for (Shape a : other) {
      if (a.ypos != ypos && a.xpos != xpos && sqrt(pow(a.xpos - xpos, 2) + pow(a.ypos - ypos, 2)) < rad + a.rad) {
        xpos = 0;
        ypos = 0;
      }
    }
  }

  //Launches a bullets with an xmagnitude and ymagnitude
  void launch(float xMag, float yMag) {
    bullets.add(new Bullet(xpos, ypos, xMag, yMag));
    bullets.get(bullets.size() - 1).id = bullets.size() - 1;
  }
  
  void stamp(){
   super.stamp();
//  triangle()
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

  //Movement of bullet, complete with vertical and horizontal component and acceleration downwards
  void fall () {
    yMag += life * 0.003;
    ypos += yMag;
    xpos += xMag;
    checkImpact();
    life ++;
  }

  void checkImpact () {
    for (Topsoil t : top) {
      if (t.xpos == xpos && ypos >= t.ypos) {
        detonate(15);
      }
    }
  }

  void detonate(float rad) {
    for (Topsoil t : top) {
      if (t.xpos >= xpos - rad && t.xpos <= xpos + rad) {
        float temp = sqrt(pow(rad, 2) - pow(t.xpos - xpos, 2));
        if (sqrt(pow(t.xpos - xpos, 2) + pow(t.ypos - ypos, 2)) < rad) {
          t.ypos = ypos + temp;
        } else if (t.ypos <= ypos) {
          t.ypos += 2 * temp;
        }
      }
    }
    ypos = height + 10;
  }  

  //Removes bullets from list of bullets after it exits the screen
  void correction() {
    if (xpos < 0 || xpos > width || ypos > height) {
      bullets.remove(0);
    }
  }
}

//The "upper" boundary of the ground
class Topsoil extends Thing {
  Topsoil(float startx, float starty) {
    super(.5, startx, starty);
  }
}

ArrayList<Shape> balls = new ArrayList<Shape>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Topsoil> top = new ArrayList<Topsoil>();
Random rand = new Random();

void setup() {
  size(1000, 500);
  drawTerrain();
  frameRate(60);
  for (int i = 0; i < 1; i++) {
    balls.add(new Shape(25, 25 + rand.nextInt(width - 25), 25));
  }
}

void draw() {
  background(#6BB9F0);
  terrain();
  for (Shape a : balls) {
    a.correction();
    a.checkCollision(balls);
    a.stamp();
  }
  for (int i = bullets.size () - 1; i >= 0; i--) {
    bullets.get(i).fall();
    bullets.get(i).stamp();
    bullets.get(i).correction();
  }
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
  //Pew pew from tank
  if (key == ' ') {
    balls.get(0).launch(5, -9);
  }
}

//creates the initial terrain
void drawTerrain() {
  float startx = 0;
  float starty = height * 3 / 4;
  float nexty;
  System.out.println(width);
  while (startx < width) {
    stroke(#2ECC71);
    top.add(new Topsoil(startx, starty));
    //  line (startx, starty, startx, height);
    nexty = starty + -3 + rand.nextInt(7);
    //line(startx + 1, nexty, startx, starty);
    startx += 1;
    starty = nexty;
  }
  stroke(#FFFFFF);
}

//updates the terrain
void terrain() {
  stroke(#2ECC71);
  for (Topsoil t : top) {
    line(t.xpos, t.ypos, t.xpos, height);
  } 
  stroke(#FFFFFF);
}

