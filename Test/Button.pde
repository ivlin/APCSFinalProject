class Button {
  String id;
  float xpos, ypos, xlen, ylen;
  boolean isValid, isSelected;

  Button(String id, float x, float y, float w, float h) {
    this.id = id;
    xpos = x;
    ypos = y;
    xlen = w;
    ylen = h;
    isValid = true;
    isSelected = false;
  }

  void stamp() {
    if (isValid);
    if (isSelected) {
      fill(#FF4444);
    } else {
      fill(200);
    }
    rect(xpos, ypos, xlen, ylen);
    textAlign(CENTER);
    fill(#000000);
    text(id, xpos + xlen / 2, ypos + ylen / 2);
  }

  void checkState() {
    if (mouseX > xpos && mouseX < xpos + xlen && mouseY > ypos && mouseY < ypos + ylen) {
      isSelected = !isSelected;
    }
  }
}

