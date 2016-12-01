/* 
  Autores:

  Fecha:
  
  Asignatura:

*/
import processing.serial.*;
Bird player;
ArrayList<Column> columns;
Serial serialPort;

MyThread genColumns, cleanArray;

PImage p_img, scene, ground;
int state;

int c;
int spaceBtwColumns = 700;
int speed = 10;
float narrow = 0.25;
float setColWidth = 0.08;
int count = 0;


float ground_l;
float playerPos = 0.30*width;

void setup()
{
  fullScreen();
  
  state = -1;
  ground_l = height-65;
  
  columns = new ArrayList<Column>();
  
  println(Serial.list());  
  serialPort = new Serial(this, Serial.list()[1], 57600);
  serialPort.bufferUntil('\n');
  
  genColumns = new MyThread("GenColumns");
  cleanArray = new MyThread("CleanArray");
  
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
      
// Colision con el suelo 
      if(((player.getY()) > ground_l))
      {
        state = 2; // GAME OVER
      }
      
      // Colision con las tuberias
      for(int i = 0; i < columns.size(); ++i)
      {
        //if(( ((columns.get(i).getX() + columns.get(i).colWidth()) >= (playerPos+player.getSize()/2)) || ((playerPos+player.getSize()/2) >= columns.get(i).getX()) )  
        //    &&  ((player.getY() < columns.get(i).getHeightUpper()) || (player.getY() > columns.get(i).getHeightLower() ) ))
        //{
        //  state = 2; // GAME OVER; 
        //}
        //if(( ((columns.get(i).getX() + columns.get(i).colWidth()) >= (playerPos+player.getSize()/2)) || ((playerPos+player.getSize()/2) >= columns.get(i).getX()) )  )
        //{
        //  state = 2; // GAME OVER; 
        //}
      }
      
      break;
      
    case 2:
      textSize(40);
      text("GAME OVER",0.5*width,0.5*height);
      textAlign(CENTER);
      
      break;
  }

  player.drawIt();
    
    for(int i = 0; i < columns.size(); ++i)
      {
        if(state == 2) columns.get(i).stop();
        columns.get(i).drawColumn();
      }
}

void mousePressed()
{
  switch(state)
  {
    case 0: 
      state = 1;
      columns.add(new Column(speed, narrow, setColWidth)); 
      cleanArray.start();
      break;
    case 1: player.tap(); break;
    case 2: 
      state = 0;
      player.reset();
      columns.clear();
      player.drawIt();  
      break;
  }
  
}

void serialEvent(Serial myport) {
  String str = myport.readStringUntil('\n');
  if(float(str) >;
  //println(dato);
  
  if(tap)
    switch(state)
    {
      case 0: 
        state = 1;
        columns.add(new Column(speed, narrow, setColWidth)); 
        cleanArray.start();
        break;
      case 1: player.tap(); break;
      case 2: 
        state = 0;
        player.reset();
        columns.clear();
        player.drawIt();  
        break;
    }
}

class MyThread extends Thread
{
  private Thread t;
  private String threadName;
  
  MyThread (String name) {
    threadName = name; 
    System.out.println("Creado " + threadName);
  }
  public void run()
  {
     try{
       switch(threadName)
       {
         case "GenColumns":
            
            while(true)
            {
              delay(5);
              if(columns.size() > 0)
              {
                if(columns.get(columns.size()-1).getX() <= width - spaceBtwColumns){
                  columns.add(new Column(speed, narrow, setColWidth));              
                }
              }
            }
            
          case "CleanArray":
            while(true){
              if(columns.size() > 0){
                 for(int i = 0; i < columns.size() && columns.get(i).getX() < -100; ++i){
                    columns.remove(i);                    
                 }
              }
            }
       }
     } catch(Exception e){
        System.out.println("Running error " + threadName); 
     }
    System.out.println("Thread " + threadName + " exiting.");
  }
  public void start() {
    System.out.println("Comienza " + threadName);
    if(t == null){
       t = new Thread (this, threadName);
       t.start();
    }
  }
} //<>//