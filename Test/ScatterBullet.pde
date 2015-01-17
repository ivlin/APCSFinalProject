class ScatterBullet extends Bullet {

  ScatterBullet (int team, float startx, float starty, float xMagStart, float yMagStart) {
    super(team, startx, starty, xMagStart, yMagStart);
  }

  void scatter () {
      for (float i = 0; i < .80; i+=.25) {
        bullets.add(new Bullet(team, xpos, ypos, xMag+i, yMag));
      }
      for (float i = 0; i > -.80; i-= .25) {
        bullets.add(new Bullet(team, xpos, ypos, xMag+i, yMag));
      }
      ypos = height + 1;
    }
 




  void checkImpact () {
    if (yMag > 0 && yMag < .15){
      scatter();
    }
    if (xpos <= width && xpos >= 0 && top.get((int)xpos).ypos <= ypos) {
      detonate(15);
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



