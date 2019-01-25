import java.lang.Runnable;


public synchronized void critical() {
    
  // some thread critical stuff
        // here
}

// creates a copy of a list (ArrayList) and returns only the copy of the list. This way the client of this class cannot remove elements from the list.
public class MyDataStructure {
        List<String> list = new ArrayList<String>();

        public void add(String s) {
                list.add(s);
        }

        /**
         * Makes a defensive copy of the List and return it
         * This way cannot modify the list itself
         *
         * @return List<String>
         */
        public List<String> getList() {
                return Collections.unmodifiableList(list);
        }
}

/**
 * MyRunnable will count the sum of the number from 1 to the parameter
 * countUntil and then write the result to the console.
 * <p>
 * MyRunnable is the task which will be performed
 *
 * @author Lars Vogel
 *
 */
public class MyRunnable implements Runnable {
        private final long countUntil;

        MyRunnable(long countUntil) {
                this.countUntil = countUntil;
        }

        @Override
        public void run() {
                long sum = 0;
                for (long i = 1; i < countUntil; i++) {
                        sum += i;
                }
                System.out.println(sum);
        }
}

/*
Using the Thread class directly has the following disadvantages.
•Creating a new thread causes some performance overhead.
•Too many threads can lead to reduced performance, as the CPU needs to switch between these threads.
•You cannot easily control the number of threads, therefore you may run into out of memory errors due to too many threads.
*/
void CreateThreads(){
 List<Thread> threads = new ArrayList<Thread>();
                // We will create 100 threads
                for (int i = 0; i < 100; i++) {
                        Runnable task = new MyRunnable(10000000L + i);
                        Thread worker = new Thread(task);
                        // We can set the name of the thread
                        worker.setName(String.valueOf(i));
                        // Start the thread, never call method run() direct
                        worker.start();
                        // Remember the thread for later usage
                        threads.add(worker);
                }
                int running = 0;
                do {
                        running = 0;
                        for (Thread thread : threads) {
                                if (thread.isAlive()) {
                                        running++;
                                }
                        }
                        System.out.println("We have " + running + " running threads. ");
                } while (running > 0);
  
  
}