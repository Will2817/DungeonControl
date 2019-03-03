class Map {
  float x, y, width, height;
  Map(float x, float y, float wid, float hei) {
    this.x = x;
    this.y = y;
    this.width = wid;
    this.height = hei;
  }

  void resize(float x, float y, float wid, float hei){
    this.x = x;
    this.y = y;
    this.width = wid;
    this.height = hei;
  }

  void drawMap() {
    image(img, this.x, this.y, this.width, this.height);
    strokeWeight(4);
    stroke(125);
    fill(200,100);
    rect(this.x, this.y, this.width, this.height);
    fill(200,50);

    for (int i=0; i <= this.width/tileWidth; i++){
      for (int j=0; j <= this.height/tileHeight; j++){
        rect(this.x+i*tileWidth, this.y+j*tileHeight, tileWidth, tileHeight);
      }
    }
  }

}
