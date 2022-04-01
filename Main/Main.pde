import controlP5.*;

ControlP5 cp5;

Data myData;
Target myTarget;
//Data myData;
//int trialNr;
int screenBorder = 25;
int trialNum = 0;

float previousMillis = 0;
float currentMillis;
float movementTime;

float distance;
float targetDiameter;

float[] distances = { 40,80,160,320 };
float[] diameters = { 10,20,40,80 };

void setup() {
  size(750,750);
  background(25);
  cp5 = new ControlP5(this);
  cp5.addButton("START").setPosition((width/2)-30,20).setSize(60,20);
  cp5.addTextfield("SUBJECT").setPosition(20,20).setSize(200,20);
  //Target is created
  myTarget = new Target(new PVector(width/2, height/2),getParameter(diameters));
  //myData.createTable();
}

void draw() {
  background(25);
  myTarget.display();
  //myData.saveData(trialNr, targetDiameter, distance, movementTime);
}

float getParameter(float[] parameters) {
  float parameter = parameters[int(random(parameters.length))];
  return parameter;

}

PVector calculateNewPosition(float distance) {
  float angle = random(360);
  float x = mouseX + distance * cos(angle);
  float y = mouseY + distance * sin(angle);
  PVector newPos = new PVector(x,y);
  return newPos;
}

//This function calculates the time between clicks (MT)
float calculateMovementTime(float prev, float curr) {
  return (curr - prev);
}

//This function calculates the distance between two points
double calculateDistance(int x1,int y1,int x2, int y2) {
  int x = x2 - x1;
  int y = y2 - y1;
  return Math.sqrt(x * x + y * y);
}

void handleHit() {
  trialNum += 1;
  currentMillis = millis();
  movementTime = calculateMovementTime(previousMillis, currentMillis);
  previousMillis = currentMillis;

  PVector newPos = calculateNewPosition(getParameter(distances));
  while(newPos.x > width - (myTarget.diameter/2) - screenBorder
  || newPos.x < 0 + (myTarget.diameter/2) + screenBorder
  || newPos.y > height - (myTarget.diameter/2) - screenBorder
  || newPos.y < 0 + (myTarget.diameter/2) + screenBorder) {
    newPos = calculateNewPosition(200);
  }
  myTarget = new Target(newPos, getParameter(diameters));

  println("Movement time: " + movementTime + " ms");

  myData.saveData(targetDiameter, distance, movementTime);

}

void mouseClicked() {
  if(myTarget.isMouseInside()) {
    handleHit();
  }
}
