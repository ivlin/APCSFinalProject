import java.util.*;
import static java.lang.Math.*;

ArrayList<Tank> tanks = new ArrayList<Tank>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Topsoil> top = new ArrayList<Topsoil>();
ArrayList<Button> playerNum = new ArrayList<Button>();
Button ffa, team, start;
int turn = 0;
int players = 0;
int teams = 1;
Tank current;
Random rand = new Random();
boolean settingUp = true;
int change = 1;

void setup() {
  size(1000, 500);
  frameRate(40);
  if (settingUp) {
    for (int b = 2; b < 11; b++) {
      playerNum.add(new Button("" + b, (width - 20) / 9 * (b - 2) + 10, 100, (width - 20) / 8.4, (width - 20) / 9));
    }
    ffa = new Button("Free for All", 10, 200, (width - 20) / 2, (width - 20) / 9);
    team = new Button("Team", width / 2, 200, (width - 20) / 2, (width - 20) / 9);
    start = new Button("start", 10, 300, (width - 20), (width - 20) / 9);
  } else {
    drawTerrain();
    for (int i = 0; i < players; i++) {
      int t;
      if (teams == 2) {
        t = i % 2;
      } else {
        t = i;
      }
      tanks.add(new Tank(t, 12, 25 + rand.nextInt(width - 25), 25));
    }
  }
}


void draw() {
  if (settingUp) {
    fill(100);
    rect(10, 10, width - 20, height - 20);
    for (Button b : playerNum) {
      b.stamp();
    }
    ffa.stamp();
    team.stamp();
    start.stamp();
    if (start.isSelected) {
      settingUp = false;
      setup();
    }
  } else {
    current = tanks.get(turn);
    terrain();
    for (Tank a : tanks) {
      a.correction();
      a.stamp();
    }
    for (int i = bullets.size () - 1; i >= 0; i--) {
      bullets.get(i).fall();
      bullets.get(i).stamp();
      bullets.get(i).correction();
    }
  }
}

void keyPressed() {
  if (!settingUp) {
    if (bullets.size() == 0) {
      if (key == 'w' || key == 'W') {
        current.ang += 1;
        if (current.ang == 360) {
          current.ang = 0;
        }
      }
      if (key == 's' || key == 'S') {
        current.ang -= 1;
        if (current.ang == - 1) {
          current.ang = 359;
        }
      }
      if (current.mvt > 0 && !current.isFloating()) {
        if (key == 'a' || key == 'A') {
          current.xpos -= 3;
          current.mvt --;
          if (top.get((int)current.xpos).ypos < current.ypos - 8) {
            current.xpos += 3;
          }
        }
        if (key == 'd' || key == 'D') {
          current.xpos += 3;
          current.mvt --;
          if (top.get((int)current.xpos).ypos < current.ypos - 8) {
            current.xpos -= 3;
          }
        }
      }
      //Pew pew from tank
      if (key == ' ') {
        if (current.pow == 121 || current.pow == -1) {
          change = -change;
        }
        current.pow += change;
      }
      if (key == 'x') {
        current.launch();
        current.mvt = 25;
        if (turn < tanks.size() - 1) {
          turn++;
        } else {
          turn = 0;
        }
      }
    }
  }
}

void mouseClicked() {
  for (Button a : playerNum) {
    a.checkState();
    if (a.isSelected) {
      players =  Integer.parseInt(a.id);
      if (("" + players).equals(a.id)) {
        for (Button b : playerNum) {
          if (b != a) {
            b.isSelected = false;
          }
        }
      }
    }
  }
  ffa.checkState();
  team.checkState();
  if (ffa.isSelected) {
    teams = players;
    team.isSelected = false;
  } else if (team.isSelected && players % 2 == 0) {
    teams = 2;
    ffa.isSelected = false;
  }
  start.checkState();
}

//creates the initial terrain
void drawTerrain() {
  float startx = 0;
  float starty = height * 3 / 4;
  float nexty;
  while (startx < width) {
    stroke(#2ECC71);
    top.add(new Topsoil(startx, starty));
    nexty = starty + -2 + rand.nextInt(5);
    startx += 1;
    starty = nexty;
  }
}

//updates the terrain
void terrain() {
  background(#6BB9F0);
  //status box
  fill(#777777, 127);
  stroke(#000000);
  rect(width - 180, 0, 175, 65, 7);
  rect(width - 175, 35, 165, 10);
  fill(#FF0000, 200);
  rect(width - 174, 35, current.pow * 163 / 120, 10);
  fill(#000000);
  textSize(15);
  textAlign(LEFT);
  text("Player " + current.name + " Team " + current.team, width - 175, 15);
  text("Power: " + current.pow, width - 175, 30);
  text("Angle: " + current.ang, width - 90, 30);
  text("Movement Points: " + current.mvt, width - 175, 60);

  //updates terrain
  stroke(#2ECC71);
  float lowest = top.get(0).ypos;
  for (Topsoil t : top) {
    if (t.ypos > lowest) {
      lowest = t.ypos;
    }
  }
  for (Topsoil t : top) {
    line(t.xpos, t.ypos, t.xpos, lowest);
  }
  fill(#2ECC71);
  rect(0, lowest, width, height - lowest);
}

