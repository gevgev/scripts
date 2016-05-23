#!/bin/bash

set -x

path=$1
file=$2
bucket=$3

#ftp -in ec2-52-24-138-152.us-west-2.compute.amazonaws.com << SCRIPTEND
#user adsawsftp quickaccess123
#binary
#cd "$path"
#mget "$file"
#SCRIPTEND

wget --passive-ftp ftp://adsawsftp:quickaccess123@ec2-52-24-138-152.us-west-2.compute.amazonaws.com/"$1"/"$2"

rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

echo `mkdir tmp`
echo `unzip "$file" -d "tmp"`

rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

./csbufferanalizer -L -M 50000 -d "tmp"

rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

echo `rm -f tmp/*`
echo `mv *.csv tmp/`

/home/ubuntu/aws/env/bin/aws s3 cp tmp/ s3://"$bucket" --recursive

echo `rm -f tmp/*`
echo `rm "$file"`