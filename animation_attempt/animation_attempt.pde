int     nFramesInLoop = 10;
int     nElapsedFrames;
boolean bRecording; 
String  myName = "celinenguyen";
boolean debug = false;
int     canvasSize = 500; // 500/1500
int     strokeSize = 2; // 2, 6
int     ellipseSize = 6; // 6, 18

float[] quadrantLength = new float[3];


void setup() {
  size (canvasSize, canvasSize); 
  bRecording = false;
  nElapsedFrames = 0;
  frameRate (nFramesInLoop);
}

void keyPressed() { 
  bRecording = true;
  nElapsedFrames = 0;
}

//===================================================
void draw() {
  // compute a percentage (0...1) representing where we are in the loop.
  float percentCompleteFraction = 0; 
  if (bRecording) {
    percentCompleteFraction = (float) nElapsedFrames / (float)nFramesInLoop;
  } 
  else {
    float modFrame = (float) (frameCount % nFramesInLoop);
    percentCompleteFraction = modFrame / (float)nFramesInLoop;
  }
  // render the design based on that percentage. 
  renderMyDesign (percentCompleteFraction);
  // if we're recording, save the frame to a file. 
  if (bRecording) {
    saveFrame("output/"+ myName + "-loop-" + nf(nElapsedFrames, 4) + ".png");
    nElapsedFrames++; 
    if (nElapsedFrames == nFramesInLoop) {
      bRecording = false;
    }
  }
}

//===================================================
void renderMyDesign (float percent) {
  float changingOpacity = sin(percent * (PI * 2)) * 255;
  quadrantLength[0] = 350 * (1 * sin(percent - 0.5)); // 350/1200
  quadrantLength[1] = 300 * (1 * sin(percent - 0.5)); // 300/1100
  quadrantLength[2] = 200 * (1 * sin(percent - 0.5)); // 200/800
  
  background(#1D1921); // dark purple
  smooth(); 
  strokeWeight (0);
  fill(#1F2638, changingOpacity);
  rect(0, 0, canvasSize, canvasSize);

  if (debug) {
    // displaying percentage
    fill(255);
    String percentDisplayString = nf(percent, 1, 3);
    text (percentDisplayString, 50, 50);
  }

  translate (canvasSize / 2, canvasSize / 2);
  color[] palette = new color[3];
  palette[0] = #E6E3BA;
  palette[1] = #ABA86A;
  palette[2] = #9C9628;
  int paletteIndex = 0;

  float length, x, y;
  fill(255, changingOpacity);

  int quadrantCount = 0;
  for (float i = 0.0; i < (2 * PI); i = i + (PI / 2)) {
    stroke(palette[0], changingOpacity);
    length = quadrantLength[0];
    strokeWeight (strokeSize);
    x = length * cos(i);
    y = length * sin(i);
    line (0, 0, x, y);
    strokeWeight (0);
    ellipse(x, y, ellipseSize, ellipseSize);
  } 
  for (float i = (PI / 4); i < (2 * PI); i = i + (PI / 2)) {
    stroke(palette[1], changingOpacity);
    length = quadrantLength[1];
    strokeWeight (strokeSize);
    x = length * cos(i);
    y = length * sin(i);
    line (0, 0, x, y);
    strokeWeight (0);
    ellipse(x, y, ellipseSize, ellipseSize);
  } 
  for (float i = (PI / 8); i < (2 * PI); i = i + ((2 * PI) / 8)) {
    stroke(palette[2], changingOpacity);
    length = quadrantLength[2];
    strokeWeight (strokeSize);
    x = length * cos(i);
    y = length * sin(i);
    line (0, 0, x, y);
    strokeWeight (strokeSize);
    ellipse(x, y, ellipseSize, ellipseSize);
  } 
}

