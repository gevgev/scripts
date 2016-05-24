#!/bin/bash
if [ "$#" -eq 1 ]; then
	set -x
fi

GOOS=linux go build -v github.com/gevgev/csbufferanalizer
rc=$?; if [[ $rc != 0 ]]; then 
	echo "csbufferanalizer build failed"
	exit $rc; 
fi

echo "Success"
