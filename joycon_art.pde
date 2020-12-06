import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

void setup() {
  size(1000, 1000);
  
  // Initialise the ControlIO
  control = ControlIO.getInstance(this);
  
  // Find left Joy-Con
  joy_l = control.getMatchedDevice("joycon_l");
  if (joy_l == null) {
    println("Left Joy-Con not found!");
    System.exit(-1);
  }
  joy_l.getButton("L_BTN").plug(this, "reset_l", ControlIO.ON_RELEASE);
  
  // Find right Joy-Con
  joy_r = control.getMatchedDevice("joycon_r");
  if (joy_r == null) {
    println("Right Joy-Con not found!");
    System.exit(-1);
  }
  joy_r.getButton("R_BTN").plug(this, "reset_r", ControlIO.ON_RELEASE);
  
  l_x = 0;
  l_y = 0;
  l_z = 0;
  
  l_x = 0;
  l_y = 0;
  l_z = 0;
  
  plrx = 0;
  plry = 0;
  plrz = 0;
  
  prrx = 0;
  prry = 0;
  prrz = 0;
  
  frameRate(120);
}

void reset_l() {
  l_x = 0;
  l_y = 0;
  l_z = 0;
}

void reset_r() {
  r_x = 0;
  r_y = 0;
  r_z = 0;
}

void draw() {
  background(204);
  stroke(0);
  float mult = 0.1 * 60 / frameRate;
  
  rx = joy_l.getSlider("L_IO").getValue();
  ry = joy_l.getSlider("L_UD").getValue();
  rz = joy_l.getSlider("L_LR").getValue();
  l_x += mult * rx;
  l_y += mult * ry;
  l_z += mult * rz;
  
  pushMatrix();
  translate((1 - l_x) * width/2, (1 + l_y) * height/2);
  rotate(2 * l_z);
  fill(0x66ff8888);
  triangle(0, -15, 6, 6, -6, 6);
  
  plrx = rx;
  plry = ry;
  plrz = rz;
  
  rx = joy_r.getSlider("R_IO").getValue();
  ry = joy_r.getSlider("R_UD").getValue();
  rz = joy_r.getSlider("R_LR").getValue();
  r_x += mult * rx;
  r_y += mult * ry;
  r_z += mult * rz;
  
  popMatrix();
  translate((1 + r_x) * width/2, (1 - r_y) * height/2);
  rotate(2 * r_z);
  fill(0x668888ff);
  triangle(0, -15, 6, 6, -6, 6);
  
  prrx = rx;
  prry = ry;
  prrz = rz;
  
  // println(frameRate);
}
