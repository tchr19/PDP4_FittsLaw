class Startscreen {
  
  Button start;
  Button stop;
  Button[] test;
  
  void showPage() {
   
  start = cp5.addButton("Start").setPosition((width/2)-30,20).setSize(60,20);
  //Make subject id field that takes input and saves to subjectId variable
  
  //Add all elements to a array
  
  }
  
  void hidePage() {
    start.hide();
    // Instead of calling hide on each element, 
    //make a for loop that calls hide on all elements in array
  }
  
}
