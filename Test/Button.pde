class Button {
  String id;
  float xpos, ypos, xlen, ylen;
  boolean isSelected;

  Button(String id, float x, float y, float w, float h) {
    this.id = id;
    xpos = x;
    ypos = y;
    xlen = w;
    ylen = h;
    isSelected = false;
  }

  void stamp(float r, float g, float b, float a) {
    if (isSelected) {
      fill(#FF4444, a);
    } else {
      fill(r, g, b, a);
    }
    rect(xpos, ypos, xlen, ylen);
    textAlign(CENTER);
    fill(#000000);
    text(id, xpos + xlen / 2, ypos + ylen / 2);
  }

  void checkState() {
    isSelected = mouseX > xpos && mouseX < xpos + xlen && mouseY > ypos && mouseY < ypos + ylen;

  }
}

