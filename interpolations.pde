float decasteljau_bicubic(float x, float y, float[] pts) {
  float b0, b1, b2;
  float[] t = new float[4];
  float x_1 = 1-x, y_1 = 1-y;
  
  for (int i = 0; i < 4; i++) {
    b0 = x_1 * pts[4*i]   + x * pts[4*i+1];
    b1 = x_1 * pts[4*i+1] + x * pts[4*i+2];
    b2 = x_1 * pts[4*i+2] + x * pts[4*i+3];
    
    b0 = x_1 * b0 + x * b1;
    b1 = x_1 * b1 + x * b2;
    
    t[i] = x_1 * b0 + x * b1;
  }
  
  t[0] = y_1 * t[0] + y * t[1];
  t[1] = y_1 * t[1] + y * t[2];
  t[2] = y_1 * t[2] + y * t[3];
  
  t[0] = y_1 * t[0] + y * t[1];
  t[1] = y_1 * t[1] + y * t[2];
  
  return y_1 * t[0] + y * t[1];
}
