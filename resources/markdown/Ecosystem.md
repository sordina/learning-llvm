
----

# Ecosystem

The Haskell ecosystem is large and interesting, it is held together more
by convention than by dictation, with the current convention being that
open source packages are made available through `cabal` on Hackage.


## Cabal

Cabal is a library package, but "cabal" is often used to refer to the
cabal executable provided by the "cabal-install" package.
These packages are both provided by the Haskell Platform.

The premiere online Cabal package repository is [Hackage.](http://hackage.haskell.org/)

Cabal provides mechanisms for download and installing packages
from Hackage onto your system. It also provides a consistent
way to structure, export, test, and package your own programs.

```instruction
 

Install the hlint package from hackage.

Use the `hlint` command-line program to to check for stylistic issues in one
of your previous solutions.
```

```{ .answer }
Information about the hlint package can be found at

* hackage.haskell.org/package/hlint
* http://www.haskell.org/hoogle/?hoogle=hlint

etc.

The command used to install the hlint package is

> cabal install hlint

Although you may have to run

> cabal update

to ensure that your list of packages is up to date.

Once you have the hlint tool installed you can run it like so:

> hlint dragon.hs

    dragon.hs:35:17: Warning: Redundant $
    Found:
      flip zip (map toLower text) $ dragon_points
    Why not:
      flip zip (map toLower text) dragon_points
```

```open
An open-ended question:

How would you go about publishing your own package to Hackage?
```
