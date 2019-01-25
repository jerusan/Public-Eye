
void DeleteFile(String fileToDelete)
{
  
  try
    {
      String fileName= "/home/publiceye/Documents/Serial_Communicaton___Processing_Rev2/" + fileToDelete;
      File file = new File(fileName);
      if(file.exists())
      {
       file.delete();  
      }
    }
  catch(Exception e)
    {
      println("SHIT FAILED");
    
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