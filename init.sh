#!/bin/bash

if [ $# -eq 1 ]
then 
    dir=$1

    if [ -d $dir ]
    then
        echo ERROR: Directory $dir already exists. 1>&2
        exit 1
    fi

    mkdir $dir
    mkdir $dir/notes
    mkdir $dir/data
    mkdir $dir/scripts
    mkdir $dir/runs

    if [ ! -f ~/.edenconfig ]
    then
        cp /etc/edenconfig ~/.edenconfig
    fi
    
    cp ~/.edenconfig $dir/.eden.cfg
fi
