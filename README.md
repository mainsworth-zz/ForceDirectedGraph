# ForceDirectedGraph
This program creates a force-directed graph showing relationships between nodes, graphically showing how "central" nodes are to
the overall population. 

## Purpose
Force-directed graphs are useful in networking to understand how nodes or groups of nodes fit in within a population. By having nodes
pull in other nodes that are connected to it and push away nodes that are not, these graphs will result in the most connected nodes 
being pulled toward the center. This gives us an intuitive measure of finding which nodes have the highest degree centrality in the
network. 

For this example, we are given an example dataset using the cast from "Les Misérables", to see how each character in the play interacts
with each other character in the play. If a character shares a scene with another character, the dataset will represent that through a
link. In doing so, we can have a force-directed graph create a network that will pull related characters closer together. In effect,
the main characters will be pulled to the center because they share scenes with a greater number of characters, and side characters
will be pulled together based on their relevance to one another. The dataset also has characters grouped together based on their role in
the story, to help visualize how those groups fit in with the overall network.


## Methodology
The graph begins by having all nodes created randomly on the sketch, then creates links to each node to represent their relationships.
Once these relationships have been identified, the program will then have those nodes "pull in" their connected neighbors, so that
they will be physically close together. Not only does this make it easier to identify neighborhoods, but also other unique network
characterstics such as cliques, since the graph makes it easier for those nodes to meet. 

While not featured in the program, it is still possible to create weighted connections between nodes in a force-directed graph
to make certain connections more valuable than others. This can be useful if you are trying to examine a certain type of node's influence
on the network.

## Getting Started
To run this program, you need to have Processing installed. It can be downloaded from this website:
https://processing.org/

Then, once installed, run any of the Processing (.pde) files in the main folder. It will open up Processing with the project
loaded into it.

Hit the "Run" button at the top, and then select the JSON file you wish to use. An example 'miserables.JSON' has been provided, but
other datasets can be used as long as it matches the formatting of the example.

## Running the Program                                                           
Once the graph has been drawn, it is possible to click on the group buttons on the right side of the window to see where the members
of the group are in the graph. Once a group has been selected, all other nodes will be grayed out to highlight the nodes within that
group. To resume normal view, simply right-click anywhere in the window. 
