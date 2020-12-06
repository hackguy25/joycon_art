import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

void setup() {
  size(1000, 1000);
  mode = DrawMode.GESTURE;
  state = DrawState.IDLE;
  
  // Initialise the ControlIO
  control = ControlIO.getInstance(this);
  
  // Find left Joy-Con
  joy_l = control.getMatchedDevice("joycon_l");
  if (joy_l == null) {
    println("Left Joy-Con not found!");
    System.exit(-1);
  }
  joy_l.getButton("L_BTN").plug(this, "reset_pos", ControlIO.ON_RELEASE);
  
  init_pos();
  cursor = createGraphics(width, height);
  canvas = createGraphics(width, height);
  figure = createGraphics(width, height);
  
  canvas.beginDraw();
  canvas.background(0, 0);
  canvas.image(cursor, 0, 0);
  canvas.endDraw();
  
  frameRate(120);
}

void draw() {
  background(204);
  
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
}
