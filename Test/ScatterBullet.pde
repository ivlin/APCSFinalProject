class ScatterBullet extends Bullet {
  
  ScatterBullet (int team, float startx, float starty, float xMagStart, float yMagStart) {
   super(team,startx,starty,xMagStart,yMagStart);
  }
 
  void scatter () {
    if (yMag == 0) {
      for (int i = 0; i < 4; i++){
        
