import processing.video.*;
import com.hamoid.*;
VideoExport vid;
Capture cam; 

int FPS = 30;

void cameraSetup(){
cam = new Capture(this, 640,480,FPS);
cam.start();

//addending cam to the constructor tells vid to capture what the camera sees.
vid = new VideoExport(this, "newMov.mov",cam);

}

void cameraRead(){
if(cam.available()){
cam.read();
}
//vid will save a frame from the camera everytime this is called. Need to find the right place to put it.
vid.saveFrame();
}