/* 
  Autores:

  Fecha:
  
  Asignatura:

*/

import processing.serial.*;
Bird player;
ArrayList<Column> columns;
Serial serialPort;
String msg;

MyThread genColumns, collisionSys, pointSys;

PImage p_img, scene, ground;
PFont bungeeFont;
int state;

int c;
int spaceBtwColumns = 600;
int speed = 10;
float narrow = 0.25;
float setColWidth = 0.08;

float ground_l;
float playerPos = 0.30*width;

void setup()
{
  fullScreen();
  
  state = -1;
  ground_l = height-65;
  
  columns = new ArrayList<Column>();
  
  print("Puertos COM disponibles:\n" + "  ");
  println(Serial.list());
  println();
  serialPort = new Serial(this, Serial.list()[0], 57600);
  serialPort.bufferUntil('\n');
  
  genColumns = new MyThread("GenColumns");
  collisionSys = new MyThread("CollisionSys");
  pointSys = new MyThread("PointSys");
   
  bungeeFont = createFont("Bungee.ttf",100);
  
  scene = loadImage("SM_Background.png");
  scene.resize(width,height);
  
  ground = loadImage("ground.png");
  
  p_img = loadImage("flappybird.png");
  player = new Bird(p_img);
  
}

void draw()
{
  background(200,200,255);
  //background(scene); 
  
  c=0;
  for(int i=width/71; i>0; i--){
    image(ground,c,ground_l);
    c += 72;
  }
  
  switch(state)
  {
    case -1:
      genColumns.start();
      collisionSys.start();
      pointSys.start();
      state = 0;
      break;
    
    case 1: //<>//
      player.update();
      for(int i = 0; i < columns.size(); ++i)
      {
        columns.get(i).update();
        if(!columns.get(i).isDrawn())
        {
          columns.get(i).drawColumn();
        }
      } 
      break;    
  }

  player.drawIt();
    
    for(int i = 0; i < columns.size(); ++i)
      {
        columns.get(i).drawColumn();
        
        if(state == 2){
          columns.get(i).stop();
          
          textFont(bungeeFont);
          text("GAME OVER",0.5*width,0.5*height);
          textAlign(CENTER);
        }     
      }
}

void mousePressed()
{
  switch(state)
  {
    case 0: 
      state = 1;
      columns.add(new Column(speed, narrow, setColWidth)); 
      break;
    
    case 1: 
      player.tap(); 
      break;
    
    case 2: 
      state = 0;
      player.reset();
      columns.clear();
      player.drawIt();  
      break;
  }
}

void serialEvent(Serial myport) {
  msg = myport.readStringUntil('\n');
  
  if(float(msg) == 1){ 
    switch(state)
    {
      case 0: 
        state = 1;
        columns.add(new Column(speed, narrow, setColWidth)); 
        break;
        
      case 1: 
        player.tap(); 
        break;
        
      case 2: 
        state = 0;
        player.reset();
        columns.clear();
        player.drawIt();  
        break;
    }
  }
}

void cleanArray(){
  for(int i = 0; i < columns.size() && columns.get(i).getX() < -width*setColWidth; ++i){
     columns.remove(0);
  }
}