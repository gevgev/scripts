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

dir=$(pwd)

for filename in "$zipfolder"/*.zip; do
	echo "unzipping $filename"
	unzip "$filename" -d "$tmpfolder"

	rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

	echo "running csbufferanalizer"
	./csbufferanalizer -L -d "$tmpfolder"
	rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

	echo "running sqlpusher for each csv file"
	for csvfile in "$dir"/*.csv; do
		./sqlpusher -U="$un" -P="$psw". -S="$db" -d=Clickstream -I="$csvfile" m=900
		rc=$?; if [[ $rc != 0 ]]; then 
			echo "clean up for $filename"
			echo `rm -f *.csv`
			echo `rm -f "$tmpfolder"/*.raw`
			exit $rc; 
		fi
	done

	echo "clean up for $filename"
	echo `rm -f *.csv`
	echo `rm -f "$tmpfolder"/*.raw`
done
