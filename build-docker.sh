#!/bin/bash

set -x

docker build -t gevgev/s3uploader .

rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

docker push gevgev/s3uploader
