//Halløj

import controlP5.*;

//Import classes
ControlP5 cp5;
Data myData;
Target myTarget;
Startscreen myStartscreen;

//Variables
String subjectId;
int screenBorder = 25;
int trialNum = 0;
int trialPerComb = 1;

//Time variables
float previousMillis = 0;
float currentMillis;
float movementTime;

//Parameter variablers
float distance;
float diameter;


int[] dia = { 20,40,80,160 };
int[] dist = { 160,320,640,1280 };

//Make a list of combinations for each diameter with all distances
ArrayList<Integer> distances = new ArrayList<Integer>();
ArrayList<Integer> diameters = new ArrayList<Integer>();

void setup() {
  //Combinations of parameters created in lists
  createCombinations();
  //size(500,500);
  fullScreen();
  background(25);
  cp5 = new ControlP5(this);
  //Target created
  myData = new Data();
  myStartscreen = new Startscreen();
  myStartscreen.showPage();
}

void draw() {
  background(25);
  if(myTarget != null) {
    myTarget.display();
  }
}

//Get parameter should retrieve a random parameter combination from the parameters array
//And remove this from the array afterwards 
//+ save parameters in distance and diameter variables
void getParameters() {
  int index = int(random(diameters.size()));
  diameter = diameters.get(index); // * pix;
  distance = distances.get(index); // * pix;
  diameters.remove(index);
  distances.remove(index);
}

//Calculates new position of target
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

//Function is called everytime a target is hit
void handleHit() {
  //Keeps track of amount of trials and changes state when done
  if(trialNum >= -1 + trialPerComb * dia.length * dist.length) {
    print("Done");
    myTarget = null;
  }
  
  else {
  trialNum += 1;
  currentMillis = millis();
  movementTime = calculateMovementTime(previousMillis, currentMillis);
  previousMillis = currentMillis;
  
  //Save parameters for next target in "distance" and "diameter" variables
  getParameters();
  
  //Calculate target position within borders of screen
  PVector newPos = calculateNewPosition(distance);
  while(newPos.x > width - (myTarget.diameter/2) - screenBorder
  || newPos.x < 0 + (myTarget.diameter/2) + screenBorder
  || newPos.y > height - (myTarget.diameter/2) - screenBorder
  || newPos.y < 0 + (myTarget.diameter/2) + screenBorder) {
    newPos = calculateNewPosition(200);
  }
  myTarget = new Target(newPos, diameter);

  myData.saveData(diameter, distance, movementTime, subjectId);
  }
}

void mouseClicked() {
  if(myTarget !=null){
  if(myTarget.isMouseInside()) {
    handleHit();
  }}
}

//Creates combinations of parameters
void createCombinations() {
  for(int i = 0; i < dia.length;i++) {
    for(int j = 0; j < dist.length;j++) {
      diameters.add(dia[i]);
      distances.add(dist[j]);
    }
  }
  println(diameters);
  println(distances);
}

//When Start is pressed
void Start() {
    myStartscreen.hidePage();
    subjectId = myStartscreen.subjectID.getText();
    myTarget = new Target(new PVector(width/2, height/2),50);
  }
