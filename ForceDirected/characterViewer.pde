
 // Object representing the list of characters at the bottom of the window
 class charViewerBox {
  
  characterNode characterReference;
 
  float topLeftX, topLeftY, bottomRightX, bottomRightY;
  String name;
  
  color currentColor;
  
  boolean pressed = false;
  
  charViewerBox(characterNode reference, String groupNum, float _tLX, float _tLY, float _bRX, float _bRY) {
  
    characterReference = reference;
    name = groupNum;
    topLeftX = _tLX;
    topLeftY = _tLY; 
    bottomRightX = _bRX; 
    bottomRightY = _bRY;
    currentColor = 255;
    
  }
  
   void printText() {
    textSize(16);
    textAlign(CENTER);
    fill(0);
    text(name, topLeftX + (bottomRightX-topLeftX)/2, topLeftY + 20);
    
  }
  
  // functions to set pressed to true or false
  void setFlag() {
    
   pressed = true;
  }
  
  void removeFlag() {
    
   pressed = false; 
  }
  
  // listener function for cursor
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
     currentColor = 205;
     characterReference.setColor(105);
    }
    
    else {
     currentColor = 255;
     characterReference.setColor(characterReference.groupColor);
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

  // object references
  groupViewer viewerReference; // needed to link which group has been selected to the viewer box
  ArrayList<ArrayList<charViewerBox>> buttons =  new ArrayList<ArrayList<charViewerBox>>();
  ArrayList<charViewerBox> currentSelection;
  
  // dimensions of viewer
  float topLeftX, topLeftY, bottomRightX, bottomRightY;
  
  // settings for boxes
  float textSpacing = 20;
  float boxSpacingWidth = 154;
  float boxSpacingHeight = 40;
  
  
  int cliqueIndex = -1; // collection number
  int pressIndex = -1; // box in clique number
   
   
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
     }
   }

 }
 
  void setPositions(ArrayList<characterNode> clique, ArrayList<charViewerBox> buttons) {
    int i = 0; // used for rows
    int j = 0;  // used for columns
    int k = 0; // used for names
    
    // creates a button for each member of the group
    while(buttons.size() < clique.size()) {
     String name = clique.get(k).character.getString("id"); // returns name of character
     charViewerBox button = new charViewerBox(clique.get(i), name, topLeftX + boxSpacingWidth*i, topLeftY + boxSpacingHeight*j, topLeftX + boxSpacingWidth * (i+1), 
                                              topLeftY + boxSpacingHeight*(j+1));
     buttons.add(button);
     j = (j+1) % 3; // 3 characters in a column
     k++;
     if(j == 0) {  // start a new column
       ++i;
       
     }
     
       
    
    }

  }
    
   // prints boxes in characterViewer on bottom of screen based on selected group in groupViewer
   void checkSelection() {
    int i = 0;
    for(charViewerBox button : currentSelection) {
     if(button.overRect()) {

       fill(205);
      if(mousePressed) {
        if(pressIndex != -1 && pressIndex <= currentSelection.size()) {
          currentSelection.get(pressIndex).removeFlag();
        }

        pressIndex = i;
        button.setFlag();
        
        
      }
       
     }
     i++;
    }
    
  }
  
  // selects group based on groupViewer Selection
  void selectGroup(int i) {
    if(i >= 0 && i <= 9) {
    cliqueIndex = i;
    populateViewer();
    if(currentSelection != null && pressIndex != -1) {
    currentSelection.get(pressIndex).pressed = false;
    
    }
    pressIndex = -1;
    currentSelection = buttons.get(i); // allows reference calls
    }
  }
  
  // prints boxes
  void populateViewer() {
    
   ArrayList<charViewerBox> characters = buttons.get(cliqueIndex);
   for(charViewerBox box : characters) {
    box.draw(); 
   }
  }

 
 void draw() {
   if(mousePressed && (mouseButton == RIGHT) && cliqueIndex != -1) {
     cliqueIndex = -1; 
   }
   
  rectMode(CORNERS);
  fill(255);
  rect(topLeftX, topLeftY, bottomRightX, bottomRightY);
  fill(0);
  textSize(18);
  textAlign(CENTER);
  
  // if no group is selected, show this text
  if(cliqueIndex == -1) {
    text("Left click on a group to highlight nodes by color.", 
          topLeftX + (bottomRightX - topLeftX)/2, topLeftY + (bottomRightY - topLeftY)/2 - 20) ;
    text("Right click on a group to de-select it.", topLeftX + (bottomRightX - topLeftX)/2, topLeftY + (bottomRightY - topLeftY)/2 + 20);
  }
  
  fill(255);
  selectGroup((viewerReference.pressIndex));
  
  if(currentSelection != null) {
    checkSelection();
  }
 }
  
  
}