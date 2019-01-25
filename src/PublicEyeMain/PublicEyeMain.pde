import processing.video.*;
import java.util.*;
import java.util.Arrays;
import java.io.*;
import java.awt.*;

// Constants.
static final String MASK_FILE_NAME = "ovalmaskbig.png";
static final int VID_WIDTH = 128;  // Width of input videos
static final int VID_HEIGHT = 96;   // Heigh of input videos
static final int DISPLAY_WIDTH = 128;
static final int DISPLAY_HEIGHT = VID_HEIGHT;
static final String DATA_DIRECTORY_NAME = "data";
static final String FRAMES_DIRECTORY_NAME = "frames";
static final String ARCHIVE_DIRECTORY_NAME = "archive";
static final String RECORDINGS_DIRECTORY_NAME = "recordings";
static final String MASKS_DIRECTORY_NAME = "masks";
static final int DISPLAYED_MOVIE_COUNT = 6; //Amount of videos to be running at one time
static final int TOTAL_ARCHIVE_COUNT = 11;//Update when new files are added to Archive
static final float PX_PER_FRAME = 0.75;  // Controls the number of pixels the rendering scrolls per frame. The scope of this constant is DrawMovie.pde, consider moving declaration.
File[] archivedMovies;  // Read the archived movie files into the environment.


// Global lists for handling video attributes.
ArrayList<Movie> archive; //Replaced by currentlyDisplayedMovies[]
ArrayList<PImage> inputImage;
ArrayList<RecordedMovie> recordedMovieList;
PImage mask;  // Image for mask
float[] curXRender;
boolean positionedFlag = false;  //Flag for setting up display window position on first draw() call
boolean deleteNewestFileFlag = false; //used to delete the newest recording if not a valid video

void setup() {
  if (!(configurationCheck())) {
    // Then something on the system is not setup correctly.
	// Ensure you have checked out the Configuration page of the project wiki.
    println("ERROR: Configuration check failed. Program exiting.");
    exit();
  }
  initializeData();
  size(480, 96); // surface.setSize() accepts variable args, but doesn't work
  background(0);
  // Load mask into PImage
  mask = loadImage(MASKS_DIRECTORY_PATH + "/" + MASK_FILE_NAME);
  if (mask == null) {
    println("ERROR: Failed to load mask image file. Program exiting.");
    exit();
  }
  mask.resize(VID_WIDTH + 2, VID_HEIGHT);  // Gives image new height & width.
  openArchiveVideos();
}

void draw() {
  try {
    DrawMovie();  // Writes frames to screen.
  } catch (Exception e) {
    println("Exception occurred in PublicEyeMain.draw()");
	e.printStackTrace();
  }
}
