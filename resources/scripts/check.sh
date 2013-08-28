#!/bin/bash

function err {
  echo "$@"
  echo "$@" 1>&2
}

tee /tmp/haskell_workshop_check.hs

touch /tmp/haskell_workshop_md5_$PANDOCTOR_COUNT

checksum=`md5 /tmp/haskell_workshop_check.hs`
previous=`cat /tmp/haskell_workshop_md5_$PANDOCTOR_COUNT`

if [[ "$checksum" = "$previous" ]]
then
	exit 0
fi

echo "Processing Example $PANDOCTOR_COUNT" 1>&2

grep '^main =' /tmp/haskell_workshop_check.hs
status=$?
if [ $status -ne 0 ]
then
	echo "main = undefined" >> /tmp/haskell_workshop_check.hs
fi

ghc /tmp/haskell_workshop_check.hs &> /tmp/ghc_results_$PANDOCTOR_COUNT

status=$?
if [ $status -ne 0 ]
then
	err
	err "Error compiling example:"
	err
	err "> $@"
	err
	sed 's/^/~~~> /' /tmp/haskell_workshop_check.hs
	sed 's/^/~~~> /' /tmp/haskell_workshop_check.hs 1>&2
	err
	cat /tmp/ghc_results_$PANDOCTOR_COUNT
	cat /tmp/ghc_results_$PANDOCTOR_COUNT 1>&2

	exit 0
fi

echo $checksum > /tmp/haskell_workshop_md5_$PANDOCTOR_COUNT
