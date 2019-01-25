static final int VISIBLE_MOVIE_COUNT = 6;
static float SHIFT_PX_PER_FRAME = 0.75;

static float[] movieCoordsX = new float[VISIBLE_MOVIE_COUNT];
static Movie[] displayedMovies = new Movie[VISIBLE_MOVIE_COUNT];
static PImage[] inputImages = new PImage[VISIBLE_MOVIE_COUNT];

// used in place of a function parameter when the background thread replaces
// the rightmost movie with new content (before it scrolls onto the screens)
static int newMovieIndex;

// set up the initial visible movies to play when the sketch starts
void initializeMovieDisplay() {
	for (int i = 0; i < VISIBLE_MOVIE_COUNT; i++) {
		movieCoordsX[i] = VID_WIDTH * i;
 		Movie newMovie = MovieManager.getNextMovie();
		newMovie.loop();
		displayedMovies[i] = newMovie;
		PImage inputImage = createImage(width, height, ARGB);
		inputImages[i] = inputImage;
	}
}

void drawMovie() {
	for (int i = 0; i < VISIBLE_MOVIE_COUNT; i++) {
		loadPixels();
		// shift this movie left by SHIFT_PX_PER_FRAME pixels
		movieCoordsX[i] -= SHIFT_PX_PER_FRAME;
		// if the movie has scrolled off the screen,
		if (movieCoordsX[i] < -1 * VID_WIDTH) {
			// wrap it around and place it to the right of the rightmost video.
			movieCoordsX[i] = (float) (VISIBLE_MOVIE_COUNT - 1) * VID_WIDTH;
			// in a background thread (so as to avoid stuttering), replace the
			// Movie shown at this index when it scrolls onto the screen.
			Movie oldMovie = displayedMovies[i];
			oldMovie.noLoop();
			oldMovie.stop();
			oldMovie.dispose();
			newMovieIndex = i;
			thread("loadNewMovie");
		}
		Movie m = displayedMovies[i];
		if (m != null && m.available()) {
			m.read();
			inputImages[i].copy(
				m, 0, 0, m.width, m.height, 0, 0, VID_WIDTH, VID_HEIGHT
			);
		} else {
			// Log.d("movie " + i + " currently unavailable");
		}
		image(inputImages[i], movieCoordsX[i], 0);
		image(mask, movieCoordsX[i], 0);
	}
}

void loadNewMovie() {
    Movie newMov = MovieManager.getNextMovie();
    newMov.loop();
    displayedMovies[newMovieIndex] = newMov;
}
