class TeleportBullet extends Bullet {

  TeleportBullet (int team, float startx, float starty, float xMagStart, float yMagStart) {
    super(team, startx, starty, xMagStart, yMagStart);
  }
  void teleport() {
    if (xpos <= width && xpos >= 0 && top.get((int)xpos).ypos <= ypos) {
      if (turn == 0) {
        tanks.get(tanks.size()-1).xpos = xpos;
        tanks.get(tanks.size()-1).ypos = ypos - .25;
      } else {
        tanks.get(turn-1).xpos = xpos;
        tanks.get(turn-1).ypos = ypos - .25;
      }
    }
    for (Tank b : tanks) {
      if (getDist(b) < b.rad) {
        if (turn == 0) {
          tanks.get(tanks.size()-1).xpos = xpos;
          tanks.get(tanks.size()-1).ypos = height/2;
        } else {  
          tanks.get(turn-1).xpos = xpos;
          tanks.get(turn-1).ypos = height/2;
        }
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

