
class characterNode{

   ForceGraph graphReference;
  
   JSONObject character;
   JSONArray relationships;
   int x, y;
   int size = 30;
  
  characterNode(JSONObject data, JSONArray _relationships, ForceGraph reference) {
    graphReference = reference;
    character = data; 
    relationships = _relationships;
    float x_value = random(reference.d0+size, reference.d0 + reference.w-size);
    float y_value = random(reference.e0+size, reference.e0 + reference.h-size);
    x = int(x_value);
    y = int(y_value);
    
  }
  
  void createNode() {
   fill(205);
   ellipse(x, y, size, size); 
  }
  
  void printCharacter() {
    
    if(character != null) {
      
      println(character.getString("id"));
      
    }
    
    
  }
  
  
  
  
  
}