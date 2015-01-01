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
    boolean floating = isFloating();
    if (ypos + rad <= height && floating) {
      ypos += 2;
    }
  }

  boolean isFloating() {
    boolean floating = true;
    for (Topsoil t : top) {
      if (t.xpos >= xpos - rad && t.xpos <= xpos + rad) {
        floating = floating && t.ypos > ypos && getDist(t) > rad;
      }
    }
    return floating;
  }

  float getDist(Thing other) {
    return (sqrt(pow(xpos - other.xpos, 2) + pow(ypos - other.ypos, 2)));
  }

  void stamp() {
    fill(#FFFFFF);
    ellipse(xpos, ypos, 2 * rad, 2 * rad);
  }
}


//This is the basic "Tank"
class Shape extends Thing {
  int hp, ang, pow, team, mvt;
  String name;

  Shape(int team, float radius, float startx, float starty) {
    super(radius, startx, starty);
    this.team = team;
    hp = 120;
    mvt = 30;
    ang = 0;
    pow = 0;
  }

  //Keeps within screen boundaries, applies gravity
  void correction() {
    if (xpos - rad < 0) {
      xpos = 0 + rad;
    } else if (xpos + rad > width) {
      xpos = width - rad;
    }
    //stops the tank from phasing "into" terrain
    if (top.get((int)xpos).ypos < ypos + rad) {
      ypos = top.get((int)xpos).ypos - rad;
    }
    fall();
  }

  //Launches a bullets with an xmagnitude and ymagnitude
  void launch() {
    float xMag = (float)pow / 10 * cos(ang * PI / 180);
    float yMag = (float)pow / 10 * -sin(ang * PI / 180);
    bullets.add(new Bullet(team, xpos, ypos, xMag, yMag));
    bullets.get(bullets.size() - 1).id = bullets.size() - 1;
  }

  void stamp() {
    super.stamp();
    fill(255 / balls.size() * team);
    triangle(xpos + (1.25 * rad) * cos(((float)ang - 30) * PI / 180), ypos + -(1.25 * rad) * sin(((float)ang - 30) * PI / 180), 
    xpos + 1.25 * rad * sin((60 - (float)ang) * PI / 180), ypos + -1.25 * rad * cos((60 - (float)ang) * PI / 180), 
    xpos + 2.25 * rad * cos((float)ang * PI / 180), ypos + -2.25 * rad * sin((float)ang * PI / 180));
    fill(#000000);
    textSize(10);
    textAlign(CENTER);
    text(name+ " " + hp + " HP", xpos, ypos + rad + 7);
  }
}

class Bullet extends Thing {
  int id, team;
  float life, yMag, xMag;

  Bullet (int team, float startx, float starty, float xMagStart, float yMagStart) {
    super(2, startx, starty);
    life = 0;
    this.team = team;
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
      if (t.xpos == floor(xpos) && ypos >= t.ypos || ypos == height) {
        detonate(15);
      }
    }
    for (Shape b : balls) {
      if (b.team != team && getDist(b) < b.rad) { 
        detonate(15);
      }
    }
  }

  void detonate(float rad) {
    for (Topsoil t : top) {
      if (t.xpos >= xpos - rad && t.xpos <= xpos + rad) {
        float temp = sqrt(pow(rad, 2) - pow(t.xpos - xpos, 2));
        if (getDist(t) < rad) {
          t.ypos = ypos + temp;
        } else if (t.ypos <= ypos) {
          t.ypos += 2 * temp;
        }
      }
    }
    for (Shape b : balls) {
      float dist = getDist(b);
      if (dist < b.rad + rad) {
        b.hp -= 20;
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
int turn = 0;
Shape current;

Random rand = new Random();

void setup() {
  size(1000, 500);
  drawTerrain();
  frameRate(60);
  for (int i = 0; i < 2; i++) {
    balls.add(new Shape(i, 12, 25 + rand.nextInt(width - 25), 25));
  }
}

void draw() {
  current = balls.get(turn);
  terrain();
  for (Shape a : balls) {
    a.correction();
    a.stamp();
  }
  for (int i = bullets.size () - 1; i >= 0; i--) {
    bullets.get(i).fall();
    bullets.get(i).stamp();
    bullets.get(i).correction();
  }
}

void keyPressed() {
  if (bullets.size() == 0) {
    if (key == 'w' || key == 'W') {
      current.ang += 1;
      if (current.ang == 360) {
        current.ang = 0;
      }
    }
    if (key == 's' || key == 'S') {
      current.ang -= 1;
      if (current.ang == - 1) {
        current.ang = 359;
      }
    }
    if (current.mvt > 0 && !current.isFloating()) {
      if (key == 'a' || key == 'A') {
        current.xpos -= 3;
        current.mvt --;
        if (top.get((int)current.xpos).ypos < current.ypos - 8) {
          current.xpos += 3;
        }
      }
      if (key == 'd' || key == 'D') {
        current.xpos += 3;
        current.mvt --;
        if (top.get((int)current.xpos).ypos < current.ypos - 8) {
          current.xpos -= 3;
        }
      }
    }
    //Pew pew from tank
    if (key == ' ') {
      current.pow ++;
      if (current.pow == 121) {
        current.pow = 0;
      }
    }
    if (key == 'x') {
      current.launch();
      current.mvt = 25;
      if (turn < balls.size() - 1) {
        turn++;
      } else {
        turn = 0;
      }
    }
  }
}


//creates the initial terrain
void drawTerrain() {
  float startx = 0;
  float starty = height * 3 / 4;
  float nexty;
  while (startx < width) {
    stroke(#2ECC71);
    top.add(new Topsoil(startx, starty));
    nexty = starty + -2 + rand.nextInt(5);
    startx += 1;
    starty = nexty;
  }
  stroke(#FFFFFF);
}

//updates the terrain
void terrain() {
  background(#6BB9F0);
  Shape current = balls.get(turn);
  //status box
  fill(#777777, 127);
  stroke(#000000);
  rect(width - 180, 0, 175, 65, 7);
  rect(width - 175, 35, 165, 10);
  fill(#FF0000, 200);
  rect(width - 174, 35, current.pow * 163 / 120, 10);
  fill(#000000);
  textSize(15);
  textAlign(LEFT);
  text("Player " + current.name, width - 175, 15);
  text("Power: " + current.pow, width - 175, 30);
  text("Angle: " + current.ang, width - 90, 30);
  text("Movement Points: " + current.mvt, width - 175, 60);
  //updates terrain
  stroke(#2ECC71);
  for (Topsoil t : top) {
    line(t.xpos, t.ypos, t.xpos, height);
  }
}

