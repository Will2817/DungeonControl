class Player {
  String id;
  JSONObject characterData;
  String name;
  int con;
  int maxHealth, damage, curHealth, tempHealth;
  PImage avatar;
  Player(String _id) {
    this.id = _id;
    fetchCharacter(false);
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
    this.name = this.characterData.getString("name");
    this.avatar = loadImage(this.characterData.getString("avatarUrl"));
    this.con = this.characterData.getJSONArray("stats").getJSONObject(2).getInt("value");
    this.maxHealth = this.characterData.getInt("baseHitPoints") + floor((con-10) / 2.0f);
    this.damage = this.characterData.getInt("removedHitPoints");
    this.curHealth = this.maxHealth - this.damage;
    this.tempHealth = this.characterData.getInt("temporaryHitPoints");

    println("Player name: " + this.name);
  }

  void saveCharacter(){
    saveJSONObject(this.characterData, id+".json");
  }
}