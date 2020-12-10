// Utility functions

void init_pos() {
  pos_x = 0;
  pos_y = 0;
  pos_z = 0;
  
  p_spd_x = 0;
  p_spd_y = 0;
  p_spd_z = 0;
}

void reset_pos() {
  pos_x = 0;
  pos_y = 0;
  pos_z = 0;
}

void get_inputs() {
  float mult = 0.1 * 60 / frameRate;
  
  p_spd_x = spd_x;
  p_spd_y = spd_y;
  p_spd_z = spd_z;
  
  spd_x = joy_l.getSlider("L_IO").getValue();
  spd_y = joy_l.getSlider("L_UD").getValue();
  spd_z = joy_l.getSlider("L_LR").getValue();
  
  pos_x += mult * spd_x;
  pos_y += mult * spd_y;
  pos_z += mult * spd_z;
  
  p_back_pressed = back_pressed;
  back_pressed = joy_l.getButton("L_B_B").pressed();
  
  p_up_prs = up_prs;
  up_prs = joy_l.getButton("L_D_U").pressed();
}
