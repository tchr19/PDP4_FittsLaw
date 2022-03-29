class Target {
  int diameter;
  PVector position;
  color targetColor = 255; // Target Color
  float targetX, targetY; //
  
  Target(float targetX, float targetY, int diameter){
    this.targetX=targetX;
    this.targetY=targetY;
    this.diameter=diameter;
  }

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
    fill(targetColor);
  }
}
