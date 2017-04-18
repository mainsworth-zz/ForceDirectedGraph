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

  groupViewer viewerReference;
  
  float topLeftX, topLeftY, bottomRightX, bottomRightY;
  ArrayList<ArrayList<charViewerBox>> buttons =  new ArrayList<ArrayList<charViewerBox>>();
  
  float textSpacing = 20;
  float boxSpacingWidth = 150;
  float boxSpacingHeight = 40;
  
  int cliqueIndex = -1;
   
 characterViewer(groupViewer graph, float _tLX, float _tLY, float _bRX, float _bRY) {
 
    viewerReference = graph;
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
    int i = 0; // used for rows
    int j = 0;  // used for columns
    int k = 0; // used for names
    while(buttons.size() < clique.size()) {
     String name = clique.get(k).character.getString("id");
     charViewerBox button = new charViewerBox(name, topLeftX + boxSpacingWidth*i, topLeftY + boxSpacingHeight*j, topLeftX + boxSpacingWidth * (i+1), 
                                              topLeftY + boxSpacingHeight*(j+1));
     buttons.add(button);
     j = (j+1) % 3; // 3 characters in a column
     k++;
     if(j == 0) {  // start a new column
       ++i;
       
     }
     
        println(buttons.size());
    
    }

  }
  
  void selectGroup(int i) {
    if(i > 0 && i <= 10) {
    cliqueIndex = i;
    populateViewer();
    }
  }
  
  void populateViewer() {
    
   ArrayList<charViewerBox> characters = buttons.get(cliqueIndex);
   for(charViewerBox box : characters) {
    box.draw(); 
   }
  }

 
 void draw() {
  rectMode(CORNERS);
  fill(255);
  rect(topLeftX, topLeftY, bottomRightX, bottomRightY);
  selectGroup((viewerReference.pressIndex));
 }
  
  
}