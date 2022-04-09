class Timer {
  int time;
  boolean timerStarted = false;
  
  void startTimer() {
    if(!timerStarted) {
      time = millis();
      timerStarted = true;
    }
  }
  
  void resetTimer() {
    time = millis();
    timerStarted = false;
  }
  
  boolean waitTime(int delay) {
    return(millis() > time + delay);
  }
}
