import gab.opencv.*;
import processing.video.*;	// Plays movie files and captures video data from a camera. These files can be loaded from anywhere.
import java.awt.*;
boolean record;
 
Capture video;		// The Capture class can store and manipulate frames of video from an attached capture device such as a camera. 
OpenCV opencv;		// The OpenCV class provides functions for doing common computer vision tasks like loading images, filtering them, detecting faces, etc.
 
void setup() {
  size(640, 480);				// Defines dimension of display window width & height where units are pixels. This must be the first line of code in setup().
  video = new Capture(this, 640/2, 480/2);	// Usage: Capture(parent, width of frame, height of frame). It would be good to determine why these sizes were chosen.
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade("haarcascade_lefteye_2splits.xml");	// Load cascade file to be used for face/object detection.
 
  record=false;			// I suspect this variable is unused.
 
  video.start();		// Starts capturing frames from the selected device.
}
 
void draw() {
  scale(2);				// Usage: scale(percentage to scale object). Increases size of shape by 200%. What shape though? 
  opencv.loadImage(video);		// Load an image from a path.
 
  image(video, 0, 0 );			// Usage: image(image to display, x-coordinate of image, y-coordinate of image).
 
  noFill();				// Disables filling geometry. Otherwise shapes can be filled with colors.

  // I believe that the bottom values dictate how the boxes show up that identify the eyes.
  stroke(0, 255, 0);			// Usage: stroke(red/hue value, green/saturation value, blue/brightness value). It would be good to determine why these values were chosen.
  strokeWeight(3);			// Usage: strokeWeight(weight of pixels of stroke), units: pixels. Sets width of stroke used for lines, points, & border around shapes.
  Rectangle[] eye = opencv.detect();	// Detects object using cascade classifier.
  //println(faces.length);
 
  for (int i = 0; i <eye.length; i++) {
    println(eye[i].x + "," + eye[i].y);
    rect(eye[i].x, eye[i].y, eye[i].width, eye[i].height);	// Usage(x-coordinate of rectangle, y-coordinate of rectangle, width of rectangle, height of rectangle). Draws rectangle to screen.
    record();
    }
 
}
 
void captureEvent(Capture c) {
  c.read();	// Reads the current video frame.
}
 
void record(){
// println("enregistrement");
 // saveFrame() saves a numbered sequence of images, one image ea. time the function is ran. When this is ran at the end of draw(), an image will be saved identical to the display window.
 saveFrame("C:/Users/Darius/Desktop/Images/capture-####.tif"); //change this to desired file location. 
}
