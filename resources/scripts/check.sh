rm -rf /tmp/haskell_workshop_check.*
cat > /tmp/haskell_workshop_check.hs

touch /tmp/haskell_workshop_md5_$PANDOCTOR_COUNT

checksum=`md5 /tmp/haskell_workshop_check.hs`
previous=`cat /tmp/haskell_workshop_md5_$PANDOCTOR_COUNT`

if [[ "$checksum" = "$previous" ]]
then
	echo "Skipping $PANDOCTOR_COUNT"
	exit 0
fi

echo "Processing $PANDOCTOR_COUNT"

echo $checksum > /tmp/haskell_workshop_md5_$PANDOCTOR_COUNT

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
