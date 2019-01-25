import processing.video.*;

static final String MASK_IMAGE_PATH = "data/mask.png";
static final int VID_WIDTH = 128;
static final int VID_HEIGHT = 96;

static PApplet app;
static String cwd;
PImage mask;

void setup() {
	Log.setLevel("INFO");
	Log.d(sketchPath(""));
	app = this;
	PublicEye.cwd = sketchPath("");
	if (!MovieManager.initializeArchive()) {
		Log.e("Archive initialization failed.");
		exit();
	}
	// load the vignette mask for the movie overlay
	mask = loadImage(MASK_IMAGE_PATH);
	if (mask == null) {
		Log.e("Mask image loading failed.");
		exit();
	}
	mask.resize(VID_WIDTH + 2, VID_HEIGHT);
	size(480, 96);
	background(0);
	initializeMovieDisplay();
}

void draw() {
	drawMovie();
}