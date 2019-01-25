// Relevant directory paths assigned at runtime.
String SKETCH_DIRECTORY_PATH;
String DATA_DIRECTORY_PATH;
String FRAMES_DIRECTORY_PATH;
String ARCHIVE_DIRECTORY_PATH;
String RECORDINGS_DIRECTORY_PATH;
String MASKS_DIRECTORY_PATH;

//Initialize Movie list, rendering list, input frame and other lists
void initializeData() {
  archive = new ArrayList<Movie>();
  recordedMovieList = new ArrayList<RecordedMovie>();
  curXRender = new float[DISPLAYED_MOVIE_COUNT];
  inputImage = new ArrayList<PImage>();
  archivedMovies = new File(ARCHIVE_DIRECTORY_PATH).listFiles();
  // Read the archived movie files into the environment.
}

//Open videos currently in archive.
void openArchiveVideos() {
  for (int i = 0; i < DISPLAYED_MOVIE_COUNT; i++) {
    Movie movieFromArchive = new Movie(this, ARCHIVE_DIRECTORY_PATH + "/vid" + new Random().nextInt(TOTAL_ARCHIVE_COUNT) + ".mov");
    PImage newInputImage = createImage(width, height, ARGB);
    inputImage.add(newInputImage);
    movieFromArchive.loop();  // Play Movie continuously, restarting when it's over.
    archive.add(movieFromArchive);
  }

  for (int i = 0; i < curXRender.length; i++) {
    curXRender[i] = VID_WIDTH * i;
  }
}

// The purpose of this function is to make sure the data directory contains the expected
// children directories for this program to run correctly.
boolean configurationCheck()
{
  boolean configurationIsValid = true;
  SKETCH_DIRECTORY_PATH = sketchPath("");
  String query = SKETCH_DIRECTORY_PATH + DATA_DIRECTORY_NAME;

  if (directoryExists(query))
  {
    // Then the data directory exists in the sketches root folder, now check for it's expected children directories.
    DATA_DIRECTORY_PATH = query;
    query = DATA_DIRECTORY_PATH + "/" + ARCHIVE_DIRECTORY_NAME;

    if (directoryExists(query))
    {
      ARCHIVE_DIRECTORY_PATH = query;
    }
    else { configurationIsValid = false; }

    query = DATA_DIRECTORY_PATH + "/" + FRAMES_DIRECTORY_NAME;
    if (directoryExists(query))
    {
      FRAMES_DIRECTORY_PATH = query;
    }
    else { configurationIsValid = false; }

    query = DATA_DIRECTORY_PATH + "/" + MASKS_DIRECTORY_NAME;
    if (directoryExists(query))
    {
      MASKS_DIRECTORY_PATH = query;
    }
    else { configurationIsValid = false; }

    query = DATA_DIRECTORY_PATH + "/" + RECORDINGS_DIRECTORY_NAME;
    if (directoryExists(query))
    {
      RECORDINGS_DIRECTORY_PATH = query;
    }
    else { configurationIsValid = false; }

  }
  else { configurationIsValid = false; }

  return configurationIsValid;
}

// This function returns true if the directory path, passed in as an argument
// is a valid directory that exists in the expected location.
boolean directoryExists(String directoryName)
{
  File directoryBeingChecked = new File(directoryName);

  if (directoryBeingChecked.isDirectory())
  {
    return true;
  }
  else
  {
    println("Are you missing a " + directoryName + " directory?");
    return false;
  }
}
