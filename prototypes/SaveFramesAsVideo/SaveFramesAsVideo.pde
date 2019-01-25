// Run this program only in the Java mode inside the IDE,
// not on Processing.js (web mode)!!

// To convert images to a movie you can use:
// ffmpeg -i seq-%04d.tga -r 25 -threads 4 video.mp4

//import statement for VideoExportLibrary

int c = 255;

void setup() {
  size(640, 480);
  background(0);
  frameRate(25);
  noStroke();
  rectMode(CENTER);
  cameraSetup();
  
    
}
void draw() {
  
  if(frameCount < 475){
         cameraRead();
  }
  
  
}


//String ffmpegPath = "C:/Users/Spencer/Documents/Processing/code/SaveFramesAsVideo/ffmpeg-20161127-801b5c1-win64-static/ffmpeg-20161127-801b5c1-win64-static/bin";