

#import "@preview/lemmify:0.1.7": *


#let (
  theorem, lemma, corollary,
  remark, proposition, example,
  proof, rules: thm-rules
) = default-theorems("thm-group", lang: "en")

#show: thm-rules

#theorem(name: "Some theorem")[
  Theorem content goes here.
]<thm>

#proof[
  Complicated proof.
]<proof>

@proof and @thm[theorem]
