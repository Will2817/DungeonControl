class Player {
  String id;
  JSONObject characterData;
  boolean readFromFile;
  float x,y,width,height;
  PImage avatar;
  Player(String _id, boolean fromFile, float x,float y,float width,float height) {
    this.id = _id;
    this.readFromFile = fromFile;
    fetchCharacter();
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }

  void fetchCharacter() {
    if (this.readFromFile) {
      println(id+".json");
      this.characterData = loadJSONObject(id+".json");
    } else {
      GetRequest get = new GetRequest("http://www.dndbeyond.com/character/"+this.id+"/json");
      get.send(); // program will wait untill the request is completed
      this.characterData = parseJSONObject(get.getContent());
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
    int health = this.characterData.getInt("baseHitPoints");
    int damage = this.characterData.getInt("removedHitPoints");
    int curHealth = health - damage;
    int tempHealth = this.characterData.getInt("temporaryHitPoints");
    String healthStr = "Health: "+curHealth + "/" + health;
    if (tempHealth > 0){
      healthStr += " (+" + tempHealth + ")";
    }
    text(healthStr, this.x + this.width * 0.42, this.y + 40);
  }
}