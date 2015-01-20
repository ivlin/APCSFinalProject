class MineBullet extends Bullet{
  
    void checkImpact () {
    if (xpos <= width && xpos >= 0 && top.get((int)xpos).ypos <= ypos) {
      ypos += .0005 ;
    }
    for (Tank b : tanks) {
      if (ff.selection == 0) {
        if (xpos-1.5 < b.xpos < xpos +1.5) {
          detonate(30);
          ypos = height + 1;
        }
      } else {
        if (b.team != team && getDist(b) < b.rad) {
          if (xpos-1.5 < b.xpos < xpos + 1.5) {
            detonate(30);
            ypos = height + 1;
          }
        }
      }
    }
  }
  
   void detonate(float rad) {
    float temp;
    Thing t;
    for (int x = (int)(xpos - rad); x < (int)(xpos + rad) && x < width && x >= 0; x++) {
      t= top.get(x);
      if (t.xpos > xpos - rad && t.xpos < xpos + rad) {
        temp = sqrt(pow(rad, 2) - pow(t.xpos - xpos, 2));
        if (getDist(t) < rad) {
          t.ypos = ypos + temp;
        } else if (t.ypos < ypos) {
          t.ypos += 2 * temp;
        }
      }
    }
    for (Tank b : tanks) {
      temp = getDist(b);
      if (temp < b.rad + rad) {
        b.hp -= dmg;
      }
    }
  }
  
}
