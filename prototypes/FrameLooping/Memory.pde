import java.lang.Object;
import java.util.List;
import java.lang.Runtime;

void MemoryUsage(long init, long used, long committed, long max)
{
 
} 
 private static final long MEGABYTE = 1024L * 1024L;

public  long bytesToMegabytes(long bytes) {
                return bytes / MEGABYTE;
        }



void MemoryTest()
{
  Runtime runtime = Runtime.getRuntime();
runtime.gc();
long memory = runtime.totalMemory() - runtime.freeMemory();
                System.out.println("Used memory is bytes: " + memory);
                System.out.println("Used memory is megabytes: " + bytesToMegabytes(memory));
}  