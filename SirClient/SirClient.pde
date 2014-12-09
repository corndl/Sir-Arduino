import processing.net.*; 
Client myClient; 
String msgServer;
String msg;
 
void setup() { 
  size(200, 200); 
  // Connect to the local machine at port 5204.
  // This example will not run if you haven't
  // previously started a server on this port.
  myClient = new Client(this, "127.0.0.1", 5204); 
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
  if (key == 'r')
    msg = "recording";
  if (key == 's')  
    msg = "stoprecording";    
  if (key >= '0' && key <= '9')
    msg = "" + key;  
} 
 
void draw() { 
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


