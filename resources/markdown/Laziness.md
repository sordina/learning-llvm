
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
// The Fibonacci Sequence in all its glory~
//
function fibs() { return [1, cons(1, zipWith(add, fibs, tail( fibs )))] }

exports.main = function() { runList(fibs, 13) }

// Helpers
//
function cons(h,t)        { return function() { return [h,t] }}
function head(list)       { return list()[0] }
function add(x,y)         { return x + y }
function tail(list)       { return function() { return list()[1]() }}

function zipWith(f, x, y) { return function() {
                            return [ f(head(x), head(y)),
                                     zipWith(f, tail(x), tail(y))] } }

function runList(list, n) { while(n-- > 0) {
                            console.log(head(list)); list = tail(list)}}
~~~

The main difference between a normal recursive definition and this one
is that the recursion happens at the value level, as opposed to the
function-call location.
