class Thing {
  float rad, xpos, ypos;

  Thing (float radius, float startx, float starty) {
    rad = radius;
    xpos = startx;
    ypos = starty;
  }

  //things fall while on screen - maybe unnecessary
  void fall() {
    boolean floating = isFloating();
    if (ypos + rad <= height && floating) {
      ypos += 2;
    }
  }

  boolean isFloating() {
    boolean floating = true;
    for (Thing t : top) {
      if (t.xpos >= xpos - rad && t.xpos <= xpos + rad) {
        floating = floating && t.ypos > ypos && getDist(t) > rad;
      }
    }
    return floating;
  }

  float getDist(Thing other) {
    return (sqrt(pow(xpos - other.xpos, 2) + pow(ypos - other.ypos, 2)));
  }

  void stamp() {
    ellipse(xpos, ypos, 2 * rad, 2 * rad);
  }
}
