
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

class groupViewer {
  
  float topLeftX, topLeftY, bottomRightX, bottomRightY, viewerWidth, viewerHeight;

  float textSpacing = 65;
  float boxSpacing = 62;
  ArrayList<viewerBox> buttons =  new ArrayList<viewerBox>();
  int[] selections = {0,0,0,0,0,0,0,0,0,0};
 
  int pressIndex = -1;

  // constructor
  groupViewer(float _tLX, float _tLY, float _bRX, float _bRY) {
   // sets dimensions of viewer
    topLeftX = _tLX;
    topLeftY = _tLY; 
    bottomRightX = _bRX; 
    bottomRightY = _bRY;
    viewerWidth = (bottomRightX - topLeftX);
    viewerHeight = (bottomRightY - topLeftY); 
    
    
  }
  
  void setPositions(ArrayList<viewerBox> buttons) {
    int i = 0;
    while(buttons.size() < 10) {
     String name = "Group " + (i+1);
     viewerBox button = new viewerBox(name, topLeftX, topLeftY + boxSpacing*i, bottomRightX, topLeftY + boxSpacing*(i+1));
     buttons.add(button);
     ++i;
    println(buttons.size());
    println("Printing buttons.");  
    }
    
  }
  
  void checkSelection() {
    int i = 0;
    for(viewerBox button : buttons) {
     if(button.overRect()) {
 //      println("Over it");
 //      fill(205);
      if(mousePressed) {
        if(pressIndex != -1) {
          println("Turned off button " + pressIndex);
          buttons.get(pressIndex).removeFlag();
        }
        pressIndex = i;
        println("Pressed.");
        println(pressIndex);
        button.setFlag();
        
        
      }
       
     }
     i++;
    }
    
  }

  
  void draw() {
   fill(255); 
//   rect(topLeftX, topLeftY, bottomRightX, bottomRightY); 

   setPositions(buttons);
   checkSelection();
   for(viewerBox button : buttons) {
    button.draw(); 
     
   }
  }
  
  
}