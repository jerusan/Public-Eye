

void Randomize(int max)
{
  int maximum = max;
  randomNum = (int)(Math.random() * maximum); 
}


void GetFileName(){
  int index = 0;
  File folder = new File("/home/publiceye/Documents/ObjectOrientedDemo/data/archive/");
  File[] listOfFiles = folder.listFiles();
  if (listOfFiles != null)
  {
    for (int i = 1; i < listOfFiles.length; i++)
    {
      if (listOfFiles[i].isFile())
      {
        index = index +1;
        //archiveMovieNames.add(listOfFiles[i].getName());
      }
    }
  }
}

void newMovieSearch(){
  int index = 0;
  File folder = new File("/home/publiceye/Documents/ObjectOrientedDemo/data/new");
  File[] listOfFiles = folder.listFiles();
  if (listOfFiles != null)
  {
    for (int i = 1; i < listOfFiles.length; i++)
    {
      if (listOfFiles[i].isFile())
      {
        index = index +1;
        //newMovieNames.add(listOfFiles[i].getName());
        
      }
    }
  }
}

void renderMovie() {
  for(int i = 0; i < curXRender.length; i++) { 
 
    // Shift the video pxPerFrame left
    curXRender[i] -= pxPerFrame;
      
    // If the video has scrolled all the way left off the screen, reset its position to
    // the right of the rightmost video in the list (at mov.size() - 1 * w)
    if(curXRender[i] < (w * -1)) {
      curXRender[i] = (float) (curXRender.length - 1) * w;  //<>//
      
      if(newMovieNames != null && flag == 0) {
        Movie newMov1;
        newMov1 = mov.get(i);
        newMov1.noLoop();
        //newMovieNames.get(0)
        Movie newMov = new Movie(this, "new/" + newMovieNames[0]);
        newMov.loop();
        mov.set(i, newMov);
        newMov = mov.get(i); 
        
      }
      
      else {
        Movie newMov1;
        newMov1 = mov.get(i);
        newMov1.noLoop();
        Randomize(numb);
        //archiveMovieNames.get(randomNum);
        Movie newMov = new Movie(this, "archive/" + archiveMovieNames[randomNum]);
        newMov.loop();
        mov.set(i, newMov);
        newMov = mov.get(i); 
      }
    }
      
    
    // Actually obtain the video's new frame, and render it at the just-updated position
    if ((mov.get(i) != null) && (mov.get(i).available())) {
      mov.get(i).read();
      //input the movie on screen
      inputImage.get(i).copy(mov.get(i), 0, 0, mov.get(i).width, mov.get(i).height, 0, 0, w, h);
      //input the mask on screen
      inputImage.get(i).blend(mask, 0, 0, w+2, h, 0, 0, w+2, h, ADD);
    }
    image(inputImage.get(i),curXRender[i], 0);
    image(mask,curXRender[i], 0);
    
  }
}
  