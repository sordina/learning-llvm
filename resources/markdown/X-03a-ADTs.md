
----

\pagebreak


ADTs (Algebraic Data Types)
===========================

### ... and Sanity Checking


Ensure that you have the following programs installed and functioning correctly:

* GHC(i)

At a command prompt, enter the following command:


```shell
ghci
```

This should launch the GHC Haskell REPL.

Type the following to ensure that you have a functioning REPL:

~~~{data-language="haskell"}
1 + 1
~~~

This should yield the result:

```text
2
```

Create the following source file (program.hs):

~~~{data-language="haskell"}
main = print "hello world"
~~~

Compile the program as follows:

```shell
ghc --make program.hs
```

Run the program with the following command:

```shell
./program
```

The output should look as follows:

```text
"hello world"
```

## Cabal

You should have access to a Cabal installation if you have installed the Haskell Platform.

Check that you have cabal by running:

```shell
cabal --version
```

This should output something similar to:

```text
cabal-install version 1.16.0.2
using version 1.16.0 of the Cabal library
```
