#import "@preview/lovelace:0.3.0": *

#import "@preview/ctheorems:1.1.3": *

#let question = thmbox("question", "Question", base_level: 0).with(numbering: "1.", )
#let answer = thmplain("answer", "Answer").with(numbering: none)
#set math.equation(numbering: "1.")
#set heading(numbering: "1.a")

#show: thmrules.with(qed-symbol: $square$)
// #set cite(style: "chicago-author-date")
// #show link: underline


// #set page(width: 16cm, height: auto, margin: 1.5cm)
#set heading(numbering: none)  

#question[
  = Rank Complexity
  Rank the following functions in order of their asymptotic growth.
]

#answer[
  From small to larger: \
  $
    f_3(n) = 10^10 = Theta(1) \
    f_7(n) = n^(1 /(ln 5)) = Theta(n^(1 /(ln 5))) \
    f_4(n) = 2^log_2(n) = n = Theta(n) \
    f_2(n) = (n ln n )/ (ln 2), f_5(n) = (2 n ln n) /(ln 10) = Theta(n ln n) \
    f_9(n) = n (log_2 n)^3 = Theta(n (ln n)^3) \
    f_1(n) = n^5 = Theta(n^5) \
    f_8(n) = n^(log_2 n) = Theta((n^(1 / (ln 2)))^n) \
    f_6(n) = (n+1)! = Theta(sqrt(n)(n/e)^n) \
  $
]

#question[
  = Judge Correctness
]

#answer[
  Use $N$ to denote any positive integer.
  - True. $2^n lt.eq 2^(n+1) lt.eq 2 dot 2^n$ holds for all natural number $n$.
  - False. $n gt log_2 N arrow.r 2^(2n) gt N 2^n $, thus $2^(2n) = Omega(2^n)$
  - False. let $f "be" n arrow.bar 2^(2n)$, an counterexample is given in (b)'s proof.
  - False. $op("LHS")= n^2 = Omega(n)$ and $op("RHS") = n$, we have $n gt N arrow.r n^2 gt N dot n$
  - True. the statement is equivalent to 
  $
    arrow.l.r &exists M N forall n gt.eq M therefore f(n) lt.eq N g(n) \
    arrow.l.r &exists M exists N' = N^2 forall n gt.eq M therefore f(n)^2 lt.eq N' g(n)^2 \
    arrow.l.r & f^2 = O(g^2)
  $

]

#pagebreak()

#question[
  = Fewest suitcase
]
#let weight = math.op("weight")
#answer[
  Let $C_(j in [m])$ be a partition of $[n] = {1, 2, ..., n}$ into $m$ disjoint nonempty sets, representing the suitcases used in a particular packing solution. For an approximate solution, the $C_j$ is ordered by their first appearance in "first-fit" algorithm. 
  In other words, for suitcases corresponding to approximate solution 
  $ forall j < m exists phi(j) in C_(j+1) therefore weight(C_j) + s_(phi(j)) = sum_(i in C_j)s_i + s_(phi(j)) > 1 $<loptim>
  Note that $phi$ is injective, this property is useful in Upperbound proof.
  == Lowerbound
  Show the optimal number of suitcases is $gt.eq ceil(S)$
  $ S = sum_(j in [m]) weight(C_j) lt.eq sum_(j in [m]) 1 = m \
  ceil(S) lt.eq m "since" m in NN $

  == Upperbound
  Show the first-fit never uses more than $ceil(2S)$ suitcases. \
  Use @loptim and $phi$ being injective to see:
  $ 2 S gt.eq sum_(j in [m-1]) weight(C_j) + s_(phi(j)) > sum_(j in [m-1]) 1 = m - 1 \
  ceil(2 S) gt.eq m "since" m in NN $ 

  == Approximate
  Using the previous results:
  $ ceil(S) <= m_("optimal") lt.eq m_("first_fit") lt.eq ceil(2S) lt.eq 2m_("optimal") $
  So first-fit is a 2-approximation algorithm with respect to the performance function as the number of suitcases used.
]

