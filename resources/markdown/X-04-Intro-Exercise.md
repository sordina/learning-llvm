
----

\pagebreak

# Opening Exercises

## Variables

In Haskell you can define a variable with the `=` sign.

These can be used in a top-level definition (no-indentation):

~~~{data-language=haskell}
my_variable = 1
~~~

Variable names should start with a lowercase letter and contain no spaces, or special characters, besides underscores, numbers, and `'`.

```instruction
Ex. 1.1 - Define your own variable.
```

## Type Signatures

You can annotate a definition with a valid type-signature:

# TODO: Decide if we should introduce how to define items in GHCi {.todo}

~~~{data-language=haskell}
my_variable :: Int
my_variable = 1
~~~

```instruction
Ex. 1.2 - Give your variable a type-signature.
```

## String Literals

String literals look familiar:

~~~{data-language=haskell}
my_string :: String
my_string = "hello world"
~~~

```instruction
Ex. 1.3 - Define a variable containing a string.
```

## Tuples

Tuples look like this:

~~~{data-language=haskell}
my_tuple_pair :: (Int, String)
my_tuple_pair = (1,"hello")

my_tuple_trio :: (Int, String, Int)
my_tuple_trio = (1,"hello",3)
~~~

They can be used to group multiple, differently-typed (heterogeneous) values.

```instruction
Ex. 1.4 - Define a variable containing a tuple.
```

## Functions

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


```instruction
Ex. 1.5 - Define a function `my_multiply` that multiplies 3 numbers.
```

```instruction
Ex. 1.6 - Give your function a type-signature
```

~~~{data-language=haskell .answer}
my_multiply :: Int -> Int -> Int -> Int
my_multiply x y z = x * y * z
~~~

# TODO: Decide if variables should include underscores {.todo}


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

```instruction
Ex. 1.7 - Define a variable containing a list.
```

```instruction
Ex. 1.8 - Give your variable a type-signature.
```

You can deconstruct a list by pattern matching the head and tail like so:

~~~{data-language=haskell}
f (x:xs) = ...
~~~

```instruction
Ex. 1.9 - Define a function to get the first element of a list.
```

Note: In `Prelude` this function is called `head`.

~~~{.answer data-language=haskell}
myHead (x:xs) = x -- This is a partial function, Beware!
~~~

```instruction
Ex. 1.10 - Define a variable containing the first element of your list.
```

~~~{.answer data-language=haskell}
myFirstElement = myHead myList
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

### Define `myMap`

```instruction
Ex. 1.11 -

Define a function that takes a function from a to b "a -> b",
and a list of as "[a]",
and returns a list of bs "[b]".
```

Things to consider:

* What is the type-signature of myMap?
* What is the base-case of myMap?

~~~{.answer data-language=haskell}
myMap :: (a -> b) -> [a] -> [b]
myMap f [] = []
myMap f [] = []
myMap f (x:xs) = f x : myMap f xs
~~~

## Fun Functions

For your reading pleasure, here are some definintions of common functions:

~~~{data-language=haskell}
myfilter f []     = []
myfilter f (x:xs) = if f x then x : myfilter f xs
                           else     myfilter f xs

myFold f z []     = z
myFold f z (x:xs) = f x (myFold f z xs)

myReverse []     = []
myReverse (x:xs) = myReverse xs ++ [x]

myElem e []     = False
myElem e (x:xs) = if e == x then True
                            else myElem e xs
~~~

See if you can find the signatures for these functions.

# TODO: Hide .answers in PDF {.todo}
