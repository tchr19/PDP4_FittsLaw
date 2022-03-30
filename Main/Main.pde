import controlP5.*;

ControlP5 cp5;
Target myTarget;
Data myData;

int programState = 0;

int screenBorder = 25;

float previousMillis = 0;
float currentMillis;
float movementTime;

void setup() {
  size(750,750);
  background(25);
  cp5 = new ControlP5(this);
  cp5.addTextfield("FP-ID").setPosition((width/2)-50,20).setSize(100,20);
  cp5.addButton("START").setPosition((width/2)-30,70).setSize(60,30);
  
  //Target is created
  myTarget = new Target(new PVector(width/2, height/2),50);
}

void draw() {
  background(25);
  
    if (programState == 0){
     myTarget.display();
     if (mousePressed){
       programState = 1;
     }
     if (programState == 1){
       println("program state er nu 1");
     }
  }

  

 
}

PVector calculateNewPosition(int distance) {
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
  currentMillis = millis();
  movementTime = calculateMovementTime(previousMillis, currentMillis);
  previousMillis = currentMillis;
  
  PVector newPos = calculateNewPosition(200);
  while(newPos.x > width - (myTarget.diameter/2) - screenBorder 
  || newPos.x < 0 + (myTarget.diameter/2) + screenBorder
  || newPos.y > height - (myTarget.diameter/2) - screenBorder
  || newPos.y < 0 + (myTarget.diameter/2) + screenBorder) {
    newPos = calculateNewPosition(200);
  }
  myTarget = new Target(newPos, 50);
  print("Movement time: " + movementTime + " ms");
  
}

void mouseClicked() {
  if(myTarget.isMouseInside()) {
    handleHit();
  }
}

void START(){
  println("Knappen virker wee");
  
}
