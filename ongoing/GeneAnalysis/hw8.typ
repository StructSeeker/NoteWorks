#set text(size: 1.2em)
#set math.equation(numbering: "1.")

#import "@preview/lovelace:0.3.0": *

#import "@preview/lemmify:0.1.8": *

#let my-styling = (
  // thm-styling: thm-styling-simple,
  thm-numbering: thm-numbering-linear,
  // ref-styling: ..
)

// #set heading(numbering: "1.a", )

#set enum(numbering: "a)")

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


#question[*Linkage Disequilibrium*
A through H are different SNP marker loci, each with alleles 1 and 2. Which of the following haplotypes shows evidence of substantial linkage disequilibrium, given the individual allele frequencies? What is the degree of linkage disequilibrium r2 in each case?
]
+ A1 – B1	    population frequency 0.101; A1 = 0.532 and B1 = 0.334
  #answer[
    $ 
    p_(A^1 B^1)  &= (0.101 - 0.532 dot 0.334)^2/(0.532 dot (1 - 0.532) dot 0.334 dot (1 - 0.334)) 
              &= 0.106188 
    $
  ]
+ G2 – H1	    population frequency 0.101;   G2 = 0.231  and H1 = 0.431
  #answer[
    $ 
    p_(G^2 H^1)  &= (0.101 - 0.231 dot 0.431)^2/(0.231 dot (1 - 0.231) dot 0.431 dot (1 - 0.431)) 
              &= 0.0000475328
    $
  ]

#pagebreak()

#question[
  What is the problem of population admixture and how can it lead to false positives in GWAS analyses?
]

#answer[
  Population admixture occurs when individuals from different populations interbreed, leading to a mixing of genetic backgrounds. This can result in false positives in GWAS analyses because the genetic variants associated with a trait may be confounded by population structure, making it difficult to determine whether the observed associations are due to the trait linkage or simply reflect differences in allele frequencies between populations.
]

#question[One	study	examined theassociation	between	5	SNPs and diseases and reported the association
below	shows	the	raw	P	values.	Which	one(s) are significantly associate with the disease	
via	Bonferroni correction? Which one(s)	are	significantly	associated with	the	disease	via	
Holm-Bonferroni	correction?	The	significance level is	0.05.	

#table(columns: (auto, auto, auto, auto, auto, auto) , [SNPs],	[A],	[B],	[C],	[D], 	[E],
[P-value],	[0.16], [0.022],	[0.0004],	[0.02],	[0.012]	)

]

#answer[
  #table(columns: (auto, auto, auto, auto, auto, auto) , 
  [SNPs],       [C],	      [E], 	    [D],     [B],	     [A],	          
[P-value],    [0.0004],     [0.012],	[0.02],	[0.022],    [0.16], 		     
[$alpha/(m+1-k)$], [0.01],  [0.0125], [0.0166667],  [0.025], [0.05],          
[$alpha/m$],        [0.01], [0.01] , [0.01], [0.01], [0.01],
)
Thus $k = 3$: Via Bonferroni correction, E, A, D, and B are significantly associated with the disease. Via Holm-Bonferroni correction, D, B, A are significant.]


#question[
Further Study showed	that	SNPs	C	and	D	are located	in	the	exons	while	SNPs	A,	B	and	E	are	located	in	the	promoters.	Based	on	the	p	values	generated	by	Holm-Bonferroni	correction,	please	speculate	on	how	SNPs	that	are	significantly	associated	with	disease	may	affect	the	gene	function.	
]

#answer[
  D, B, A are significantly associated and D is located in the exons, thus D is likely affecting the gene function. A, B are located in the promoters, thus they may affect the gene expression. C & E are likely irrelevant.
]

#pagebreak()
#question[Further	study	showed	that	SNP	E	leads	to	a	reduction	of	the	
downstream	gene	expression.	To	determine	whether	SNP	E	regulates	gene	expression	by	
controlling	the	open	and	close	states of	chromatin, you	plan to	measure	histone	
modification and DNA methylation levels. Please	predict	how	SNP	E	affects	the	following	
epigenetic	marks	compared	to	wildtype allele,	increased	or	decreased.	
]

#answer[
  Since it reduce downstream gene expression, it is likely that it will reduce the open chromatin state and increase the closed chromatin state. Thus, we expect to see the following changes in epigenetic marks: \

H3K9ac: Decreasing \ 
H3K9me3: Increasing \
H3K4me3: Decreasing \
DNA	methylation: Increasing \		


]	