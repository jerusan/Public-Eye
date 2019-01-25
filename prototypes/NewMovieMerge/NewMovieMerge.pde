import gab.opencv.*;
import processing.video.*;
//import java.io.FilenameFilter;
import java.util.*;
import java.util.Arrays;
import java.io.*;
import java.awt.*;
import com.hamoid.*;

ArrayList<String> frameListNames = new ArrayList<String>();
File f = new File("/home/publiceye/Documents/NewMovieMerge/data/frames");
ArrayList<File> files = new ArrayList<File>(Arrays.asList(f.listFiles()));
File folder = new File("/home/publiceye/Documents/NewMovieMerge/data/frames");

ArrayList <String> newMovieNames = new ArrayList<String>(); 

// Alterable program variables
// Archived video files should be placed in the data/archive/ directory

// Alternate mask images should be placed in the data/masks/ directory
String maskFilename = "ovalmaskbig.png";

// Controls the number of pixels the rendering scrolls per frame
float pxPerFrame = 1;

// Must be updated with location of eyeDemo program
String eyeDemoPath = "/home/publiceye/Documents/NewMovieMerge";

// Movie extension filter
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
int laps = 3;

// New video attribute lists
ArrayList<String> running;
ArrayList<String> ran;
ArrayList<Integer> loops;
ArrayList<Integer> indexInMov;
int frameCounter = 0;
FilenameFilter fileNameFilter;


void setup() {
  
  ArduinoSetup();
  cameraSetup();
   InitializeData();
  //setup OpenCV
  //VideoSetup();
  //populate list  
  GetFileName();
  // Initialize canvas size
  size(640, 480);
  // Initialize video attribute lists
 
  // Load mask into PImage
  mask = loadImage("masks/" + maskFilename);
  mask.resize(w+2,h);
  
 
  OpenArchiveVideos();
}

int i = 0;
void draw() {
  
  try
  {
    newMovieSearch();
   
    DrawMovie();
  }
  catch(Exception e)
  {
    println("Actually happened in draw");
  }
  
}


void DisplayFrames()
{
  PImage img;
  try{
    if( i < frameListNames.size()-1 )
      {
        delay(31);
        img = loadImage("frames/" + frameListNames.get(i));
        image(img,0,0);
         
        i++;
      }
      else{
      i=0;
      }
    }
  catch(Exception e){
   println("HEY THIS HAPPENED");
  }
  
}