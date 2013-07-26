
<hr>

Exercise - Music
================

Once you have a model that reaches a sufficient level of complexity you will find
that your data-types become recursive.

<!-- http://i824.photobucket.com/albums/zz163/Boysie8/Telecaster%20build/f-hole.jpg -->
<div class="center"><img src="resources/images/f-hole.jpg" /></div>

Here is a small musical target-language:

~~~{data-language="haskell"}
data Music
  = A_ -- Underscore Represents a Flat
  | A
  | A' -- Prime represents a Sharp
       -- ... B, C, D, E, F, G ...
  | Sequence [Music]
  | Sharp (Music)
  | Longer Integer (Music a)
~~~

Certainly not comprehensive enough to write Beethoven's 5th Symphony,
but good enough for Baa Baa Black-Sheep.

Your task is to write a melody using this language. Try to write and compose
functions, rather than declaring one big data-structure.
