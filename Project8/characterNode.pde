
class characterNode{
   JSONObject character;
   int x, y;
  
  characterNode(JSONObject data) {
    character = data; 
    float x_value = random(width);
    float y_value = random(height);
    x = int(x_value);
    y = int(y_value);
    
  }
  
  void createNode() {
   fill(255);
   ellipse(x, y, 50, 50); 
  }
  
  void printCharacter() {
    
    if(character != null) {
      
      println(character.getString("id"));
      
    }
    
    
  }
  
  
  
  
  
}