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
== 

]

#answer[
#figure(
  kind: "algorithm",
  supplement: [Algorithm],
  pseudocode-list(booktabs: true, numbered-title: [Splay Sort])[
    + *input*:
    + *output*:
    + *gist* :
])
]

#pagebreak()


