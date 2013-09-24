#!/bin/bash

function err {
  echo "$@"
  echo "$@" 1>&2
}

if [ -f "$SOURCE_FILE" ]
then
	cat $SOURCE_FILE > /tmp/llvm_tutorial.s
else
	tee /tmp/llvm_tutorial.s
fi

touch /tmp/haskell_workshop_md5_$PANDOCTOR_COUNT

checksum=`md5 /tmp/llvm_tutorial.s`
previous=`cat /tmp/haskell_workshop_md5_$PANDOCTOR_COUNT`

if [[ "$checksum" = "$previous" ]]
then
	exit 0
fi

lli /tmp/llvm_tutorial.s &> /tmp/lli_results_$PANDOCTOR_COUNT

status=$?
if [ $status -ne 0 ]
then
	err
	err "Error compiling example:"
	err
	err "> $@"
	err
	sed 's/^/~~~> /' /tmp/llvm_tutorial.s
	sed 's/^/~~~> /' /tmp/llvm_tutorial.s 1>&2
	err
	cat /tmp/lli_results_$PANDOCTOR_COUNT
	cat /tmp/lli_results_$PANDOCTOR_COUNT 1>&2

	exit 0
fi

echo $checksum > /tmp/haskell_workshop_md5_$PANDOCTOR_COUNT
