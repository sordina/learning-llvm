


f x y = x + y

a = "this is a string"

b = (1,"hello")


-- This is a comment

{- This is a
   Multi-Line comment
 -}

list = ["asdf","qwer"]

data MyDatatype = Foo String | Bar Int

-- GHCi
--
-- Inspecting types
-- > :t my_variable
--
-- Reloading
-- > :r
--
-- Expressions
-- > 1 + 1
--
-- IO
-- > print "hello world"


-- Type Signatures

my_int :: Int
my_int = 1

my_function :: Int -> Int
my_function x = x + 5

my_multi_arg_function :: String -> String -> String
my_multi_arg_function firstname lastname = "Hello " ++ firstname ++ " " ++ lastname




-- Intro:
-- * Functions
-- * Primitives (Int, List, Char (strings), Tuples, Maybe)
-- * Types
-- * Pattern Matching
-- Numbers
f 1 = "One"
f 2 = "A Couple"
f _ = "A bunch"
-- Tuples
g (x,y) = x
h (x,y) = y



-- ADTs:
-- Sum:
data Strong = HeMan | Arnie -- Strong Typing
-- Product:
data Duck = Duck String Int -- Duck Typing
-- Most complex - Recursive, Sums, Products, Parameterised

-- Typeclasses:

-- Monads:

-- Ecosystem:

-- Wildcard: Music
