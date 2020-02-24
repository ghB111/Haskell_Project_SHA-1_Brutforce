#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
for FILE in $(find "$DIR" -name "*.hs" -type f)
do
	ghc -O2 $FILE -rtsopts -threaded -eventlog
	COMPILED=${FILE%.*}
	mkdir --parents "$DIR/Compiled/Linux"
       	mv "$COMPILED" $_ 
done
find "$DIR" -name "*.o" -type f -delete
find "$DIR" -name "*.hi" -type f -delete
