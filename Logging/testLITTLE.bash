#!/bin/bash
CODE=$1
LEN=$2
CH=$3 #chunk size multiplier

LOGDIR="$PWD"
cd "../Compiled/Linux/"

hash=$(./sha1 "$CODE")
echo "Testing on \"$CODE\", hash \"$hash\""
mkdir --parents "$LOGDIR/logs/little/"

echo "Testing 4 threads..."
echo "Test: Parallel on little alpha, password passed: $CODE, hash: \"$hash\"" > "$LOGDIR/logs/little/log4.txt"
echo "Params: maxPassLen: $LEN" >> "$LOGDIR/logs/little/log4.txt"
./parBF-little $hash $LEN +RTS -s -N4 -ls &>> "$LOGDIR/logs/little/log4.txt"
mv parBF-little.eventlog "$LOGDIR/logs/little/parBF-4.eventlog"
echo "Done"; echo

echo "Testing 2 threads..."
echo "Test: Parallel on little alpha, password passed: $CODE, hash: \"$hash\"" > "$LOGDIR/logs/little/log2.txt"
echo "Params: maxPassLen: $LEN"  >> "$LOGDIR/logs/little/log2.txt"
./parBF-little $hash $LEN +RTS -s -N2 -ls &>> "$LOGDIR/logs/little/log2.txt"
mv parBF-little.eventlog "$LOGDIR/logs/little/parBF-2.eventlog"
echo "Done"; echo

echo "Testing sequentially..."
echo "Test: Sequential on little alpha, password passed: $CODE, hash: \"$hash\"" > "$LOGDIR/logs/little/logSEQ.txt"
echo "Params: maxPassLen: $LEN" >> "$LOGDIR/logs/little/logSEQ.txt"
./seqBF-little $hash $LEN +RTS -s &>> "$LOGDIR/logs/little/logSEQ.txt"
#mv parBF-little.eventlog "$LOGDIR/logs/little/parBF-seq.eventlog"
echo "Done!"; echo
