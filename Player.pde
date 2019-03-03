class Player {
  String id;
  JSONObject characterData;
  float x,y,width,height;
  PImage avatar;
  Player(String _id, float x,float y,float width,float height) {
    this.id = _id;
    fetchCharacter(false);
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }

  void fetchCharacter(boolean fromURL) {
    if (fromURL) {
      try {
        GetRequest get = new GetRequest("http://www.dndbeyond.com/character/"+this.id+"/json");
        get.send(); // program will wait untill the request is completed
        this.characterData = parseJSONObject(get.getContent());
        this.saveCharacter();
        println("Fetched character: " + this.id);
      } catch (Exception e){
        println("failed to fetch character: " + this.id);
      }
    } else {
      this.characterData = loadJSONObject(id+".json");
    }
    this.avatar = loadImage(this.characterData.getString("avatarUrl"));
    println("Player name: " + this.characterData.getString("name"));
  }

  void saveCharacter(){
    saveJSONObject(this.characterData, id+".json");
  }

  void draw() {
    fill(200);
    rect(this.x,this.y,this.width,this.height);
    image(this.avatar, this.x,this.y, this.width * 0.4, this.height);
    fill(50);
    text(this.characterData.getString("name"), this.x + this.width * 0.42, this.y + 20);
    int con = this.characterData.getJSONArray("stats").getJSONObject(2).getInt("value");
    int health = this.characterData.getInt("baseHitPoints") + floor((con-10) / 2.0f);
    int damage = this.characterData.getInt("removedHitPoints");
    int curHealth = health - damage;
    int tempHealth = this.characterData.getInt("temporaryHitPoints");
    String healthStr = "Health: "+curHealth + "/" + health;
    if (tempHealth > 0){
      healthStr += " (+" + tempHealth + ")";
    }
    text(healthStr, this.x + this.width * 0.42, this.y + 40);
    noFill();
    stroke(2);
    rect(this.x + this.width * 0.42, this.y + 60, this.width * 0.50, 30);
    noStroke();
    fill(200,20,20);
    float healthPercentage = 1.0f * curHealth / health;
    rect(this.x + this.width * 0.42, this.y + 60, healthPercentage * this.width * 0.50, 30);
  }
}