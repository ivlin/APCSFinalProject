class TeleportBullet extends Bullet {
  
   TeleportBullet (int team, float startx, float starty, float xMagStart, float yMagStart) {
     super(team,startx,starty,xMagStart,yMagStart);
   }
   /*
   void teleport () {
     if (xpos <= width && xpos >= 0 && top.get((int)xpos).ypos <= ypos) {
         current.xpos = t.xpos;
         current.ypos = t.ypos -1;
     }
     for (Tank b : tanks) {
      if (getDist(b) < b.rad) {
       current.xpos = t.xpos;
       current.ypos = height/2;
      }
     }
   }
   */
   
}
