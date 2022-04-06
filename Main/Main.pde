import controlP5.*;

ControlP5 cp5;

Data myData;
Target myTarget;
Startscreen myStartscreen;
String subjectId;
int screenBorder = 25;
int trialNum = 0;
int trialPerComb = 1;

float previousMillis = 0;
float currentMillis;
float movementTime;

float distance;
float diameter;

int[] dia = { 10,20,40,80 };
int[] dist = { 40,80,160,320 };

//Make a list of combinations for each diameter with all distances
ArrayList<Integer> distances = new ArrayList<Integer>();
ArrayList<Integer> diameters = new ArrayList<Integer>();

//float pix = 37.7952755906;

void setup() {
  createCombinations();
  size(500,500);
  background(25);
  cp5 = new ControlP5(this);
  //start = cp5.addButton("Start").setPosition((width/2)-30,20).setSize(60,20);
  //cp5.addTextfield("SUBJECT").setPosition(20,20).setSize(200,20);
  //Target is created
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
  if(trialNum >= -1 + trialPerComb * dia.length * dist.length) {
    print("Done");
    myTarget = null;
  }
  else {
  trialNum += 1;
  currentMillis = millis();
  movementTime = calculateMovementTime(previousMillis, currentMillis);
  previousMillis = currentMillis;
  
  getParameters();

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
  if(myTarget.isMouseInside()) {
    handleHit();
  }
}

void createCombinations() {
  for(int i = 0; i < dia.length;i++) {
    for(int j = 0; j < dist.length;j++) {
      diameters.add(dia[i]);
      distances.add(dist[j]);
    }
  }
}

void Start() {
    myStartscreen.hidePage();
    myTarget = new Target(new PVector(width/2, height/2),50);
  }
