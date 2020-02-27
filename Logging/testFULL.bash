#!/bin/bash
CODE=$1
LEN=$2
CH=$3 #chunk size multiplier

LOGDIR="$PWD"
cd "../Compiled/Linux/"

hash=$(./sha1 \"$CODE\")
echo "Testing on \"$CODE\", hash \"$hash\""
mkdir --parents "$LOGDIR/logs/full/"

echo "Testing 4 threads..."
echo "Test: Parallel on little alpha, password passed: $CODE, hash: \"$hash\"" > "$LOGDIR/logs/full/logALL.txt"
echo "Params: maxPassLen: $LEN, chunk multiplier: $CH" >> "$LOGDIR/logs/full/logALL.txt"
./parBF-full $hash $LEN $CH +RTS -s -N4 -ls &> "$LOGDIR/logs/full/logALL.txt"
mv parBF-full.eventlog "$LOGDIR/logs/full/parBF-ALL.eventlog"
echo "Done"; echo

echo "Testing 2 threads..."
echo "Test: Parallel on little alpha, password passed: $CODE, hash: \"$hash\"" > "$LOGDIR/logs/full/log2.txt"
echo "Params: maxPassLen: $LEN, chunk multiplier: $CH"  >> "$LOGDIR/logs/full/log2.txt"
./parBF-full $hash $LEN $CH +RTS -s -N2 -ls &> "$LOGDIR/logs/full/log2.txt"
mv parBF-full.eventlog "$LOGDIR/logs/full/parBF-2.eventlog"
echo "Done"; echo

echo "Testing 1 thread..."
echo "Test: Parallel on little alpha, password passed: $CODE, hash: \"$hash\"" > "$LOGDIR/logs/full/log1.txt"
echo "Params: maxPassLen: $LEN, chunk multiplier: $CH" >> "$LOGDIR/logs/full/log1.txt"
./parBF-full $hash $LEN $CH +RTS -s -N1 -ls &> "$LOGDIR/logs/full/log1.txt"
mv parBF-full.eventlog "$LOGDIR/logs/full/parBF-1.eventlog"
echo "Done!"; echo
