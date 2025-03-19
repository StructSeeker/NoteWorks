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




#question[Suppose $G=(V,E)$ is a directed, acyclic graph (a DAG) with positive weights $d(u,v)$ on each edge. Let $s$ be a vertex of $G$ with no incoming edges and such that every other node is reachable from $s$ through some path. Give an $O(|V|+|E|)$-time algorithm to compute the shortest paths from $s$ to all other vertices in $G$. Note that this is faster than Dijkstra’s algorithm in general]

#answer[
  #figure(
  kind: "algorithm",
  supplement: [Algorithm],
  pseudocode-list(booktabs: true, numbered-title: [DAG Shortest Path])[
    #let prev = math.op("prev")
    #let dist = math.op("dist")
    - *input:*
      - A positive-weighted connected DAG $G = (V, E, d)$
      - A vertice $s in V$ with no incoming edge. 
    - *output:*
      - $prev: V -> V$, representing the predecessor of given vertice in the shortest path. 
      - $dist: V -> RR^+$, representing the length of the shortest path from $s$ to given node.
    - *gist:* apply topological-sorting, calculate shortest path by Dynamic Programming in the sorting Order. 
    - *complexity:* $O(|V| + |E|)$, explained Below. 
    - *correctness:* Explained in the comment below.
    + *let* $l colon.eq "a exhausted list of " V "obtained by topological-sorting"$
    - Therefore the order on $l$ respect the sucesssor relationship.
    - Dynamic Programming can be applied accordingly
    - The time complexity of topological-sorting is $O(|V|+|E|)$ 
    + *foreach* $v in l$ *do*
      + *let* $A colon.eq {(u, e)| e "is the incoming edge from" u "to" v}$
      + $dist[v] = max_((u, e) in A)(dist[u] + d(e))$
      + $prev[v] = "the" u "that maximize the above" (dist[u] + d(e))$
    + *end*
    - In the whole loop each edge is visited once and each vertice visited twice, the the complexity of the loop is $O(|V|+|E|)$
  ]
) <cool>

]

#pagebreak()

#question[Bad Algorithm]

#answer[*The algorithm is wrong* because for subsets of alphabet
$ abs(A) lt.eq abs(B) arrow.r.not abs(A union {l}) lt.eq abs(B union {l}) $
As a result, extending existent shortest path doesn't necessarily give us a new shortest path.
Consider the following counterexample:
#image("dshw5.png") 
One shortest path from $s$ to $y$ is $a, u, w, x, y$ with length $= 4 = abs({a,d, e, c})$. However the extended path from $s$ to $z$ is $a, u, w, x, y, z$ is of length $= 5 = abs({a, d, e, c, b}) > abs({b, c, d, e}) = 4$, which is the length of path $s, v, u, w, x, y, z$
]

#pagebreak()

#question[

  
]

#answer[  
  Reformulate the question in the following way to make it a shortest path question: \
  Consider the following positive-weighted directed graph $G' = (V', E')$. \
  Each $v in V'$ is a spanning forest (i.e a set of edges with no cycle) of $G$. \
  There exist an edge $e in E'$ from $v_1$ to $v_2 in V'$ iff an edge can be added the spanning forest $v_1$ to obtain $v_2$ without breaking the $k$-degree constraints. The weight of edge $e$ is equal to the weight of edge needed to add in $G$. \
  Apply A\* algorithm from an empty forest to find any spanning tree on $G'$.
  The heuristic function is $h(v) = 0$, which is always admissible. \
  In case a shortest path is found, a corresponding constrained-minimum-spanning tree is found as well.
  ]

#pagebreak()

#question[Shortest Path Tree]

#answer[
  *Correctness*:
  #let dist = math.op("dist")
  Let $T$ be the edges that form a tree in $G$, $dist$ be the length of path from tree root to any vertice. We have
  $ T "is shortest path tree from" s arrow.double.l.r forall e = (u, v) in E\\T, abs(dist[u] - dist[v]) lt.eq d(u, v) $
  *Proof*:\
  $=>$: otherwise a shortest path can be constructed using $e$. \
  $arrow.double.l$: Apply induction. Suppose all vertice with shortest path length less than $l$ has their shortest path in tree, then a vertice with shortest path length $= l$ have its shortest path obtained by extending from shorter shortest path with a minimum edge. So, each vertice with length $= l$ also has its shortest path in the tree.\
  *Algorithm:* return whether the tree is shortest path tree.
  + *foreach* $(u, v) in E\\T$ *do*\
    + *if* $abs(dist[u] - dist[v]) > d(u, v)$ *then* \
    + *return* false; \
    + *end* \
  + *end* \
  + *return* true \
  \
  *Complexity:* Each edge is visited at most once, so is $O(abs(E))$
]

// #pagebreak()
