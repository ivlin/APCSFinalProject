class TeleportBullet extends Bullet {
  
   TeleportBullet (int team, float startx, float starty, float xMagStart, float yMagStart) {
     super(team,startx,starty,xMagStart,yMagStart);
   }
   
   void checkImpact () {
     if (xpos <= width && xpos >= 0 && top.get((int)xpos).ypos <= ypos) {
         current.xpos = xpos;
         current.ypos = ypos -1;
       }  
     for (Tank b : tanks) {
      if (getDist(b) < b.rad) {
       current.xpos = xpos;
       current.ypos = height/2;
      }
     }
   }
   
   
}
