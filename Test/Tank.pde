//This is the basic "Tank"
class Tank extends Thing {
  int hp, ang, pow, team, mvt, bulletSelected;
  String name;

  Tank(int team, float radius, float startx, float starty) {
    super(radius, startx, starty);
    this.team = team;
    hp = 120;
    mvt = 110;
    ang = 0;
    pow = 0;
  }

  //Keeps within screen boundaries, applies gravity
  void correction() {
    if (xpos - rad < 0) {
      xpos = 0 + rad;
    } else if (xpos + rad > width) {
      xpos = width - rad;
    }
    //stops the tank from phasing "into" terrain
    if (top.get((int)xpos).ypos < ypos + rad) {
      ypos = top.get((int)xpos).ypos - rad;
    }
    fall();
  }

  //Launches a bullets with an xmagnitude and ymagnitude
  void launch() {
    float xMag = (float)pow / 10 * cos(ang * PI / 180);
    float yMag = (float)pow / 10 * -sin(ang * PI / 180);
    switch (bulletSelected) {
    case 1:
      bullets.add(new BigBullet(team, xpos, ypos, xMag, yMag));
      break;
    case 2:
      bullets.add(new RollingBullet(team, xpos, ypos, xMag, yMag));
      break;
    case 3:
      bullets.add(new FountainBullet(team, xpos, ypos, xMag, yMag));
      break;
    case 4:
      bullets.add(new TeleportBullet(team, xpos, ypos, xMag, yMag));
      break;
    default:
      bullets.add(new Bullet(team, xpos, ypos, xMag, yMag));
      break;
    case 5:
      bullets.add(new ScatterBullet(team,xpos, ypos, xMag, yMag));
      break;
    }
    //   bullets.add(new Bullet(team, xpos, ypos, xMag, yMag));
    bullets.get(bullets.size() - 1).id = bullets.size() - 1;
  }

  void stamp() {
    super.stamp();
    fill(255 / tanks.size() * team);
    triangle(xpos + (1.25 * rad) * cos(((float)ang - 30) * PI / 180), ypos + -(1.25 * rad) * sin(((float)ang - 30) * PI / 180), 
    xpos + 1.25 * rad * sin((60 - (float)ang) * PI / 180), ypos + -1.25 * rad * cos((60 - (float)ang) * PI / 180), 
    xpos + 2.25 * rad * cos((float)ang * PI / 180), ypos + -2.25 * rad * sin((float)ang * PI / 180));
    fill(#000000);
    textSize(10);
    textAlign(CENTER);
    text(name+ " " + hp + " HP", xpos, ypos + rad + 7);
  }
}

