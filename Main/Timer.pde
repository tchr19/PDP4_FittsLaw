class Timer {
  int time;
  boolean timerStarted = false;
  boolean timerStopped = false;
  
  void startTimer() {
    if(!timerStarted) {
      time = millis();
      timerStarted = true;
    }
  }
  
  void stopTimer() {
    timerStopped = true;
  }
  
  void resetTimer() {
    time = millis();
    timerStarted = false;
  }
  
  boolean waitTime(int delay) {
    return(millis() > time + delay);
  }
  
}
