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




#question[
== ILP

]

#answer[
Using iverson bracket and iota function: 
$ 
["Prop"] := cases(1 "if Prop holds", 0 "otherwise") \
iota n := {1, 2, ..., n}
$
We formulate the following ILP to solve the problem: \
Introduce $x := x_(i,j,k in iota m times iota n times iota a) in {0, 1}$ as the variables of programs, meaning $s_i$ and $p_j$ are met at $t_k$. We are to maximize the total number of meeting:
$
  max_(x) sum_(i,j,k) x_(i, j, k)
$<goal-fn>
such that the following constraints are met: \
At each time slot, Student/Professor can only meet one professor/student:
$
  forall i, k  space.quad sum_(j) x_(i,j,k) lt.eq 1 \
  forall j, k  space.quad sum_(i) x_(i,j,k) lt.eq 1 
$
A meeting could happen only if student/professor are availabel only on that time slots and they're interested in each other:
$
  forall i, j, k space.quad x_(i, j, k) lt.eq [t_k in A_(p_j) inter A_(s_i) and p_j in M_(s_i) and s_i in M_(p_j)]
$

The required ILP is written as above, the value of goal function @goal-fn is the number of meetings that can happen.

== Actual Meeting Schedule
A meeting between $s_i$ and $p_j$ is planned at $t_k$ iff $x_(i, j, k) = 1$, because it belong to the solution that suffice contraint and maximize the goal function.

== Modify

Modify the goal function in @goal-fn as the follows:
$

  max_(x) sum_(i,j,k ) b_(p_j) x_(i, j, k)

$
So that the program maximize the number of bigshot points.


== Aux 
if there's an additional requirement that between a pair of student and professor, there's at most one meeting:
$
  forall i, j sum_(k) x_(i, j, k) lt.eq 1
$

]



