#!/bin/bash
if [ $# -ne 1 ]; then
    echo "Provide a directory to watch" >&2; exit 1
fi
outpath="$1/hipstafied" 
if [ ! -d $outpath ]; then
    mkdir $outpath
fi

while read dirname e imgname; do
    if identify "$dirname""$imgname" &>/dev/null; then
       ./hipstafy.sh "$dirname$imgname" $outpath
       echo "Image $imgname has been hipstafied!"
    fi
done < <(inotifywait -m -e create,moved_to $1)


