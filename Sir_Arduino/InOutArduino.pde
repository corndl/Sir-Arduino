class InOutArduino{
  private boolean isActive;
  private Arduino arduino;
  private int outCode;
  private int inCode;
  private ThreadSwitch thread;
  
  public InOutArduino(Arduino arduino,int inCode,int outCode){
    this.arduino = arduino;
    this.inCode = inCode;
    this.outCode = outCode;
    this.isActive = false;
  }
  
  public void turnOn(boolean isOn){
    arduino.digitalWrite(outCode,isOn?arduino.HIGH : arduino.LOW);
    isActive = isOn;
  }
  
  public void switchOn(){
    turnOn(!isActive);
  }
  
  public void switchOn(int duree){
    ThreadSwitch thread = new ThreadSwitch();
    thread.start(duree);
  }  
  
  public float read(){
    float input = arduino.analogRead(inCode);
    float in255 = convert255(600f,300f,input);
    return in255;
  }
  
  public float readAngle(){
    float in255 = read();
    float inAngle = (in255 / 255f)*180;
    return inAngle;
  }
  
  public class ThreadSwitch extends Thread {
    private int msDelay;
    public boolean isRunning;
    public void start (int msDelay) {
      this.msDelay = msDelay;
      isRunning = true;
      super.start();
    }
 
    public void run () {
      switchOn();
      delay(msDelay);
      switchOn();
      msDelay = 0;
      isRunning = false;
      println("mort du thread");
    }
    
    public void quit(){
      interrupt();
      isRunning = false;
    }
    
}
  
  private float convert255(float minval,float maxval, float input){
    float range = maxval - minval;
    float output = (input - minval) * 255 / range;
    if(output > 255) output = 255;
    if(output < 0) output = 0;
    return(abs(output));
  }
}
