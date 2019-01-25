boolean record;

Capture video;
OpenCV eye_cascade;

void VideoSetup(){
  video = new Capture(this, 640/2, 480/2);
  eye_cascade = new OpenCV(this, 640/2, 480/2);
  eye_cascade.loadCascade("haarcascade_lefteye_2splits.xml");
 
  record=false;
 
  video.start();
  
}



void PlayVideo(){
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
 saveFrame("C:/Users/livdahs/Documents/Processing/FrameLooping/data/####.png"); //change this to desired file location
}