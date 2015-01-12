class RollingBullet extends Bullet {
  float dist = 1000000;
   
  RollingBullet (int team, float startx, float starty, float xMagStart, float yMagStart) {
    super(team,startx,starty,xMagStart,yMagStart);
    }

  void setDist (Tank other) {
    dist = getDist(other);
  }
  
  float getDistance () {
    return dist;
  }
  
  Tank getCloseTank () {
    Tank x;
    for (Tank b : tanks) {
      if (getDist(b) < dist){
       x = b;
      }
      return x;
    }
    

  void checkImpact () {
    for (Topsoil t : top) {
      if (t.xpos == floor(xpos) && ypos >= t.ypos +1) {
        setDist(getCloseTank());     
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
    for (Topsoil t : top) {
      if (xpos == t.xpos && ypos > t.ypos - 1) {
        ypos = t.ypos - 1;  
         }
      } 
  }
 
  }
   
    
    
       
     
     
  
