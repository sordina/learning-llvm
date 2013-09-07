
----

# Testing

Haskell's type-system allows you to eliminate many kinds of errors
that are usually combated using testing in more dynamic languages.

However, just because the type system can prevent some classes of
error, doesn't mean that it can catch them all.

<div class="center"> ![Pokemon](resources/images/pokemotto.png) </div>

There are a couple of really useful approaches to testing used
commonly by Haskell programmers:

* [QuickCheck](http://hackage.haskell.org/package/QuickCheck)
* [HUnit](http://hackage.haskell.org/package/HUnit)

QuickCheck focuses primarily on testing pure code,
while HUnit provides means to test code that lives in the IO monad.

In the world of unit-testing, generating data can be a pain.
Coming up with concise examples that test edge-cases and don't
bother repeating useless properties is a real art-form
that can take longer than writing the code to solve the problem
at hand.

In many languages, frameworks and libraries have sprung up
to aid with this problem by providing ways to generate
various forms of valid and invalid test-data on demand.

An example of this form of library in Ruby is
[Factory Girl](https://github.com/thoughtbot/factory_girl). You specify the
structure and properties of the data you want generated, and
using the helpers provided by the framework you will
be able to generate many unit tests to ensure that your
application's code behaves as expected!

But hang-on... Why would we go about telling a Haskell library
what the structure of our data looks like when in a great-deal
of cases - Haskell already knows?

This is where the `Arbitrary` type-class from QuickCheck steps
up to bat for us!

-----

Let's say that we have a function `hyphenate` that takes a sentence and
turns the spaces into hyphens - There should be no trailing
or leading hyphens unless they were already there to begin
with, and there should be no instance of multiple hyphens
in a row in our output - For example:


```
"hello world"      => "hello-world"
"say     whaaaaa?" => "say-whaaaat?"
```

We get pretty excited and code up an enterprise solution ~

~~~{ data-language=haskell data-filter=./resources/scripts/check.sh }
hyphenate :: String -> String
hyphenate s = map (replace ' ' '-') s

replace :: Char -> Char -> Char -> Char
replace x y c | c == x    = y
              | otherwise = c
~~~

Great!

Those examples we looked at earlier kind of look
like some test-data. Let's write some unit-tests.

~~~{ data-language=haskell .nocheck }
test1 :: Bool
test1 = hyphenate "hello world" == "hello-world"

test2 :: Bool
test2 = hyphenate "say     whaaaaa?" == "say-whaaaat?"
~~~


_Awwwwwww yis._

... Except test2 fails spectacularly... Hmm...

So we fix our test-data, we fix our function (hopefully?) and
code up a few more tests, only to find we missed another
edge-case when our client comes back with some trailing hyphens
and mad as a raging bull... There has to be a better way!


Enter QuickCheck -

Rather than writing tests for individual applications, we write
properties that cover the various specifications of the
desired behavior:

~~~{ data-language=haskell .nocheck }
import Data.List

prop_no_spaces :: String -> Bool
prop_no_spaces s = not (elem ' ' (hyphenate s))

prop_no_leading :: String -> Bool
prop_no_leading s = case hyphenate s of (x:xs) -> x /= '-'
                                        _      -> True

prop_no_trailing :: String -> Bool
prop_no_trailing s = prop_no_leading (reverse s)

prop_no_multiple :: String -> Bool
prop_no_multiple s = not (elem "--" (concatMap tails (inits s)))
~~~

That's all well and good, but how does that help us?

Check this out!

```
> quickCheck +names hyphen-solution-and-tests.hs
[Prelude] > [1 of 1] Compiling Main ( hy.hs, interpreted )
Ok, modules loaded: Main.
[*Main] > prop_no_spaces: +++ OK, passed 100 tests.
[*Main] > prop_no_leading: *** Failed! (after 44 tests and 7 shrinks):
" "
[*Main] > prop_no_trailing: +++ OK, passed 100 tests.
[*Main] > prop_no_multiple: +++ OK, passed 100 tests.
[*Main] > Leaving GHCi.
```

ZOMG - So much free test data!

This found an edge-case for us without too much trouble,
and what's more, narrowed it down to the minimal failing example!

```real
If you want to be able to take advantage of QuickCheck in the
fashion performed in the example you will need to install
QuickCheck and quickcheck-script:

> cabal install quickcheck quickcheck-script
```

In order to take advantage of QuickCheck's data-generation
for custom data-types - take a look at the 
[Arbitrary](http://hackage.haskell.org/packages/archive/QuickCheck/2.6/doc/html/Test-QuickCheck-Arbitrary.html)
type-class.

```instruction
Write QuickCheck properties for the constraints required in the
Rose-Tree exercise from The Garden.
```

<div class="important">

[Link to The Garden Chapter](#the-garden)

</div>
