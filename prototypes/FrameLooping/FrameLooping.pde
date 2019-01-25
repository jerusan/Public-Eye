import java.util.*;
import java.util.Arrays;
import java.io.*;
import gab.opencv.*;
import processing.video.*;
import java.awt.*;


ArrayList<String> frameListNames = new ArrayList<String>();
File f = new File("/home/publiceye/Documents/FrameLooping/data");
ArrayList<File> files = new ArrayList<File>(Arrays.asList(f.listFiles()));

int index;
File folder = new File("/home/publiceye/Documents/FrameLooping/data");

void GetFileName(){
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
    
}
      catch(Exception e)
      {
        
          println(" in get file name" + e);}
               
} 

void setup(){
  VideoSetup();
  
GetFileName();
  
  //MemoryTest();
  size(640,480);
    
}

int i =0;
void draw(){
    try
    {
      DisplayFrames();
      //PlayVideo();
      //MemoryTest();
    }
    catch(Exception e)
    {
      println("Actually happened in draw");
    }



  
}


PImage img;
void DisplayFrames()
{
  try{
    if( i < frameListNames.size()-1 ) //<>//
      {
        delay(31);
        img = loadImage(frameListNames.get(i));
        image(img,0,0);
        
       // println(i);
        i++;
        
      }
      else{
      i=0;
      }
    }
  catch(Exception e){ //<>//
   println("HEY THIS HAPPENED");
  }
  
    
  
}