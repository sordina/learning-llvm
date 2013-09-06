
----

# Monads

There are two main ways to attack Monads -

* Theoretical
* Practical

We'll take the practical route today.

`do` expressions in Haskell can take the following form:

~~~{ data-language=haskell .nocheck }
do
  PATTERN <- Monadic Value
  ...
  Monadic Value
~~~

You can use do expressions to perform IO in a similar style to an
imperative program:

~~~{ data-language=haskell data-filter=./resources/scripts/check.sh }
import System.IO

main :: IO ()
main = do
   ()        <- print "Please enter your first name:"
   firstname <- getLine
   ()        <- print "Please enter your last name:"
   lastname  <- getLine
   ()        <- print "Please enter your title:"
   title     <- getLine
   ()        <- print "Please enter your address:"
   address   <- getLine
   ()        <- print ("Hello " ++ title ++ " " ++ lastname)
   ()        <- print "Would you like to recieve a magazine subscription..."
   ()        <- print ("to your address '" ++ address ++ "'?")
   flag      <- readLn
   ()        <- if flag then print "No worries!"
                        else print "We'll keep our magazine then!"
   return ()
~~~
