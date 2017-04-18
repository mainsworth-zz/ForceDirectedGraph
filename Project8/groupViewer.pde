
class groupViewer {
  
    float topLeftX, topLeftY, bottomRightX, bottomRightY, viewerWidth, viewerHeight;

  
  // constructor
  groupViewer() {}
    // creates a new relement viewer
  void createViewer(float _tLX, float _tLY, float _bRX, float _bRY, Table _table)
  {
    
    dataTable = _table;
    
    // sets dimensions of viewer
    topLeftX = _tLX;
    topLeftY = _tLY; 
    bottomRightX = _bRX; 
    bottomRightY = _bRY;
    viewerWidth = (bottomRightX - topLeftX);
    viewerHeight = (bottomRightY - topLeftY); 
    
  }
  
  
  
  
  
}