
class ForceGraph {
  
  ArrayList<characterNode> cast = new ArrayList<characterNode>(); // holds the references of the nodes in memory
  
  characterNode gravityNode;
  
  boolean dataLoaded = false;
  
  // dimensions of the graph
  int d0, e0, w, h;
  
  float attractionConstant = 0.005;
  float repulsionConstant = 0.01;
  float springLength = 51.0;
  float timeStep = 0.75;
  
  boolean placed = false;
  
  // color chart
  color grey = color(205);
  color groupOne = color(255, 0, 0);
  color groupTwo = color(0, 255, 0);
  color groupThree = color(0, 0, 255);
  color groupFour = color(0,0,0);
  color groupFive = color(0,0,0);
  color groupSix = color(0,0,0);
  color groupSeven = color(0,0,0);
  color groupEight = color(0,0,0);
  color groupNine = color(0,0,0);
  color groupTen = color(0,0,0);
  
  ForceGraph() {
       
  }
  
  void loadData(JSONObject data) {
      if(data != null && !dataLoaded) {
      JSONArray characters = data.getJSONArray("nodes");
      JSONArray relationships = data.getJSONArray("links");
      for (int i = 0; i < relationships.size(); i++) {
        JSONObject object = relationships.getJSONObject(i);
//        println(object.getString("source"));
        
      }
      gravityNode = new characterNode(this);
      populationCreation(characters);
      createRelationships(relationships);


      println("Loaded data.");
      dataLoaded = true;
    }
    
  }
  
  // places characters into nodes, stored into ArrayList
  void populationCreation(JSONArray characters) {
       
    // find all the characters in the JSON file
      for(int i = 0; i < characters.size(); i++) {
         JSONObject individual = characters.getJSONObject(i);
         
         characterNode person = new characterNode(individual, this);
         int colorCode = individual.getInt("group");
         
         switch (colorCode) {
           
           case 1: 
                   person.setColor(groupOne);
                   break;
           
           case 2: 
                   person.setColor(groupTwo);
                   break;
           
           case 3: 
                   person.setColor(groupThree);
                   break;
           
           case 4:
                   person.setColor(groupFour);
                   break;
           
           case 5: 
                   person.setColor(groupFive);
                   break;
           
           case 6: 
                   person.setColor(groupSix);
                   break;
           
           case 7: 
                   person.setColor(groupSeven);
                   break;
           
           case 8:
                   person.setColor(groupEight);
                   break;
           
           case 9:
                   person.setColor(groupNine);
                   break;
           
           case 10:
                   person.setColor(groupTen);
                   break;
                   
         }
           
         cast.add(person);
         
       }
    
  }
  
  // creates relationships, and places them in each individual node
  void createRelationships(JSONArray relationships) {
    
    for (int i = 0; i < cast.size(); i++) {
      characterNode individual = cast.get(i);
      
         // check for the relationships this character has
         for(int j = 0; j < relationships.size(); j++) {
           
            JSONObject chain = relationships.getJSONObject(j);
            
//            println(i + ", " + j + ": " + individual.character.getString("id") + " vs. " + chain.getString("source"));
            if(individual.character.getString("id").equals(chain.getString("source"))){
//              println("Found link.");
               individual.addRelationship(chain.getString("target"), cast);
            }
         }
         
         individual.addRelationship(gravityNode);
    }
    

  }
  
    
  void drawLines() {
    
    for(characterNode character : cast) {
     // println(character.character.getString("id")); <- working
      character.drawLine();
    }
    
    
  }
  
  void setPosition (int _d0, int _e0, int _w, int _h) {
    d0 = _d0;
    e0 = _e0;
    w = _w;
    h = _h;
   
  }
  
  void createCast() {
    if(cast != null) {
        
      for(characterNode actor : cast) {
        actor.createNode();
      }
      
    }
    
  }
  
  void printCast() {
    if (cast != null) {
      
     for(characterNode actor : cast) {
        actor.printCharacter();
     }
     
    }
    
  }
  
  

  

  
  
  void draw() {
    
       // restricts the draw function to the dimensions of the graph
      float plotMinD = d0;
      float plotMaxD = d0 + w;
      float plotMinE = e0 + h;
      float plotMaxE = e0;
//      characterNode node = cast.get(5);
//      characterNode node2 = cast.get(15);
            fill(255);
      rectMode(CORNERS);
      
      rect ( plotMinD, plotMaxE, plotMaxD, plotMinE); //border
//      createCast();
      drawLines();
//      calculateAttractions();
//      calculateRepulsions();

//      calculateAttractions();
//      attractionFunction();
      for (characterNode node : cast) {
        node.calculatePosition(cast);
         node.createNode();
//         node2.createNode();

      }      
  } 
}