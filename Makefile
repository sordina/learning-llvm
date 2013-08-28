
WHITELIST := 'README\|Makefile\|resources/'

CHAPTERS  := README.md dependencies/TOC.md \
	$(shell sed -n '/[^ ].*|/ s|^\([^ ]*\).*|resources/markdown/\1.md|p' \
	resources/markdown/TOC.md)

all: dependencies html pdf todo

html:
	@ sed 's/.*|//' resources/markdown/TOC.md                    > dependencies/TOC.md
	@ cat  resources/html/head.html                              > index.html
	@ resources/scripts/wrapchapters.sh $(CHAPTERS) | pandoctor >> index.html
	@ cat  resources/html/footer.html                           >> index.html

pdf:
	@ sed 's/^----$$/\\pagebreak/' $(CHAPTERS) | pandoc -V geometry:margin=1.5in -o workshop.pdf

display: html todo
	@ ./resources/scripts/chromereload index.html

devel:
	commando -p cat -q -j                     \
	| grep --line-buffered -v 'dependencies/' \
	| grep --line-buffered -v 'dot/'          \
	| grep --line-buffered    $(WHITELIST)    \
	| uniqhash                                \
	| conscript make display

todo: unchecked_examples
	@ grep -ni todo $(CHAPTERS) | cat

publish:
	git push origin master:gh-pages

dependencies:
	mkdir -p dependencies
	git clone git@github.com:sordina/Commando.git  dependencies/commando
	git clone git@github.com:sordina/Conscript.git dependencies/conscript
	git clone git@github.com:sordina/pandoctor.git dependencies/pandoctor
	git clone git@github.com:sordina/uniqhash.git  dependencies/uniqhash
	cd dependencies/commando  && cabal install
	cd dependencies/conscript && cabal install
	cd dependencies/pandoctor && cabal install
	cd dependencies/uniqhash  && cabal install

clean:
	rm -rf dependencies

unchecked_examples:
	@ grep -n 'data-language=haskell' $(CHAPTERS) | grep -v check | cat
