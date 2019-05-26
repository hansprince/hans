int count = 255;
float size[] = new float[count];
float snowX[] = new float[count];
float snowY[]= new float[count];
float spd[] = new float[count];
float max=10;
float min=1;
int ground = 100;
import processing.serial.*;
PrintWriter out;
Serial p;
int result;

void setup() {
  size(500, 500);
  p = new Serial(this, "COM4", 9600);
  for (int i=0; i<count; i++) {
    size[i]=random(0, 10);
    snowX[i]=random(0, width);
    snowY[i]=random(0, height);
    spd[i]=random(0.5f, 2);
  }
  fill(255);
  noStroke();
  rect(0, height-ground, width, ground);
}

void draw() {
  background(0);
  snowSpeed();

  for (int i=0; i<count; i++) {
    smooth();
    fill(255-i, 255-i, 0+i);
    noStroke();
    ellipse(snowX[i], snowY[i], size[i], size[i]);
    snowY[i] += spd[i]+result;
    if (snowY[i]>=height) {
      snowX[i]=random(0, width);
      snowY[i]=0;
    }
  }
}

void snowSpeed() {
  if (p.available () > 0) {
    String m = p.readString();
    if (m!=null) {
      background(0);
      stroke(10);
      m = trim(m);
      result = Integer.parseInt(m);
      print(m);
    }
  }
}
