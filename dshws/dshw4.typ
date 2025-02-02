#set math.equation(numbering: "1.")

#import "@preview/lovelace:0.3.0": *

#import "@preview/lemmify:0.1.7": *

#let my-styling = (
  // thm-styling: thm-styling-simple,
  thm-numbering: thm-numbering-linear,
  // ref-styling: ..
)

#let (
  theorem, lemma, corollary,
  remark, proposition, example,
  proof, rules: thm-rules
) = default-theorems("thm-group", lang: "en", ..my-styling)
#show: thm-rules

#let (question, rules: qrules) = new-theorems("thm-group", ("question": text(green)[Question]), ..my-styling)
#show: qrules

#let (answer, rules: arules) = new-theorems("thm-group", ("answer": text(blue)[Answer]), thm-numbering: thm-numbering-proof)
#show: arules


#question[
The diameter of a connected, undirected graph $G= (V, E)$ is the length (in number of edges) of the longest shortest path between two nodes. 
1. Show that if the diameter of a graph is $d > 1$ then there is some set $S⊆V$ with $|S| ≤ (|V|)/(d-1)$ such that removing the vertices in $S$ from the graph would break  it into several disconnected pieces.  
2. Give an efficient algorithm to find $S$.
]

#answer[
1. #lorem(50)
2. 
] 

#question[
  
]