rm -rf /tmp/haskell_workshop_check.*
cat > /tmp/haskell_workshop_check.hs

grep '^main =' /tmp/haskell_workshop_check.hs
status=$?
if [ $status -ne 0 ]
then
	echo "main = undefined" >> /tmp/haskell_workshop_check.hs
fi

ghc /tmp/haskell_workshop_check.hs > /dev/null

status=$?
if [ $status -ne 0 ]
then
	echo "Error compiling example:"
	echo
	echo "> $@"
	echo
	sed  's/^/~~~> /' /tmp/haskell_workshop_check.hs
fi
