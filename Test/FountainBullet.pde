class FountainBullet extends Bullet {

  FountainBullet(int team, float startx, float starty, float xMagStart, float yMagStart) {
    super(team, startx, starty, xMagStart, yMagStart);
  }

  void detonate (float rad) {
    super.detonate(10);
    for (int i = 0; i < 3; i++) {
      bullets.add(new Bullet(team, xpos, ypos - 2, -1 + (rand.nextFloat() * 2.0), -2 * rand.nextFloat()));
    }
    ypos = height + 1;
  }
}

