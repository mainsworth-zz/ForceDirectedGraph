
class characterLink {
  
   // both act as references
   characterNode source;
   characterNode target;

   
   int repulsionStrength = 200;
   float attractiveStrength = 1;
   float springLength = 10; // minimum distance
   float distance = 0;

   float velocity = 0;
   
   characterLink(characterNode _source, characterNode _target) {
     source = _source;
     target = _target; 
   }
   
 


  

}