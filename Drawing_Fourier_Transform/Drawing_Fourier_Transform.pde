final int USER = 0;
final int FOURIER = 1;

ArrayList<Complex> c;
ArrayList<FloatList> fourierX;
ArrayList<PVector> path;
ArrayList<PVector> drawing;

float time = 0;
int state = -1;

void setup() {
  fullScreen();
  background(0);
  fill(255);
  textAlign(CENTER);
  textSize(64);
  text("Draw something!", width / 2, height / 2);
}

void draw() {
  if (state == USER) { // User drawing mode
    background(0);
    drawing.add(new PVector(mouseX - width / 2, mouseY - height / 2));
    
    // Draw line after the user
    stroke(255);
    noFill();
    beginShape();
    for (PVector d : drawing) {
      vertex(d.x + width / 2, d.y + height / 2);
    }
    endShape();
  } else if (state == FOURIER) { // Fourier transform
    background(0);
    final PVector v = epicycles(width / 2, height / 2, 0, fourierX);
    path.add(v);
    
    beginShape();
    noFill();
    strokeWeight(2);
    stroke(255, 0, 255);
    for (PVector point : path) {
      vertex(point.x, point.y);
    }
    endShape();

    final float dt = TWO_PI / fourierX.size();
    time += dt;

    if (time > TWO_PI) {
      time = 0;
      path = new ArrayList<PVector>();
    }
  }
}

void mousePressed() { // New drawing, reset everything
  state = USER;
  drawing = new ArrayList<PVector>();
  c = new ArrayList<Complex>();
  path = new ArrayList<PVector>();
  time = 0;
}

void mouseReleased() { // Drawing finished, start showing
  state = FOURIER;
  for (PVector point : drawing) {
    c.add(new Complex(point.x, point.y));
  }
  fourierX = dft(c);
}

PVector epicycles(float x, float y, float rotation, ArrayList<FloatList> fourier) {
  for (FloatList f : fourier) {
    final float prevx = x;
    final float prevy = y;
    final float radius = f.get(3);
    final float rads = f.get(2) * time + f.get(4) + rotation;
    
    x += radius * cos(rads);
    y += radius * sin(rads);

    stroke(255, 100);
    noFill();
    circle(prevx, prevy, radius * 2);
    stroke(255);
    line(prevx, prevy, x, y);
  }
  return new PVector(x, y);
}
