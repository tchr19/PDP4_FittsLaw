import controlP5.*;
import processing.video.*;
import processing.serial.*;

//Import classes
Timer myTimer;
States state;
ControlP5 cp5;
Capture video;
Data myData;
Target myTarget;
Target targetFill;
//Import screen classes
StartScreen myStartscreen;
IntroScreen myIntroScreen;

//Serial variables
Serial myPort;
int byteIn;
int xPos, yPos;
String[] Ports = Serial.list();
int[] bytesArray = new int[5];
int[] allFingersUp = {1,1,1,1,1};
int[] oneFingerUp = {0,1,0,0,0};
int serialCounter = 0;



//Variables
PVector famTargetPosition;
int selectDelay = 500;
color targetColor = color(255,0,0);
color fillTargetColor = color(255,255,255,200);
PVector targetPosition;
String subjectId;
PImage hand_img;
int screenBorder = 25;
int trialNum = 0;
int trialPerComb = 4;
boolean allFingUp = false;
boolean oneFingUp = false;

//Time variables
float previousMillis = 0;
float currentMillis;
float movementTime;

//Parameter variablers
float distance;
float diameter = 50;

//Sets of distances and diameters
int[] dia = { 20,40,80,160 };
int[] dist = { 160,360,560,760};

//Make a list of combinations for each diameter with all distances
ArrayList<Integer> distances = new ArrayList<Integer>();
ArrayList<Integer> diameters = new ArrayList<Integer>();

void setup() {
  String portName = Ports[4];
  myPort = new Serial(this,portName,9600);
  //Combinations of parameters created in lists
  createCombinations();
  famTargetPosition = new PVector(width/2, height/2);
  //Set start state
  state = States.STARTSCREEN;
  
  //Video settings for intro-screen
  hand_img = loadImage("hand.png");
  
  //size(500,500);
  
  fullScreen();
  background(25);
  noStroke();
  targetPosition = new PVector(width/2, height/2);
  print(width);
  print(height);
  cp5 = new ControlP5(this);
  //Target created
  myData = new Data();
  myTimer = new Timer();
  myStartscreen = new StartScreen();
  myIntroScreen = new IntroScreen();
  myStartscreen.showPage();
  myTimer.startTimer();
}

void draw() {
  background(25);
  if(myTarget != null) {
    myTarget.display();
    if(myTarget.isMouseInside()) {
      myTimer.startTimer();
      targetFill = new Target(targetPosition, diameter * (float)(millis() - myTimer.time) / selectDelay,fillTargetColor);
      targetFill.display();
    }
    else {
      myTimer.resetTimer();
    }
    if(myTimer.waitTime(selectDelay)) {
      handleHit();
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
    showVideo();
    if(waitedTime(2000)) {
      raiseFinger();
    }
    break;
  case INTRO_selectTarget:
      showVideo();
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
PVector calculateTargetPosition(float distance) {
  float angle = random(360);
  float x = mouseX + distance * cos(angle);
  float y = mouseY + distance * sin(angle);
  targetPosition = new PVector(x,y);
  return targetPosition;
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
void handleHit() { //<>//
  myTimer.resetTimer();
  //Keeps track of amount of trials and changes state when done
  if(trialNum >= -1 + trialPerComb * dia.length * dist.length) {
    print("Done");
    myTarget = null;
  }
  
  else {
  
  currentMillis = millis();
  movementTime = calculateMovementTime(previousMillis, currentMillis);
  previousMillis = currentMillis;
  println("dist: " + distance);
  println("dia: " + diameter);
  println(Math.log((distance/diameter)+1) / Math.log(2));
  println("movement time: " + movementTime);
  myData.saveData(trialNum,diameter, distance, movementTime, subjectId);
  trialNum += 1;
  
  //Save parameters for next target in "distance" and "diameter" variables
  getParameters();
  
  //Calculate target position within borders of screen
  PVector targetPosition = calculateTargetPosition(distance);
  
  while(targetPosition.x > width - (myTarget.diameter/2) - screenBorder
  || targetPosition.x < 0 + (myTarget.diameter/2) + screenBorder
  || targetPosition.y > height - (myTarget.diameter/2) - screenBorder
  || targetPosition.y < 0 + (myTarget.diameter/2) + screenBorder) {
     targetPosition = calculateTargetPosition(distance);
  }
  myTarget = new Target(targetPosition, diameter, targetColor);

  }
}


void captureEvent(Capture video) {
  video.read();
}

void serialEvent(Serial myPort) {
  byteIn = myPort.read();
  bytesArray[serialCounter] = byteIn;
  
  serialCounter++;
  
  if(serialCounter >= 5) {
    allFingUp = checkFingers(bytesArray,allFingersUp);
    oneFingUp = checkFingers(bytesArray, oneFingerUp);
    serialCounter = 0;
  }
}

//Creates combinations of parameters
void createCombinations() {
  for(int i = 0; i < dia.length;i++) {
    for(int j = 0; j < dist.length;j++) {
      for(int k = 0; k < trialPerComb; k++) {
        diameters.add(dia[i]);
        distances.add(dist[j]);
      }
    }
  }
}

//Shows video feed on screen
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
    myTarget = new Target(targetPosition,diameter, targetColor);
  }
//When Intro is pressed
void Intro() {
  video = new Capture(this, 640, 480);
  video.start();
  myStartscreen.hidePage();
  myIntroScreen.showPage();
  state = States.INTRO_raiseHand;
}

//Checks if all fingers are up
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

//Function that checks if hand is raised and displays info accordingly
void raiseHand() {
  if(allFingUp) {
      myTimer.startTimer();
    } else {
      myTimer.resetTimer();
    }
  if(myTimer.waitTime(1000)) {
    myIntroScreen.raiseHand.setText("CORRECT").setColor(color(0,255,0));
    state = States.INTRO_raiseFinger;
    } 
  }
  
void select_intro() {
  if(myTarget != null) {
    myTarget.display();
    if(myTarget.isMouseInside()) {
      myTimer.startTimer();
      targetFill = new Target(famTargetPosition, diameter * (float)(millis() - myTimer.time) / selectDelay,fillTargetColor);
      targetFill.display();
    }
    else {
      myTimer.resetTimer();
    }
    if(myTimer.waitTime(selectDelay)) {
      handleHit();
    }
  }
  
  }

//Function that checks if f is raised and displays info accordingly
void raiseFinger() {
  hand_img = loadImage("point.png");
  myIntroScreen.raiseHand.setText("Now hold only your index finger up").setColor(color(255));
  if(oneFingUp) {
      myTimer.startTimer();
    } else {
      myTimer.resetTimer();
    }
  if(myTimer.waitTime(500)) {
    myIntroScreen.raiseHand.setText("CORRECT").setColor(color(0,255,0));
    myTarget = new Target(famTargetPosition, 100, targetColor);
    state = States.INTRO_selectTarget;
    } 
  }

//Function for waiting certain time
boolean waitedTime(int delay) {
  myTimer.startTimer();
  if(myTimer.waitTime(delay)) {
    return true;
  }
  else {
    return false;
  }
  
}

void stop() {
  myPort.clear();
  //myPort.stop();
}
