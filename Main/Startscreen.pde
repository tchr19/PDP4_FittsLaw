class StartScreen {
  
  Textlabel title;
  Button start;
  Button intro;
  Textfield subjectID;
  
  void showPage() {
    
  title = cp5.addTextlabel("title").setText("Fitts' Law - Touchless interaction\n").setPosition(width/2-75,25);
  
  subjectID =  cp5.addTextfield("Subject ID")
     .setPosition(width/2-100,150)
     .setSize(200,25);  
   
  start = cp5.addButton("Start")
     .setPosition(width/2-50,250)
     .setSize(100, 40);
  
  intro = cp5.addButton("Intro")
     .setPosition(width/2-50,300)
     .setSize(100, 40);
 
    
  //Make subject id field that takes input and saves to su250ctId variable
  
  //Add all elements to an array
  
  }
  
  void hidePage() {
    title.hide();
    start.hide();
    subjectID.hide();
    intro.hide();
    // Instead of calling hide on each element, 
    //make a for loop that calls hide on all elements in array
  }
  
}
