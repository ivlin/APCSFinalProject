class RollingBullet extends Bullet {
  
   float dist;
   
   RollingBullet (int team, float startx, float starty, float xMagStart, float yMagStart) {
     super(team,startx,starty,xMagStart,yMagStart);
   }
   
   void checkImpact () {
     for (Topsoil t : top) {
       if (t.xpos == floor(xpos) && ypos >= t.ypos) {
         roll();
       }
     }
     for (Tank b : tanks) {
      if (b.team != team && getDist(b) < b.rad) { 
        detonate(15);
      }
    }
  }
  
 void roll () {
   yMag = 0;
   }
 
}
   
    
    
       
     
     
  
