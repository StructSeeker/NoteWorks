#set text(size: 1.2em)
#set math.equation(numbering: "1.")

#import "@preview/lovelace:0.3.0": *

#import "@preview/lemmify:0.1.8": *

#let my-styling = (
  // thm-styling: thm-styling-simple,
  thm-numbering: thm-numbering-linear,
  // ref-styling: ..
)



#let (
  theorem, lemma, corollary,
  remark, proposition, example,
  proof, rules: thm-rules
) = default-theorems("thm-group", max-reset-level: 1, lang: "en", ..my-styling)
#show: thm-rules

#let (question, rules: qrules) = new-theorems("thm-group", ("question": text(green)[Question]), ..my-styling)
#show: qrules

#let (answer, rules: arules) = new-theorems("thm-group", ("answer": text(blue)[Answer]), thm-numbering: thm-numbering-proof)
#show: arules


#let push = math.op("push")
#let pop = math.op("pop")
#let size = math.op("size")
#let capacity = math.op("capacity")
#let insert = math.op("insert")
#let dp = math.op("dp")
#let dpa = math.op("dpa")
#let dpb = math.op("dpb")
#let split = math.op("split")
#let score = math.op("score")


#question[
== Color the matrix
Imagine a school is hosting a job fair where students have the opportunity to interview
with potential employers. The school wants to match as many students to employers
as possible based on the following constraints:
+ There are n students and m employers.
+ Each employer has l1, l2, ..., lm interview slots available
+ Each student has a list of employers they are interested in interviewing with, which can be represented using matrix Mn×m, M[i, j] = 1 if student i is interested in company j, else M[i, j] = 0
+ Each student can only interview with each employer at most once.
+ Each student can have at most e1, ..., en interviews.
Design a network flow-based algorithm that maximizes the total number of interviews
conducted.
]

#answer[
Forumlating the following network flow problem corresponding \
vertices: \
$
s_(i in [n]) "for each student" \
h_(j in [m]) "for each hirer (employer)" \
$
edges: \
$
c(s, s_i) &= e_i & "the i-th student has at most " e_i "interviews" \
c(s_i, h_j) &= M[i, j] & s_i "is interested in" h_j \
c(h_j, t) &= l_j & "the j-th hirer has a most " l_j "interviewees" \
$
Thus the max flow $f$ for the network corresponds to a distribution plan between students and employers that maximize the interview numbers. 
$ f(s_i, h_j) = 1 arrow.l.r s_i "is matched to" h_j $
Apply the ford-fulkerson algorithm to solve the above network flow problem and obtain the matching. \
Complexity: Since there're $O(m n)$ edges and and totally $sum e_i$ capacity for $s$ outgoing, and the flow problem can be formulated in opposite direction, the complexity is $O(m n min(sum e_i, sum l_j) )$ 
]

#pagebreak()


#question[

Consider the Binary Magic Square problem: Given a list of n integers r = (r1, . . . , rn),
and a list of m integers c = (c1, . . . , cm), we ask whether there is an n ×m grid of
0/1 such that row i sums to ri and column j sums to cj. We assume

Pi ri = Pj cj.
]

#answer[

Forumlating the following integer network flow problem corresponding \
vertices: \
$
R_(i in [n]) "for each row" i \
c_(j in [m]) "for each column" j \
$
edges: \
$
c(s, R_i) &= r_i  & "required to sum up to" r_i \
c(R_i, C_j) &= 1 & "value must be among" {0, 1} \
c(C_j, t) &= c_j & "required to sum up to" c_j \
$
Apply ford-fulkerson algorithm to the problem and obtain the max flow $f$.
Thus, the Binary Magic Square problem has a solution if and only if 
$ sum_i R_i = sum_j C_j = v("maxflow")  $
In which case $f(R_i, C_j)$ is the assigned value to $"matrix"[i, j]$

Complexity is less than the proportion of $O(min(sum R_i, sum C_j) m n)$ and is thus polynomial.

]

#pagebreak()


#question[
  == Laptop and Access Point
]

#answer[
  Example: Let $n = 3$
  $
    S_1 = {p_1, p_2}, S_2 = S_3 = {p_3}
  $
  The only valid test set is ${(l_1, p_1), (l_1, p_2), (l_2, p_3), (l_3, p_3)}$

  To solve the problem, we can formulate the problem as a minimum edge cover problem, i.e. choose a set of edges such that each vertice is adjacent to one of the edges.
  We can design bipartite graph:
  $
      l_(i in [n]), p_(i in [n]) "are vertices" \
      l_i, p_j "are connected if and only if" p_j in S_i 
  $

  Now we can further reduce the minimum edge problem to a max matching problem, note that a minimum edge cover can be obtained by adding edges into max-matching edge set greedily (i.e. adding one edge covering a new vertice). The obtained covering is indeed minimum, because its size $
  = "the size of maximum-matching edge set" \ 
  + "number of vertices not covered in maximum matching"
  $
  note that one less edge in maximum matching will contribute two vertices not covered by matching, meaning all other edge cover is of larger size.

  Now we can further reduce the max matching problem to network flow: Add source connected to $l_(i in [n])$ and sink connected to $p_(j in [n])$. Let capacity for all edges be 1, apply ford-fulkerson algorihtm to obtain max-flow $f$. Let $M$ be the flowing edges in $f$, apply greedily algorithm mentioned above to find a minimum edge cover, if the size of minimum edge cover is not greater than $k$, then the problem has a solution.

  The time cost is polynomial because ford-fulkerson is polynomial and the greedy process of adding edges is $O(n^2)$


  
]