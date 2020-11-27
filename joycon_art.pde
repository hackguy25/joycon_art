import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

void setup() {
  size(1000, 1000);
  background = createGraphics(1000,1000);
}

void draw() {
  // draw background
  int t1 = millis();
  // naive_perlin_background();
  simple_perlin_grid_background(20);
  int t2 = millis();
  image(background, 0, 0, width, height);
  int t3 = millis();
  println(frameRate, t2-t1, t3-t2);
}
