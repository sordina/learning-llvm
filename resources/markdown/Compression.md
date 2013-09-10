
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

Unfortunately, the compression algorithm contains a bug.

```instruction
In the compression scaffolding project, locate and fix the bug
that causes the test-suite to fail.

You can run the tests by calling "cabal test" from within
the project folder.
```



~~~{ data-language=haskell data-filter=./resources/scripts/check.sh }
type Bit = Bool

compress :: String -> [ Bit ]
compress = undefined
~~~

```open
An open question:

How would you implement a more efficient compression algorithm in Haskell?
```
