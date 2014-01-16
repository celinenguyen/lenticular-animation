int     nFramesInLoop = 30;
int     nElapsedFrames;
boolean bRecording; 
String  myName = "celinenguyen";
 
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
  // Compute a percentage (0...1) representing where we are in the loop.
  float percentCompleteFraction = 0; 
  if (bRecording) {
    percentCompleteFraction = (float) nElapsedFrames / (float)nFramesInLoop;
  } 
  else {
    float modFrame = (float) (frameCount % nFramesInLoop);
    percentCompleteFraction = modFrame / (float)nFramesInLoop;
  }
  // Render the design, based on that percentage. 
  renderMyDesign (percentCompleteFraction);
  // If we're recording the output, save the frame to a file. 
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
  // here, I set the background and some other graphical properties
  background (255);
  smooth(); 
  stroke (0, 0, 0); 
  strokeWeight (2);
  
  rect(100, 100, 200, 200);
   
  translate (200, 200);
  percent -= 0.3;
  while (percent > 0) {
    pushMatrix();
    float rotatingSquareAngle =  percent * TWO_PI;
    rotate (rotatingSquareAngle); 
    rect (-100, -100, 200, 200);
    popMatrix();
    percent -= 0.1;
  }
  stroke (255, 0, 0);
  ellipse(250, 250, 100, 100);
}
