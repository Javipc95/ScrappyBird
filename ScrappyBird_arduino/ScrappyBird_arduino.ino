//************************************************************
//    Scrappy Bird Game
//    
//      Autores:
//        Pablo Cazorla Martínez
//        Javier Peces Chillarón
//
//************************************************************

const int tapPin = A0;
int tapValue = 0;

boolean sample;

void setup() {
  Serial.begin(57600);
}

void loop() {
  tapValue = analogRead(tapPin);

  //Serial.println(tapValue);

  if(tapValue > 50 && !sample) {
    sample = true;
    Serial.println("tap"); 
  
  }else {
    if(tapValue < 50) sample = false;
  }
}
