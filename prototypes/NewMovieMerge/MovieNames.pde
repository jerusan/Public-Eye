//String[] archiveMovieNames = {"Sam.mov", "Erik.mov", "Wyatt.mov", "Tarun.mov", "Bjorn.mov", "b.mov", "c.mov", "d.mov","e.mov","s.mov","t.mov","w.mov" };
String[] archiveMovieNames = {"noaudio.mov", "noaudio2.mov","noaudio3.mov","noaudio4.mov"};




void newMovieSearch(){
  int index = 0;
  File folder = new File("/home/publiceye/Documents/NewMovieMerge/new");
  File[] listOfFiles = folder.listFiles();
  if (listOfFiles != null)
  {
    for (int i = 1; i < listOfFiles.length; i++)
    {
      if (listOfFiles[i].getName() == "newMov.mov")
      {
        index = index +1;
        newMovieNames.add(listOfFiles[i].getName());
      }
    }
  }

}