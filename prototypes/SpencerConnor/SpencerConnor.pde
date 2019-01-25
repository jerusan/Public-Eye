import processing.video.*;
import java.io.FilenameFilter;
import java.util.Arrays;

// Alterable program variables
// Archived video files should be placed in the data/archive/ directory
String[] archiveMovieNames = {"hi.ogg", "1.ogg", "2.ogg"};
// Alternate mask images should be placed in the data/masks/ directory
String maskFilename = "ovalmaskbig.png";
// Controls the number of pixels the rendering scrolls per frame
float pxPerFrame = 0.5;
// Must be updated with location of eyeDemo program
String eyeDemoPath = "home/publiceye/Documents/SpencerConnor/";
// Movie extension filter
String movieExtensionFilter = ".avi";

// Global lists for handling video attributes
ArrayList<Movie> mov;
ArrayList<PImage> inputImage;

// Image for mask
PImage mask;

// Width and height of the input videos
int w = 128;
int h = 96;

// New video attribute lists
ArrayList<String> running;
ArrayList<String> ran;
ArrayList<Integer> loops;
ArrayList<Integer> indexInMov;

//Added by Chris
int[] curRender; 
float[] curXRender;


int frameCounter = 0;
FilenameFilter fileNameFilter;

void setup() {
  // Initialize video attribute lists
  mov = new ArrayList<Movie>();
  //Movie Index
  curRender = new int[20];
  //position index
  curXRender = new float[20];
  
  inputImage = new ArrayList<PImage>();
  
  // Initialize new video attribute lists
  running = new ArrayList<String>();
  ran = new ArrayList<String>();
  loops = new ArrayList<Integer>();
  indexInMov = new ArrayList<Integer>();
  
  // Initialize canvas size
  size(288, 96);
  
  // Load mask into PImage
  mask = loadImage("masks/" + maskFilename);
  mask.resize(w+2,h);
 
  // Open archive videos from archiveMovieNames
  for(String archiveMovieName : archiveMovieNames) {
    Movie newMov = new Movie(this, "archive/" + archiveMovieName);
    PImage newInputImage = createImage(width, height, ARGB);
    inputImage.add(newInputImage);
    newMov.loop();
    mov.add(newMov);
  }
  //Chris modifications
  for (int i=0; i < curRender.length; i++)
  {
    //get a random video
    curRender[i] = (int) random(mov.size() - 1);
    curXRender[i] = w * i;
  }
  
  // Initialize filename filter, which will only look for .avi files
  fileNameFilter = new FilenameFilter() {
    @Override
    public boolean accept(File dir, String name) {
       if(name.lastIndexOf('.')>0)
       {
          // get last index for '.' char
          int lastIndex = name.lastIndexOf('.');
          
          // get extension
          String str = name.substring(lastIndex);
          
          // match path name extension
          if(str.equals(movieExtensionFilter))
          {
             return true;
          }
       }
       return false;
    }
   };
}


void draw() {
  // For each video open, stored in the mov list
  for(int i = 0; i < curRender.length; i++) { //<>//
    // Shift the video pxPerFrame left
    curXRender[i] -= pxPerFrame;
       
    // If the video has scrolled all the way left off the screen, reset its position to
    // the right of the rightmost video in the list (at mov.size() - 1 * w)
    if(curXRender[i] < (w * -1)) {
      curXRender[i] = (float) (curRender.length - 1) * w;
      curRender[i] = (int) random(mov.size() -1);
    }
    
    // Actually obtain the video's new frame, and render it at the just-updated position
    if ((mov.get(curRender[i]) != null) && (mov.get(curRender[i]).available())) {
      mov.get(curRender[i]).read();
      inputImage.get(curRender[i]).copy(mov.get(curRender[i]), 0, 0, mov.get(curRender[i]).width, mov.get(curRender[i]).height, 0, 0, w, h);
      inputImage.get(curRender[i]).blend(mask, 0, 0, w+2, h, 0, 0, w+2, h, ADD);
    }
    image(inputImage.get(curRender[i]),curXRender[i], 0);
    image(mask,curXRender[i], 0);
  }
  
  // Every 30 frames, check for a new movie in a new thread to increase performance
  /*if(frameCount % 30 == 0) {
    thread("newMovies");
  }*/
  
} //<>//

void newMovies() {
  // Open new files if available in the data/new/ directory
  File f = new File(eyeDemoPath + "data/new");  
  File[] paths = f.listFiles(fileNameFilter);
  
  
}