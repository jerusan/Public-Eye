
//Populate a list with filenames
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

//Delete specified file.
void DeleteFile(String fileToDelete)
{
  
  try{
    String fileName = "/home/publiceye/Documents/NewMovieMerge/" + fileToDelete;
    File file = new File(fileName);
    if(f.exists())
    {
     file.delete();  
    }
  }
  catch(Exception e)
  {
    println("File does not exist");
  
  }
}

void CreateFile()
{
  try
  {
    PrintWriter output;
    output = createWriter("helloWorld.txt");
    output.println("File was created");
  }
  catch(Exception e)
  {
    println("NOT CREATED");
  } 
}



//Save frames specified location.
void Frames(String path)
{
    saveFrame("/home/publiceye/Documents/NewMovieMerge/data/TempFrames/" + path);
}