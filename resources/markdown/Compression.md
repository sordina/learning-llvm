
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
These accept data on STDIN and output data on STDOUT.

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
