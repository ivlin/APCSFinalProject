class TeleportBullet extends Bullet {
  
   TeleportBullet (int team, float startx, float starty, float xMagStart, float yMagStart) {
     super(team,startx,starty,xMagStart,yMagStart);
   }
   void teleport () {
     if (xpos <= width && xpos >= 0 && top.get((int)xpos).ypos <= ypos) {
         tanks.get(turn-1).xpos = xpos;
         tanks.get(turn-1).ypos = ypos -1;
     }
     for (Tank b : tanks) {
      if (getDist(b) < b.rad) {
       tanks.get(turn-1).xpos = xpos;
       tanks.get(turn-1).ypos = height/2;
      }
     }
     ypos = height + 1;
   }
   
   void detonate(float rad) {
    float temp;
    Thing t;
    for (int x = (int)(xpos - rad); x < (int)(xpos + rad); x++) {
      t= top.get(x);
      if (t.xpos > xpos - rad && t.xpos < xpos + rad) {
        temp = sqrt(pow(rad, 2) - pow(t.xpos - xpos, 2));
        if (getDist(t) < rad) {
          t.ypos = ypos + temp;
        } else if (t.ypos <= ypos) {
          t.ypos += 2 * temp;
        }
      }
    }
    float dist;
    for (Tank b : tanks) {
      dist = getDist(b);
      if (dist < b.rad + rad) {
        b.hp -= 20;
      }
    }
    ypos = height + 1;
  }
     
   
   void checkImpact () {
     if (xpos <= width && xpos >= 0 && top.get((int)xpos).ypos <= ypos) {
      teleport();
    }
    for (Tank b : tanks) {
      if (b.team != team && getDist(b) < b.rad) {
        teleport();
      }
    }
  }
   
}
