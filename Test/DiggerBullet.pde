class DiggerBullet extends Bullet {
  boolean underground;

  DiggerBullet(int team, float startx, float starty, float xMagStart, float yMagStart) {
    super(team, startx, starty, xMagStart, yMagStart);
    dmg = 20;
    underground = false;
  } 
  void fall () {
    if (top.get((int)xpos).ypos > ypos) {
      yMag += 0.125;
    } else {
      underground = true;
      yMag -= 0.175;
    }
    ypos += yMag;
    xpos += xMag;
    checkImpact();
  }

  void checkImpact () {
    if (xpos <= width && xpos >= 0 && top.get((int)xpos).ypos >= ypos && underground) {
      detonate(15);
      ypos = height + 1;
    }
    detect ();
  }
}

