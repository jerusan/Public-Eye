//Initialize Movie list, rendering list, input frame and other lists
void InitializeData(){
  numb = archiveMovieNames.length;
  
  // Initialize video attribute lists
  mov = new ArrayList<Movie>();
  inputImage = new ArrayList<PImage>();
  curXRender = new float[5];
  
  // Initialize new video attribute lists
  running = new ArrayList<String>();
  ran = new ArrayList<String>();
  loops = new ArrayList<Integer>();
  indexInMov = new ArrayList<Integer>();
  
}
  
//Open videos currently in archive.
void OpenArchiveVideos()
{
// Open archive videos from archiveMovieNames
  //archiveMovieNames--> put back in the for each to get original functionality
  for(int n = 0;n < 6; n++) {
    Randomize(numb);
    Movie newMov = new Movie(this, "archive/" + archiveMovieNames[randomNum]);
    PImage newInputImage = createImage(width, height, ARGB);
    inputImage.add(newInputImage);
    newMov.loop();
    mov.add(newMov);
  }
  
  for (int i=0; i < curXRender.length; i++)
  {
    curXRender[i] = w * i;
  }
  
  // Initialize filename filter, which will only look for .avi files
  fileNameFilter = new FilenameFilter() {
    @Override
    public boolean accept(File dir, String name) {
       if(name.lastIndexOf('.')>0)
       {
          // get last index for '.' char
          int lastIndex = name.lastIndexOf('.');
          
          // get extension
          String str = name.substring(lastIndex);
          
          // match path name extension
          if(str.equals(movieExtensionFilter))
          {
             return true;
          }
       }
       return false;
    }
   };
}

void Randomize(int max)
{
  int maximum = max;
  randomNum = (int)(Math.random() * maximum); 
}