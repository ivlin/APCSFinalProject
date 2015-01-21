class MineBullet extends Bullet{
  
  boolean isFloor;
  
  MineBullet (int team, float startx, float starty, float xMagStart, float yMagStart) {
    super(team, startx, starty, xMagStart, yMagStart);
    isFloor = false;
  }  
  
  void checkImpact () {
    Thing t;
    if (xpos <= width && xpos >= 0 && top.get((int)xpos).ypos <= ypos) {
      t = top.get((int)xpos);
    if (t.xpos == floor(xpos) && ypos >= t.ypos +1) {
        mines.add(bullets.get((int)xpos));
        bullets.remove(bullets.get((int)xpos));
        xMag = 0;
        yMag= -1;
        isFloor = true;
      }
    for (Tank b : tanks) {
      if (ff.selection == 0) {
        if (xpos-2 < b.xpos && b.xpos < xpos + 2 && isFloor == true) {
          detonate(30);
          ypos = height + 1;
        }
      } else {
        if (b.team != team && getDist(b) < b.rad && isFloor == true) {
          if (xpos-2 < b.xpos && b.xpos < xpos + 2 && isFloor == true) {
            detonate(30);
            ypos = height + 1;
          }
        }
      }
    }
   }
   }

}
  

  

