#!/bin/bash

arr=()

for f in "$@"; do
    if [[ "$f" == *.rlib ]]; then
        #echo Extracting $f
        
        ar --output "$(dirname $f)" -x $f
        
        ar -t $f | grep .o | while read o; do
            fo=$(dirname $f)/$o
            
            #echo File $fo
            arr+=("$fo")
        done
    else
        #echo Passing arg $f
        arr+=("$f")
    fi
done

emcc ${arr[@]}