class FountainBullet extends Bullet {

  FountainBullet(int team, float startx, float starty, float xMagStart, float yMagStart) {
    super(team, startx, starty, xMagStart, yMagStart);
  }

  void checkImpact () {
    if (xpos <= width && xpos >= 0 && top.get((int)xpos).ypos <= ypos) {
      detonate(15);
    }
    for (Tank b : tanks) {
      if (b.team != team && getDist(b) < b.rad) {
        detonate(25);
      }
    }
  }

  void detonate (int rad) {
    for (int i = 0; i < 3; i++) {
      bullets.add(new Bullet(team, xpos, ypos - 2, -2 + rand.nextInt(5), -1));
    }
    ypos = height + 1;
  }
}

