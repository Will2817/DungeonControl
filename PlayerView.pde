class PlayerView {
  Player player;
  float x,y, width, height;

  PlayerView(Player _player,float _x,float _y,float _width,float _height){
    this.player = _player;
    this.x = _x;
    this.y = _y;
    this.width = _width;
    this.height = _height;
  }

  void draw() {
    fill(200);
    rect(this.x,this.y,this.width,this.height);
    image(this.player.avatar, this.x,this.y, this.width * 0.4, this.height);
    fill(50);
    text(this.player.name, this.x + this.width * 0.42, this.y + 20);
    String healthStr = "Health: "+this.player.curHealth + "/" + this.player.maxHealth;
    if (this.player.tempHealth > 0){
      healthStr += " (+" + this.player.tempHealth + ")";
    }
    text(healthStr, this.x + this.width * 0.42, this.y + 40);
    noFill();
    stroke(2);
    rect(this.x + this.width * 0.42, this.y + 60, this.width * 0.50, 30);
    noStroke();
    fill(200,20,20);
    float healthPercentage = 1.0f * this.player.curHealth / this.player.maxHealth;
    rect(this.x + this.width * 0.42, this.y + 60, healthPercentage * this.width * 0.50, 30);
  }
}