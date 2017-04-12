
class characterNode{

   ForceGraph graphReference;
   JSONObject character; // data structure for character values
   ArrayList<characterLink> relationships = new ArrayList<characterLink>();
   int x, y;
   int size = 30;
  
  characterNode(JSONObject data, ForceGraph reference) {
    graphReference = reference;
    character = data; 
    float x_value = random(reference.d0+size, reference.d0 + reference.w-size);
    float y_value = random(reference.e0+size, reference.e0 + reference.h-size);
    x = int(x_value);
    y = int(y_value);
    
  }
  
  void createNode() {
   fill(205);
   ellipse(x, y, size, size); 
  }
  
  void addRelationship(String nameTarget, ArrayList<characterNode> cast) {
    for(int i = 0; i < cast.size(); i++) {
      characterNode target = cast.get(i);
      
      // found target
      println(target.character.getString("id") + " == " + nameTarget);
      if(target.character.getString("id") == nameTarget) {
         println("Found match.");
         characterLink newRelationship = new characterLink(target);
         relationships.add(newRelationship);
         break;
      }
      
    }


  }

  void drawLine() {
    int x1, x2, y1, y2;
    x1 = x;
    y1 = y;
    println(relationships.size());
   for(characterLink link : relationships) {
     x2 = link.target.x;
     y2 = link.target.y;
     
     line(x1, y1, x2, y2);
     println(x1 + ", " + y1 + " and " + x2 + ", " + y2);
   }
    
  }
  
  void printCharacter() {
    
    if(character != null) {
      
      println(character.getString("id"));
      
    }
    
    
  }
  
  
  
  
  
}