// Gestures for gesture drawing

void bubbles() {
  float min_dist = 10;
  int num_circles = 3;
  
  PVector first = gesture_inputs.get(0);
  PVector last = gesture_inputs.get(gesture_inputs.size() - 1);
  PVector delta = PVector.sub(last, first);
  delta.z = 0;
  
  if (delta.mag() >= min_dist) {
    figure.beginDraw();
    for (int i = 0; i < num_circles; i++) {
      PVector point = delta.copy();
      point.rotate(HALF_PI);
      float disp = random(-1.5, 1.5);
      point.mult(disp);
      point.add(first.x, first.y);
      
      float r = min_dist * 0.5;
      r *= 100 * abs(last.z - first.z) + 1;
      
      figure.circle(-point.x + width / 2, point.y + height / 2, r);
    }
    figure.endDraw();
    
    gesture_inputs.clear();
    gesture_inputs.add(last);
  }
}
