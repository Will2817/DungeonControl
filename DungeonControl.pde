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
float xPos = 0.0f,yPos = 0.0f, zoom = 1.0f;
float mX, mWidth, mY, mHeight;
Map map;
PImage avatar;

void setup() {
  size(1024,768);
  curHeight = height;
  curWidth = width;
  
  surface.setResizable(true);
  img = loadImage("Cragmaw Hideout.jpg");
  avatar = loadImage("https://media-waterdeep.cursecdn.com/avatars/thumbnails/10/93/150/150/636339382612972808.png", "png");
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
  
  mX = width*(1-mapWidth)/2;
  mY = 0;
  mWidth = width*mapWidth + mX;
  mHeight = height* mapHeight + mY;
  map = new Map(mX, mY, width*mapWidth, height* mapHeight);
}
void draw() {
  background(200);
  translate(xPos,yPos);
  scale(zoom);
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
  mX = width*(1-mapWidth)/2;
  mY = 0;
  mWidth = width*mapWidth;
  mHeight = height* mapHeight;
  map.resize(mX,mY,mWidth,mHeight);
  map.drawMap();
  resetMatrix();
  fill(100);
  rect(0,0, mX, height* mapHeight);
  rect(mWidth + mX,0, width, height*mapHeight);
  rect(0,height*mapHeight + mY,width, height);
  image(avatar, 100, 600, 50, 50);
}

void keyPressed() {
  if (key == ' '){
    xPos = 0;
    yPos = 0;
    zoom = 1.0f;
  }
}

void mouseDragged() {
  if ((mX <= mouseX) && (mWidth >= mouseX) && (mY <= mouseY) && (mHeight >= mouseY)){
    xPos = xPos + (mouseX - pmouseX);
    yPos = yPos + (mouseY - pmouseY);
   }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  zoom = constrain(zoom - e * 0.05, 1, 5);
}

public void handleSliderEvents(GValueControl slider, GEvent event) { 
  if (slider == widthSlider) {  // The slider being configured?
    tileWidth = widthSlider.getValueF();
  } else if (slider == heightSlider) {
    tileHeight = heightSlider.getValueF();
  }
    //println(sdr.getValueS() + "    " + event);    
}
