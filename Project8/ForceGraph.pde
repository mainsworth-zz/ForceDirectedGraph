
class ForceGraph {
  
  ArrayList<characterNode> cast = new ArrayList<characterNode>();
  boolean dataLoaded = false;
  // dimensions of the graph
  int d0, e0, w, h;
  
  ForceGraph() {
       
  }
  
  void loadData(JSONObject data) {
      if(data != null && !dataLoaded) {
      JSONArray characters = data.getJSONArray("nodes");
      JSONArray relationships = data.getJSONArray("links");
      
      int k;
      // find all the characters in the JSON file
      for(int i = 0; i < characters.size(); i++) {
         k = 0; // resets the counter, to start new "links" array at 0
         JSONObject individual = characters.getJSONObject(i);
         JSONArray links = new JSONArray();
         
         // check for the relationships this character has
         for(int j = 0; j < relationships.size(); j++)
         {
            JSONObject chain = relationships.getJSONObject(i);
            if(individual.getString("id") == chain.getString("source")){
               links.setJSONObject(k, chain);
               k++;
            }
         }
         characterNode person = new characterNode(individual, links, this);
         cast.add(person);
         
       }
      println("Loaded data.");
      dataLoaded = true;
    }
    
  }
  
  void setPosition (int _d0, int _e0, int _w, int _h) {
    d0 = _d0;
    e0 = _e0;
    w = _w;
    h = _h;
   
  }
  
  void printCast() {
    if(cast != null) {
        
      for(characterNode actor : cast) {
        actor.printCharacter();
        actor.createNode();
      }
      
    }
    
  }
  
  void draw() {
    
       // restricts the draw function to the dimensions of the graph
      float plotMinD = d0;
      float plotMaxD = d0 + w;
      float plotMinE = e0 + h;
      float plotMaxE = e0;
            fill(255);
      rectMode(CORNERS);
      
      rect ( plotMinD, plotMaxE, plotMaxD, plotMinE); //border
  } 
}