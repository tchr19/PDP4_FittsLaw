class IntroScreen {
  
  Textlabel introText;
  Textlabel raiseHand;
  Button start;
  Textfield subjectID;
  
  void showPage() {
    
  introText = cp5.addTextlabel("introText").setText("Welcome to the intro!\nLet's get you up to speed on how it works...").setPosition(width/2-75,25);
  
  raiseHand = cp5.addTextlabel("raiseHand").setText("Raise your right hand so it is visible to the camera").setPosition(width/2-75,100);
    
  //Make subject id field that takes input and saves to subjectId variable
  
  //Add all elements to an array
  
  }
  
  void hidePage() {
    introText.hide();
    // Instead of calling hide on each element, 
    //make a for loop that calls hide on all elements in array
  }
  
}
