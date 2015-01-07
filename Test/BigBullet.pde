/*
class BigBullet extends Bullet{
  
  BigBullet(int team, float startx, float starty, float xMagStart, float yMagStart) {
    super(team,startx,starty,xMagStart,yMagStart);
  }
  
  void checkImpack () {
    for (Topsoil t : top) {
      if (t.xpos == floor(xpos) && ypos >=t.xpos || ypos == height) {
        detonate(25);
      }
    }
    for (Tank b : tanks) {
      if (b.team != team && getDist(b) < b.rad){
          detonate(25);
      }
    }
  }
        
  void detonate(float rad) {
    float temp;
    for (Topsoil t : top) {
      if (t.xpos >= xpos - rad && t.xpos <= xpos + rad) {
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
        b.hp -= 30;
      }
    }
    ypos = height + 10;
  }
  
}
*/
