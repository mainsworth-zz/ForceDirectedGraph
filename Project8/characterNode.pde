
class characterNode {

   ForceGraph graphReference;
   JSONObject character; // data structure for character values
   ArrayList<characterLink> relationships = new ArrayList<characterLink>();
   int x, y;
   int size = 30;
   color nodeColor;
  
  
  
  characterNode(JSONObject data, ForceGraph reference) {
    graphReference = reference;
    character = data; 
    float x_value = random(reference.d0+size, reference.d0 + reference.w-size);
    float y_value = random(reference.e0+size, reference.e0 + reference.h-size);
    x = int(x_value);
    y = int(y_value);
    
  }
  
  void createNode() {
   fill(nodeColor);
   ellipse(x, y, size, size); 
  }
  
  
  void setColor(color newColor) {
   
    nodeColor = newColor;
  }
  
  void addRelationship(String nameTarget, ArrayList<characterNode> cast) {
    for(int i = 0; i < cast.size(); i++) {
      characterNode target = cast.get(i);
      
      // found target
//      println(target.character.getString("id") + " == " + nameTarget);
      if(target.character.getString("id").equals(nameTarget)) {
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
   for(characterLink link : relationships) {
     x2 = link.target.x;
     y2 = link.target.y;
     
     line(x1, y1, x2, y2);
   }
    
  }
  
  void printCharacter() {
    
    if(character != null) {
      
      println(character.getString("id"));
      
    }
    
    
  }
  
  void updatePosition(int _x, int _y) {

    // binds to dimensions of graph
   if ((x+size-5) < (graphReference.d0 + graphReference.w) && (x-size+5) > graphReference.d0) {     
   
     x = _x;
 
   }
   
   if ((y+size-5) < graphReference.e0 + graphReference.h && (y-size+5) > graphReference.e0) {

     y = _y; 
    
   }

   
  }
  
  
  
}