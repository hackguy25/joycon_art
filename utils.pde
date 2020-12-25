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
  p_reset_prs = reset_prs;
  reset_prs = joy_l.getButton("L_B_T").pressed();
  p_hold_prs = hold_prs;
  hold_prs = joy_l.getButton("L_B_B").pressed();
  p_conf_prs = conf_prs;
  conf_prs = joy_l.getButton("L_D_U").pressed();
  p_prev_prs = prev_prs;
  prev_prs = joy_l.getButton("L_D_L").pressed();
  p_next_prs = next_prs;
  next_prs = joy_l.getButton("L_D_R").pressed();
  p_canc_prs = canc_prs;
  canc_prs = joy_l.getButton("L_D_D").pressed();
  
  float mult = 0.1 * 60 / frameRate;
  
  p_spd_x = spd_x;
  p_spd_y = spd_y;
  p_spd_z = spd_z;
  
  if (!hold_prs) {
    spd_x = joy_l.getSlider("L_IO").getValue();
    spd_y = joy_l.getSlider("L_UD").getValue();
    spd_z = joy_l.getSlider("L_LR").getValue();
  } else {
    spd_x = 0.;
    spd_y = 0.;
    spd_z = 0.;
  }
  
  pos_x += mult * spd_x;
  pos_y += mult * spd_y;
  pos_z += mult * spd_z;
}

void debug_framerate() {
  textAlign(LEFT, BASELINE);
  textFont(menu_font, 15);
  fill(255);
  text(Float.toString(frameRate), 0, height);
}
