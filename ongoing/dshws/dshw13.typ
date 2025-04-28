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




#question[Universal]

#answer[
  Note the following facts for finite field $Z_p$:
  - Let $b, X_i$ be i.i.d uniformlly distributed random varibale over $Z_p$, then $b + sum k_i X_i$ is also uniformly distributed over $Z_p$.
  Sketch of Proof: Use induction and the fact that subset sum of some i.i.d are still independent , note $
  Pr[sum_i^(n) k_i X_i + b = v] &= Pr[X_n = v - b - sum_i^(n - 1) k_i X_i ] \
        &= sum_(u in Z_p) Pr[X_n = u] Pr[sum_i^(n - 1) k_i X_i = v - b - u] \
        &= 1/abs(Z_p) 
  $
  Now $h(x_1) = v_1 and h(x_2) = v_2$ is equivalent to on each row $i in {1...m}$ and for each variable $n in {1, 2}$
  $
    sum_(j in {1...u}) A_(i, j) x_(1,j) + b= v_(1, j) "and"\
    sum_(j in {1...u}) A_(i, j) (x_(1, j) - x_(2, j))= v_(1,j) - v_(2, j)
  $
  In the second equation, because each $j$ with $x_(1, j) eq.not x_(2, j)$ witness a "flip" independently and such j exists sicne $x_1 eq.not x_2$. Apply the lemma, the two sum are uniformly distributed over $Z_p$ and independent.

  So the probability is $(1/2 dot 1/2)^m = 1/(M^2)$




]

#pagebreak()

