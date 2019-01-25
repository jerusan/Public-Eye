class Log { 
  static final String DEFAULT_LOG_LEVEL = "INFO";
  
	static final String FATAL_PREFIX = "(F)";
	static final String ERROR_PREFIX = "(E)";
	static final String WARN_PREFIX = "(W)";
	static final String INFO_PREFIX = "(I)";
	static final String DEBUG_PREFIX = "(D)";

	static final String SEP = ": ";

	static String level = DEFAULT_LOG_LEVEL;

	static void setLevel(String level) {
		switch (level.toUpperCase()) {
			case "FATAL":
			case "ERROR":
			case "WARN":
			case "INFO":
			case "DEBUG":
				Log.level = level.toUpperCase();
				break;
			default:
				Log.e("Unknown log level \"" + level + "\" specified.");
				return;
		}
	}

	static void f(String s) {
		if (doesPrintLevel("FATAL")) {
			System.out.println(FATAL_PREFIX + SEP + s);
		}
	}

	static void e(String s) {
		if (doesPrintLevel("ERROR")) {
			System.out.println(ERROR_PREFIX + SEP + s);
		}
	}

	static void w(String s) {
		if (doesPrintLevel("WARN")) {
			System.out.println(WARN_PREFIX + SEP + s);
		}
	}

	static void i(String s) {
		if (doesPrintLevel("INFO")) {
			System.out.println(INFO_PREFIX + SEP + s);
		}
	}

	static void d(String s) {
		if (doesPrintLevel("DEBUG")) {
			System.out.println(DEBUG_PREFIX + SEP + s);
		}
	}

	private static boolean doesPrintLevel(String level) {
		int threshold = levelAsInt(Log.level);
		int l = levelAsInt(level);
		return (l <= threshold);
	}

	private static int levelAsInt(String level) {
		switch (level) {
			case "FATAL":
				return 0;
			case "ERROR":
				return 1;
			case "WARN":
				return 2;
			case "INFO":
				return 3;
			case "DEBUG":
				return 4;
			default:
				return -1;
		}
	}
}
