import processing.serial.*;
import cc.arduino.*;

InOutArduino ioa;



void setup(){
    ioa = new InOutArduino(new Arduino(this, Arduino.list()[1], 57600),
                                0,13);  
}


void draw(){
  loop();
  int plop[] = {10000};
  IntList seq = new IntList();
  seq.append(10000);
  seq.append(9000);
  seq.append(8000);
  seq.append(7000);
  seq.append(6000);
  seq.append(5000);
  seq.append(4000);
  seq.append(3000);
  
  //println(seq);
  Sequence test = new Sequence(seq);
  IntList seq2 = new IntList(seq);
  
  seq2.insert(0,plop);
  Sequence test2 = new Sequence(seq2);
  
  
  
  println(test.distance(test2));
  
  
  
  //ioa.switchOn();
  //delay(1000);
  /*
  fd.turnOn(false);
  println("Attendons 20secondes");
  delay(20000);
  
  println("allumé");
  fd.turnOn(true);
  println("attendons 10secondes");
  delay(10000);
  
  println("switch éteint");
  fd.switchOn();
  println("attendre 5 secondes");
  delay(5000);
  
  println("Allumons pendant 20 secondes");
  fd.switchOn(20000);
  for(int i=20; i>0; i--) {
    println(i + " secondes");
    delay(1000);
  }
  
  println("Etteint final pendant 13 secondes");
  delay(13000);
  //*
  /*
  if(sensor255>0)
    arduino.tone(50*sensor255);
  else
    arduino.noTone();
  //*/
}
