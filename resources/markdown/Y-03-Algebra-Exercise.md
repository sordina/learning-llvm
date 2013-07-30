
----

\pagebreak

# Exercise - Symbolic Differentiation

Your Highschool math teacher has decided to introduce differentiation of single-variable polynomials...

This is in super easy once you grasped the concept:

Polynomial term differentiation:

<div class="center"> $$ a . x^n . \frac{d}{dx} = n.a.x^{n-1} $$ </div>

Linearity of differentiation:

<div class="center"> $$ (a + b) \frac{d}{dx} = a \frac{d}{dx} + b \frac{d}{dx} $$ </div>

But you don't wish to perform the undoubtedly large number of rote-examples required after your moment of epiphany.

In this exercise you should develop a data-type to represent a single-variable polynomial expression.

After you feel confident that you can represent any such expression, write
a function using the two rules listed to provide the following function:

~~~{data-language=haskell}
differentiate :: Polynomial -> Polynomial
differentiate = ...
~~~

