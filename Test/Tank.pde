//This is the basic "Tank"
class Tank extends Thing {
  int hp, ang, pow, team, mvt, bulletSelected, r, g, b;
  int[]inv;
  String name;

  Tank(int team, float radius, float startx, float starty) {
    super(radius, startx, starty);
    this.team = team;
    hp = 200;
    mvt = 40;
    ang = 90;
    pow = 0;
    bulletSelected = 0;
    r = rand.nextInt(256);
    g = rand.nextInt(256);
    b = rand.nextInt(256);
    inv = new int[bulletType.size()];
    inv[1] = 20;
    inv[2] = 5;
    inv[3] = 5;
    inv[4] = 2;
    inv[5] = 5;
    inv[6] = 3;
    inv[7] = 10;
    inv[8] = 3;
    inv[9] = 3;
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
    if (inv[bulletSelected] <= 0) {
      bulletSelected = 0;
    }
    switch (bulletSelected) {
    case 1:
      bullets.add(new BigBullet(team, xpos + rad * cos(ang * PI / 180), ypos + rad * -sin(ang * PI / 180), xMag, yMag));
      break;
    case 2:
      bullets.add(new RollingBullet(team, xpos + rad * cos(ang * PI / 180), ypos + rad * -sin(ang * PI / 180), xMag, yMag));
      break;
    case 3:
      bullets.add(new FountainBullet(team, xpos + rad * cos(ang * PI / 180), ypos + rad * -sin(ang * PI / 180), xMag, yMag));
      break;
    case 4:
      bullets.add(new TeleportBullet(team, xpos + rad * cos(ang * PI / 180), ypos + rad * -sin(ang * PI / 180), xMag, yMag));
      break;
    case 5:
      bullets.add(new ScatterBullet(team, xpos + rad * cos(ang * PI / 180), ypos + rad * -sin(ang * PI / 180), xMag, yMag));
      break;
    case 6:
      bullets.add(new RollingFountainBullet(team, xpos + rad * cos(ang * PI / 180), ypos + rad * -sin(ang * PI / 180), xMag, yMag));
      break;
    case 7:
      bullets.add(new DiggerBullet(team, xpos + rad * cos(ang * PI / 180), ypos + rad * -sin(ang * PI / 180), xMag, yMag));
      break;
    case 8:
      bullets.add(new HealthBullet(team, xpos + rad * cos(ang * PI / 180), ypos + rad * -sin(ang * PI / 180), xMag, yMag));
      break;
    case 9:
      bullets.add(new MineBullet(team, xpos + rad * cos(ang * PI / 180), ypos + rad * -sin(ang * PI / 180), xMag, yMag));
      break;  
    default:
      bullets.add(new Bullet(team, xpos + rad * cos(ang * PI / 180), ypos + rad * -sin(ang * PI / 180), xMag, yMag));
      break;
    }
    inv[bulletSelected] --;
  }

  void stamp() {
    if (gameMode.selection == 0) {
      fill(r, g, b);
    }else{
     fill((255 + team) % 256, (256 - team) % 256, 128);
    }
    super.stamp();
    triangle(xpos + (1.25 * rad) * cos(((float)ang - 30) * PI / 180), ypos + -(1.25 * rad) * sin(((float)ang - 30) * PI / 180), 
    xpos + 1.25 * rad * sin((60 - (float)ang) * PI / 180), ypos + -1.25 * rad * cos((60 - (float)ang) * PI / 180), 
    xpos + 2.25 * rad * cos((float)ang * PI / 180), ypos + -2.25 * rad * sin((float)ang * PI / 180));
    fill(#000000);
    textSize(10);
    textAlign(CENTER);
    text(name+ " " + hp + " HP", xpos, ypos + rad + 7);
  }
}

