boolean record;

Capture video;
OpenCV eye_cascade;

void VideoSetup(){
  
  video = new Capture(this, 640/4, 480/4, 30);
  eye_cascade = new OpenCV(this, 640, 480);
  eye_cascade.loadCascade("haarcascade_lefteye_2splits.xml");
  record=false;
  video.start();
  
}


//Use the camera to detect eyeballs
void CaptureVideo(){
 scale(2);
  eye_cascade.loadImage(video);
 
  image(video, 0, 0 );
 
  
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] eye = eye_cascade.detect();
  //println(faces.length);
 
 //draw detected face area(s)
  noFill();
  for (int i = 0; i <eye.length; i++) {
    println(eye[i].x + "," + eye[i].y);
    rect(eye[i].x, eye[i].y, eye[i].width, eye[i].height);
    record();
    }
  
  
}

void captureEvent(Capture c) {
  c.read();
}
 
void record(){
// println("enregistrement");
 saveFrame("/home/publiceye/Documents/MergeAttempt/data/frames/capture-#####.png"); //change this to desired file location
 //saveFrame("/home/publiceye/Documents/MergeAttempt/data/frames/capture-#####.png"); //change this to desired file location
}