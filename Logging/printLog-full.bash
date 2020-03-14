#!/bin/bash
cd ./logs/full/
for FILE in $(find -name "*.txt" -type f)
do
	cat $FILE
	echo; echo;
done
