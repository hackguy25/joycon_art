// Menu for gesture drawing

void drawMenu() {
  fill(palette[0]);
  stroke(palette[1]);
  strokeWeight(5);
  rect(width / 2 - 100, 150, 200, 250, 2);
  textAlign(CENTER, CENTER);
  textFont(menu_font);
  
  drawMenuItem(menu_position == 0,   "RIŠI", 150);
  drawMenuItem(menu_position == 1,  "GESTA", 200);
  drawMenuItem(menu_position == 2, "PALETA", 250);
  drawMenuItem(menu_position == 3, "SHRANI", 300);
  drawMenuItem(menu_position == 4,  "IZHOD", 350);
}

void drawMenuItem(boolean selected, String name, float y_pos) {
  if (selected) {
    fill(palette[1]);
    noStroke();
    rect(width / 2 - 100, y_pos, 200, 50);
    fill(palette[0]);
    text(menu_selected ? menu_override_text : name, width / 2, y_pos + 20);
  } else if (!menu_selected) {
    fill(palette[1]);
    text(name, width / 2, y_pos + 20);
  }
}

void processMenuInputs() {
  if (menu_selected) {
    if (p_conf_prs && !conf_prs) {
      menu_selected = false;
    } else if (p_prev_prs && !prev_prs) {
      switch (menu_position) {
        case 1:
          selectedGesture = selectedGesture.next();
          menu_override_text = selectedGesture.toString();
          println("gesta: " + menu_override_text);
          break;
        case 2:
          paletteNum += palettes.length - 1;
          paletteNum %= palettes.length;
          println("palette: ", paletteNum + 1);
          palette = palettes[paletteNum];
          menu_override_text = Integer.toString(paletteNum + 1);
          break;
      }
    } else if (p_next_prs && !next_prs) {
      switch (menu_position) {
        case 1:
          selectedGesture = selectedGesture.next();
          menu_override_text = selectedGesture.toString();
          println("gesta: " + menu_override_text);
          break;
        case 2:
          paletteNum += 1;
          paletteNum %= palettes.length;
          println("palette: ", paletteNum + 1);
          palette = palettes[paletteNum];
          menu_override_text = Integer.toString(paletteNum + 1);
          break;
      }
    } else if (p_canc_prs && !canc_prs) {
      menu_selected = false;
    }
  } else {
    if (p_conf_prs && !conf_prs) {
      switch (menu_position) {
        case 0:
          state = DrawState.IDLE;
          println("MENU -> IDLE");
          break;
        case 1:
          println("menjaj gesto");
          menu_selected = true;
          menu_override_text = selectedGesture.toString();
          break;
        case 2:
          println("menjaj paleto");
          menu_override_text = Integer.toString(paletteNum + 1);
          canvas = createGraphics(width, height);
          menu_selected = true;
          break;
        case 3:
          println("shrani umetnino");
          menu_override_text = "SHRANJENO";
          String save_name = save_current_canvas();
          println(" -> " + save_name);
          menu_selected = true;
          break;
        case 4:
          exit();
          break;
      }
    } else if (p_prev_prs && !prev_prs) {
      menu_position += 4;
      menu_position %= 5;
    } else if (p_next_prs && !next_prs) {
      menu_position += 1;
      menu_position %= 5;
    } else if (p_canc_prs && !canc_prs) {
      state = DrawState.IDLE;
      println("MENU -> IDLE");
    }
  }
}
