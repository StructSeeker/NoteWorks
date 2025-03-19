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
An array is a contiguous reserved block of memory used to store a list of numbers. Consider a dynamic array $A$ of size $n$ with reserved space for $m gt.eq n$ items. Then, indexing into it to find $A[i]$ is $O(1)$ time, whereas inserting items is $O(n)$. However, pushing an item onto the end of the array is $O(1)$ time if we keep track of the current size $n$ in a counter $C = n$. Then, pushing an item $x$ simply requires setting $A[C] = x$ (we are 0-indexing here, so $A[n]$ is the $(n+1)$th item) and then $C = C + 1$, but this only works if $m gt.eq 1$. If $m < n + 1$, then we need to reallocate a larger block of memory and copy all the items over to the new memory space, which may take $O(n)$ time. Design and analyze a version of a dynamic array where pushing an item onto the end of the array takes amortized $O(1)$ time.
]

#answer[
The given dynamic array suffice the requirement of amortized $O(1)$ operation, to be specific:
/ Data: 
  / counter $C$: recording the number of element in the array
  / counter $N$: recording the number of total (reserved or used slots in the array
  / array $A$: whose size is $N$.
/ Operations:
  / $[i]$: Return the $i$th element of the array, implemented by random access the underlying array. \
    Complexity is O(1)
  / $push(x)$: If $C lt.eq N$, set $A[C] = x$ and $C = C + 1$. Otherwise, allocate a new array $A'$ of size $2N$, copy all elements from $A$ to $A'$, set $A'[C] = x$, and $C = C + 1$. Then, set $A = A'$ and $N = 2N$. 
/ Amortized Analysis: Consider a series of operation, between any two $push$ that trigger the reallocation $(N-> 2N, 2N -> 4N)$, there are at least $N - 1 = 2N - N - 1$ $push$ operations that are $O(1)$ and don't trigger reallocation. Therefore, by applying accounting method to assign 1 credit extra to each $push$ operation, we conclude that amortized cost of $push$ is $Theta(1) = Theta(2N)/N$. 
]

#pagebreak()




#question[
== Splay tree 
Suppose you inserted the integers $3, 11, 7, 20, 9$ into a splay tree in that order. Draw the structure of the splay tree following the last insertion.

]

#answer[
#image("assets/2025-03-07-21-18-11.png", height: 2em)
#image("assets/2025-03-07-21-20-38.png", height: 3em)
#image("assets/2025-03-07-21-21-06.png")
#image("assets/2025-03-07-21-21-49.png")
#image("assets/2025-03-07-21-23-10.png")
]

#pagebreak()




#question[
== Sorting
Given a binary search tree of size $n$, we can recover a sorted list of all keys by doing an in-order traversal of the nodes. Design a sorting algorithm using splay trees and the above property. What is the runtime of the sorting algorithm? Some sorting algorithms (like naive quicksort) perform poorly on already sorted data. Prove that the splay tree sorting algorithm actually performs better on an already sorted list than it does on an unsorted list. What is the runtime? For the purposes of this problem, please be careful to distinguish between amortized analysis, average-case performance, and worst-case performance.
]

#answer[
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
/ Correctness: in-order traversal of a binary search tree is a sorted list. \
/ Complexity: note that the complexity is dominated by the $T.insert(x)$ loop, in which:
  / Sorted: If the array $A$ is alreay sorted, the splay tree is a degenerate linked list with each new item inserted at the root and splayed to become new root in $O(1)$ time. Therefore, the total complexity is $O(n)$. (Worst case perfomances for a sorted list.) 
  / Worst cost random cases: If the array $A$ is random, since the amortized cost of inserting a splay tree is O(|log(n)|), the total cost is in proportion to $n log(n)$, thus is $O(n log(n))$. 
]

#pagebreak()




#question[
== Design an efficient in-place algorithm to convert a $(4,7)$-tree into a $(2,3)$-tree.
Note: For both subproblems, we specify “in-place” to disallow the trivial solution of just using an in-order traversal to get a sorted list and constructing the new tree from scratch, though in practice, that would be a reasonable solution absent memory limitations.
]

#answer[
  #figure(
  kind: "algorithm",
  supplement: [Algorithm],
  pseudocode-list(booktabs: true, numbered-title: [Root Split])[
    + *input*: $R$, the root node of a $(4, 7)$-tree. 
    + *output*: A $(2, 3)$-tree with the same set of keys from R.
    + *if* $R$ has 3 of less children *then* *return* $R$ *end*
    + The $R$ now has 3 to 6 keys, pick the median key $m$ and split the left and right keys totally into 3 nodes (left keys, m, right keys) with the m node as the new tree root, the children inbetween is distributed in the obvious way. After splitting, root node has 1 key and 2 children, each children has 1 to 2 keys (or 2 to 3 children). 
])

  #figure(
  kind: "algorithm",
  supplement: [Algorithm],
  pseudocode-list(booktabs: true, numbered-title: [$(4, 7)$ node Split])[
    + *input*: $T$, a proper subtree of $(4, 7)$-tree, meaning each non-leaf node has 4 to 7 children. 
    + *output*: A $(2, 3)$-subtree with the same set of keys from R.
    + at the first node, it must have 4 to 7 childrean and thus 3 to 6 keys, split the node by three half, the new parent has 1 to 2 keys, and 2 to 3 children, each child has 1 to 2 keys (or 2 to 3 children). The inbetween pointers are redistributed to the two children nodes in the obvious way.
    + Apply the above spliting operation recursively to all nonleaf children.
])

First apply root-split to the (4, 7)-tree root, then apply the node-split recursively to all its (4, 7)-node children.

/ Correctness: As is stated above, the constraint of $(2, 3)$-tree at root and internal nodes are satisified. Since each leaf in original tree is of same depth and each original internal-node is split into 3 in 2 layers, the depth of new leaf in new tree is the same.

/ Complexity: Suppose the total number of keys are $n$, Note that the cost of spliting a node with $k$ keys is $O(k)$, and the total cost of spliting all nodes is $O(n)$.

]

#pagebreak()


