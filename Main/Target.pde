class Target {
  float diameter;
  PVector position;
  color targetColor = color(255,0,0); // Target Color

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
  
  //Make a function that starts a timer when isMouseInside() is true 
  //and if it reaches a certain time limit it should tell main so that a function
  //return true 
  //in main can handle the hit
  

  void display() {
    fill(targetColor);
    ellipse(position.x, position.y, diameter, diameter);
  }
  }
