class InOutArduino{
  private boolean isActive;
  private Arduino arduino;
  private int outCode;
  private int inCode;
  private ThreadSwitch thread;
  
  //constructeur arduino (la carte connecté) intCode (le numéro de l'entrée) out code (le numéro de la sortie)
  public InOutArduino(Arduino arduino,int inCode,int outCode){
    this.arduino = arduino;
    this.inCode = inCode;
    this.outCode = outCode;
    this.isActive = false;
  }
  //si isOn alors allume sinon on etteint
  public void turnOn(boolean isOn){
    arduino.digitalWrite(outCode,isOn?arduino.HIGH : arduino.LOW);
    isActive = isOn;
  }
  
  //on allume si c'est etteint et inversement
  public void switchOn(){
    turnOn(!isActive);
  }
  
  //on switch pendant la duree (non bloquant)
  public void switchOn(int duree){
    if(thread != null && thread.isRunning) thread.quit();
    
    thread = new ThreadSwitch();
    thread.start(duree);
  }  
  
  public float read(){
    return arduino.analogRead(inCode);
  }
  
  //retourn la valeur d'input entre 0 et 255
  public float read255(){
    float input = read();
    float in255 = convert255(600f,300f,input);
    return in255;
  }
  
  //retourn la valeur d'input entre 0 et 180
  public float readAngle(){
    float in255 = read255();
    float inAngle = (in255 / 255f)*180;
    return inAngle;
  }
  
  public boolean isOn(){
    return read()>125;
  }
  
  //thread appelé
  public class ThreadSwitch extends Thread {
    private int msDelay;
    public boolean isRunning;
    public void start (int msDelay) {
      this.msDelay = msDelay;
      isRunning = true;
      super.start();
    }
    //code exécuté du thread
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
  //converti l'input en valeur entre 0 et 255 par rapport à ses valeur extrème
  private float convert255(float minval,float maxval, float input){
    float range = maxval - minval;
    float output = (input - minval) * 255 / range;
    if(output > 255) output = 255;
    if(output < 0) output = 0;
    return(abs(output));
  }
}
