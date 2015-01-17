class BigBullet extends Bullet {

  BigBullet(int team, float startx, float starty, float xMagStart, float yMagStart) {
    super(team, startx, starty, xMagStart, yMagStart);
    dmg = 25;
  }

  void checkImpact () {
    if (xpos <= width && xpos >= 0 && top.get((int)xpos).ypos <= ypos) {
      detonate(25);
      ypos = height + 10;
    }
    for (Tank b : tanks) {
      if (b.team != team && getDist(b) < b.rad) {
        detonate(25);
        ypos = height + 10;
      }
    }
  }
}

