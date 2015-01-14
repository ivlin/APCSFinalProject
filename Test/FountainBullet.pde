class FountainBullet extends Bullet {

  FountainBullet(int team, float startx, float starty, float xMagStart, float yMagStart) {
    super(team, startx, starty, xMagStart, yMagStart);
  }
  
  void detonate(int rad) {
    System.out.println("Split");
    for (int i = 0; i < 5; i++) {
      bullets.add(new Bullet(team, xpos, 10, -2 + rand.nextInt(5), 8));
    }
  }
}

