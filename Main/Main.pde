import controlP5.*;
import processing.video.*;
import processing.serial.*;

//Import classes
States state;
ControlP5 cp5;
Capture video;
Data myData;
Target myTarget;
StartScreen myStartscreen;
IntroScreen myIntroScreen;

//Serial variables
Serial myPort;
int byteIn;
int xPos, yPos;
String[] Ports = Serial.list();
int[] bytesArray = new int[5];
int[] allFingersUp = {1,1,1,1,1};
int serialCounter = 0;

boolean fingersUp;
int time;
boolean timerStarted = false;
//Variables
String subjectId;
PImage hand_img;
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
  String portName = Ports[3];
  myPort = new Serial(this,portName,9600);
  //Combinations of parameters created in lists
  createCombinations();
  
  //Set start state
  state = States.STARTSCREEN;
  
  //Video settings for intro-screen
  video = new Capture(this, 640, 480);
  video.start();
  hand_img = loadImage("hand.png");
  
  size(500,500);
  //fullScreen();
  background(25);
  cp5 = new ControlP5(this);
  //Target created
  myData = new Data();
  myStartscreen = new StartScreen();
  myIntroScreen = new IntroScreen();
  myStartscreen.showPage();
}

void draw() {
  background(25);
  if(myTarget != null) {
    myTarget.display();
    if(myTarget.isMouseInside()) {
      //Make other if statement to check if inside-timer-function is true
      //Add handle hit function call, 
    }
  }
  
  switch(state) {
  case STARTSCREEN:
    break;
  case NEW_TEST:
    myTarget.display();
    break;
  case INTRO_raiseHand:
    showVideo();
    raiseHand();
    break;
  case INTRO_raiseFinger:
    
    break;
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

//void mouseClicked() {
//  if(myTarget !=null){
//  if(myTarget.isMouseInside()) {
//    handleHit();
//  }}
//}

void captureEvent(Capture video) {
  video.read();
}

void serialEvent(Serial myPort) {
  //byteIn gemmer det byte der bliver læst i serial port
  byteIn = myPort.read();
  //Dette byte gemmes på den "serialCounter" plads i bytesArray
  bytesArray[serialCounter] = byteIn;
  
  //serialCounter forøges med 1
  serialCounter++;
  
  //Hvis serialCounter bliver større eller lig med 2
  if(serialCounter >= 5) {
    if(checkFingers(bytesArray, allFingersUp)) {
      fingersUp = true;
    }
    else {
      fingersUp = false;
    }
    // Bliver xPos og yPos sat til de læste værdier
    // Og serial går i nul
    serialCounter = 0;
  }
}

//Creates combinations of parameters
void createCombinations() {
  for(int i = 0; i < dia.length;i++) {
    for(int j = 0; j < dist.length;j++) {
      diameters.add(dia[i]);
      distances.add(dist[j]);
    }
  }
}

void showVideo() {
  pushMatrix();
  scale(-.5, .5);
  translate(-200,300);
  tint(255);
  image(video, -video.width, 0);
  popMatrix();
  tint(255, 127);
  image(hand_img, 250,200,150,150);
}

//When Start is pressed
void Start() {
    myStartscreen.hidePage();
    subjectId = myStartscreen.subjectID.getText();
    myTarget = new Target(new PVector(width/2, height/2),50);
  }
  
void Intro() {
  myStartscreen.hidePage();
  myIntroScreen.showPage();
  state = States.INTRO_raiseHand;
}

boolean checkFingers(int[] data, int[] reference) {
  int correct = 0;
  for(int i = 0; i < data.length;i++) {
    if(data[i] == reference[i]) {
      correct += 1;
    }
  }
  if(correct == 5) {
    return true;
  }
  else {
  return false;
  }
}

void raiseHand() {
  if(fingersUp) {
      if(!timerStarted) {
        time = millis();
        timerStarted = true;
      }
    } else {
      time = millis();
    }
    if(millis() > time + 1000) {
      myIntroScreen.raiseHand.setText("CORRECT").setColor(color(0,255,0));
      hand_img = loadImage("point.png");
    } 
  }

void stop() {
  myPort.clear();
  //myPort.stop();
}
