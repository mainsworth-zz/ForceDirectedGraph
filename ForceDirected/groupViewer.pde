
class viewerBox {
 
  float topLeftX, topLeftY, bottomRightX, bottomRightY;
  String name;
  
  color currentColor;
  
  boolean pressed = false;
  
  viewerBox(String groupNum, float _tLX, float _tLY, float _bRX, float _bRY) {
  
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
  
  // Function to designate which group has been selected
  void setFlag() {
     
   pressed = true;
  }
  
  // removes flag showing that this group has been selected
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
     currentColor = 205;
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

 class groupViewer {
  
  ForceGraph graphReference; // reference to force graph
  ArrayList<viewerBox> buttons =  new ArrayList<viewerBox>(); // list of buttons for groupViewer
  
  // dimensions of viewer
  float topLeftX, topLeftY, bottomRightX, bottomRightY, viewerWidth, viewerHeight;

  // settings of box
  float textSpacing = 65;
  float boxSpacing = 62;
 
  int pressIndex = -1;

  // constructor
  groupViewer(ForceGraph reference, float _tLX, float _tLY, float _bRX, float _bRY) {
   
    // sets dimensions of viewer
    graphReference = reference;
    
    topLeftX = _tLX;
    topLeftY = _tLY; 
    bottomRightX = _bRX; 
    bottomRightY = _bRY;
    viewerWidth = (bottomRightX - topLeftX);
    viewerHeight = (bottomRightY - topLeftY); 
    
    
  }
  
  // used for each box in list
  void setPositions(ArrayList<viewerBox> buttons) {
    int i = 0;
    while(buttons.size() < 10) {
     String name = "Group " + (i+1);
     viewerBox button = new viewerBox(name, topLeftX, topLeftY + boxSpacing*i, bottomRightX, topLeftY + boxSpacing*(i+1));
     buttons.add(button);
     ++i;
    }
    
  }
  
  // allows for highlighting of individual boxes in viewer
  void checkSelection() {
    int i = 0;
    for(viewerBox button : buttons) {
     if(button.overRect()) {
       fill(205);
      if(mousePressed && mouseButton == LEFT) {
        if(pressIndex != -1) {
          buttons.get(pressIndex).removeFlag();
        }
       
        pressIndex = i;

        button.setFlag();
        
        
      }
       
     }
     i++;
    }
    
  }
  
  // passed to force graph for highlight nodes in graph
  void highlightGroup() {
   
    graph.groupSelected = pressIndex;
    
  }
  

  
  void draw() {
   if(mousePressed && (mouseButton == RIGHT) && pressIndex != -1) {
     buttons.get(pressIndex).removeFlag();
     pressIndex = -1; 
   }
   fill(255); 
//   rect(topLeftX, topLeftY, bottomRightX, bottomRightY); 

   setPositions(buttons);
   checkSelection();
   for(viewerBox button : buttons) {
    button.draw(); 
     
   }
   highlightGroup();
  }
  
  
}