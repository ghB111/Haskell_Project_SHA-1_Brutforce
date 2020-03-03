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
echo "Test: Parallel on little alpha, password passed: $CODE, hash: \"$hash\"" > "$LOGDIR/logs/little/logALL.txt"
echo "Params: maxPassLen: $LEN, chunk multiplier: $CH" >> "$LOGDIR/logs/little/logALL.txt"
./parBF-little $hash $LEN $CH +RTS -s -N4 -ls &>> "$LOGDIR/logs/little/logALL.txt"
mv parBF-little.eventlog "$LOGDIR/logs/little/parBF-ALL.eventlog"
echo "Done"; echo

echo "Testing 2 threads..."
echo "Test: Parallel on little alpha, password passed: $CODE, hash: \"$hash\"" > "$LOGDIR/logs/little/log2.txt"
echo "Params: maxPassLen: $LEN, chunk multiplier: $CH"  >> "$LOGDIR/logs/little/log2.txt"
./parBF-little $hash $LEN $CH +RTS -s -N2 -ls &>> "$LOGDIR/logs/little/log2.txt"
mv parBF-little.eventlog "$LOGDIR/logs/little/parBF-2.eventlog"
echo "Done"; echo

echo "Testing 1 thread..."
echo "Test: Parallel on little alpha, password passed: $CODE, hash: \"$hash\"" > "$LOGDIR/logs/little/log1.txt"
echo "Params: maxPassLen: $LEN, chunk multiplier: $CH" >> "$LOGDIR/logs/little/log1.txt"
./parBF-little $hash $LEN $CH +RTS -s -N1 -ls &>> "$LOGDIR/logs/little/log1.txt"
mv parBF-little.eventlog "$LOGDIR/logs/little/parBF-1.eventlog"
echo "Done!"; echo
