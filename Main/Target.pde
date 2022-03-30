class Target {
  float diameter;
  PVector position;
  color targetColor = 255; // Target Color

  Target(PVector position, float diameter) {
    this.position = position;
    this.diameter = diameter;
  }

  boolean isMouseInside() {
    return mouseX>=position.x-(diameter/2) 
    && mouseX<=position.x+(diameter/2) 
    && mouseY>=position.y-(diameter/2) 
    && mouseY<=position.y+(diameter/2);
  }

  void display() {
    fill(targetColor);
    ellipse(position.x, position.y, diameter, diameter);
  }
}
