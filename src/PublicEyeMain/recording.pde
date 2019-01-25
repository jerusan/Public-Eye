import processing.video.*;
import com.hamoid.*;
import gab.opencv.*;
import java.awt.*;

//capture the camera frames
Capture cam;

//For the OpenCV
OpenCV opencv;

//For recording from camera
VideoExport videoExport;

//To store the detected eye location to check for few more conditions
Rectangle[] eye;
int size = 0;
int FPS = 30;
int start_time = 0;
int counter = 1;
boolean detected = true;
boolean recording = false;

void setup() {
  size(600, 600);
  frameRate(FPS);

  cam = new Capture(this, 640, 480, FPS);
 
  videoExport = new VideoExport(this, nf(counter,5)+ ".mov", cam);
  
  opencv = new OpenCV(this, width/2, height/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  
   cam.start();
}

void draw() {
  opencv.loadImage(cam);
  
  image(cam, 0,0);
  
  eye = opencv.detect();
 /* if (!eye[0].isEmpty()){//eye.length != size){
    println("Face detected"+ eye[0].width + " " + eye[0].height);
    detected = true;
    size = eye.length;
  }*/
  
  if (detected && !recording)
      record();
  if (recording){
    videoExport.saveFrame();
    if (millis() - start_time >= 15000){
    videoExport.endMovie();
    println("ended the video # "+ counter);
    counter += 1;
    recording = false;
    detected = false;
    }    
 }
}

void record(){
  recording = true;
  start_time = millis();
  videoExport.startMovie();
  println("Recording started");
}

void captureEvent(Capture c) {
  c.read();
}
