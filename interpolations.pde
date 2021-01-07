// Interpolation functions

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

// Subdivision functions

void chaikin(ArrayList<PVector> points) {
  int len = points.size();
  if (len < 2)
    return;
  for (int i = 1; i < len; i++) {
    PVector p0 = points.get(0).copy().div(4);
    PVector p1 = points.get(1).copy().div(4);
    PVector t0 = p0.copy().mult(3);
    PVector t1 = p1.copy().mult(3);
    t0.add(p1);
    t1.add(p0);
    points.add(t0);
    points.add(t1);
    points.remove(0);
  }
  points.remove(0);
}

// Smoothing functions

void smooth_naive(ArrayList<PVector> points, float factor) {
  for (int i = points.size() - 2; i > 0; i--) {
    PVector temp = points.get(i-1).copy();
    temp.add(points.get(i+1));
    temp.sub(points.get(i));
    temp.sub(points.get(i));
    temp.mult(factor / 2);
    points.get(i).add(temp);
  }
}

void smooth_wider(ArrayList<PVector> points, float factor) {
  for (int i = points.size() - 3; i > 1; i--) {
    PVector temp = points.get(i-2).copy();
    temp.add(points.get(i+2));
    temp.sub(PVector.mult(points.get(i-1), 3));
    temp.sub(PVector.mult(points.get(i+1), 3));
    temp.sub(PVector.mult(points.get(i), 2));
    temp.mult(factor / 10);
    points.get(i).add(temp);
  }
}

// Pruning functions

float prune_by_distance(ArrayList<PVector> points, float min_dist) {
  int i = points.size() - 2;
  float total_dist = 0;
  while (i >= 0) {
    PVector temp = PVector.sub(points.get(i), points.get(i+1));
    temp.z = 0;
    float mag = temp.mag();
    if (mag < min_dist) {
      points.remove(i);
    } else {
      total_dist += mag;
    }
    i--;
  }
  return total_dist;
}

float prune_and_center_by_distance(ArrayList<PVector> points, ArrayList<PVector> target, float min_dist) {
  int i = points.size() - 2;
  float total_dist = 0;
  PVector center = points.get(i+1).copy();
  while (i >= 0) {
    PVector temp = PVector.sub(points.get(i), points.get(i+1));
    temp.z = 0;
    float mag = temp.mag();
    if (mag < min_dist) {
      points.remove(i);
    } else {
      total_dist += mag;
      center.add(points.get(i));
    }
    i--;
  }
  center.div(points.size());
  //for (i = 0; i < points.size(); i++) {
  //  points.set(i, points.get(i).sub(center));
  //}
  target.clear();
  for (PVector point : points) {
    target.add(PVector.sub(point, center));
  }
  return total_dist;
}

float prune_and_center_at_head(ArrayList<PVector> points, ArrayList<PVector> target, float min_dist) {
  int i = points.size() - 2;
  int added = 1;
  float total_dist = 0;
  PVector center = points.get(i+1).copy();
  while (i >= 0) {
    PVector temp = PVector.sub(points.get(i), points.get(i+1));
    temp.z = 0;
    float mag = temp.mag();
    if (mag < min_dist) {
      points.remove(i);
    } else {
      total_dist += mag;
      if (total_dist < 20 * min_dist) {
        center.add(points.get(i));
        added++;
      }
    }
    i--;
  }
  center.div(added);
  //for (i = 0; i < points.size(); i++) {
  //  points.set(i, points.get(i).sub(center));
  //}
  target.clear();
  for (PVector point : points) {
    target.add(PVector.sub(point, center));
  }
  return total_dist;
}
