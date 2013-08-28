#!/bin/sh

for i in "$@"
do
	echo
	echo
	echo "<div class='chapter'>"
	echo "<div class='content'>"
	echo
	sed 's/^\\startmode.*//;s/^\\stopmode.*//' "$i"
	echo
	echo "</div>"
	echo "</div>"
	echo
	echo
done
