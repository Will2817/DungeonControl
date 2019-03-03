import g4p_controls.*;
import http.requests.*;

// Resize tracking
float curHeight, curWidth;

// GUI Items
GTextField textField;
GSlider    widthSlider;
GSlider    heightSlider;
GPanel     mapPanel;
GButton	   fetchButton;

// Map variables
Map map;
PImage img;
float xPos = 0.0f,yPos = 0.0f, zoom = 1.0f;
float mapWidth = 0.75f, mapHeight = 0.8f;
float tileHeight = 29.2f,  maxHeightValue = 75.0f, minHeightValue = 10.0f;
float tileWidth= 25.6f, maxWidthValue = 75.0f, minWidthValue = 10.0f;

// Players
String[] characters = {"9225877", "9049460", "9059016", "9030942"};
ArrayList<Player> players = new ArrayList<Player>();
ArrayList<PlayerView> playerViews = new ArrayList<PlayerView>();

// Setup the stuff (Processing event)
void setup() {
  size(1024,768);
  curHeight = height;
  curWidth = width;
  surface.setResizable(true);

  // Setup GUI
  img = loadImage("Cragmaw Hideout.jpg");
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
  fetchButton = new GButton(this, 15, 200, 100, 40, "Fetch Characters");

  // Setup Map
  float mX = width*(1-mapWidth)/2;
  float mY = 0;
  float mWidth = width*mapWidth + mX;
  float mHeight = height* mapHeight + mY;
  map = new Map(mX, mY, width*mapWidth, height* mapHeight);

  // Setup Players and PlayerViews
  for (int i=0; i < characters.length; i++){
    Player p = new Player(characters[i]);
    players.add(p);
    playerViews.add(new PlayerView(p, i*width/characters.length, height* mapHeight, width/characters.length, height * (1-mapHeight)));
  }
}

// Draw stuff on tick (Processing event)
void draw() {
  if ((curWidth != width) || (curHeight != height)){
    resize();
    curHeight = height;
    curWidth = width;
  }

  background(200);
  translate(xPos,yPos);
  scale(zoom);
  map.drawMap();
  resetMatrix();
  fill(100);
  rect(0,0, map.x, height * map.height);
  rect(map.width + map.x,0, width, height*map.height);
  rect(0,height*map.height + map.x,width, height);
  for (int i=0; i < playerViews.size(); i++){
    playerViews.get(i).draw();
  }
}

// Handle resize events
void resize() {
  if (curWidth != width){
    tileWidth = tileWidth * width/curWidth;
    widthSlider.setValue(tileWidth);
  }
  if (curHeight != height){
    tileHeight = tileHeight * height/curHeight;
    heightSlider.setValue(tileHeight);
  }
  float mX = width*(1-mapWidth)/2;
  float mY = 0;
  float mWidth = width*mapWidth;
  float mHeight = height* mapHeight;
  map.resize(mX,mY,mWidth,mHeight);
  for (int i=0; i < playerViews.size(); i++){
    playerViews.get(i).resize(i*width/characters.length, height* mapHeight, width/characters.length, height * (1-mapHeight));
  }
}

// Handle key presses (Processing event)
void keyPressed() {
  // Reset map position
  if (key == ' '){
    xPos = 0;
    yPos = 0;
    zoom = 1.0f;
  }
}

// Handle mouseDragged events (Processing event)
void mouseDragged() {
  if ((map.x <= mouseX) && (map.x + map.width >= mouseX) &&
      (map.y <= mouseY) && (map.y + map.height >= mouseY)){
    xPos = xPos + (mouseX - pmouseX);
    yPos = yPos + (mouseY - pmouseY);
   }
}

// Handle mouse scroll events (Processing event)
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  zoom = constrain(zoom - e * 0.05, 1, 5);
}

// Handle GUI Slider events (G4P event)
public void handleSliderEvents(GValueControl slider, GEvent event) {
  if (slider == widthSlider) {  // The slider being configured?
    tileWidth = widthSlider.getValueF();
  } else if (slider == heightSlider) {
    tileHeight = heightSlider.getValueF();
  }
}

// Handle GUID Button events (G4P event)
void handleButtonEvents(GButton button, GEvent event) {
   if(button == fetchButton && event == GEvent.CLICKED){
      for (int i=0; i<players.size(); i++){
        players.get(i).fetchCharacter(true);
      }
   }
}