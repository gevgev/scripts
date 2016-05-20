#!/bin/bash
dir=$(pwd)
if [ "$#" -eq 1 ]; then
	dir=$1
fi

if [ "$#" -eq 2 ]; then
	dir=$1
	set -x
fi

echo "preparing the archive"
echo `mkdir -p tmp` 
echo `cp run.sh tmp/`

echo `cd tmp`
GOOS=linux GOARCH=arm go build -v github.com/gevgev/sqlpusher
rc=$?; if [[ $rc != 0 ]]; then 
	echo "sqlpusher build failed"
	exit $rc; 
fi

GOOS=linux GOARCH=arm go build -v github.com/gevgev/csbufferanalizer
rc=$?; if [[ $rc != 0 ]]; then 
	echo "csbufferanalizer build failed"
	exit $rc; 
fi

tar cvzf archive.zip csbufferanalizer sqlpusher run.sh
rc=$?; if [[ $rc != 0 ]]; then 
	echo "could not create the archive file"
	exit $rc; 
fi

echo `cp archive.zip $1`
rc=$?; if [[ $rc != 0 ]]; then 
	echo "could not copy the archive file to specified location"
	exit $rc; 
fi

echo "Success"
echo `cd ..`
echo `rm -R -f tmp`