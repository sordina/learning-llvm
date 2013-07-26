build:
	@ cat resources/head.html > index.html
	pandoc *.md >> index.html
	@ cat resources/footer.html >> index.html

display: build todo
	@ chromereload index.html

devel:
	commando -c echo -j | grep --line-buffered 'md\|resources' | uniqhash | conscript make display

todo:
	@ grep -i todo *.md
