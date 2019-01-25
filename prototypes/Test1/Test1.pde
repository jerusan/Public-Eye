import processing.video.*;
import java.io.FilenameFilter;
import java.util.Arrays;


//ArrayList <String> archiveMovieNames = new ArrayList<String>(); 
ArrayList<String> archiveMovieNames = new ArrayList<String>()
{{
  add("Sam.mov"); 
  add("Erik.mov"); 
  add("Wyatt.mov"); 
  add("Tarun.mov"); 
  add("Bjorn.mov");
}};
ArrayList <String> newMovieNames = new ArrayList<String>(); 
String maskFilename = "ovalmaskbig.png";
float pxPerFrame = 1.0;
String eyeDemoPath = "/home/publiceye/Documents/Test/data";
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
int count = 0;
int newVidCount=0;
int laps = 2;

// New video attribute lists
ArrayList<String> running;
ArrayList<String> ran;
ArrayList<Integer> loops;
ArrayList<Integer> indexInMov;
int frameCounter = 0;
FilenameFilter fileNameFilter;

void setup() {
  //GetFileName();
  numb = archiveMovieNames.size();
  
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
    Movie newMov = new Movie(this, "archive/" + archiveMovieNames.get(randomNum));
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
  newMovieSearch();
  renderMovie();
  //println(newMovieNames.get(0));
} //<>//