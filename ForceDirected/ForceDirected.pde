/***************************************************ForceDirectedGraph*********
 * Notes:                                                                     * 
 *  1) Creates a force-directed graph that shows relationships between nodes  *
 *  2) Reads from a properly formatted JSON file, with example                *
 *     'miserables.json' given                                                *
 *  3) Other datasets can be used, so long as it matches the format of        *
 *     the example                                                            *
 ******************************************************************************   
 * Execution:                                                                 *
 *  - Hit the "Run" button in Processing to start the program                 *
 *  - Select a formatted JSON file to use                                     *
 *    * The program may default to the installation folder - in this case,    *
 *      you will need to navigate to the folder with your desired file. For   *
 *      test runs, use 'miserables.json' in the project folder.               *
 ******************************************************************************
 * Interactions:                                                              *
 *  - Left clicking on a group from the menu highlights all nodes of that     *
 *    group, and shows where they are arranged in the layout                  *
 *  - Right-clicking anywhere in the program de-selects the group, and        *
 *    returns the layout to the original function                             *
 ****************************************************************************** 
 * Author: Matthew Ainsworth                                                  *
 ******************************************************************************/

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
      graph.setPosition(20, 20, width-180, height-180);
      graph.loadData(data);
      graph.draw();
    
  }
  
}