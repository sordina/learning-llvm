
----

# Laziness

Haskell's evaluation strategies ~ Exploring the magic.

Often when looking at exaples of Haskell functions you will come across
examples of laziness in action.
The cannonical example used to demonstrate the lazy recursive approach used in Haskell
the definition of the list of Fibbonacci numbers -

~~~{ data-language=haskell data-filter=./resources/scripts/check.sh }
fibs = 1 : 1 : zipWith (+) fibs (tail fibs)
~~~

This is a good one!

Most programmers won't have any problem with the usual recursive definition
of `fibs`, so what makes this one special? Let's see if we can implement this
function in a more familiar language -

~~~{ data-language=javascript }

function fibs() {
	
}

~~~
