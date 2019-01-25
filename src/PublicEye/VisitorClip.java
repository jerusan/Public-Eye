import processing.video.*;
import java.util.Calendar;

class VisitorClip {
	static final int TOTAL_LAP_COUNT = 5;
	// minimum time (in seconds) between plays of a given video
	static final int WAITING_TIME = 120;

	private Movie movie;
	private int lapCount;
	private Calendar lastPlayed;

	VisitorClip(Movie movie) {
		this.movie = movie;
		lapCount = 0;
	}

	Movie getMovie() {
		lapCount++;
		lastPlayed = Calendar.getInstance();
		return movie;
	}

	int getLapCount() {
		return lapCount;
	}

	// checks how recently the video has been played, and returns false if the
	// time since it has been played is less than WAITING_TIME.
	boolean isPlayable() {
		if (lastPlayed == null) {
			return true;
		}
		Calendar playAfter = (Calendar) lastPlayed.clone();
		playAfter.add(Calendar.SECOND, WAITING_TIME);
		Calendar now = Calendar.getInstance();
		return now.after(playAfter);
	}
}