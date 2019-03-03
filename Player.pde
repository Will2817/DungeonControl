class Player {
  String id;
  JSONObject characterData;
  String name;
  int dex, con, wis;
  int ac;
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

    JSONArray stats = this.characterData.getJSONArray("stats");
    this.dex = stats.getJSONObject(1).getInt("value");
    this.con = stats.getJSONObject(2).getInt("value");
    this.wis = stats.getJSONObject(4).getInt("value");
    JSONArray raceMods = this.characterData.getJSONObject("modifiers").getJSONArray("race");
    for (int i=0; i < raceMods.size(); i++){
      JSONObject mod = raceMods.getJSONObject(i);
      switch (mod.getString("subType")){
        case "dexterity-score":
          this.dex += mod.getInt("value");
          break;
        case "constitution-score":
          this.con += mod.getInt("value");
          break;
        case "wisdom-score":
          this.wis += mod.getInt("value");
          break;
      }
    }
    JSONArray featMods = this.characterData.getJSONObject("modifiers").getJSONArray("feat");
    for (int i=0; i < featMods.size(); i++){
      JSONObject mod = featMods.getJSONObject(i);
      switch (mod.getString("subType")){
        case "dexterity-score":
          this.dex += mod.getInt("value");
          break;
        case "constitution-score":
          this.con += mod.getInt("value");
          break;
        case "wisdom-score":
          this.wis += mod.getInt("value");
          break;
      }
    }

    this.maxHealth = this.characterData.getInt("baseHitPoints") + floor((con-10) / 2.0f);
    this.damage = this.characterData.getInt("removedHitPoints");
    this.curHealth = this.maxHealth - this.damage;
    this.tempHealth = this.characterData.getInt("temporaryHitPoints");
    this.calculateAC();

    println("Player name: " + this.name);
  }

  void calculateAC() {
    boolean isHeavy = false, isMonk;
    int shieldValue = 0, armorValue = 10;
    JSONArray inventory = this.characterData.getJSONArray("inventory");
    for (int i = 0; i < inventory.size(); i++) {
      JSONObject item = inventory.getJSONObject(i);
      if (item.getBoolean("equipped")) {
        JSONObject definition = item.getJSONObject("definition");
        if (definition.getString("filterType").equals("Armor")) {

          switch (definition.getString("type")) {
            case "Shield":
              shieldValue = definition.getInt("armorClass");
              break;
            case "Heavy Armor":
              isHeavy = true;
            case "Medium Armor":
            case "Light Armor":
              armorValue = definition.getInt("armorClass");
              break;
          }
        }
      }
    }
    JSONArray classes = this.characterData.getJSONArray("classes");
    isMonk = classes.getJSONObject(0).getJSONObject("definition").getString("name").equals("Monk");
    this.ac = armorValue + shieldValue;
    this.ac += isHeavy ? 0 : floor((this.dex-10) / 2.0f);
    println("Wisdom: " + this.wis);
    this.ac += (isMonk && armorValue == 10) ? floor((this.wis - 10)/2.0f) : 0;
  }

  void saveCharacter(){
    saveJSONObject(this.characterData, id+".json");
  }
}