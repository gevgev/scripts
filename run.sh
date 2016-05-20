#!/bin/bash
if [ "$#" -eq 6 ]; then
	set -x
fi

if [ "$#" -ne 5 -a "$#" -ne 6 ]; then
	echo "Error: Missing parameters:"
	echo "  zipfolder"
	echo "  tmpfolder"
	echo "  db"
	echo "  user name"
	echo "  password"
	echo "  debug"
	exit 1
fi

zipfolder=$1
tmpfolder=$2
db=$3
un=$4
psw=$5

for filename in "$zipfolder"/*.zip; do
	echo "unzipping $filename"
	unzip "$filename" -d "$tmpfolder"

	echo "running csbufferanalizer"
	./csbufferanalizer -L -d "$tmpfolder"

	echo "running sqlpusher"
	./sqlpusher -U="$un" -P="$psw". -S="$db" -d=Clickstream -I=*.csv m=900

	echo "clean up for $filename"
	echo `rm -f *.csv`
	echo `rm -f "$tmpfolder"/*.raw`
done
