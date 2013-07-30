all: html pdf

html: dotty
	@ cat  resources/html/head.html    > index.html
	pandoc resources/markdown/*.md    >> index.html
	@ cat  resources/html/footer.html >> index.html

pdf:
	pandoc -V geometry:margin=1.5in resources/markdown/*.md -o workshop.pdf

display: html todo
	@ chromereload index.html

devel:
	commando -c echo -j                       \
	| grep --line-buffered    'md\|resources' \
	| grep --line-buffered -v 'dot/'          \
	| uniqhash                                \
	| conscript make display

todo:
	@ grep -ni todo resources/markdown/*.md

publish:
	git push origin master:gh-pages

dotty:
	sed 's/^\\startmode.*//;s/^\\stopmode.*//' resources/markdown/*.md | pandoctor
