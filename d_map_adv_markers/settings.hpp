#ifndef __SETTINGS_HPP_
#define __SETTINGS_HPP_

// #define USERCONFIG_PATH "\userconfig\DMapAdvMarkers\config.txt"

#define DISTANCE_TO_MARKER_TO_DELETE_SQR 0.0008

#define CLIENT_MARKER_COLOR_AR ["Default", "ColorBlack", "ColorRed", "ColorGreen", "ColorBlue", "ColorYellow", "ColorOrange", "ColorWhite", "ColorPink", "ColorBrown", "ColorKhaki"]
#define CLIENT_MARKER_THICKNESS_AR [0.25, 0.5, 1, 2, 4]
//, 60]

//#define CLIENT_MARKER_DEFAULT_COLOR 0
#define CLIENT_MARKER_DEFAULT_THICKNESS 2



#define LINE_MARKER_CHANNEL_TO_TYPE_AR ["mil_circle", "mil_dot", "selector_selectable", "mil_triangle", "mil_box", "waypoint"];

#define MARKER_CHANNEL_TO_CHAR_AR ["G", "S", "C", "g", "V", "D"];



#define MTAG_DEFAULT_OPTIONS [MTAG_ALWAYS_ON, MTAG_ALWAYS_ON, MTAG_OFF, MTAG_OFF, MTAG_ALWAYS_OFF, MTAG_OFF]
#define MTAG_DEFAULT_KEY [42, true, false, false]  // left shift

#define DEFAULT_MOD_KEY_FOR_LINE_MARKERS 5  // 5 = Ctrl

#define TEMPORARY_MARKERS_TIMEOUT 5


#define MAX_DISTANCE_FOR_DIRECT 5

#endif
