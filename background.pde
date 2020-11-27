void naive_perlin_background() {
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      pixels[j * width + i] = 0xff000000 + 0x00010101 * int(255 * noise(float(i)/width, float(j)/height, millis()/float(2000)));
    }
  }
}

void simple_perlin_grid_background(int delims) {
  int pts = 2 * delims + 2;
  float[][] grid = new float[pts][pts];
  
  for (int j = 0; j < pts; j++) {
    for (int i = 0; i < pts; i++) {
      grid[j][i] = noise(float(i+(i/2)%2) / 2, float(j+(j/2)%2) / 2, millis()/float(5000));
      // grid[j][i] = random(1);
    }
  }
  
  background.beginDraw();
  background.loadPixels();
  
  for (int j = 0; j < delims; j++) {
    for (int i = 0; i < delims; i++) {
      float[] block = {
        grid[2*j+1][2*i+1], 2*grid[2*j+1][2*i+1]-grid[2*j+1][2*i], grid[2*j+1][2*i+2], grid[2*j+1][2*i+3],
        2*grid[2*j+1][2*i+1]-grid[2*j][2*i+1], 4*grid[2*j+1][2*i+1]-2*(grid[2*j+1][2*i]+grid[2*j][2*i+1])+grid[2*j][2*i],
          2*grid[2*j+1][2*i+2]-grid[2*j][2*i+2], 2*grid[2*j+1][2*i+3]-grid[2*j][2*i+3],
        grid[2*j+2][2*i+1], 2*grid[2*j+2][2*i+1]-grid[2*j+2][2*i], grid[2*j+2][2*i+2], grid[2*j+2][2*i+3],
        grid[2*j+3][2*i+1], 2*grid[2*j+3][2*i+1]-grid[2*j+3][2*i], grid[2*j+3][2*i+2], grid[2*j+3][2*i+3]
      };
      float y_min = (j * background.height) / delims, y_max = ((j + 1) * background.height) / delims, y_delta = y_max - y_min;
      float x_min = (i * background.width) / delims,  x_max = ((i + 1) * background.width) / delims,  x_delta = x_max - x_min;
      for (int y = (j * background.height) / delims; y < ((j + 1) * background.height) / delims; y++) {
        for (int x = (i * background.width) / delims; x < ((i + 1) * background.width) / delims; x++) {
          background.pixels[y * background.width + x] = 0xff000000 + 0x00010101 *
            int(255 * (decasteljau_bicubic((x - x_min) / x_delta, (y - y_min) / y_delta, block)+1) / 3);
        }
      }
    }
  }
  
  background.updatePixels();
  background.endDraw();
}
