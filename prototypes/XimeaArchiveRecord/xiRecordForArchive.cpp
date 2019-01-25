#include <stdio.h>
#include "xiApiPlusOcv.hpp"
#include <opencv2/opencv.hpp>
#include <string>
#include <stdlib.h>
#include <ncurses.h>
#include <time.h>
#include <limits.h>
#include <iostream>
//Captures video for permanent archive
//Uses ncurses for non-blocking io (sudo apt-get install libncurses-dev)
#define EXPECTED_IMAGES 500
#define fps 30
using namespace cv;
using namespace std;
int main(int argc, char* argv[]) {
  try {
    int vidNumber;
    if(argc == 2) {
      vidNumber = atoi(argv[1]);
    } else {
      printf("\rEnter number of next video: ");
      cin >> vidNumber;
    }
    //ncurses no delay for non-blocking
    filter();
    initscr();
    nodelay(stdscr, TRUE);
    noecho();
    keypad(stdscr, TRUE);
    cbreak();
    while(1) {
    //Set up video capture opencv
    xiAPIplusCameraOcv cam;
    cam.OpenFirst();
    cam.SetExposureTime(10000); //in microseconds
    //cam.SetFrameRate(fps);
    cam.SetImageDataFormat(XI_RGB24);
    VideoWriter writer;
    int codec = CV_FOURCC('M', 'J', 'P', 'G');  // select desired codec (must be available runtime)
      // Note: The default parameters of each camera might be different in different API versions
      Size frameSize(1280,1024);
      printf("\rPress ENTER to record a video or CTRL C to stop\n");
      cin.sync(); // clear the input buffer
      string filename = "/home/publiceye/Public-Eye/src/PublicEyeMain/data/archive/vid" + to_string(vidNumber++) + ".mov";// name of the output video file
      cam.StartAcquisition();
      //Captures 15 seconds worth of frames
      int i = 0;
      int sec = 1;
      int ch;
      bool recording = false;
      while(i < EXPECTED_IMAGES) {
        //Simple color correction test
        Mat frame = cam.GetNextImageOcvMat();
        //Mat ccFrame;
        //cvtColor(frame, ccFrame, CV_BGR2Lab);
        if ((ch = getch()) != ERR && !recording) {
          recording = TRUE;
          writer.open(filename, codec, fps, frameSize, 1);
          printf("\rRecording\n");
        }
        if(recording) {
          writer.write(frame);
          i++;
          if(i%33 == 0) {
            printf("\r%d\n", sec++);
          }
        }
         cv::imshow("Image from camera", frame);//Usually doesn't load without a short delay (cvWaitKey(10))
         cvWaitKey(5);
      }
      writer.release();
      printf("\rFinished Recording\n");
      cam.StopAcquisition();
      cam.Close();
      endwin();
    }
  }
  catch(xiAPIplus_Exception& exp) {
    printf("Error:\n");
    exp.PrintError();
    cvWaitKey(2000);
  }
  return 0;
}
