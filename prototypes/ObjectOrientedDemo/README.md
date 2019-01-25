How to run the eyeDemo Processing prototype
NOTE: These directions assume that Processing has already been installed on your computer

1. Unzip the project to any location on your computer.
2. Obtain the absolute pathname to the location of the eyeDemo project folder.
	For example, my project folder was located at 
	/Users/eriksopper/Documents/College/Spring 2016/EE 4951W/eyeDemo/
3. Open the eyeDemo.pde file in Processing.
4. Copy and paste the pathname from step 2 into line 13 of the program, between 
	the quotation marks, so the line reads something like 
	String eyeDemoPath = "/Users/eriksopper/Documents/College/Spring 2016/EE 4951W/eyeDemo/";
5. Click the run button.
6. Now, movie files dropped into the eyeDemo/data/new/ directory, matching the extension
	filter on line __ (defaulted to .avi files for compatibility with the recording program),
	will be rendered with the archived videos, then deleted.