#!/bin/bash
cd ./logs/little/
for FILE in $(find -name "*.txt" -type f)
do
	cat $FILE
done
