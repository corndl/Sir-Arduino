import processing.serial.*;
import cc.arduino.*;

Arduino arduino;

void setup(){
    arduino = new Arduino(this, Arduino.list()[3], 57600);
}
