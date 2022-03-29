class Target {
  int diameter;
  PVector position;
  color targetColor = 255; // Target Color
  float targetX, targetY; //

  Target(float targetX, float targetY, int diameter) {
    this.targetX=targetX;
    this.targetY=targetY;
    this.diameter=diameter;
  }

  boolean isMouseInside() {
    if (mouseX>=targetX-(diameter/2) && mouseX<=targetX+(diameter/2) && mouseY>=targetY-(diameter/2) && mouseY<=targetY+(diameter/2)) {
     println("Mouse is inside target");
      return true;
    } else {
      println("Mouse is NOT inside target");
      return false;
    }
  }

  boolean correctClick() {
    if (isMouseInside() && mousePressed) {
      println("correct click = true");
        return true;
    } else {
      println("correct click = false");
      return false;
      
    }
  }

  boolean falseClick() {
    if (!isMouseInside() && mousePressed) {
      println("false click = true");
      return true;
    } else {
      println("false click = false");
      return false;
    }
  }

  void display() {
    ellipse(targetX, targetY, diameter, diameter);
    fill(targetColor);
  }
}
