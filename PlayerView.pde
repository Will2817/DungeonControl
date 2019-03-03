static class PlayerViewSize {
  static float width = 0f;
  static float height = 0f;

  static void resize(float _width, float _height) {
    width = _width;
    height = _height;
  }
}

class PlayerView extends PlayerViewSize {
  Player player;

  PlayerView(Player _player){
    this.player = _player;
  }

  void draw() {
    fill(200);
    textSize(16);
    rect(0,0,this.width,this.height);
    image(this.player.avatar, 0,0, this.width * 0.4, this.height);
    fill(50);
    text(this.player.name, this.width * 0.42, 20);
    String healthStr = "Hit Points: "+this.player.curHealth + "/" + this.player.maxHealth;
    if (this.player.tempHealth > 0){
      healthStr += " (+" + this.player.tempHealth + ")";
    }
    text(healthStr, this.width * 0.42, 40);
    noFill();
    strokeWeight(2);
    stroke(100);
    rect(this.width * 0.42, 60, this.width * 0.50, 30);
    noStroke();
    fill(200,20,20);
    float healthPercentage = 1.0f * this.player.curHealth / this.player.maxHealth;
    rect(this.width * 0.42, 60, healthPercentage * this.width * 0.50, 30);
    textSize(32);
    fill(0);
    text(this.player.ac, this.width * 0.60, 135);

  }
}