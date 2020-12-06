// Global variables

// canvases
PGraphics background;
PGraphics cursor;
PGraphics canvas;
PGraphics figure;

// control devices
ControlIO control;
ControlDevice joy_l;

// positions
boolean back_pressed, p_back_pressed;
boolean up_prs, p_up_prs;
float pos_x, pos_y, pos_z;
float spd_x, spd_y, spd_z;
float p_spd_x, p_spd_y, p_spd_z;

// vectors
ArrayList<PVector> gesture_inputs;

// states
enum DrawState {
  IDLE,      // nothing is happening
  DRAW,      // user is inputting a gesture
  POSITION   // user is adjusting the position
}
DrawState state;
enum DrawMode {
  CURSOR,
  GESTURE
}
DrawMode mode;
