Target myTarget;

int screenBorder = 25;

void setup() {
  size(750,750);
  background(25);
  //Target is created
  myTarget = new Target(new PVector(width/2, height/2),50);
}

void draw() {
  background(25);
  myTarget.display();

}

PVector calculateNewPosition(int distance) {
  float angle = random(360);
  float x = mouseX + distance * cos(angle);
  float y = mouseY + distance * sin(angle);
  PVector newPos = new PVector(x,y);
  return newPos;
}

//This function calculates the time between clicks (MT)
float calculateMovementTime(float start, float end) {
  return (end - start);
}

//This function calculates the distance between two points
double calculateDistance(int x1,int y1,int x2, int y2) {
  int x = x2 - x1;
  int y = y2 - y1;
  return Math.sqrt(x * x + y * y);
}

void handleHit() {
  //PREV MILLIS
  //CURRENT MILIS
  //MOVEMENT TIME
  //DISTANCE TO TARGET CENTER FROM CLICK
  PVector newPos = calculateNewPosition(200);
  
  while(newPos.x > width - (myTarget.diameter/2) - screenBorder 
  || newPos.x < 0 + (myTarget.diameter/2) + screenBorder
  || newPos.y > height - (myTarget.diameter/2) - screenBorder
  || newPos.y < 0 + (myTarget.diameter/2) + screenBorder) {
    newPos = calculateNewPosition(200);
  }
  myTarget = new Target(newPos, 50);
  
}

void mouseClicked() {
  if(myTarget.isMouseInside()) {
    handleHit();
  }
}
