import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import java.util.Arrays;
boolean record;
boolean end;
int index = 1; 
int folderindex = 1; 

Capture video;
OpenCV opencv;

void setup() {
  size(640, 480);
  GetFileName();
  cameraSetup();
}
 
void draw() {
  //if(record == true){
  //  record();
  //}
  DisplayFrames();
  
}

ArrayList<String> frameListNames = new ArrayList<String>();
File f = new File("/home/publiceye/Documents/EyeTiming/Archive");
ArrayList<File> files = new ArrayList<File>(Arrays.asList(f.listFiles()));
File folder = new File("/home/publiceye/Documents/EyeTiming/Archive");


 void DisplayFrames()
{
  int i = 0;
  PImage img;
  try{
    if( i < frameListNames.size()-1 )
      {
        delay(310);
        img = loadImage("Archive/"+  frameListNames.get(i));
        image(img,0,0);
         
        i++;
      }
      else{
      i=0;
      }
    }
  catch(Exception e){
   println("HEY THIS HAPPENED");
  }
  
}

void GetFileName()
{
  try{

        File[] listOfFiles = folder.listFiles();          
          if(listOfFiles != null)
          {
            for (int i = 0; i < listOfFiles.length; i++) 
            {   
              if (listOfFiles[i].isFile()) 
                {
                  //index = i;
                  frameListNames.add(listOfFiles[i].getName());
                  //println(listOfFiles.length);
                 println(listOfFiles[i].getName());
                 
                }    
            }
            //return "hi";
          }
          else
          {  
          //  return "";
          }
        println("Files in List");
        }
      catch(Exception e)
      {
          println(" in get file name" + e);
      }
         
}