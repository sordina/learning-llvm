
----

\pagebreak

Required Resources
==================

Before you begin you will require the following...

## A Text-Editor

We are assuming previous programming experience, however, if you would like a
recommendation, have a look at
[Notepad++](http://notepad-plus-plus.org/),
[Sublime Text](http://www.sublimetext.com/), or the ever-popular
[Emacs](http://www.gnu.org/software/emacs/) and
[Vim](http://www.vim.org/). Just make sure that you are fluent enough to embark
on exercises as they appear in the workshop.

## [The Haskell Platform](http://www.haskell.org/platform/)

In order to run the programs written during this workshop you will need a Haskell
installation. The easiest way to get up and running is to install the latest
Haskell Platform. This is a "batteries included" installation of GHC and Cabal
that includes many of the most useful packages available in the Hackage ecosystem.

## [A Copy of the Workshop Scaffold Project](https://github.com/sordina/haskell_workshop)

<https://github.com/sordina/haskell_workshop>

Either clone with git:

```shell
git clone https://github.com/sordina/haskell_workshop.git
```

... or [download the zip](https://github.com/sordina/haskell_workshop/archive/master.zip) from GitHub.



Useful Resources
================

These resources are available to help you with any issues you face when learning Haskell:


## \#haskell on [Freenode](http://freenode.net/)

An IRC channel dedicated to discussion of Haskell. This is often the easiest place to fire off
a one-off question that is simple enough not to warrant a permanent listing on the internet.


## [Hackage](http://hackage.haskell.org/packages/hackage.html)

Hackage is the primary repository for Haskell packages. It is public,
searchable, versioned, and uses Cabal package metadata for classification.
Furthermore, this can be used to easily browse package contents, documentation
and source-code.

For example, browse the [Shake](http://hackage.haskell.org/package/shake) package and look
at some of the [Modules](http://hackage.haskell.org/packages/archive/shake/0.10.6/doc/html/Development-Shake-Command.html).


## [Hoogle](http://www.haskell.org/hoogle/)

Hoogle is a Haskell module and function search-engine. Hoogle allows you to
take advantage of the granular type-system used by Haskell to search not just
for function-names, but for function type-signatures.

For example, have a look for the function with signature [Text -> ByteString](http://www.haskell.org/hoogle/?hoogle=Text+-%3E+ByteString).


## [MFUG](http://www.meetup.com/Melbourne-Functional-User-Group-MFUG/)

MFUG is the Melbourne Functional Programmer's User Group. This group discusses
many topics, including Haskell.

## [/r/haskell](http://www.reddit.com/r/haskell)

For Reddit users, /r/haskell is a very useful resource with a great deal of
information regarding recent developments in the Haskell ecosystem and community.
This is a good place to ask some more advanced questions or start a flame-war.

## [Haskell News](http://haskellnews.org/)

Haskell News is a firehose-style haskell news aggregator taking information from
sources as varied as academic-journals, and GitHub accounts.


## [HLint](http://hackage.haskell.org/package/hlint)

HLint is a [linting tool](http://en.wikipedia.org/wiki/Lint_(software))
for Haskell source - It can often provide some
useful hints about refactoring avenues for your code.
