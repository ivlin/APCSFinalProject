class Bullet extends Thing {
  int team, dmg;
  float life, yMag, xMag;

  Bullet (int team, float startx, float starty, float xMagStart, float yMagStart) {
    super(2, startx, starty);
    life = 0;
    dmg = 15;
    this.team = team;
    xMag = xMagStart;
    yMag = yMagStart;
  }

  //Movement of bullet, complete with vertical and horizontal component and acceleration downwards
  void fall () {
    yMag += life * 0.003;
    ypos += yMag;
    xpos += xMag;
    if (wind.selection == 0) {
      xpos += (float)windDirection / 4;
    }
    checkImpact();
    life ++;
  }

  void checkImpact () {
    if (xpos <= width && xpos >= 0 && top.get((int)xpos).ypos <= ypos) {
      detonate(15);
      ypos = height + 1;
    }
    detect ();
  }

  void detonate(float rad) {
    float temp;
    Thing t;
    for (int x = (int)(xpos - rad); x < (int)(xpos + rad) && x < width && x >= 0; x++) {
      t= top.get(x);
      if (t.xpos > xpos - rad && t.xpos < xpos + rad) {
        temp = sqrt(pow(rad, 2) - pow(t.xpos - xpos, 2));
        if (getDist(t) < rad) {
          t.ypos = ypos + temp;
        } else if (t.ypos < ypos) {
          t.ypos += 2 * temp;
        }
      }
    }
    for (Tank b : tanks) {
      temp = getDist(b);
      if (temp < b.rad + rad) {
        b.hp -= dmg;
      }
    }
  }

  //Removes bullets from list of bullets after it exits the screen
  void correction() {
    if (xpos < 0 || xpos > width || ypos > height) {
      int x = 0;
      for (int i = bullets.size () - 1; i >= 0; i--) {
        if (bullets.get(i).xpos == xpos && bullets.get(i).ypos == ypos) {
          x = i;
        }
      }
      bullets.remove(x);
    }
  }

  void detect () {
    for (Tank b : tanks) {
      if (ff.selection == 0) {
        if (getDist(b) < b.rad) {
          detonate(15);
          ypos = height + 1;
        }
      } else {
        if (b.team != team && getDist(b) < b.rad) {
          detonate(15);
          ypos = height + 1;
        }
      }
    }
  }
}

