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

  if(tapValue > 140 && !sample) {
    sample = true;
    Serial.println("1"); 
    
  
  }else {
    if(tapValue < 5) sample = false;
    delay(10);
  }
}
