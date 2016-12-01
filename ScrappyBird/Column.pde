/* Clase para crear los obstáculo a evitar por flappy bird
  Autores:

  Fecha:
  
  Asignatura:

*/

class Column
{
  float UpperHeight, colWidth, x, vx, ax; //vx: Marca la velocidad a la que avanzan las columnas por el lienzo.
  float LowerHeight, DownHeight;
  float narrow; //[0, 1] Marca la distancia vertical entre los tubos del juego.
  boolean drawn = false;
  float setColWidth;
  
  Column(float _vx, float _narrow, float _setColWidth) //Los parametros vx y narrow estan asociado a la
  {                                                                          //dificultad del juego.
    setColWidth = _setColWidth;
    UpperHeight = random(200, height*0.6);
    colWidth =  width*setColWidth;
    x = width;
    vx = _vx; // Puede servir para modificar la dificultad del juego.
    narrow = _narrow;
    LowerHeight = -(height - UpperHeight)+height*narrow;
  }
  
  void drawColumn()
  {
     
     pushStyle();
     pushMatrix();
     //rect(x, 0, colWidth, UpperHeight,0,0, 2*PI, 2*PI);
     //rect(x, height, colWidth, LowerHeight, 2*PI, 2*PI, 0, 0);     
     //image(imColumnDown, x, 0, colWidth, UpperHeight);
     //image(imColumnUp, x, height, colWidth, LowerHeight);
     fill(0, 200, 0);
     rect(x-4, UpperHeight+(height*narrow)-20, colWidth+8, 20, 2*PI); //Parte superior columna inferior
     rect(x-4, UpperHeight, colWidth+8, 20, 2*PI); //Parte superior columna superior
     rect(x, 0, colWidth, UpperHeight,0,0, 2*PI, 2*PI);
     rect(x, height, colWidth, LowerHeight, 2*PI, 2*PI, 0, 0);
     
     
     drawn = true;
     popStyle();
     popMatrix();
  }
  
  void update()
  {
     x -= vx; 
  }
  void stop()
  {
    vx = 0;
  }
  
  float getX()
  {
    return x;
  }
  
  float getHeightUpper()
  {
     return UpperHeight+20; 
  }
  
  float getHeightLower()
  {
    return (height - LowerHeight)-20;
  }
  
  float colWidth()
  {
    return colWidth;
  }
  
  boolean isDrawn()
  {
      return drawn;
  }
  
}