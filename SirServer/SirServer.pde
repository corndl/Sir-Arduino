import processing.net.*;
Server myServer;
String msg = null;
Client c;

void setup() {
  size(200, 200);
  // Starts a myServer on port 5204
  myServer = new Server(this, 5204); 
}

void listClient() {
  
}

void draw() {
  // Get the next available client
  c = myServer.available();
  
  // If the client is not null, and says something, display what it said
  if (c !=null) {
    String msg = c.readString();
    
    if (msg == "defi") {
      c.write("choix de la cible ?");
      println("choix cible");
    } 
    
    else if (msg != null) {
    //  println("Client (" + thisClient.ip() + ") said : " + whatClientSaid + ".");
    //  println(whatClientSaid + " " + (whatClientSaid.equals("oki")));
      c.write(msg);

    }
  } 
}
