float x, y, r = 180, g = 180, b = 0, a = 255; // variables for start position of lightning & color of lightning
float inc = 1; // 'resolution' of lightning
float prevX, prevY; // initializing
double rNum, rNum2;
PImage img;

void setup() {
  size(1200, 500);
  img = loadImage("skyline3.jpg");
  background(img);
  frameRate(5); // boring setup stuffs
}

void draw() {
  background(img);
  if (r >= 180 && g >= 180) {
    r += 5*((float)Math.random()-0.5);
    g += 5*((float)Math.random()-0.5);
  } else {
    r += 20*((float)Math.random());
    g += 20*((float)Math.random());
  } // keep the lightning yellowish
}

void mousePressed() {
  bolt(-1);
}

void bolt(int neg) { // neg to dictate whether lightning goes up or down so lightning can arc downwards when it doesn't hit a building
  rNum = Math.random(); // decide whether the lightning hits foreground, midground, or background
  if (rNum <= 0.5) { // background (thin strokes, more transparent
    strokeWeight(1);
    a = 175;
    
    fullCalibrate(524, 93, 200, 192); // see function below
    
  } else if (rNum <= 0.8) { // midground
    strokeWeight(1.5);
    a = 220;
    
    fullCalibrate(300, 245, 676, 156); 
    
  } else if (rNum <= 0.9) { // foreground
    strokeWeight(3);
    a = 255;
    
    fullCalibrate(1067, 276, 468, 350);
    
  } else { // don't hit a building
    neg = (-1)*neg;
    strokeWeight(1);
    x = (float)Math.random() * width;
    y = 0;
  }
  
  while (y <= height && x <= width - 10 && x >= 10) { // actually create a bolt to the given position
    stroke(r, g, b, a);
    prevX = x;
    prevY = y;
    x += neg * (inc * ((int)(Math.random() * 8) - 3));
    y += neg * (inc * ((int)(Math.random() * 8) - 2));
    line(prevX, prevY, x, y);
  }
}


void calibrateStrike(int antennaX, int antennaY) { // set destination of lightning strike
  x = antennaX;
  y = antennaY;
}

void fullCalibrate(int anX, int anY, int anX2, int anY2) { // to avoid typing this conditional statement three times
  rNum2 = (int)(Math.random() * 2);
  if (rNum2 == 1) {
    calibrateStrike(anX, anY);
  } else {
    calibrateStrike(anX2, anY2);
  }
}
