
----

ADTs (Algebraic Data Types)
===========================

<div class="center">
[Haskell Wiki Link](http://www.haskell.org/haskellwiki/Algebraic_data_type)
</div>

Algebraic Data Types are THE bread and butter of Haskell programs.

* Functions evaluate data by pattern-matching against ADTs
* Domains are modeled using ADTs
* Laziness is linked to ADTs
* Types can be derived from ADT definitions

<div class="collapse">

But how does that help me?

An example of an ADT in Haskell:

~~~{data-language=haskell data-filter=./resources/scripts/check.sh}
data MyBool = MyTrue | MyFalse | MyNotSure

should_I_eat_something_bigger_than_my_own_head :: MyBool
should_I_eat_something_bigger_than_my_own_head = MyFalse
~~~

```real
With this functionality, you are able to introduce your own "Enum"
values.

The MyBool example is somewhat equivalent to the following C++ code:

enum MyBool { MyTrue, MyFalse, MyNotSure };

With the added bonus of not having out-of-bounds casting ruin your day.

If your problem space can be moddeled using various discrete values,
then this form of ADT will allow you to create a program that mirrors
your problem!
```


You can add parameters to the data constructors:

~~~{data-language=haskell data-filter=./resources/scripts/check.sh}
data MyNullString = Nada | MyString String

stringy :: MyNullString
stringy = MyString "Whatever, It's just a string"

blanky :: MyNullString
blanky = Nada
~~~

Constructors can take multiple parameters:

~~~{data-language=haskell data-filter=./resources/scripts/check.sh}
data SomeJunk = Rubbish String | TrashPile String Int Bool

discards :: SomeJunk
discards = TrashPile "Junk Yard" 42 True
~~~

Furthermore, ADTs can be recursive:

~~~{data-language=haskell data-filter=./resources/scripts/check.sh}
data MyNumberList = Nada | SomeNumbers Int MyNumberList

numbers :: MyNumberList
numbers =  SomeNumbers 1 (SomeNumbers 2 Nada)
~~~

Finally, ADTs can be parametrised by other types:

~~~{data-language=haskell data-filter=./resources/scripts/check.sh}
data MyContainer x = Jar x

contained :: MyContainer Int
contained = Jar 1

pun :: MyContainer (MyContainer String)
pun = Jar (Jar "Binks")
~~~

In general, the syntax of an ADT looks similar to the following:

```bnf
ADT          := data <TypeName> <Variables> = <Constructors>
TypeName     := [A-Z] + [a-z'_]*
Parameters   := <ConcreteType> + (" " + <ConcreteType>)*
Constructors := <Constructor> + (" | " + <Constructor>)*
Constructor  := <TypeName> + <Parameters>
Variables    := <Variable> + (" " + <Variable>)*
Variable     := [a-z] + [a-z'_]*
```

ConcreteType can't be defined syntactically, but it means that your type is
"Fully Applied" (in Haskell terms, has a kind of `*`). An example of some concrete types
are:

* `String`
* `Int`
* `Maybe String`
* `[Int]`

Examples of some non-concrete types are:


With all of this power at your disposal, it's time to define a list ADT yourself.

</div>

```instruction
Ex. 3a.1 - Define your own list ADT.
```

Things to consider:

* Should this ADT be parametrised?
* Should this ADT be recursive?
* Should this ADT have multiple constructors?
* Should the constructors be parametrised?

~~~{data-language=haskell .answer data-filter=./resources/scripts/check.sh}
data MyList a = Empty | Items a (MyList a)
~~~

```instruction
An open-ended question:

What would the ADT for a LISP-like language look like?
```

<div class="note">
If you wish to learn about why ADTs are "Algebraic", then have a look at:

* [The Algebra of Algebraic Data Types, Part 1](http://chris-taylor.github.io/blog/2013/02/10/the-algebra-of-algebraic-data-types/)
* [The Algebra of Algebraic Data Types, Part 2](http://chris-taylor.github.io/blog/2013/02/11/the-algebra-of-algebraic-data-types-part-ii/)
* [The Algebra of Algebraic Data Types, Part 3](http://chris-taylor.github.io/blog/2013/02/13/the-algebra-of-algebraic-data-types-part-iii/)
</div>
