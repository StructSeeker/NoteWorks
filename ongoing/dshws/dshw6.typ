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




#question[Powers]

#answer[
We can calculate $a^n$ with the following recursion relationship:
$ a^0 &= 1 \
  a^1 &= a \
  a^n &= "let" b := a^(floor(n/2)) "in" b times b times (a^(n mod 2)) \
  n mod 2 &= ceil(n/2)
 $
The correonding equation for time complexity is:
$ T(n) = T(floor(n/2)) + O(1) lt.eq T(n/2) + O(1) \
 T(n) = O(log(n)) "by master theorem" $
]

#pagebreak()

