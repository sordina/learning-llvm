
----

# The Garden

This chapter will focus on various kinds of trees.

~~~{ data-language=haskell data-filter=resources/scripts/check.sh }
data BinaryTree a = Empty | Node a (BinaryTree a) (BinaryTree a)
~~~~

~~~{ data-language=haskell data-filter=resources/scripts/check.sh }
data RoseTree a = Node a [RoseTree a]
~~~~

~~~{ data-language=haskell data-filter=resources/scripts/check.sh }
type Forrest a = [Tree a]
data Tree a = Branch a (Forrest a)

countF :: Forrest a -> Int
countF = sum . map countT

countT :: Tree a -> Int
countT (Branch _ f) = 1 + countF f
~~~~

```instruction
You have a Garden full of RoseBushes

Aphids

Seccatirs
```

```instruction
Graft
```

```instruction
Weed
```

```instruction
Recreation

Ignore recursion with the power of parameters
```

```poem
Our adventurer intrepid, climbing high in hopes to find...
a single solitary flower, ends up being left behind.
Each fork of branches he encounters leave him in a deeper bind.
This thorny tree falls easiest with axes of another kind.
```

~~~{ data-language=haskell .nocheck }
data RoseTree a = Node a [RoseTree a]

quest :: RoseTree (Maybe Rose)
quest = undefined

solution = climb quest
	where
		climb (Node (Just rose) branches) = rose
		climb (Node Nothing     branches) = map climb branches .... ?? !!!!

-- Another kind..... If a RoseTree is a Monad (of kind "* -> *")

instance Monad RoseTree where
  return x = Node x []
  Node x ts >>= f = Node x' (ts' ++ map (>>= f) ts)
    where Node x' ts' = f x

branches :: RoseTree a -> [RoseTree a]
branches f (Node a bs) = a : bs

solution2 = iterate (>>= branches) quest
~~~

