#!/bin/bash
if [ "$#" -eq 1 ]; then
	set -x
fi

echo "preparing the archive"

GOOS=linux go build -v github.com/gevgev/sqlpusher
rc=$?; if [[ $rc != 0 ]]; then 
	echo "sqlpusher build failed"
	exit $rc; 
fi

GOOS=linux go build -v github.com/gevgev/csbufferanalizer
rc=$?; if [[ $rc != 0 ]]; then 
	echo "csbufferanalizer build failed"
	exit $rc; 
fi

zip -r archive.zip csbufferanalizer sqlpusher run.sh
rc=$?; if [[ $rc != 0 ]]; then 
	echo "could not create the archive file"
	exit $rc; 
fi

echo "Success"
