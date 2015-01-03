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
    for (Tank b : tanks) {
      if (b.team != team && getDist(b) < b.rad) { 
        detonate(15);
      }
    }
  }

  void detonate(float rad) {
    float temp;
    for (Topsoil t : top) {
      if (t.xpos >= xpos - rad && t.xpos <= xpos + rad) {
        temp = sqrt(pow(rad, 2) - pow(t.xpos - xpos, 2));
        if (getDist(t) < rad) {
          t.ypos = ypos + temp;
        } else if (t.ypos <= ypos) {
          t.ypos += 2 * temp;
        }
      }
    }
    float dist;
    for (Tank b : tanks) {
      dist = getDist(b);
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
