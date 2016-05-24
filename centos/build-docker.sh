#!/bin/bash

# set -x

docker build -t gevgev/s3uploader-centos .

rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

docker push gevgev/s3uploader-centos
