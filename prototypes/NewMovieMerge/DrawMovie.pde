
void DrawMovie() {
  for(int i = 0; i < curXRender.length; i++) { 
 
    // Shift the video pxPerFrame left
    curXRender[i] -= pxPerFrame;
      
    // If the video has scrolled all the way left off the screen, reset its position to
    // the right of the rightmost video in the list (at mov.size() - 1 * w)
    if(curXRender[i] < (w * -1)) {
      curXRender[i] = (float) (curXRender.length - 1) * w; 
      
      if(count == curXRender.length && newVidCount<laps){
        flag =0;
        newVidCount++;
      }
      
      //if(newVidCount == laps){
        //newMovieNames.remove(0);
        //File folder = new File("/home/publiceye/Documents/Test/data/new");
        //File[] files = folder.listFiles();
          //if(files != null) { //some JVMs return null for empty dirs
            //for(File f: files) {
                 
              //    f.delete();
                 
              //}
          //}
      //}
      
      if(newMovieNames.size() != 0 && flag==0) {
        Movie newMov1;
        newMov1 = mov.get(i);
        newMov1.noLoop();
        Randomize(numb);
        Movie newMov = new Movie(this, "new/" + newMovieNames.get(0));
        newMov.loop();
        mov.set(i, newMov);
        newMov = mov.get(i); 
        flag =1; //<>//
        count = 0;
        newVidCount++;
      }
      
      else {
        Movie newMov1;
        newMov1 = mov.get(i);
        newMov1.noLoop();
        Randomize(numb);
        Movie newMov = new Movie(this, "archive/" + archiveMovieNames[randomNum]);
        newMov.loop();
        mov.set(i, newMov);
        newMov = mov.get(i); 
      }
      
      count++; //<>//
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