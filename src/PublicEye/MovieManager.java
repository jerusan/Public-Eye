import processing.video.*;
import processing.core.*;
import java.util.*;
import java.util.Collections;
import java.io.File;
import java.nio.file.*;

class MovieManager {
	// these probabilities control the distribution of archived / new clips
	static final double NEW_CLIP_PROBABILITY = 0.9;
	static final double VISITOR_CLIP_PROBABILITY = 0.3;

	static final String ARCHIVE_PATH = "data/archive";
	static final String ARCHIVED_MOVIE_PREFIX = "vid";
	static final String ARCHIVED_MOVIE_EXTENSION = ".mov";
	private static int archivedMovieCount;

	private static List newVisitorClips = Collections.synchronizedList(
		new ArrayList<VisitorClip>()
	);
	private static List visitorClips = Collections.synchronizedList(
		new ArrayList<VisitorClip>()
	);

	static boolean initializeArchive() {
		File archiveDir = new File(PublicEye.cwd + ARCHIVE_PATH);
		if (!archiveDir.isDirectory()) {
			Log.e("The directory \"" + archiveDir + "\" could not be found.");
			return false;
		}
		File[] archivedMovies = archiveDir.listFiles();
		int movieIndex = 0;
		while (Files.exists(
			Paths.get(
				PublicEye.cwd + ARCHIVE_PATH,
				ARCHIVED_MOVIE_PREFIX + movieIndex + ARCHIVED_MOVIE_EXTENSION
			)
		)) {
			movieIndex++;
		}
		if (movieIndex == 0) {
			Log.e("No archived movies were found.");
			return false;
		}
		// movies with indices in the range [0, movieIndex) exist.
		archivedMovieCount = movieIndex;
		Log.i(movieIndex + " movies were found in the archive.");
		return true;
	}
	
	static Movie getNextMovie() {
		Movie m;
		int randomIndex;
		// first, check if there are any brand new (as-yet unplayed) visitor clips
		if (
			newVisitorClips.size() > 0
			&& new Random().nextFloat() < NEW_CLIP_PROBABILITY
		) {
			randomIndex = new Random().nextInt(newVisitorClips.size());
			m = getVisitorMovie(randomIndex);
		} else if (
			visitorClips.size() > 0
			// ensures at least one visitor clip has not been played recently
			&& visitorClipsPlayable()
			&& new Random().nextFloat() < VISITOR_CLIP_PROBABILITY
		) {
			randomIndex = new Random().nextInt(visitorClips.size());
			m = getNewVisitorMovie(randomIndex);
		} else {
			randomIndex = new Random().nextInt(archivedMovieCount);
			m = getArchivedMovie(randomIndex);
		}
		if (m == null) {
			Log.e("The next movie could not be retrieved.");
		}
		return m;
	}

	// retrieves an as-yet unplayed visitor movie from the newVisitorClips list
	private static Movie getNewVisitorMovie(int index) {
		if (index < 0 || index >= visitorClips.size()) {
			Log.e(
				"The movie index requested (" + index + ") was out of range."
			);
			return null;
		}
		VisitorClip vc = (VisitorClip) newVisitorClips.get(index);
		// the movie is no longer unplayed; add it to the general list
		visitorClips.add(vc);
		return vc.getMovie();
	}

	private static boolean visitorClipsPlayable() {
		for (int i = 0; i < visitorClips.size(); i++) {
			if (((VisitorClip) visitorClips.get(i)).isPlayable()) {
				return true;
			}
		}
		return false;
	}

	private static Movie getVisitorMovie(int index) {
		if (index < 0 || index >= visitorClips.size()) {
			Log.e(
				"The movie index requested (" + index + ") was out of range."
			);
			return null;
		}
		int startIndex = index;
		while (!((VisitorClip) visitorClips.get(index)).isPlayable()) {
			index++;
			if (index == visitorClips.size()) {
				index = 0;
			}
			if (index == startIndex) {
				Log.w("All visitor clips have been played recently.");
			}
		}
		VisitorClip vc = (VisitorClip) visitorClips.get(index);
		if (vc.getLapCount() >= VisitorClip.TOTAL_LAP_COUNT) {
			// this is the final lap; remove this clip from future searches
			removeVisitorClip(index);
		}
		return vc.getMovie();
	}

	private static void addNewVisitorClip(VisitorClip clip) {
		// TODO: ensure this is thread-safe
		newVisitorClips.add(clip);
	}

	private static void removeVisitorClip(int index) {
		// TODO: ensure this is thread-safe
		visitorClips.remove(index);
	}

	private static Movie getArchivedMovie(int index) {
		if (index < 0 || index >= archivedMovieCount) {
			Log.e(
				"The movie index requested (" + index + ") was out of range."
			);
			return null;
		}
		Movie m = new Movie(
			PublicEye.app,
			PublicEye.cwd + ARCHIVE_PATH + "/" + ARCHIVED_MOVIE_PREFIX
			+ index + ARCHIVED_MOVIE_EXTENSION
		);
		return m;
	}
}
