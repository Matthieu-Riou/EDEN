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

    echo "EDEN_RUN=\"echo No run command\"" >> $dir/.eden.cfg
    echo "EDEN_RUN_DIR=" >> $dir/.eden.cfg
    echo "EDEN_RUN_NAME=DATE"_"XP"_"ID" >> $dir/.eden.cfg

fi
