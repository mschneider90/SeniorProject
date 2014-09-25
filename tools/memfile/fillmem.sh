#!/bin/bash
# Fills a "memfile" with no-ops
# Usage: fillmem <memfile.dat> <num_lines>
# Notes: the memfile should have no extra lines after the last operation

FILE_NAME=$1
NUM_TOTAL_LINES=$2

num_current_lines=`cat $1 | wc -l`
lines_to_fill=$(( NUM_TOTAL_LINES - num_current_lines ))
# wc -l is weird, so do one less iteration
lines_to_fill=$(( lines_to_fill - 1 ))

for i in `seq 1 $lines_to_fill` ; do
	printf "\n20040000" >> $FILE_NAME
done

echo "Filled $lines_to_fill lines of no-ops in $FILE_NAME"
