int     nFramesInLoop = 30;
int     nElapsedFrames;
boolean bRecording; 
String  myName = "celinenguyen";
boolean debug = true;

void setup() {
  size (400, 400); 
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
  background (255);
  smooth(); 
  strokeWeight (0);
  
//  rect(100, 100, 200, 200);

  if (debug) {
    // displaying percentage
    fill (100);
    String percentDisplayString = nf(percent, 1, 3);
    text (percentDisplayString, 50, 50);
  }
   
  translate (200, 200);
  percent -= 0.5;
  color[] palette = new color[3];
  palette[0] = #BBF2EB; // mint blue
  palette[1] = #FF9A52; // orange
  palette[2] = #FF5252; // pink
  int paletteIndex = 0;
  while (percent > 0 && percent <= .5) {
    fill(palette[paletteIndex]);
    pushMatrix();
    float rotatingSquareAngle =  (percent * 2) * TWO_PI;
    rotate (rotatingSquareAngle); 
    rect (-100, -100, 200, 200);
    popMatrix();
    percent -= 0.1;
    paletteIndex = (paletteIndex + 1) % 3;
  }
  stroke (255);
  strokeWeight(1);
  fill(255);
  int ellipseSize = 255;
  ellipse(0, 0, ellipseSize, ellipseSize);
}
