
----

# Compression

Let's see if we can implement a "zip" like program in haskell!

The go-to place to start looking at compression techniques is
[Huffman Coding](http://en.wikipedia.org/wiki/Huffman_coding).

The basic idea is that in a non-random string, some combinations
of tokens will be more frequent than others, and as-such, common
substrings can be represented with a short-hand encoding to
save space.

An issue arises - If we will have different length codes for various
tokens concatenated into a string as a result of compression,
how will we know where one coded token ends and another one begins?

~~~{ data-language=haskell data-filter=./resources/scripts/check.sh }
type Bit = Bool

compress :: String -> [ Bit ]
compress = undefined
~~~

<div class="center">

  ![Huffman Tree](resources/images/huffmantree.png)

</div>

~~~{ data-language=haskell data-filter=./resources/scripts/check.sh }
data HuffmanTree = Foo
~~~

~~~{ data-language=haskell data-filter=./resources/scripts/check.sh }
data HuffmanTree = Foo
~~~
