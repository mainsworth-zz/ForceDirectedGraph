/**********************************************
* Name: Matthew Ainsworth                     *
* Class: Data Visualization - CIS4930         *
* Assignment: Project 8                       *
***********************************************/
import java.text.DecimalFormat;

//object references
JSONObject data;

ForceGraph graph;

void setup() {
 size(800,800);
 background(255);
 textSize(14);
 smooth();
  selectInput("Select a file to process:", "fileSelected");
  graph = new ForceGraph();
     
}

// allows user to select a dataset to be used from csv file
void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    data = loadJSONObject(selection.getAbsolutePath());
  }
  
}



void draw() {
  
  if(data == null) {
    
  }
  
  else {
      rectMode(CORNERS);
      fill(205);
      rect(0, 0, width, height);
      graph.setPosition(20, 20, width-175, height-175);
      graph.loadData(data);
      graph.draw();
    
  }
  
}