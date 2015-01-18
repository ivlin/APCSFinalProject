class ButtonArray {
  Button[]array;
  int selection;
  float x, y, w, h;

  ButtonArray (int size, float x, float y, float w, float h) {
    array = new Button[size];
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    for (int i = 0; i < array.length; i++) {
      array[i] = new Button(null, x + w / size * i, y, w / size, h);
    }
    array[0].isSelected = true;
  }

  void setButton(int i, String newId) {
    array[i].id = newId;
  }

  void checkState() {
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      for (int i = 0; i < array.length; i++) {
        array[i].checkState();
        if (array[i].isSelected) {
          selection = i;
        }
      }
    }
  }

  void stamp(float r, float g, float b, float a) {
    for (int i = 0; i < array.length; i++) {
      array[i].stamp(r, g, b, a);
    }
  }

  String getSelection() {
    return array[selection].id;
  }
}

