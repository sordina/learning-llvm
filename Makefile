CHAPTERS := README.md resources/markdown/*.md

all: dependencies html pdf todo unchecked_examples

html:
	@ cat  resources/html/head.html                                       > index.html
	@ sed 's/^\\startmode.*//;s/^\\stopmode.*//' $(CHAPTERS) | pandoctor >> index.html
	@ cat  resources/html/footer.html                                    >> index.html

pdf:
	pandoc -V geometry:margin=1.5in $(CHAPTERS) -o workshop.pdf

display: html todo
	@ ./resources/scripts/chromereload index.html

devel:
	commando -c echo -j                       \
	| grep --line-buffered    'md\|resources' \
	| grep --line-buffered -v 'dot/'          \
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
