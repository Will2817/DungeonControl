import g4p_controls.*;

GTextField textField;
GSlider    widthSlider;
GSlider    heightSlider;
GPanel     mapPanel;

float mapWidth = 0.75f, mapHeight = 0.8f;
float tileHeight = 29.2f,  maxHeightValue = 75.0f, minHeightValue = 10.0f;
float tileWidth= 25.6f, maxWidthValue = 75.0f, minWidthValue = 10.0f;
boolean sliderSelected = false;
PImage img;
float curHeight, curWidth;

void setup() {
  size(1024,768);
  curHeight = height;
  curWidth = width;
  surface.setResizable(true);
  img = loadImage("Cragmaw Hideout.jpg");
  //textField = new GTextField(this, 5, 5, 50, 20);
  //textField.setText(str(tileWidth));
  widthSlider = new GSlider(this, 15,50,100,60,15);
  widthSlider.setLimits(tileWidth, minWidthValue, maxWidthValue);
  widthSlider.setShowValue(true);
  widthSlider.setShowTicks(true);
  widthSlider.setShowLimits(true);
  heightSlider = new GSlider(this, 15,120,100,60,15);
  heightSlider.setLimits(tileHeight, minHeightValue, maxHeightValue);
  heightSlider.setShowValue(true);
  heightSlider.setShowTicks(true);
  heightSlider.setShowLimits(true);
  mapPanel = new GPanel(this, width*(1-mapWidth)/2, 0, width*mapWidth, height* mapHeight);
  mapPanel.setDraggable(true);
}
void draw() {
  background(200);
  if (curWidth != width){
    tileWidth = tileWidth * width/curWidth;
    widthSlider.setValue(tileWidth);
  }
  if (curHeight != height){
    tileHeight = tileHeight * height/curHeight;
    heightSlider.setValue(tileHeight);
  }
  curHeight = height;
  curWidth = width;
  drawGrid(width*(1-mapWidth)/2, 0, width*mapWidth, height* mapHeight);
}

void drawGrid(float xpos, float ypos, float width, float height) {
  image(img, xpos, ypos, width, height);
  strokeWeight(4);
  stroke(125);
  fill(200,100);
  rect(xpos, ypos, width, height);
  fill(200,50);
  for (int i=0; i <= width/tileWidth; i++){
    for (int j=0; j <= height/tileHeight; j++){
      rect(xpos+i*tileWidth, ypos+j*tileHeight, tileWidth, tileHeight);
    }
  }
}

public void handleSliderEvents(GValueControl slider, GEvent event) { 
  if (slider == widthSlider) {  // The slider being configured?
    tileWidth = widthSlider.getValueF();
  } else if (slider == heightSlider) {
    tileHeight = heightSlider.getValueF();
  }
    //println(sdr.getValueS() + "    " + event);    
}
