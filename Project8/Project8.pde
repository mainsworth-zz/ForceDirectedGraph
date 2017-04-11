/**********************************************
* Name: Matthew Ainsworth                     *
* Class: Data Visualization - CIS4930         *
* Assignment: Project 8                       *
***********************************************/
import java.text.DecimalFormat;

//object references
JSONArray castValues;

void setup() {
 size(1200,800);
 background(255);
 textSize(14);
 smooth();
  selectInput("Select a file to process:", "fileSelected");
     
}

// allows user to select a dataset to be used from csv file
void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    castValues = loadJSONArray(selection.getAbsolutePath());
  }
  
}


void draw()
{
  if(castValues == null)
  {
    
  }
  
  else
  {
      for(int i = 0; i < castValues.size(); i++)
      {
        JSONObject character = castValues.getJSONObject(i);
         println(character.getString("id")); 
        
      }
    
  }
  
}