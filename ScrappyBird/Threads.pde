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
           if(columns.size() > 0){
             if(columns.get(columns.size()-1).getX() <= width - spaceBtwColumns){
                columns.add(new Column(speed, narrow, setColWidth)); 
                cleanArray();
             }
           }
           delay(10);
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