
----

Setup
=====

<div class="important">
Ensure that you have the following programs installed and functioning correctly:

## GHCi
</div>

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

```real
You can use GHCi to perform calculations other than just "1 + 1".

Here is an example session:

lyndon@endpin ~ ghci
GHCi, version 7.6.2: http://www.haskell.org/ghc/  :? for help
Loading package ghc-prim ... linking ... done.
Loading package integer-gmp ... linking ... done.
Loading package base ... linking ... done.
[Prelude] > 1 + 2 + 3
6
[Prelude] > 100 / 2
50.0
[Prelude] > 6 ^ 7
279936
[Prelude] > ^D
Leaving GHCi.
```

```instruction
Using GHCi...

Calculate the price of 42-bakers-dozens of eggs at $3 per-egg.
```

```answer
[Prelude] 42 * 13 * 3
1638
```

## Loading files in GHCi {.important}

There are many ways to load and execute Haskell code. For the purposes of this workshop,
if you do not already have a workflow you are comfortable with, then we suggest the
following steps:

* Write and edit your programs in files ending in the extension ".hs"
* When you are ready to test your program, load it into GHCi
* After making modifications to your program, reload the program in GHCi

Say you had written the following program `test.hs` in your home directory:

~~~{data-language=haskell data-filter=./resources/scripts/check.sh}
main = print "hello world"
~~~

Load the file in GHCi to see it in action:

```shell
lyndon@endpin ~ ghci test.hs
GHCi, version 7.6.2: http://www.haskell.org/ghc/  :? for help
Loading package ghc-prim ... linking ... done.
Loading package integer-gmp ... linking ... done.
Loading package base ... linking ... done.
[1 of 1] Compiling Main             ( test.hs, interpreted )
Ok, modules loaded: Main.
[*Main] > main
"hello world"
```

... Unfortunately there is a bug in the program, so in your editor you
make the change required to print "hello, world" with the mandated comma:

~~~{data-language=haskell data-filter=./resources/scripts/check.sh}
main = print "hello, world"
~~~

Now, back in GHCi, you can reload the program without exiting the REPL:

```shell
[*Main] > :reload
[1 of 1] Compiling Main             ( test.hs, interpreted )
Ok, modules loaded: Main.
[*Main] > main
"hello, world"
```

Much better!

```instruction
  

* Define a new numeric function in a source file
* Load it in GHCi
* Test your function in GHCi
* Make a modification
* Reload your chages without exiting GHCi
* Test your changes
```

## GHC {.important}

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

```real
Compiled programs are almost always significantly faster than instructions
run inside GHCi. Even greater speed-ups are possible by using the "-O"
optimisation settings for GHC.
```

```instruction
Using GHC...

Compile and run your own spin on Hello-World.
```

```answer
lyndon@endpin ~ echo 'main = print "hello homies"' > main.hs
lyndon@endpin ~ ghc --make main.hs
[1 of 1] Compiling Main             ( main.hs, main.o )
Linking main ...
lyndon@endpin ~ ./main
"hello homies"
```

## Cabal {.important}

You should have access to a Cabal installation if you have installed the Haskell Platform.

Check that you have cabal by running:

```shell
cabal --version
```

This should output something similar to:

```text
cabal-install version <VERSION>
using version <VERSION> of the Cabal library
```

```instruction
Install the QuickCheck package using cabal.
```

```answer
lyndon@endpin ~ cabal update # not required if done recently
Downloading the latest package list from hackage.haskell.org
lyndon@endpin ~ cabal install quickcheck
...
```

```open
An open-ended question:

What are some of the current issues with the Haskell ecosystem?
```
