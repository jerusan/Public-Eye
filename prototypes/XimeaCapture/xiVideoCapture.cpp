#include <stdio.h>
#include "xiApiPlusOcv.hpp"
#include <opencv2/opencv.hpp>
#include <string>
#include <time.h>
#define EXPECTED_IMAGES 500
#define fps 30
using namespace cv;
using namespace std;
int main(int argc, char* argv[])
{
  try
  {
    //Set up video capture opencv
    xiAPIplusCameraOcv cam;
    cam.OpenFirst();
    cam.SetExposureTime(10000); //in microseconds
    //cam.SetFrameRate(60);
    cam.SetImageDataFormat(XI_RGB24);
    // Note: The default parameters of each camera might be different in different API versions
    printf("Starting acquisition...\n");
    Size frameSize(1280,1024);
    VideoWriter writer;
    int codec = CV_FOURCC('M', 'J', 'P', 'G');  // select desired codec (must be available runtime)

    // generate number between 1 and 100 for naming temporary files
    srand (time(NULL));
    int randInt = rand() % 100 + 1;
    string filename = "/home/publiceye/Public-Eye/src/PublicEyeMain/data/recordings/newVid" + to_string(randInt) + ".mov";// name of the output video file
    writer.open(filename, codec, fps, frameSize, 1);
    cam.StartAcquisition();
    //Captures 15 seconds worth of frames
    for(int i = 0; i < EXPECTED_IMAGES; i++) {
      Mat frame = cam.GetNextImageOcvMat();
      //Simple color correction test
      //Mat ccFrame;
      //cvtColor(frame, ccFrame, CV_BGR2Lab);
      //cv::imshow("Image from camera", frame);//Usually doesn't load without a delay (cvWaitKey(20))
      //cvWaitKey(20);
      writer.write(frame);
    }
    cam.StopAcquisition();
    cam.Close();
    printf("Done\n");
  }
  catch(xiAPIplus_Exception& exp)
  {
    printf("Error:\n");
    exp.PrintError();
    cvWaitKey(2000);
  }
  return 0;
}
