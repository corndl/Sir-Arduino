class Defi  {
  
  public Client exp;
  public Client dest;
  public boolean accepted; 
  public Sequence sequence;
  
  Defi (Client c1, Client c2) {
    exp = c1;
    dest = c2;  
    accepted = false;
  } 
   
}
