import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

void setup() {
  size(1000, 1000);
  //fullScreen();
  //mode = DrawMode.CURSOR;
  mode = DrawMode.GESTURE;
  state = DrawState.MENU;
  selectedGesture = Gesture.WAVES;
  
  // Initialise the ControlIO
  control = ControlIO.getInstance(this);
  
  // Find left Joy-Con
  joy_l = control.getMatchedDevice("joycon_l");
  if (joy_l == null) {
    println("Left Joy-Con not found!");
    System.exit(-1);
  }
  
  joy_l.getButton("L_B_T").plug(this, "reset_pos", ControlIO.ON_RELEASE);
  
  init_pos();
  cursor = createGraphics(width, height);
  canvas = createGraphics(width, height);
  figure = createGraphics(2*width, 2*height);
  
  paletteNum = int(random(palettes.length));
  println("palette: ", paletteNum+1);
  palette = palettes[paletteNum];
  
  menu_font = createFont("NotoSans-Bold.ttf", 24);
  
  canvas.beginDraw();
  canvas.background(0, 0);
  canvas.image(cursor, 0, 0);
  canvas.endDraw();
  
  frameRate(60);
}

void draw() {
  background(palette[0]);
  
  get_inputs();
  
  switch (mode){
    case CURSOR:
      draw_cursor();
      break;
    case GESTURE:
      draw_gesture();
      break;
  }
  
  // println(frameRate);
  // debug_framerate();
}
