//*************************************************************************
//    Scrappy Bird Game
//    
//      Authors:
//        Pablo Cazorla Martínez
//        Javier Peces Chillarón
//
//   NOTE: Processing 3+ Version (It may not work in another version)
//
//*************************************************************************

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
                 if(columns.get(columns.size()-1).getX() <= width*spaceBtwColumns){
                    columns.add(new Column(speed, narrow, setColWidth)); 
                    cleanArray();
                 }
               }
              delay(10);
              break;
            
            case "CollisionSys":
              
              // ****************************************** Ground collision ************************************************** \\
              if(((player.getY()+player.getSize()/2) > ground_l))
              {
                state = 2; // GAME OVER
              }       
      
              // ****************************************** Pipes collision *************************************************** \\
         
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
           
       // Points System in progress
            //case "PointSys":
              
            //  break;
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