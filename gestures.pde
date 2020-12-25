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
      r *= abs(last.z - first.z);
      r = 1 - exp(-(r+0.05));
      r = r * 100 + 1; 
      
      // r < 10 => fill
      // r = 10 => 50% chance fill
      if (r >= 10 && random(1) > exp(-(r - 10) * 0.06931471)) {
        // stroke only
        figure.fill(palette[0]);
        figure.stroke(palette[int(random(1, palette.length))]);
        figure.strokeWeight(1 + r/20);
      } else {
        // fill only
        figure.fill(palette[int(random(1, palette.length))]);
        figure.noStroke();
      }
      figure.circle(-point.x + width, point.y + height, r);
    }
    figure.endDraw();
    
    gesture_inputs.clear();
    gesture_inputs.add(last);
  }
}

void drawSelectedGesture() {
  switch (selectedGesture) {
    case BUBBLES:
      bubbles();
      break;
  }
}
