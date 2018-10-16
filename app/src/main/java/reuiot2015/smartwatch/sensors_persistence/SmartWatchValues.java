package reuiot2015.smartwatch.sensors_persistence;

import java.io.File;

/** Some default persistence values and methods for use by SmartWatch. */
public class SmartWatchValues {
    public static final String ALBUM_NAME = "SmartWatch Samples";
    //Number of data per prediction. Related to prediction interval.
    public static final int TRIGGER = 100;
    //unit: millisecond
    public static final int WINDOW_SIZE = 750;
    //unit: (time/second)
    public static final float SAMPLE_FREQUENCY = 31.25f;
    //How many data are compared at once
    public static final int DATA_PER_WINDOW = (int)(WINDOW_SIZE/(1000 / SAMPLE_FREQUENCY));
    //How many rounds of predictions for rewriting of default.csv to happen
    public static final int REWRITE_INTERVAL = 10;

    public static final int OVERLAP_RADIUS = 3;

    public static final int THRESHOLD_LOW = 3; //Thresholds for heuristic function
    public static final int THRESHOLD_HIGH = 50;

}
