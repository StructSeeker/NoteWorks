==
An article about how to teach myself linear algebra

== Universal Algebra
The four isomrophism theorem of universal algebra naturally holds for module as well. What's special is about module is that a congruence uniquely cooresponds to a subalgebra, resulting in 

== Dimension and Basis
Matroid methods leads to proving the number of basis is an invariant.


== Localization
We wants to complete the commutative ring by introducing $x u = v$, and wants it to be compatible with congruence by:
$
  cases(x u ~ v ,  x u' ~ v') => cases(x u u' ~ v u', x u' u ~ v' u) => v u' ~ v' u  
$
Also a congruence also need to be transitve:
$ (u, v) ~ (u', v') and (u', v') ~ (u'', v'') \
  u v' = v u' and u' v'' = v' u'' \
  u v' v'' = v u' v'' and v u' v'' = v v' u'' \
  (u v'' - v u'') v' = 0 
$
Thus we obtain the localization condition


#bibliography("Algebra.bib")