// The exec is left commented out because its functionality has not been tested. But, this is exactly what we should need.
    // Uncomment to test and remove old deleting code if it works.
    // It should be noted that you must install Wipe if this is to work correctly by running the following command:
    //   sudo apt-get install wipe
    // See the following links for more information about use of exec():
    //   https://processing.org/reference/launch_.html
    //   http://processing.github.io/processing-javadocs/core/
void deleteFile(String fileToDelete)
{
  try
  {
    //newlyRecordedClipNeedsToBeFoundInFilesystem = false;
    println("[DEBUG] Deleting file " + fileToDelete);
    File file = new File(fileToDelete);
    println("File is being deleted");
    //exec("/usr/bin/wipe", fileToDelete);
    file.delete();
    newVidCount = 0;
  }
  catch (Exception e)
  {
    println(e.getMessage());
  }
}