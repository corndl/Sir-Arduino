import processing.net.*;
Server myServer;
String msg, msgClient;
Client c;
ArrayList<Client> clients;
boolean isIn, waitingDefi;
int i;

void setup() {
  size(200, 200);
  // Starts a myServer on port 5204
  myServer = new Server(this, 5204); 
  clients = new ArrayList<Client>();
  waitingDefi = false;
}

void listClients() {
  msgClient = "Liste des cibles potentiellles : ";
  for (int i = 0; i < clients.size(); i++) 
    if (clients.get(i) != c)
      msgClient = msgClient + i + " : " + clients.get(i) + " ";
}

void defi() {
  //waiting for digit input
  if (clients.size() > 1) {
    waitingDefi = true; 
    msgClient = "Entrez le numéro de l'adversaire à défier.";
  }
  else {
    println("no one");
    msgClient = "Il n'y a personne à défier";
  } 
}

void draw() {
  // Get the next available client
  c = myServer.available();

  isIn = false;
  for (int i = 0; i < clients.size(); i++) {
    if (clients.get(i) == c)
      isIn = true;     
  }
  if (!isIn && c != null) {
    clients.add(c);
  }
  
  if (c !=null) {
    String msg = c.readString();
   
    //si on attend un defi on ne prend aucun autre input    
    if (waitingDefi == true) {
      try {
        i = Integer.parseInt(msg);
      }
      catch (NumberFormatException e) {
        return;
      }
      if (i < 10 && (i >= 0) && i <= clients.size() - 1 && clients.get(i) != c) {
        clients.get(i).write("Vous avez reçu un défi de " + c + " !");
        c.write("Défi envoyé au client " + msg);
        waitingDefi = false;
      }
      return;
    }
    
    if (msg.equals("choose"))
      listClients();
    else if (msg.equals("defi"))
      defi(); 

    if (msgClient != null) {
      c.write(msgClient);
      msgClient = null;
    }
    
  }   
}
