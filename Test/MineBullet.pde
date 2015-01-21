class MineBullet extends Bullet {

  MineBullet (int team, float startx, float starty, float xMagStart, float yMagStart) {
    super(team, startx, starty, xMagStart, yMagStart);
  }  

  void plantBullet() {
    mines.add(new MineBullet(team, xpos, top.get(int(xpos)).ypos - 1, 0, 0));
  }

  void checkImpact () {
    if (xpos <= width && xpos >= 0 && top.get((int)xpos).ypos <= ypos) {
      mines.add(new MineBullet(team, xpos, top.get(int(xpos)).ypos - 1, 0, 0));
      ypos = height + 1;
    }
  }
}

