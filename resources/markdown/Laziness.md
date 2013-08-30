
----

# Laziness

<div class="center">

_Haskell's evaluation strategies ~ Exploring the magic._

</div>

Often when looking at examples of Haskell functions you will come across
examples of laziness in action.
The canonical example used to demonstrate the lazy recursive approach of Haskell
is the definition of the list of Fibonacci numbers -

~~~{ data-language=haskell data-filter=./resources/scripts/check.sh }
fibs = 1 : 1 : zipWith (+) fibs (tail fibs)
~~~

This solution has a reputation for being somewhat mind-bending for
beginners... What is going on here?

```real
In order to show the start of an infinite list, use the `take` function -

For example:

[Prelude] > let fibs = 1 : 1 : zipWith (+) fibs (tail fibs)
[Prelude] > take 10 fibs
[1,1,2,3,5,8,13,21,34,55]
```

Here is a Fibonacci solution in Javascript:

~~~{ data-language=javascript }
function fib(n) {
	if(n < 2) return 1
	return fib(n-1) + fib(n-2)
}
~~~

Most programmers won't have any problem with the usual recursive definition
of `fibs`, so what makes the Haskell one special? Let's see if we can implement
the Haskell version in Javascript:

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

function runList(list, n) { while(n --> 0) {
                            console.log(head(list)); list = tail(list)}}
~~~

The main difference between a normal recursive definition and this one
is that the recursion happens at the value level, as opposed to the
function-call location.

```instruction
 

Implement an infinite list of ascending numbers using lazy,
value-based recursion.
```

~~~{ data-language=haskell data-filter=resources/scripts/check.sh .answer}
ascending = 1 : zipWith (+) ascending ascending
~~~

```open
An open-ended question:

Can all numberic-lists be defined by using value-based recursion?
```
