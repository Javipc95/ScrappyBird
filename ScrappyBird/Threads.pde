//************************************************************
//    Scrappy Bird Game
//    
//      Autores:
//        Pablo Cazorla Martínez
//        Javier Peces Chillarón
//
//***********************************************************

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
        while(true)
        {
          switch(threadName){ 
          
            case "GenColumns":
              if(columns.size() > 0){
                 if(columns.get(columns.size()-1).getX() <= width - spaceBtwColumns){
                    columns.add(new Column(speed, narrow, setColWidth)); 
                    cleanArray();
                 }
               }
              delay(10);
              break;
            
            case "CollisionSys":
              
              // ************************************** Colision con el suelo ************************************************ \\
              if(((player.getY()+player.getSize()/2) > ground_l))
              {
                state = 2; // GAME OVER
              }       
      
              // ************************************* Colision con las tuberias ********************************************** \\
         
              for(int i = 0; i < columns.size(); ++i)
              {
                if((columns.get(i).inDangerZone())) //Zona critica*width+0.020*width)){
                {
            
                  if(((columns.get(i).getHeightLower() - player.getY()) < player.getSize()/2) || ((player.getY() - columns.get(i).getHeightUpper()) < player.getSize()/2) ){
                    state = 2; // GAME OVER
                  }
                  
                  if((player.getY() >= columns.get(i).getHeightLower()) || (player.getY() <= columns.get(i).getHeightUpper())){
                    state = 2; // GAME OVER
                  }
                }
              }
              delay(10);
              break;
           
            case "PointSys":
              
              break;
          }
        }
     } catch(Exception e){
        System.out.println("Running error " + threadName); 
     }
    System.out.println("Thread " + threadName + " termina su ejecucion.");
  }
  public void start() {
    System.out.println("Comienza " + threadName);
    if(t == null){
       t = new Thread (this, threadName);
       t.start();
    }
  }
} 