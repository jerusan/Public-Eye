#include <stdio.h>
#include "xiApiPlusOcv.hpp" 

using namespace cv;
using namespace std;

int main (void)
{
 try
 {
   xiAPIplusCameraOcv cam;
   cam.OpenFirst();
   cam.SetExposureTime(10000); //10000 us = 10 ms
   cam.StartAcquisition();

   // Read and convert a frame from the camera
   Mat cv_mat_image = cam.GetNextImageOcvMat();
   // Show image on display
   cv::imshow("Image from camera",cv_mat_image);

   cam.StopAcquisition();
   cam.Close();
 }
 catch(xiAPIplus_Exception& exp)
 {
   exp.PrintError(); // report error if some call fails
 }
}
