class Target {
  int diameter;
  PVector position;
  color targetC; // Target Color
  float targetX, targetY; //


  boolean isMouseInside() {
    if (mouseX>=targetX-(diameter/2) && mouseX<=targetX+(diameter/2) && mouseY>=targetY-(diameter/2) && mouseY<=targetY+(diameter/2)) {
      return true;
    } else {
      return false;
    }
  }


  boolean correctClick() {
    if (isMouseInside() && mousePressed) {
      return true;
    } else {
      return false;
    }
  }

  boolean falseClick() {
    if (!isMouseInside() && mousePressed) {
      return true;
    } else {
      return false;
    }
  }



  void display() {
    ellipse(targetX, targetY, diameter, diameter);
    fill(targetC);
  }
}
