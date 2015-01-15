class ScatterBullet extends Bullet {
  
  ScatterBullet (int team, float startx, float starty, float xMagStart, float yMagStart) {
   super(team,startx,starty,xMagStart,yMagStart);
  }
 
  void scatter () {
   /*
    if (yMag == 0) {
      for (int i = 0; i < 4; i++){
         bullets.add(new Bullet(team, xpos, 10, -2 + rand.nextInt(5), 8));
      }
    }
  }
  */
  if ( tanks.get(turn-1).ypos < ypos && yMag < 0) {
    if (yMag > 0 && ypos >=  tanks.get(turn-1).ypos-100){
      bullets.add(new Bullet(team, xpos, ypos, xMag+5, yMag));
      bullets.add(new Bullet(team, xpos, ypos, xMag+3, yMag));
      bullets.add(new Bullet(team, xpos, ypos, xMag+0, yMag));
      bullets.add(new Bullet(team, xpos, ypos, xMag-3, yMag));
      bullets.add(new Bullet(team, xpos, ypos, xMag-5, yMag));
    }
  }else if (tanks.get(turn-1).ypos < ypos && yMag > 0){
      bullets.add(new Bullet(team, xpos, ypos, xMag+5, yMag));
      bullets.add(new Bullet(team, xpos, ypos, xMag+3, yMag));
      bullets.add(new Bullet(team, xpos, ypos, xMag+0, yMag));
      bullets.add(new Bullet(team, xpos, ypos, xMag-3, yMag));
      bullets.add(new Bullet(team, xpos, ypos, xMag-5, yMag));
    }
}
  
  
  
  void checkImpact () {
    scatter();
    if (xpos <= width && xpos >= 0 && top.get((int)xpos).ypos <= ypos) {
      detonate(15);
    }
    for (Tank b : tanks) {
      if (b.team != team && getDist(b) < b.rad) {
        detonate(25);
      }
    }
  }
  
}
  
       
        
