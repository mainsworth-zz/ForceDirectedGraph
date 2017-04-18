
class characterNode {

   ForceGraph graphReference;
   JSONObject character; // data structure for character values
   ArrayList<characterLink> relationships = new ArrayList<characterLink>();
   
   PVector coordinates = new PVector();
   
   int nodeSize = 30;
   float mass = 350.0;
   PVector velocity = new PVector();
   color nodeColor;
   
   float repulsionConstant;
   float attractionConstant;
   float springLength;
   float timeStep;
  
  int sumRepulsions = 0;
  
  characterNode(ForceGraph reference) { // overloaded constructor for center, invisible node
    float x_value = (reference.d0 + reference.w)/2;
    float y_value = (reference.e0 + reference.h)/2;
    coordinates.set(x_value, y_value);
    
  }
  
  characterNode(JSONObject data, ForceGraph reference) {
    graphReference = reference;
    character = data; 
    float x_value = random(reference.d0+nodeSize, reference.d0 + reference.w-nodeSize);
    float y_value = random(reference.e0+nodeSize, reference.e0 + reference.h-nodeSize);
    
    coordinates.set(x_value, y_value);
    repulsionConstant = graphReference.repulsionConstant;
    attractionConstant  = graphReference.attractionConstant;
    springLength = graphReference.springLength;
    timeStep = graphReference.timeStep;
    
  }
  
  void createNode() {
   fill(nodeColor);
   ellipse(coordinates.x, coordinates.y, nodeSize, nodeSize); 
  }
  
  
  void setColor(color newColor) {
   
    nodeColor = newColor;
  }
  
  void addRelationship(characterNode node) {
    characterLink newRelationship = new characterLink(this, node);
    relationships.add(newRelationship);
    
  }
  
  void addRelationship(String nameTarget, ArrayList<characterNode> cast) {
    for(int i = 0; i < cast.size(); i++) {
      characterNode target = cast.get(i);
      
      // found target
//      println(target.character.getString("id") + " == " + nameTarget);
      if(target.character.getString("id").equals(nameTarget)) {
         characterLink newRelationship = new characterLink(this, target);
         relationships.add(newRelationship);
         break;
      }
      
    }


  }

  void drawLine() {
    float x1, x2, y1, y2;
    x1 = coordinates.x;
    y1 = coordinates.y;
   for(int i = 0; i < relationships.size(); i++) {
     x2 = relationships.get(i).target.coordinates.x;
     y2 = relationships.get(i).target.coordinates.y;
     
     line(x1, y1, x2, y2);
   }
    
  }
  
  void printCharacter() {
    
    if(character != null) {
      
      println(character.getString("id"));
      
    }
    
    
  }
  
    PVector calculateRepulsions(ArrayList<characterNode> cast) {

     float value = 0.0;
     PVector sumVectors = new PVector(0,0);
     PVector directionalVector;
     PVector newTest;
     PVector mouseCursor = new PVector(mouseX, mouseY);
//     characterNode character2 = cast.get(15);

      
      for (characterNode character2 : cast) {
        if(coordinates.dist(character2.coordinates) != 0) {
        directionalVector = coordinates.copy(); // P

        directionalVector.sub(character2.coordinates); // (P - Q as numerator)
        directionalVector.div(coordinates.dist(character2.coordinates)); // vector normalized by the distance
       
        value = repulsionConstant * mass * character2.mass;

        value = value / (coordinates.dist(character2.coordinates) * (coordinates.dist(character2.coordinates))); // at this point, is force value
//        println("-: " + value);
        directionalVector.mult(value); // numerical number of force by slide 8 applied to vector
//        println("-: " + directionalVector.x + ", " + directionalVector.y);
        sumVectors.add(directionalVector);      
        }
      
    }
//    println(sumVectors.x + ", " + sumVectors.y);
    return sumVectors;
    
  }
  
  PVector calculateAttractions(ArrayList<characterNode> cast) {
     float value = 0.0;
     PVector sumVectors = new PVector(0,0);
     PVector directionalVector;
     PVector newTest;
     PVector mouseCursor = new PVector(mouseX, mouseY);
//     characterNode character2 = cast.get(15);

      // only have attraction towards linked nodes
      for (characterLink link : relationships) {
        if(link.target.coordinates.dist(coordinates) != 0) {
        directionalVector = link.target.coordinates.copy(); // Q

        directionalVector.sub(coordinates); // (Q - P as numerator)
//        println(character2.coordinates.dist(coordinates));
        directionalVector.div(link.target.coordinates.dist(coordinates)); // vector normalized by the distance
       
        value = attractionConstant * (coordinates.dist(link.target.coordinates) - springLength); // attraction formula
//       println("+: " + value);
//        value = value / (coordinates.dist(character2.coordinates) * (coordinates.dist(character2.coordinates))); // at this point, is force value

        directionalVector.mult(value); // numerical number of force by slide 8 applied to vector
//        println("+: " + directionalVector.x + ", " + directionalVector.y);
        sumVectors.add(directionalVector);      
        }
      }
    return sumVectors;
  }
  
    PVector calculateVelocity(ArrayList<characterNode> cast) {
   
    PVector rVector = calculateRepulsions(cast).copy();
//    println(rVector.x + ", " + rVector.y);
    PVector aVector = calculateAttractions(cast).copy();
    
    rVector.add(aVector);
    rVector.div(mass);
    rVector.mult(timeStep);
//    rVector.add(
    velocity.add(rVector);
//   println(velocity.x + ", " + velocity.y);

    return velocity;
   
  }
  
  void calculatePosition(ArrayList<characterNode> cast) {
    PVector timeStepVector = calculateVelocity(cast).copy();
    

    timeStepVector.mult(timeStep);
//    print("timeStepVector : ");
//    println(timeStepVector.x + ", " + timeStepVector.y);
//    print("Added to coordinates: ");
for(int i = 0; i < relationships.size(); i++) {
  if(coordinates.dist(relationships.get(i).target.coordinates) > 65) {
    updatePosition(timeStepVector);
  }
  }
  }
  
  void updatePosition(PVector newPosition) {

    if( ((coordinates.x - newPosition.x - nodeSize - 5) >= graphReference.d0) && 
        ((coordinates.x + newPosition.x - nodeSize) <= graphReference.d0 + graphReference.w - nodeSize - 15)) {
      coordinates.x += newPosition.x;
    }
    
    else if (newPosition.x > 0 && (coordinates.x + newPosition.x + nodeSize) <= graphReference.d0 + graphReference.w - nodeSize - 15) {
      coordinates.x += newPosition.x;
    }

   
   if( ((coordinates.y - newPosition.y - nodeSize - 5) >= graphReference.e0) && 
        ((coordinates.y + newPosition.y - nodeSize) <= graphReference.e0 + graphReference.h - nodeSize - 15)) {
      coordinates.y += newPosition.y;
    }
    
    else if (newPosition.y > 0 && (coordinates.y + newPosition.y + nodeSize) <= graphReference.e0 + graphReference.w - nodeSize - 15) {
      coordinates.y += newPosition.y;
    }


   
  }
  

  
  
}