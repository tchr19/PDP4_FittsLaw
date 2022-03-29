Target myTarget;

void setup() {
  size(750,750);
  background(25);
  //Target is created
  myTarget = new Target(200,100,25);
}

void draw() {
  myTarget.display();
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
  
}
