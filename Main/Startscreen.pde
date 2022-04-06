class Startscreen {
  
  Button start;
  Button stop;
  Button[] test;
  Textfield subjectID;
  String[] controllers;
  
  void showPage() {
  subjectID =  cp5.addTextfield("Subject ID")
     .setPosition(width/2-80,50)
     .setSize(200,25)
     .setColorBackground(color(255))
     .setFont(createFont("arial", 20))
     .setFocus(true)
     .setColor(color(0))
     ;  
   
  start = cp5.addButton("Start")
     .setPosition((width/2)-30,200)
     .setSize(100, 40)
     .setFont(createFont("arial", 15))
     .setColorBackground(color(255))
     .setColorForeground(color(180))
     .setColorActive(color(#b4a7d6))
     .setColorLabel(color(0));
    
  //Make subject id field that takes input and saves to subjectId variable
  
  //Add all elements to an array
  
  }
  
  void hidePage() {
    start.hide();
    subjectID.hide();
    // Instead of calling hide on each element, 
    //make a for loop that calls hide on all elements in array
  }
  
}
