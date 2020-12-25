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
boolean reset_prs, p_reset_prs;
boolean hold_prs, p_hold_prs;
boolean conf_prs, p_conf_prs;
boolean prev_prs, p_prev_prs;
boolean next_prs, p_next_prs;
boolean canc_prs, p_canc_prs;
float pos_x, pos_y, pos_z;
float spd_x, spd_y, spd_z;
float p_spd_x, p_spd_y, p_spd_z;

// vectors
ArrayList<PVector> gesture_inputs;

// states
enum DrawState {
  IDLE,      // nothing is happening
  MENU,      // user is in the menu
  DRAW,      // user is inputting a gesture
  POSITION   // user is adjusting the position
}
DrawState state;
enum DrawMode {
  CURSOR,
  GESTURE
}
DrawMode mode;
enum Gesture {
  BUBBLES
}
Gesture selectedGesture;

// color palettes
final color palettes[][] = {
  {#edddd4, #283d3b, #197278, #c44536, #772e25}, // https://coolors.co/283d3b-197278-edddd4-c44536-772e25
  {#210044, #8da7ff, #665eff, #ff9cce, #ff52bf}, // https://coolors.co/ff9cce-ff52bf-210044-665eff-8da7ff
  {#390099, #ffbd00, #9e0059, #ff0054, #ff5400}, // https://coolors.co/390099-9e0059-ff0054-ff5400-ffbd00
  {#e5dada, #002642, #840032, #e59500, #02040f}, // https://coolors.co/002642-840032-e59500-e5dada-02040f
  {#f2e8cf, #386641, #6a994e, #a7c957, #bc4749}, // https://coolors.co/386641-6a994e-a7c957-f2e8cf-bc4749
};
int paletteNum;
color[] palette;

// menu
int menu_position;
boolean menu_selected;
PFont menu_font;
String menu_override_text;

// fonts
