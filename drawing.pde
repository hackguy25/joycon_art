// Various ways to draw on screen

void draw_cursor() {
  cursor.beginDraw();
  cursor.background(0, 0);
  cursor.translate((1 - pos_x) * width/2, (1 + pos_y) * height/2);
  cursor.rotate(2 * pos_z);
  if (conf_prs) {
    cursor.fill(0x66ff8888);
  } else {
    cursor.fill(0x668888ff);
  }
  cursor.triangle(0, -15, 6, 6, -6, 6);
  cursor.endDraw();
  
  if (conf_prs) {
    canvas.beginDraw();
    canvas.image(cursor, 0, 0);
    canvas.endDraw();
    image(canvas, 0, 0);
  } else {
    image(canvas, 0, 0);
    image(cursor, 0, 0);
  }
}

void draw_gesture() {
  switch(state) {
    case IDLE:
      if (p_conf_prs && !conf_prs) {
        reset_pos();
        gesture_inputs = new ArrayList<PVector>();
        if (selectedGesture == Gesture.WAVES || selectedGesture == Gesture.WAVES_2) {
          waves_colors = new color[2 * waves_num_lines_per_side + 1];
          for (int i = 0; i < 2 * waves_num_lines_per_side + 1; i++) {
            waves_colors[i] = palette[int(random(1, palette.length))];
          }
        }
        state = DrawState.DRAW;
        println("IDLE -> DRAW");
      }
      if (p_canc_prs && !canc_prs) {
        state = DrawState.MENU;
        menu_position = 0;
        menu_selected = false;
        println("IDLE -> MENU");
      }
      image(canvas, 0, 0);
      break;
    case MENU:
      processMenuInputs();
      image(canvas, 0, 0);
      drawMenu();
      break;
    case DRAW:
      if (p_reset_prs && !reset_prs) {
        gesture_inputs = new ArrayList<PVector>();
      }
      if (p_conf_prs && !conf_prs) {
        reset_pos();
        state = DrawState.POSITION;
        println("DRAW -> POSITION");
        image(canvas, 0, 0);
        image(figure, -width/2, -height/2);
        break;
      }
      if (p_canc_prs && !canc_prs) {
        reset_pos();
        state = DrawState.IDLE;
        println("DRAW -> IDLE");
        figure.beginDraw();
        figure.background(0, 0);
        figure.endDraw();
        image(canvas, 0, 0);
        break;
      }
      if (p_prev_prs && !prev_prs) {
        if ((selectedGesture == Gesture.WAVES || selectedGesture == Gesture.WAVES_2) && waves_num_lines_per_side > 1) {
          waves_num_lines_per_side -= 1;
          waves_colors = new color[2 * waves_num_lines_per_side + 1];
          for (int i = 0; i < 2 * waves_num_lines_per_side + 1; i++) {
            waves_colors[i] = palette[int(random(1, palette.length))];
          }
        }
      }
      if (p_next_prs && !next_prs) {
        if (selectedGesture == Gesture.WAVES || selectedGesture == Gesture.WAVES_2) {
          waves_num_lines_per_side += 1;
          waves_colors = new color[2 * waves_num_lines_per_side + 1];
          for (int i = 0; i < 2 * waves_num_lines_per_side + 1; i++) {
            waves_colors[i] = palette[int(random(1, palette.length))];
          }
        }
      }
      gesture_inputs.add(new PVector(pos_x * 500, pos_y * 500, pos_z));
      drawSelectedGesture();
      image(canvas, 0, 0);
      image(figure, -width/2, -height/2);
      break;
    case POSITION:
      if (p_conf_prs && !conf_prs) {
        canvas.beginDraw();
        canvas.image(figure.copy(), int((-pos_x - 1) * width/2), int((pos_y - 1) * height/2));
        canvas.endDraw();
        figure.beginDraw();
        figure.background(0, 0);
        figure.endDraw();
        state = DrawState.IDLE;
        println("POSITION -> IDLE");
        image(canvas, 0, 0);
        break;
      }
      if (p_canc_prs && !canc_prs) {
        reset_pos();
        state = DrawState.IDLE;
        println("POSITION -> IDLE");
        figure.beginDraw();
        figure.background(0, 0);
        figure.endDraw();
        image(canvas, 0, 0);
        break;
      }
      image(canvas, 0, 0);
      image(figure, int((-pos_x - 1) * width/2), int((pos_y - 1) * height/2));
      break;
  }
}
