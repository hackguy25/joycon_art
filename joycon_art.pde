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
  
  // Find right Joy-Con
  joy_r = control.getMatchedDevice("joycon_r");
  if (joy_r == null) {
    println("Right Joy-Con not found!");
    System.exit(-1);
  }
}

void draw() {
  background(204);
  stroke(0);
  
  rx = joy_l.getSlider("L_IO").getValue();
  ry = joy_l.getSlider("L_UD").getValue();
  rz = joy_l.getSlider("L_LR").getValue();
  
  pushMatrix();
  translate((1-rx) * width/2, (1+ry) * height/2);
  rotate(2*rz);
  fill(0x66ff8888);
  triangle(0, -15, 6, 6, -6, 6);
  
  rx = joy_r.getSlider("R_IO").getValue();
  ry = joy_r.getSlider("R_UD").getValue();
  rz = joy_r.getSlider("R_LR").getValue();
  
  popMatrix();
  translate((1+rx) * width/2, (1-ry) * height/2);
  rotate(2*rz);
  fill(0x668888ff);
  triangle(0, -15, 6, 6, -6, 6);
}
