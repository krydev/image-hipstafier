#!/bin/bash
if [ $# -lt 1 ]; then
    echo "Provide an input image" >&2; exit 1
fi
inputfile=$(basename "$1")
ext=${inputfile#*.}
prefix=${inputfile%.$ext}
outfile="$prefix-hipstah.$ext"
if [ $# -gt 1 ]; then
   outfile="$2/$outfile"
else
    outfile="$(dirname "$1")/$outfile"
fi
convert -sepia-tone 60% +polaroid $1 $outfile
