
----

# Compression

In the scaffold folder `compression` there is a Cabal project that
implements a compression strategy based on [Huffman Coding](http://en.wikipedia.org/wiki/Huffman_coding).

<div class="center">

  ![Huffman Tree](resources/images/huffmantree.png)

</div>

The basic idea is that in a non-random string, some combinations
of tokens will be more frequent than others, and as-such, common
substrings can be represented with a short-hand encoding to
save space.

The project contains two executables: `compression` and `decompression`.
These accept data on STDIN and output data on STDOUT. `compression` accepts
text on STDIN and outputs binary data. Decompression does the reverse.

```real
The Haskell package "binary" exposes the module "Data.Binary" that
allows for very easy binary serialisation and parsing, with
most existing types already containing a marshelling implementation.
```

If you install these executables by using `cabal install`, then
you will be able to use them in the following manner:

```shell
> # Compress
> compression < lyrics.txt > lyrics.txt.compressed
> # Decompress
> decompression < lyrics.txt.compressed
```

Unfortunately, the compression algorithm contains a bug.

```instruction
In the compression scaffolding project, locate and fix the bug
that causes the test-suite to fail.

You can run the tests by calling "cabal test" from within
the project folder.
```

<div class="answer">

Line 131 should be:

~~~{ data-language=haskell .nocheck }
treeToBits t = map (second reverse) result
~~~

</div>

Although the algorithm itself is very basic, and the use of
strings instead of binary-data is not a common way to perform
compression, the structure  itself is typical of a real-world
Haskell project. The project structures itself around the Cabal toolkit,
and uses several libraries. It exposes a library, several
executables, and a test-suite.

```open
An open question:

How would you implement a more efficient compression algorithm in Haskell?
```
