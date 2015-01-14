class RollingBullet extends Bullet {
  float dist = 1000000;
  int mvt, dir;

  RollingBullet (int team, float startx, float starty, float xMagStart, float yMagStart) {
    super(team, startx, starty, xMagStart, yMagStart);
    mvt = 8;
  }

  void setDist (Tank other) {
    dist = getDist(other);
    if (getCloseTank().xpos > xpos) {
      dir = 1;
    } else {
      dir = -1;
    }
  }

  float getDistance () {
    return dist;
  }

  Tank getCloseTank () {
    Tank x = tanks.get(0);
    for (Tank b : tanks) {
      if (getDist(b) < dist) {
        x = b;
      }
    }
    return x;
  }


  void checkImpact () {
    for (Thing t : top) {
      if (t.xpos == floor(xpos) && ypos >= t.ypos +1) {
        setDist(getCloseTank());     
        roll();
      }
    }
    for (Tank b : tanks) {
      if (b.team != team && getDist(b) < b.rad) { 
        detonate(15);
      }
    }
  }


  void roll () {
    yMag = 0;
    /* for (Thing t : top) {
     if (xpos == t.xpos && ypos > t.ypos - 1) {
     ypos = t.ypos - 1;  
     }
     } 
     */
    if (top.get((int)xpos).ypos < ypos + rad) {
      ypos = top.get((int)xpos).ypos - rad;
    }
    // Obi add the movement and direction stuff info in Test KeyPressed() and Tank correction()
    if (dir == 1 && mvt > 0) {
      xpos += 3;
      mvt--;
    }
    if (dir == -1 && mvt > 0) {
      xpos -= 3;
      mvt--;
    }
    if (mvt == 0) {
      detonate(15);
    }
  }
}







