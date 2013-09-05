
----

# Ecosystem

The Haskell ecosystem is large and interesting, it is held together more
by convention than by dictation.


## Cabal


The premiere online Cabal package repository is "Hackage".

```instruction
 

Install the hlint package from hackage.

Use the command-line to to check for stylistic issues in one
of your previous solutions.
```

```{ .answer }
Information about the hlint package can be found at

* hackage.haskell.org
* www.haskell.org/hoogle

etc.

The command used to install the hlint package is

> cabal install hlint

Although you may have to run

> cabal update

to ensure that your list of packages is up to date.

Once you have the hlint tool installed you can run it like so:

> hlint temp/dragon.hs

    temp/dragon.hs:35:17: Warning: Redundant $
    Found:
      flip zip (map toLower text) $ dragon_points
    Why not:
      flip zip (map toLower text) dragon_points
```


