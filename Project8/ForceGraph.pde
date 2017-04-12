
class ForceGraph{
  
  JSONArray relationships;
  ArrayList<characterNode> cast = new ArrayList<characterNode>();
  
  // dimensions of the graph
  int d0, e0, w, h;
  
  ForceGraph() {
       
  }
  
  void loadData(JSONObject data) {
      if(data != null && relationships == null) {
      JSONArray characters = data.getJSONArray("nodes");
      for(int i = 0; i < characters.size(); i++) {
         JSONObject individual = characters.getJSONObject(i);
         characterNode person = new characterNode(individual);
         cast.add(person);
         
       }
      relationships = data.getJSONArray("links");
      println("Loaded data.");
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