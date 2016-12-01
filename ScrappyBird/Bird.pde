//************************************************************ //<>//
//    Scrappy Bird Game
//    
//      Autores:
//        Pablo Cazorla Martínez
//        Javier Peces Chillarón
//
//***********************************************************

class Bird
{
  PImage player_icon;
  float y,x;
  float size = 0.06*height;
  
  int state;
  
  // physics
  float ay;
  float vy;
  
  Bird (PImage _img)
  {
    player_icon = _img;
    
    y = 0.5*height;
    x = 0.30*width;
    vy = 0;
    ay = 0.5;
    state = 0;
  }
  
  float getY()
  {
    return y;
  }
  float getSize()
  {
    return size;
  }
  
  void drawIt()
  {
    pushStyle();
    pushMatrix();   // Anotamos donde está el 0,0 
    translate(x,y); //trasladamos el 0,0
    ellipse(0,0,size*0.7,size*0.7);
    image(player_icon,-size*0.6,-size/2,size*1.20,size);
    popMatrix();    //recuperamos la posicion original del 0,0
    popStyle();
  }
  
  void reset()
  {
    y = 0.5*height;
    vy = 0;
    ay = 0.5;
  }
  
  void tap()
  {
    ay = -4;
    state = 1;
    vy = 0;
  }
  
  void update()
  {
    if(state == 1)
    {
       vy += ay;
       ay += 0.8; 
       y += vy;
       if(ay > 0) state =0;
    }
    else
    {
      ay += abs(ay)*0.02; 
      vy += ay;
      y += vy;
    }
     
  }
  
}