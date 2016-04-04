(* 
Models of computation:
  1. Turing machines            -> assembly language, C, C++, Python
  2. Grammars (rewrite systems) -> Maude, Prolog (logic programs)
  3. Lambda calculus            -> computing is doing "algebra"
*)

(*
Lambda calculus
Terms:                      also (M N) P
  A term is either:
  - An identifier (variable) x, y, z, ...
  - λx.M  where x is an identifier and M is a λ-term    <- this is intuitively a function
  - M N   where M, and N are λ-terms                    <- this is an application
  - (M)   where M is a λ-term

e.g.
  λx.x
  λx.y      <- y here is a free identifier
  (λx.x)y   <- second x here is a bound identifier

                       V-body of λ
occurences of x inside M are said to be "bound" occurences
an identifier that is not bound is said to be free
    
you can always rename bound identifiers (as long as you're consistent about it)
  |> two terms that are the same up to ren bound identifiers are ∝-equivalent
    e.g (λx.x) (λy.y)
    and (λz.z)(λa.a) are ∝-equivalent

substitution:  M[x <- N]    {substitute N for x in M}
e.g. 
  λy.x y [x <- z a]       => λy.(z a) y
  λy.x(λx.x) [x <- z a]   => λy.(z a) (λb.b)    {can only substitute the free terms}
                                        ^- name is irrelevant
  x [x <- N]    => N
  y [x <- N] (when x != y)   => y
  (M1 M2) [x <- N]    => (M1 [x <- N] M2 [x <- N])
  (λy.M) [x <- N] when x+y and [y not free in N]  => (λy.M [x <- N])


There is only one rule of simplification:
  (λx.M) N    => M [x <- N]
  ---------> a redex
A term is in normal form when it cannot be simplified
  Not every term has a normal form


                                                    IF WE HAD NUMBERS (e.g)
                                                      (λx. (x + 1)) 2
                                                        => 2 is x, so 2 + 1 = 3
e.g.
  (λx.x) y
   = y
  (λx.x) (λy.y)
   = λy.y
  λx.x y
   => (interpreted as) (λx.(x y))
   = doesn't simplify
  λx.((λy.z) x)
   = λx.(z [y <- x]) which results in λx.(z)
   = λx.z
  (λx.x x) (λx.x x)  <-not normal form
   =  ---M --------N
   = M [x <- N]
   = (x x) [x <- N]
   = (x [x <- N] x [x <- N])
   = N N
   = (λx.x x) (λx.x x)



true  = λx.(λy.x)
false = λx.(λy.y)
if    = λc.(λx.(λy.c x y))
and   = λm.(λn.(if m n false)) = (simplified)  λm.(λn.m n m) <- and true true   = true
                                                                and true false  = false
                                                                and false true  = false
                                                                and false false = false
or    = ???
not   = ???

if = λc.(λx.(λy.c x y))
  e.g. 
    ((if true) a) b 
     = (((λc.(λx.(λy.c x y))) (λx.(λy.x))) a) b
  redex  ------------------M  ----------N
     = ((λx.(λy.(λp.(λq.p)) x y)) a) b    use H as placeholder H=λy.(λp.(λq.p)) x y
     = (H [x <- a]) b
     = (λy.(λp.(λq.p))a y) b    use H as a new placeholder H=(λp.(λq.p))a y
     = (λy.H) b
     = H [y <- b]
     = ((λp.(λq.p))a) b
     = (λq.a) b
     = a

    so   if true  a b = a
    also if false a b = b


Encoding natural numbers:
  0 = λf.(λx.x)
  1 = λf.(λx.f x)
  2 = λf.(λx.f (f x))
  3 = λf.(λx.f (f (f x)))
  ...
  n = λf.(λx.f^n x)

succ (successor) = λn.(λf.(λx.(n f) (f x)))

succ 0 = (λn. H) (λf.(λx.x))
       = λf.(λx.((λf.(λx.x))f) (f x))
       = λf.(λx.(λx.x)(f x))
       = λf.(λx. WELP he erased it, crap)

succ 1 = (λn.H)(λf.(λx.f x))
       = λf.(λx.((hg.(λy.g y)) (f x)))
       = λf.(λx.(n f) (f x))
       = λf.(λx.((λf.(λx.x)) f) (f x))
       = λf.(λx.(λy.f y) (f x))
       = λf.(λx.f (f x)) = 2

plus = λm.(λn.(λf.(λx.(m f) (n f x))))
e.g.
  plus 1 2 = 3

times = λn.(λn. (λf.(λx.m(n f) x)))
e.g.
  times 2 3 = 6

iszero? = λn.n(λx.false) true

pred = ??? (predecessor function, supes messy)



fact (factorial) = λn.if (iszero? n) 1 (times n (fact (pred n)))

Ffact (fixed-point of fact, a solution)
    F = λF.(λn.if (iszero? n) 1 (times n (F (pred n))))
suppose we have a fixed-point of F:
  say g is a fixed-point of F.
    F(g) = g or
    g = F(g) = (λn.if (iszero? n) 1 (times n (g (pred n))))
    replacing g with fact
    fact = F(g) = (λn.if (iszero? n) 1 (times n (fact (pred n))))


every function in the lambda calculus has a fixed point
  and we can find it (super easily)

Finding fixed points in the λ-calculus:
  Y = λf.(λx.f(x x)) (λx.f(x x))
  
  Given G.
  YG = (λx.G(x x)) (λx.G(x x))
     = G (N N)      ---------N
     = G ((λx.G(x x)) (λx.G(x x)))
     = G (G(N N))      -----------N
     = G(G((λx.G(x x)) (λx.G(x x))))
         ---------------------------same as above bit, know it equals YG
     = G(Y G)

  so YG = G(YG)

so fact = Y (λf.(λn.if(iszero? n) 1 (times n (f (pred n))))
  fact 3 = 6
*)