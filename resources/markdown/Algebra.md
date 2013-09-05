
----

# Symbolic Differentiation

Your Highschool math teacher has decided to introduce differentiation of single-variable polynomials...

This is in super easy once you grasped the concept:

<div class="important">

Polynomial term differentiation:

<div class="center"> $$ a . x^n . \frac{d}{dx} = n.a.x^{n-1} $$ </div>

Linearity of differentiation:

<div class="center"> $$ (a + b) \frac{d}{dx} = a \frac{d}{dx} + b \frac{d}{dx} $$ </div>

</div>

But you don't wish to perform the undoubtedly large number of rote-examples required after your moment of epiphany.

~~~{data-language=haskell .nocheck}
differentiate :: Polynomial -> Polynomial
differentiate = ...
~~~

<div class="important">

The data-types used to represent a `Polynomial` are as follows:

~~~{ data-language=haskell data-filter=./resources/scripts/check.sh }
data Constant   = C Int             deriving (Show, Eq)
data Power      = U Int             deriving (Show, Eq)
data Term       = T Constant Power  deriving (Show, Eq)
data Polynomial = P [ Term ]        deriving (Show, Eq)
~~~

The `x` variable is implicit in the Term data-type.

</div>


```instruction

  
Create a function "differentiate" that takes a Polynomial, and returns a new
Polynomial that has been differentiated with respect to x.
```
