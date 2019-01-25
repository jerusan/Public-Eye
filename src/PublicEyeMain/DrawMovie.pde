static final int LAPS = 5; // Suspect this is the number of times a recordingInProgressed clip will pass across the canvas before being deleted.

//Variable that will increment each DrawMovie() call. Will reset after 6, could need to be set higher later
int displayCount = 0;

// This variable gets set to 0 in DrawMovie() when vidCount == LAPS.
// This variable also gets set to 0 in DrawMovie() when it is greater than 6.
// This variable also gets set to 0 in deleteFile() whenever a file is deleted from the file system (this file usually being a recorded movie clip).
// This variable gets incremented if flag is TRUE and it is less than 1. It also gets incremented in the corresponding else statement...confusing right?
int newVidCount = 0;

// This flag is set to TRUE in Arduino.pde when a new clip has finished being recorded.
// This flag is set to FALSE in newMovieSearch() once the recorded clip has been confirmed to exist on the file system
boolean newRecordedClipAvailable;

int newestMovIndex;

void DrawMovie()
{
  try
  {
    //For each video open, stored in the mov list
    for (int i = 0; i < curXRender.length; i++)
    {
      loadPixels();
      // Shift the video PX_PER_FRAME left
      curXRender[i] -= PX_PER_FRAME;

      // If the video has scrolled all the way left off the screen, reset its position to
      // the right of the rightmost video in the list (at mov.size() - 1 * w)
      if (curXRender[i] < (VID_WIDTH * -1))
      {
        curXRender[i] = (float) (curXRender.length - 1) * VID_WIDTH;

        // Added This block to attempt new movie addition
        Movie oldMov;
        Movie newMov;
        // Displays one recorded video on the screen at a time. Ensures that if there is only one recorded video it does not appear twice on the screen
        if (recordedMovieList.size() > 0 && displayCount == DISPLAYED_MOVIE_COUNT)
        {
          int randomIndexIntoRecordings = new Random().nextInt(recordedMovieList.size());
          oldMov = archive.get(i);
          oldMov.noLoop();
          oldMov.stop();
          oldMov.dispose();
          if(recordedMovieList.get(randomIndexIntoRecordings).lapCount >= LAPS)
          {
            println("[DEBUG] Removing recorded video from list.");
            deleteFile(recordedMovieList.get(randomIndexIntoRecordings).path);
            recordedMovieList.remove(randomIndexIntoRecordings);
          }
        }
        else
        {
          oldMov = archive.get(i);
          oldMov.noLoop();
          oldMov.stop();
          oldMov.dispose();
          newestMovIndex = i;
          thread("loadNewestMov");
          
        }
        if(displayCount >= DISPLAYED_MOVIE_COUNT)
        {
          displayCount = 0;
        }
        else
        {
          displayCount++;
        }
      }

      if ((archive.get(i) != null) && (archive.get(i).available())) {
        archive.get(i).read();
        inputImage.get(i).copy(archive.get(i), 0, 0, archive.get(i).width, archive.get(i).height, 0, 0, VID_WIDTH, VID_HEIGHT);  // Input the movie on screen.
      }

      image(inputImage.get(i), curXRender[i], 0);
      image(mask, curXRender[i], 0);
    }
  } //<>// //<>//
  catch (Exception e)
  { //<>// //<>//
    println(e.getMessage());
  }
}
 //<>//
// I wanna delete this variable because I am pretty sure it has duplicate behavior as newRecordedClipAvailable. Although newRecordedClipAvailable gets set to true slightly earlier.
// This variable gets set to false when deleting a file, which makes sense as a precaution but this really shouldn't be necessary with the correct design. //<>//
boolean newlyRecordedClipNeedsToBeFoundInFilesystem = false;
String newFilename;//Added

void searchForNewlyRecordedClipInFilesystem()
{
  // The below code is looking for a file in the project's root directory.
  // This could potentially create a situation that entails a lot of unnecessary searching.
  // We should improve this somehow.
  File folder = new File(RECORDINGS_DIRECTORY_PATH);
  File[] listOfFiles = folder.listFiles();
  if (newRecordedClipAvailable) // (listOfFiles != null && (newRecordedClipAvailable = true)) //Old conditional
  {
    for (int i = 0; i < listOfFiles.length; i++)
    {
      //Need a check here to make sure the file being added isn't already in the list
      //Could use hashset for efficient checking, but might not be necessary as the set will probably never grow too large
      if (listOfFiles[i].getName().endsWith(".mov"))
      {
        int notFound = 1;
        for(int j = 0; j < recordedMovieList.size(); j++) {
          if(listOfFiles[i].getPath().equals(recordedMovieList.get(j).path)) {
            notFound = 0;
          }
        }
        if(notFound == 1 && !deleteNewestFileFlag) {
          recordedMovieList.add(new RecordedMovie(listOfFiles[i].getPath()));
          newRecordedClipAvailable = false;
          newlyRecordedClipNeedsToBeFoundInFilesystem = false;
        } else if(notFound == 1 && deleteNewestFileFlag) {
          deleteFile(listOfFiles[i].getPath());
          deleteNewestFileFlag = false;//reset flag
        }
      }
    }
  }
}

// to be called from a background thread,
// so as not to interrupt the animation thread when adding videos.
void loadNewestMov() {
    Movie newMov = new Movie(this, ARCHIVE_DIRECTORY_PATH + "/" + "vid" + new Random().nextInt(TOTAL_ARCHIVE_COUNT) + ".mov"); //NOTE: may need to change to .avi
    newMov.loop();
    archive.set(newestMovIndex, newMov);
}