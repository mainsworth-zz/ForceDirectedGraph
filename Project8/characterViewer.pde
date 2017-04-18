class charViewerBox {
 
  float topLeftX, topLeftY, bottomRightX, bottomRightY;
  String name;
  
  color currentColor;
  
  boolean pressed = false;
  
  charViewerBox(String groupNum, float _tLX, float _tLY, float _bRX, float _bRY) {
  
    name = groupNum;
    topLeftX = _tLX;
    topLeftY = _tLY; 
    bottomRightX = _bRX; 
    bottomRightY = _bRY;
    currentColor = 255;
    
//    pressed = true;

  }
  
   void printText() {
    textSize(16);
    textAlign(CENTER);
    fill(0);
    text(name, topLeftX + (bottomRightX-topLeftX)/2, topLeftY + 20);
    
  }
  
  void setFlag() {
    
   pressed = true;
  }
  
  void removeFlag() {
    
   pressed = false; 
  }
  
  boolean overRect() {
  if (mouseX >= topLeftX && mouseX <= bottomRightX && 
      mouseY >= topLeftY && mouseY <= bottomRightY) {
    return true;
  } else {
    return false;
  }
 
}
  void highlightButton() {
   
    if(pressed) {
     currentColor = 105;
    }
    
    else {
     currentColor = 255;
    }
    
  }

  void draw() {

    rectMode(CORNERS);
    highlightButton();
    fill(currentColor);
    rect(topLeftX, topLeftY, bottomRightX, bottomRightY);
    printText();

    
  }
  
}

class characterViewer {
  
  float topLeftX, topLeftY, bottomRightX, bottomRightY;
  ArrayList<ArrayList<charViewerBox>> buttons =  new ArrayList<ArrayList<charViewerBox>>();
  
  float textSpacing = 65;
  float boxSpacing = 62;
  
 characterViewer(float _tLX, float _tLY, float _bRX, float _bRY) {
 
 
    topLeftX = _tLX;
    topLeftY = _tLY; 
    bottomRightX = _bRX; 
    bottomRightY = _bRY;
 
 
 
 } 
 
 void fillRoles(ArrayList<ArrayList<characterNode>> casts) {
   if(buttons.size() < casts.size()) {
   for(int i = 0; i < casts.size(); i++) {
     
     ArrayList<charViewerBox> groupButtons = new ArrayList<charViewerBox>();
     setPositions(casts.get(i), groupButtons);
     buttons.add(groupButtons);
     println("Clique " + (i+1) + " number of buttons: " + groupButtons.size());
   }
      println("Finished cliques.");
   }

 }
 
  void setPositions(ArrayList<characterNode> clique, ArrayList<charViewerBox> buttons) {
    int i = 0;
    while(buttons.size() < clique.size()) {
     String name = "Group " + (i+1);
     charViewerBox button = new charViewerBox(name, topLeftX, topLeftY + boxSpacing*i, bottomRightX, topLeftY + boxSpacing*(i+1));
     buttons.add(button);
     ++i;
        println(buttons.size());
    
    }

  }
 
 void draw() {
  rectMode(CORNERS);
  fill(255);
  rect(topLeftX, topLeftY, bottomRightX, bottomRightY);
 }
  
  
}