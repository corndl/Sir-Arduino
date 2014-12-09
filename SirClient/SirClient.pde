import processing.net.*; 
import processing.serial.*;
import cc.arduino.*;

Client myClient; 
String msgServer;
String msg;
InOutArduino ioa;
Sequence seq;
boolean recording = false;
 
void setup() { 
  size(200, 200); 
  // Connect to the local machine at port 5204.
  // This example will not run if you haven't
  // previously started a server on this port.
  myClient = new Client(this, "127.0.0.1", 5204); 
  myClient.write("connect");
  ioa = new InOutArduino(new Arduino(this, Arduino.list()[2], 57600),
                                0,13); 
} 
 
void chooseTarget() {
  myClient.write("defi");
} 
 
void keyPressed() {
  if (key == 'c')
    msg = "choose";
  if (key == 'd')
    msg = "defi";  
  if (key == 'a')
    msg = "accept";  
  if (key == 'r') {
    myClient.write("recording");
    IntList intl = new IntList();
    seq = new Sequence(intl);
    delay(1000);
    seq.record(ioa, 5000);
    recording = true;
  }   
  if (key >= '0' && key <= '9')
    msg = "" + key;  
  if (key == 'x') {
    msg = "disconnect";
    exit();
  }  
} 
 
void draw() { 
  if (recording) {
    try {
      myClient.write(seq.seq.get(0)+"");
      delay(500);
      seq.seq.remove(0);
      if (seq.seq.size() < 1) {
        myClient.write("endrecording");
        recording = false;
      }
    }
    catch (ArrayIndexOutOfBoundsException e) {
      myClient.write("endrecording");
      recording = false;  
    }
  }
  
  if (myClient.available() > 0) { 
    msgServer = myClient.readString(); 
  } 
  if (msg != null)
    myClient.write(msg);
   msg = null; 
   if (msgServer != null)
     println(msgServer);
   msgServer = null;
} 


