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

void bubbles2() {
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
      float px = -point.x;
      while (px < -width/2) {
        px += width;
      }
      while (px > width/2) {
        px -= width;
      }
      float py = point.y;
      while (py < -height/2) {
        py += height;
      }
      while (py > height/2) {
        py -= height;
      }
      figure.circle(px, py, r);
      figure.circle(px, py + height, r);
      figure.circle(px, py + 2*height, r);
      figure.circle(px + width, py, r);
      figure.circle(px + width, py + height, r);
      figure.circle(px + width, py + 2*height, r);
      figure.circle(px + 2*width, py, r);
      figure.circle(px + 2*width, py + height, r);
      figure.circle(px + 2*width, py + 2*height, r);
    }
    figure.endDraw();
    
    gesture_inputs.clear();
    gesture_inputs.add(last);
  }
}

void waves() {
  float min_dist = 1500;
  float max_dist = 1600;
  float line_width = 8;
  float line_margin = 6;
  
  ArrayList<PVector> to_draw[] = new ArrayList[2 * waves_num_lines_per_side + 1];
  for (int i = 0; i < 2 * waves_num_lines_per_side + 1; i++)
    to_draw[i] = new ArrayList<PVector>();
  ArrayList<PVector> center_line = to_draw[waves_num_lines_per_side];

  float dist = prune_and_center_by_distance(gesture_inputs, center_line, line_width);
  smooth_naive(center_line, 0.5);
  prune_by_distance(center_line, 3 * line_width);
  smooth_naive(center_line, 0.5);
  chaikin(center_line);
  chaikin(center_line);
  
  for (int i = 1; i < center_line.size() - 1; i++) {
    PVector delta = PVector.sub(center_line.get(i+1), center_line.get(i-1));
    PVector orth = new PVector(delta.y, -delta.x);
    orth.normalize();
    for (int j = 1; j <= waves_num_lines_per_side; j++) {
      PVector disp = PVector.mult(orth, j * 2 * line_width);
      PVector base = center_line.get(i);
      to_draw[waves_num_lines_per_side + j].add(PVector.add(base, disp));
      to_draw[waves_num_lines_per_side - j].add(PVector.sub(base, disp));
    }
  }
  
  center_line.remove(center_line.size() - 1);
  if (center_line.size() > 0)
    center_line.remove(0);
  
  for (int i = 0; i < 2 * waves_num_lines_per_side + 1; i++) {
    chaikin(to_draw[i]);
    chaikin(to_draw[i]);
    chaikin(to_draw[i]);
    prune_by_distance(to_draw[i], line_width);
    smooth_naive(to_draw[i], 0.5);
    prune_by_distance(to_draw[i], line_width);
    smooth_naive(to_draw[i], 0.5);
    chaikin(to_draw[i]);
    chaikin(to_draw[i]);
    chaikin(to_draw[i]);
    prune_by_distance(to_draw[i], 1.5 * line_width);
    int pruneOffset = int(25 * noise(i, millis() / 250.));
    for (int j = 0; j < pruneOffset; j++)
      if (to_draw[i].size() > 0)
        to_draw[i].remove(0);
    pruneOffset = int(25 * noise(i, millis() / 250.));
    for (int j = 0; j < pruneOffset; j++)
      if (to_draw[i].size() > 0)
        to_draw[i].remove(to_draw[i].size() - 1);
  }
  
  figure.beginDraw();
  figure.background(0, 0);
  
  figure.noFill();
  for (int i = 0; i < 2 * waves_num_lines_per_side + 1; i++) {
    for (int j = 2; j < to_draw[i].size(); j++) {
      figure.strokeWeight(line_width + 2 * line_margin);
      figure.stroke(palette[0]);
      figure.line(-to_draw[i].get(j-1).x + width, to_draw[i].get(j-1).y + height,
        -to_draw[i].get(j).x + width, to_draw[i].get(j).y + height);
      
      figure.strokeWeight(line_width);
      figure.stroke(waves_colors[i]);
      figure.line(-to_draw[i].get(j-2).x + width, to_draw[i].get(j-2).y + height,
        -to_draw[i].get(j-1).x + width, to_draw[i].get(j-1).y + height);
    }
  }
  
  figure.endDraw();
  
  if (dist > min_dist) {
    gesture_inputs.remove(0);
  }
  if (dist > max_dist) {
    gesture_inputs.remove(0);
  }
}

void waves2() {
  float max_dist = 5000;
  float line_width = 8;
  float line_margin = 6;
  
  ArrayList<PVector> to_draw[] = new ArrayList[2 * waves_num_lines_per_side + 1];
  for (int i = 0; i < 2 * waves_num_lines_per_side + 1; i++)
    to_draw[i] = new ArrayList<PVector>();
  ArrayList<PVector> center_line = to_draw[waves_num_lines_per_side];

  float dist = prune_and_center_by_distance(gesture_inputs, center_line, line_width);
  smooth_naive(center_line, 0.5);
  prune_by_distance(center_line, 3 * line_width);
  smooth_naive(center_line, 0.5);
  chaikin(center_line);
  chaikin(center_line);
  
  for (int i = 1; i < center_line.size() - 1; i++) {
    PVector delta = PVector.sub(center_line.get(i+1), center_line.get(i-1));
    PVector orth = new PVector(delta.y, -delta.x);
    orth.normalize();
    for (int j = 1; j <= waves_num_lines_per_side; j++) {
      PVector disp = PVector.mult(orth, j * 2 * line_width);
      PVector base = center_line.get(i);
      to_draw[waves_num_lines_per_side + j].add(PVector.add(base, disp));
      to_draw[waves_num_lines_per_side - j].add(PVector.sub(base, disp));
    }
  }
  
  center_line.remove(center_line.size() - 1);
  if (center_line.size() > 0)
    center_line.remove(0);
  
  for (int i = 0; i < 2 * waves_num_lines_per_side + 1; i++) {
    chaikin(to_draw[i]);
    chaikin(to_draw[i]);
    chaikin(to_draw[i]);
    prune_by_distance(to_draw[i], line_width);
    smooth_naive(to_draw[i], 0.5);
    prune_by_distance(to_draw[i], line_width);
    smooth_naive(to_draw[i], 0.5);
    chaikin(to_draw[i]);
    chaikin(to_draw[i]);
    chaikin(to_draw[i]);
    prune_by_distance(to_draw[i], 1.5 * line_width);
    int pruneOffset = int(25 * noise(i, millis() / 250.));
    for (int j = 0; j < pruneOffset; j++)
      if (to_draw[i].size() > 0)
        to_draw[i].remove(0);
    pruneOffset = int(25 * noise(i, millis() / 250.));
    for (int j = 0; j < pruneOffset; j++)
      if (to_draw[i].size() > 0)
        to_draw[i].remove(to_draw[i].size() - 1);
  }
  
  figure.beginDraw();
  figure.background(0, 0);
  
  figure.noFill();
  for (int i = 0; i < 2 * waves_num_lines_per_side + 1; i++) {
    for (int j = 2; j < to_draw[i].size(); j++) {
      figure.strokeWeight(line_width + 2 * line_margin);
      figure.stroke(palette[0]);
      figure.line(-to_draw[i].get(j-1).x + width, to_draw[i].get(j-1).y + height,
        -to_draw[i].get(j).x + width, to_draw[i].get(j).y + height);
      
      figure.strokeWeight(line_width);
      figure.stroke(waves_colors[i]);
      figure.line(-to_draw[i].get(j-2).x + width, to_draw[i].get(j-2).y + height,
        -to_draw[i].get(j-1).x + width, to_draw[i].get(j-1).y + height);
    }
  }
  
  figure.endDraw();
  
  if (dist > max_dist) {
    gesture_inputs.remove(0);
    gesture_inputs.remove(0);
  }
}

void drawSelectedGesture() {
  switch (selectedGesture) {
    case BUBBLES:
      bubbles();
      break;
    case BUBBLES_2:
      bubbles2();
      break;
    case WAVES:
      waves();
      break;
    case WAVES_2:
      waves2();
      break;
  }
}
