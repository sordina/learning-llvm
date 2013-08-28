
----

# The Garden

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
Prune
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
