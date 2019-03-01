class Map {
  float xPos, yPos, mapWidth, mapHeight;
  Map(float x, float y, float wid, float hei) {  
    this.xPos = x;
    this.yPos = y;
    this.mapWidth = wid;
    this.mapHeight = hei;
  }
  
  void resize(float x, float y, float wid, float hei){
    this.xPos = x;
    this.yPos = y;
    this.mapWidth = wid;
    this.mapHeight = hei;
  }
  
  void drawMap() {
    image(img, this.xPos, this.yPos, this.mapWidth, this.mapHeight);
    strokeWeight(4);
    stroke(125);
    fill(200,100);
    rect(this.xPos, this.yPos, this.mapWidth, this.mapHeight);
    fill(200,50);
    
    for (int i=0; i <= width/tileWidth; i++){
      for (int j=0; j <= height/tileHeight; j++){
        rect(this.xPos+i*tileWidth, this.yPos+j*tileHeight, tileWidth, tileHeight);
      }
    }
  }

}
