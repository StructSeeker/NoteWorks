#set text(size: 1.2em)
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
== Dynamic Array 
#figure(
  kind: "algorithm",
  supplement: [Algorithm],
  pseudocode-list(booktabs: true, numbered-title: [Splay Sort])[
    + *input*: $A$ an array of totally $n$ number to be sorted. 
    + *output*: $B$ an array of the same multiset of number in $A$ but sorted.
    + *gist* : Construct a splay tree from A. Do an in-order traversal to get the sorted list.
    + *let* $T$ be an empty splay tree.
    + *foreach* $x in A$ *do*
      + $T.insert(x)$
    + *end* _see below for the worst case complexity of this loop_
    + *for* $x in T.op("in-order-traversal-iterator")()$ *do*
      + $B.push(x)$
    + *end* _The loop cost $O(n)$_.
    + *return* $B$
])
]

#answer[

]

#pagebreak()


