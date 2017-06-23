#!/bin/bash

while [ "$PWD" != "/" ]
do
    #echo "$PWD"
    if [ -f ".eden.cfg" ]
    then
        echo "$PWD"
        exit
    fi
    cd ..
done
