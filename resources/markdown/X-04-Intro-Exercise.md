
----

\pagebreak

# Introductory Exercise

## Variables

In Haskell you can define a variable with the `=` sign.

These can be used in a top-level definition (no-indentation):

~~~{data-language=haskell}
my_variable = 1
~~~

## Type Signatures

You can annotate a definition with a type-signature:

~~~{data-language=haskell}
my_variable :: Int
my_variable = 1
~~~

## String Literals

String literals look familiar:

~~~{data-language=haskell}
my_string :: String
my_string = "hello world"
~~~

## Tuples

Tuples look like this:


~~~{data-language=haskell}
my_tuple_pair :: (Int, String)
my_tuple_pair = (1,"hello")

my_tuple_trio :: (Int, String, Int)
my_tuple_trio = (1,"hello",3)
~~~

They can be used to group multiple, differently-typed (heterogeneous) values.


## Function

Functions are a core part of Haskell. Function definitions look like this:


~~~{data-language=haskell}
my_function :: ... -> ...
my_function x y ... = ...
~~~

If a function `f` takes something of type `a` and returns something of type `b` we write the type signature as:

~~~{data-language=haskell}
f :: a -> b
~~~

For example:

~~~{data-language=haskell}
my_add :: Int -> Int -> Int
my_add x y = x + y
~~~

`my_add` takes two numbers and returns the result of the addition of those two numbers.

## Lists

List are a commonly used data-structure in Haskell. Everything in a list has the same type (they are homogeneous).

Lists are built using the infix data-constructor `(:)` (pronounced "cons"). They also have a compact notation using `[...]`.

List literals look like:

~~~{data-language=haskell}
list1 :: [Int]
list2 :: [Int]
list3 :: [String]

list1 = [1,2,3]
list2 = 1 : 2 : []
list3 = "hello" : "world" : []
~~~

You can deconstruct a list by pattern matching the head and tail like so:

~~~{data-language=haskell}
f (x:xs) = ...
~~~

### Define Length

Define a function that takes a list and returns the length. In Haskell type-signature syntax, this is written as:

~~~{data-language=haskell}
mylength :: [a] -> Int
~~~

Your solution should have the form of:

~~~{data-language=haskell}
mylength []     = ...
mylength (x:xs) = ...
~~~

Things to consider:

* What is the length of an empty list? (the base case)
* What is the length of xs?

~~~{.answer data-language=haskell}
mylength []     = 0
mylength (x:xs) = 1 + mylength xs
~~~

### Define Map

~~~{.answer data-language=haskell}
mymap f [] = []
mymap f (x:xs) = f x : mymap f xs
~~~

For your reading pleasure, here are some definintions of common functions:

~~~{data-language=haskell}
myfilter f []     = []
myfilter f (x:xs) = if f x then x : myfilter f xs
                           else     myfilter f xs
~~~

~~~{data-language=haskell}
myfold f z []     = z
myfold f z (x:xs) = f x (myfold f z xs)
~~~

# TODO: Hide .answers {.todo}
