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
]

#answer[
#let matrix = math.op("matrix")
  Suppose we color the matrix row by row, note that each $i+1$-th row is only constrained by the $i$-th row. We define two arrays:
  $ 
    "dpb"[i] = cases(delim:"|", "the total number of coloring schemes for the matrix from row 1 to row i", "such that" matrix[i, 1]."color" = matrix[i, 3]."color") \
    "dpa"[i] = cases(delim:"|", "the total number of coloring schemes for the matrix from row 1 to row i", "such that" matrix[i, 1]."color" eq.not matrix[i, 3]."color")
  $
  Using A, B, C, to represent a permutation of the RGB colors (the B here is not Blue), note there're are only finite numbers of coloring scheme on row $i$ and row $i+1$:
  $
    mat(A, B, C; B, C, A), mat(A, B, C; C, A, B); mat(A, B, A; C, A, B)\
    "dpa"[i+1] = "dpa"[i] dot 2 + "dpb"[i] \
    mat(A, B, C; B, A, B); mat(A, B, A; B, A, B), mat(A, B, A; B, C, B), mat(A, B, A; C, A, C) \
    "dpb"[i+1] = "dpa"[i] + "dpb"[i] dot 3 \
    "dp"[i+1] = mat("dpa"[i+1]; "dpb"[i+1]) = mat(2, 1; 1, 3) mat("dpa"[i]; "dpb"[i])  \
    "dp"[n] = mat("dpa"[i+1]; "dpb"[i+1]) = mat(2, 1; 1, 3)^(n-1) mat("dpa"[0]; "dpb"[0]) \    
  $
  Now we only need to calculate the base cases:
  $
    "dpa[0]" = "Permutation of 3 colors" = 3! = 6 \
    "dpb[0]" = "Select a pair of two color from 3" = 3*2 = 6 \
    "dp"[n] = mat("dpa"[i+1]; "dpb"[i+1]) = mat(2, 1; 1, 3)^(n-1) mat(6; 6) 
  $
  
  So the algorithm is to calculate $"dp"[N]$ using the above formula and add together $"dpa"[N]$ and $"dpb"[N]$ to get the final answer. 
  
  There all totally $N - 1$ matrix-vector multiplication and the time complexity is $Theta(N)$.

]
#pagebreak()




#question[
== Split the string
]

#answer[
  Note that a string with length $n$ have n+1 possible cursor position $(0...n)$, define and observe the recursvie relation and auxiliary data field for $0 lt.eq i < j lt.eq n$:
  $
    dp[i, j].score &= max cases(dp[i, k].score + dp[k, j].score "where" i < k < j, score("word"[i, j]) ) \
    dp[i, j].split &= cases("the above" k "that maximize the score if exists", "none if no such k exists") \  
    dp[i, i+1].score &= score("word"[i, i+1]) \
    dp[i, i+1].split &= "none"\
    dp[i, j].score &= "max possible score among all spliting between i-th and j-th cursor" \
    dp[i, j].split &= "a split used for max score" \ 
  $
  Let $I$ be all the possible pairs of $(i, j)$, we can calculate the $dp$ following the well-founded dependency order: $(i, j) < (p, q)$ iff $j - i < (q - p)$. That is, define $I_k := {(i, j) | j - i = k}$, note  $I_1$ is already defined, each dp item in $I_k$ can be calculated using the $dp$ in $I_(<k)$, note that $I_k$ has $n + 1 - k$ item, each item cost $Theta(k)$ to compute, so the $I_k$ cost in proprotion to $k(n+1-k)$ to compute, the total computing cost of all layer is in proportion to $ 
    sum_(k=1)^(n+1) k(n+1-k) = Theta(n^3) $
  And eventually the $dp[0, n]$ calculated by the algorithm is the answer.
]

#pagebreak()



#question[
== Tri-Longest Common Subsequence

]

#answer[
  Let $dp[i, j, k]$ denote the length of common longest sequence among $A[1...i]$, $B[1...j]$, $C[1...k]$, observe the following recursive relation:
  $
    dp[i + 1, j + 1, k + 1] = max cases(dp[i, j, k] + 1 "only if" A[i] = B[j] = C[k],
    dp[i, j + 1, k + 1], dp[i + 1, j, k + 1], dp[i + 1, j + 1, k ]) \
    dp[0, j, k] = dp[i, 0, k] = dp[i, j, 0] = 0 \
  $
  Since for $(i, j, k)$ dictionary-order is compatible with the above dependency order relation, so we can calculate the $dp$ by triple loop, the time complexity is $Theta(n^3)$.


]


