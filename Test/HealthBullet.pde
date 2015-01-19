class HealthBullet extends Bullet {

  HealthBullet (int team, float startx, float starty, float xMagStart, float yMagStart) {
    super(team, startx, starty, xMagStart, yMagStart);
  }

  void checkImpact () {
    if (xpos <= width && xpos >= 0 && top.get((int)xpos).ypos <= ypos) {
      detonate(0);
      ypos = height + 1;
    }
    for (Tank b : tanks) {
      if (getDist(b) < b.rad) {
        detonate(0);
        b.hp += 25;
        ypos = height + 1;
      }
    }
  }
}

