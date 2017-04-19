
class ForceGraph {
  // object references
  groupViewer viewer;
  characterViewer charViewer;
  characterNode gravityNode;

  ArrayList<characterNode> cast = new ArrayList<characterNode>(); // holds the references of the nodes in memory
  ArrayList<ArrayList<characterNode>> metaCasts = new ArrayList<ArrayList<characterNode>>(); // holds 10 arrays, one for each group
  
  boolean dataLoaded = false; // one-time flag to ensure data isn't re-loaded 
  
  // dimensions of the graph
  int d0, e0, w, h;
  
  // physics constants
  float attractionConstant = 0.5;
  float repulsionConstant = 100;
  float springLength = 51.0;
  float timeStep = 0.45;
  
  
  int groupSelected = -1; // keeps track of currently selected group
  
  // color chart
  color grey = color(205); 
  color groupOne = color(255, 0, 0); // red
  color groupTwo = color(0, 255, 0); // green
  color groupThree = color(0, 0, 255); // blue
  color groupFour = color(0,255,255); // teal
  color groupFive = color(153,0,153); // purple
  color groupSix = color(204,0,102); // maroon
  color groupSeven = color(255,255,0); // yellow
  color groupEight = color(255,153,153); // salmon
  color groupNine = color(0,51,102); // navy
  color groupTen = color(128,128,128); // grey
  
  
  ForceGraph() {
       
  }
  

  void loadData(JSONObject data) {
      if(data != null && !dataLoaded) {
      JSONArray characters = data.getJSONArray("nodes");
      JSONArray relationships = data.getJSONArray("links");

      gravityNode = new characterNode(this);
      populationCreation(characters);
      createRelationships(relationships);

      println("Loaded data.");
      dataLoaded = true;
    }
    
  }
  
  void setPosition (int _d0, int _e0, int _w, int _h) {
    d0 = _d0;
    e0 = _e0;
    w = _w;
    h = _h;
    if(viewer == null) {
    viewer = new groupViewer(this, d0+w+5, e0, d0+w+150, e0+_h);
    }
    if(charViewer == null && viewer != null) {
     charViewer = new characterViewer(viewer, d0, e0+h+10, d0+w+150, e0+h+135); 
    }
  }
  
  // places characters into nodes, stored into ArrayList
  void populationCreation(JSONArray characters) {
    ArrayList<characterNode> groupOneArray = new ArrayList<characterNode>();
    ArrayList<characterNode> groupTwoArray = new ArrayList<characterNode>();
    ArrayList<characterNode> groupThreeArray = new ArrayList<characterNode>();
    ArrayList<characterNode> groupFourArray = new ArrayList<characterNode>();
    ArrayList<characterNode> groupFiveArray = new ArrayList<characterNode>();
    ArrayList<characterNode> groupSixArray = new ArrayList<characterNode>();
    ArrayList<characterNode> groupSevenArray = new ArrayList<characterNode>();
    ArrayList<characterNode> groupEightArray = new ArrayList<characterNode>();
    ArrayList<characterNode> groupNineArray = new ArrayList<characterNode>();
    ArrayList<characterNode> groupTenArray = new ArrayList<characterNode>();
    
       
    // find all the characters in the JSON file
      for(int i = 0; i < characters.size(); i++) {
         JSONObject individual = characters.getJSONObject(i);
         
         characterNode person = new characterNode(individual, this);
         int colorCode = individual.getInt("group");
         
         
         // assigns color by group
         switch (colorCode) {
           
           case 1: 
                   person.setColor(groupOne);
                   person.groupColor = groupOne;
                   groupOneArray.add(person);
                   break;
           
           case 2: 
                   person.setColor(groupTwo);
                   person.groupColor = groupTwo;
                   groupTwoArray.add(person);
                   break;
           
           case 3: 
                   person.setColor(groupThree);
                   person.groupColor = groupThree;
                   groupThreeArray.add(person);
                   break;
           
           case 4:
                   person.setColor(groupFour);
                   person.groupColor = groupFour;
                   groupFourArray.add(person);
                   break;
           
           case 5: 
                   person.setColor(groupFive);
                   person.groupColor = groupFive;
                   groupFiveArray.add(person);
                   break;
           
           case 6: 
                   person.setColor(groupSix);
                   person.groupColor = groupSix;
                   groupSixArray.add(person);
                   break;
           
           case 7: 
                   person.setColor(groupSeven);
                   person.groupColor = groupSeven;
                   groupSevenArray.add(person);
                   break;
           
           case 8:
                   person.setColor(groupEight);
                   person.groupColor = groupEight;
                   groupEightArray.add(person);
                   break;
           
           case 9:
                   person.setColor(groupNine);
                   person.groupColor = groupNine;
                   groupNineArray.add(person);
                   break;
           
           case 10:
                   person.setColor(groupTen);
                   person.groupColor = groupTen;
                   groupTenArray.add(person);
                   break;
                   
         }
           
         cast.add(person);
         
       }
       
       // add finished lists into 2D array
       metaCasts.add(groupOneArray);
       metaCasts.add(groupTwoArray);
       metaCasts.add(groupThreeArray);
       metaCasts.add(groupFourArray);
       metaCasts.add(groupFiveArray);
       metaCasts.add(groupSixArray);
       metaCasts.add(groupSevenArray);
       metaCasts.add(groupEightArray);
       metaCasts.add(groupNineArray);
       metaCasts.add(groupTenArray);
   
    
  }
  
  // creates relationships, and places them in each individual node
  void createRelationships(JSONArray relationships) {
    
    for (int i = 0; i < cast.size(); i++) {
      characterNode individual = cast.get(i);
      
         // check for the relationships this character has
         for(int j = 0; j < relationships.size(); j++) {
           
            JSONObject chain = relationships.getJSONObject(j);
            
            if(individual.character.getString("id").equals(chain.getString("source"))){
               individual.addRelationship(chain.getString("target"), cast);
            }
         }
         
         individual.addRelationship(gravityNode);
    }
    

  }
  
  // show lines between each node that has a relationship to each other
  void drawLines() {
    
    for(characterNode character : cast) {
      character.drawLine();
    }
    
    
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
      int check = 0;
      
       // restricts the draw function to the dimensions of the graph
      float plotMinD = d0;
      float plotMaxD = d0 + w;
      float plotMinE = e0 + h;
      float plotMaxE = e0;

      fill(255);
      rectMode(CORNERS);
      
      rect ( plotMinD, plotMaxE, plotMaxD, plotMinE); //border
      drawLines();

      // iterate through all nodes
      for (characterNode node : cast) {
        check = node.character.getInt("group");
        check--;
        
        if(check != groupSelected && groupSelected != -1){ // if this is not the selected group, assuming we have one
          node.setColor(grey); // make it grey to allow for highlighting of selected group
        }
          node.calculatePosition(cast);
          node.draw();

      }      
      viewer.draw();
      charViewer.fillRoles(metaCasts); 
      charViewer.draw();
  } 
}