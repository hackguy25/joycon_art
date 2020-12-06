// Various ways to draw on screen

void draw_cursor() {
  cursor.beginDraw();
  cursor.background(0, 0);
  cursor.translate((1 - pos_x) * width/2, (1 + pos_y) * height/2);
  cursor.rotate(2 * pos_z);
  if (back_pressed) {
    cursor.fill(0x66ff8888);
  } else {
    cursor.fill(0x668888ff);
  }
  cursor.triangle(0, -15, 6, 6, -6, 6);
  cursor.endDraw();
  
  if (back_pressed) {
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
      if (p_up_prs && !up_prs) {
        reset_pos();
        gesture_inputs = new ArrayList<PVector>();
        state = DrawState.DRAW;
        println("IDLE -> DRAW");
      }
      image(canvas, 0, 0);
      break;
    case DRAW:
      if (p_up_prs && !up_prs) {
        reset_pos();
        state = DrawState.POSITION;
        println("DRAW -> POSITION");
        image(canvas, 0, 0);
        image(figure, -pos_x * width/2, pos_y * height/2);
        break;
      }
      gesture_inputs.add(new PVector(pos_x * width/2, pos_y * height/2, pos_z));
      bubbles();
      image(canvas, 0, 0);
      image(figure, 0, 0);
      break;
    case POSITION:
      if (p_up_prs && !up_prs) {
        canvas.beginDraw();
        canvas.image(figure.copy(), -pos_x * width/2, pos_y * height/2);
        canvas.endDraw();
        figure.beginDraw();
        figure.background(0, 0);
        figure.endDraw();
        state = DrawState.IDLE;
        println("POSITION -> IDLE");
        image(canvas, 0, 0);
        break;
      }
      image(canvas, 0, 0);
      image(figure, -pos_x * width/2, pos_y * height/2);
      break;
  }
}
