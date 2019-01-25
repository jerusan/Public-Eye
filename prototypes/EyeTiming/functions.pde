void captureEvent(Capture c) {
  c.read();
}

void cameraSetup(){
   video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade("haarcascade_lefteye_2splits.xml");
  
  record=false;

 
  video.start();
}
 

 
void Frames(){
String Path = "/home/publiceye/Documents/EyeTiming/Archive";
 //Path = Path + folderindex;
 index++;
 saveFrame(Path +"/capture-####.tif"); //change this to desired file location
 if (index == 100){
   end();
 }
}

void record(){
  scale(2);
  opencv.loadImage(video);
 
  image(video, 0, 0 );
 
  noFill();
  stroke(255, 255, 0);
  strokeWeight(3);
  Rectangle[] eye = opencv.detect();
  //println(faces.length);
 
  for (int i = 0; i <eye.length; i++) {
    println(eye[i].x + "," + eye[i].y);
    rect(eye[i].x, eye[i].y, eye[i].width, eye[i].height);
    Frames();
    }
}

void end() {
  while(1==1) {
    video.stop();
  }
}