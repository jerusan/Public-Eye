import processing.video.*;
import java.io.FilenameFilter;
import java.util.Arrays;


String[] archiveMovieNames = {"Sam.mov", "Erik.mov", "Wyatt.mov", "Tarun.mov", "Bjorn.mov"};
String[] newMovieNames = {"Connor.mov"};
String maskFilename = "ovalmaskbig.png";
float pxPerFrame = .5;
String eyeDemoPath = "/home/publiceye/Documents/ObjectOrientedDemo";
String movieExtensionFilter = ".avi";

// Global lists for handling video attributes
ArrayList<Movie> mov;
ArrayList<PImage> inputImage;
float[] curXRender;

// Image for mask
PImage mask;

// Width and height of the input videos
int w = 128;
int h = 96;

int randomNum;
int numb;
int flag = 0;

// New video attribute lists
ArrayList<String> running;
ArrayList<String> ran;
ArrayList<Integer> loops;
ArrayList<Integer> indexInMov;
int frameCounter = 0;
FilenameFilter fileNameFilter;

void setup() {
  //GetFileName();
  //numb = archiveMovieNames.size();
  numb = archiveMovieNames.length;
  
  // Initialize video attribute lists
  mov = new ArrayList<Movie>();
  inputImage = new ArrayList<PImage>();
  curXRender = new float[5];
  
  // Initialize new video attribute lists
  running = new ArrayList<String>();
  ran = new ArrayList<String>();
  loops = new ArrayList<Integer>();
  indexInMov = new ArrayList<Integer>();
  
  // Initialize canvas size
  size(600, 96);
  
  // Load mask into PImage
  mask = loadImage("masks/" + maskFilename);
  mask.resize(w+2,h);
 
  // Open archive videos from archiveMovieNames
  for(int n = 0;n < 6; n++) {
    Randomize(numb);
    //archiveMovieNames.get(randomNum)
    Movie newMov = new Movie(this, "archive/" + archiveMovieNames[randomNum]);
    PImage newInputImage = createImage(width, height, ARGB);
    inputImage.add(newInputImage);
    newMov.loop();
    mov.add(newMov);
  }
  
   for (int i=0; i < curXRender.length; i++)
  {
    curXRender[i] = w * i;
  }
  
  // Initialize filename filter, which will only look for .avi files
  fileNameFilter = new FilenameFilter() {
    @Override
    public boolean accept(File dir, String name) {
       if(name.lastIndexOf('.')>0)
       {
          //get last index for '.' char
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
  renderMovie();
  newMovieSearch();
} //<>//