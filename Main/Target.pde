class Target {
  int diameter;
  PVector position;
  color targetColor = 255; // Target Color

  Target(PVector position, int diameter) {
    this.position = position;
    this.diameter = diameter;
  }

  boolean isMouseInside() {
    if (mouseX>=position.x-(diameter/2) 
    && mouseX<=position.x+(diameter/2) 
    && mouseY>=position.y-(diameter/2) 
    && mouseY<=position.y+(diameter/2)) {
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
    fill(targetColor);
    ellipse(position.x, position.y, diameter, diameter);
  }
}
