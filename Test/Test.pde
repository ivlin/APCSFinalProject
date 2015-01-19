import java.util.*;
import static java.lang.Math.*;

ArrayList<Tank> tanks = new ArrayList<Tank>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Thing> top = new ArrayList<Thing>();
ButtonArray playerNums, gameMode, bulletType, ff, wind;
Button start, popup;
int turn, players, teams, windDirection, newWind;
Tank current;
Random rand = new Random();
boolean settingUp = true;
boolean popupVis = false;
int change = 1;

void setup() {
  size(1000, 500);
  frameRate(40);
  if (settingUp) {
    playerNums = new ButtonArray(9, 10, 50, width - 20, 100);
    for (int b = 2; b < 11; b++) {
      playerNums.setButton(b - 2, "" + b);
    }
    gameMode = new ButtonArray(2, 10, 150, width - 20, 100);
    gameMode.setButton(0, "Free for All");
    gameMode.setButton(1, "2 Team");
    ff = new ButtonArray(2, 10, 250, width / 2 - 10, (width - 20) / 9);
    wind = new ButtonArray(2, width / 2, 250, width / 2 - 10, (width - 20) / 9);
    ff.setButton(0, "Friendly Fire");
    ff.setButton(1, "No Friendly Fire");
    wind.setButton(1, "Disable Wind");
    wind.setButton(0, "Enable Wind");
    start = new Button("start", 10, 350, (width - 20), (width - 20) / 9);
  } else if (!settingUp) {
    drawTerrain();
    windDirection = 0;
    bulletType = new ButtonArray(10, 0, 0, width - 185, 65);
    //Make the bulletType buttons
    for (int x = 0; x < bulletType.size (); x ++) {
      bulletType.setButton(x, "");
    }
    bulletType.setButton(0, "Bullet");
    bulletType.setButton(1, "Big\nBullet");
    bulletType.setButton(2, "Rolling\nBullet");
    bulletType.setButton(3, "Fountain\nBullet");
    bulletType.setButton(4, "Teleport\nBullet");
    bulletType.setButton(5, "Scatter\nBullet");
    bulletType.setButton(6, "Rolling\nFountain");
    bulletType.setButton(7, "Digger\nBullet");
    bulletType.setButton(8, "Health\nBullet");
      popup = new Button("Change Name", width - 25, 66, 20, 20);

    //
    for (int i = 0; i < players; i++) {
      int l = rand.nextInt(width);
      tanks.add(new Tank(i % teams, 12, l, top.get(l).ypos - 50));
    }
  }
}



void draw() {
  if (settingUp) {
    fill(100);
    rect(10, 10, width - 20, height - 20);
    playerNums.stamp(200, 200, 200, 255);
    gameMode.stamp(200, 200, 200, 255);
    ff.stamp(200, 200, 200, 255);
    wind.stamp(200, 200, 200, 255);
    start.stamp(200, 200, 200, 255);
    if (start.isSelected) {
      settingUp = false;
      setup();
    }
  } else if (!settingUp) {
    current = tanks.get(turn);
    terrain();
    for (int i = tanks.size () - 1; i >= 0; i--) {
      Tank a = tanks.get(i);
      if (a.hp <= 0) {
        tanks.remove(i);
      } else {
        a.correction();
        a.stamp();
      }
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
        if (current.pow == 120 || current.pow == -1) {
          change = -change;
        }
        current.pow += change;
      }
      if (key == 'x') {
        current.launch();
        current.mvt = 25;
        turn++;
        if (turn == 1) {
          windDirection = newWind;
        }
        if (turn >= tanks.size()) {
          turn = 0;
          newWind = -9 + rand.nextInt(19);
        }
        for (int i = 0; i < bulletType.size (); i++) {
          bulletType.array[i].isSelected = false;
        }
        bulletType.selection = tanks.get(turn).bulletSelected;
        bulletType.array[bulletType.selection].isSelected = true;
      }
    }
  }
}

void mouseClicked() {
  if (settingUp) {
    playerNums.checkState();
    players = Integer.parseInt(playerNums.getSelection());
    if (gameMode.getSelection().equals("2 Team")) {
      teams = 2;
    } else {
      teams = players;
    }
    gameMode.checkState();
    ff.checkState();
    wind.checkState();
    start.checkState();
  } else {
    bulletType.checkState();
    current.bulletSelected = bulletType.selection;
  }
}

//creates the initial terrain
void drawTerrain() {
  float startx = 0;
  float starty = height * 3 / 4;
  float nexty;
  while (startx < width) {
    stroke(#2ECC71);
    top.add(new Thing(0.5, startx, starty));
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
  fill(#FF0000, 200);
  rect(width - 174, 35, current.pow * 163 / 120, 10);
  fill(#000000);
  textSize(13);
  textAlign(LEFT);
  text("Player " + current.name + " Team " + current.team, width - 175, 15);
  text("Power: " + current.pow, width - 175, 30);
  text("Angle: " + current.ang, width - 90, 30);
  text("Movement Points: " + current.mvt, width - 175, 60);
  text("Wind:" + newWind, width / 2, 80);
  if (popupVis) {
    rect(40, 40, width - 80, height - 80);
  }
  //updates terrain
  stroke(#2ECC71);
  bulletType.stamp(0, 0, 0, 64);
    popup.stamp(0,0,0,64);

  fill(#000000);
  textAlign(CENTER);
  for (int i = 1; i < bulletType.size (); i++) {
    text(current.inv[i], bulletType.array[i].xpos + bulletType.array[i].xlen / 2, 14);
  }
  float[]lowest = new float[4];
  for (int i = 0; i < lowest.length; i++) {
    lowest[i] = top.get(width / 4 * i).ypos;
    for (int x = i * width / 4; x < width / 4 * (i + 1); x++) {
      if (top.get(x).ypos > lowest[i]) {
        lowest[i] = top.get(x).ypos;
      }
    }
    fill(#2ECC71);
    rect(i * width / 4, lowest[i], width / 4, height - lowest[i]);
    for (int x = i * width / 4; x < width / 4 * (i + 1); x++) {
      line(top.get(x).xpos, top.get(x).ypos, top.get(x).xpos, lowest[i]);
    }
  }
}

