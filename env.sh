#!/bin/bash

while [ "$PWD" != "/" ]
do
    #echo "$PWD"
    if [ -d ".eden" ]
    then
        echo "$PWD"
        exit
    fi
    cd ..
done
