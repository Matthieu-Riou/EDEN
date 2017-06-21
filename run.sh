#!/bin/bash

EDEN_DIR=`eden_load`
if [ "$EDEN_DIR" = "" ]
then
    echo "No EDEN evironnement founded" 1>&2
    exit 1
else
    source $EDEN_DIR/.eden.cfg
fi

function uuidfunction()
{
    local N B T

    for (( N=0; N < 16; ++N ))
    do
        B=$(( $RANDOM%255 ))

        if (( N == 6 ))
        then
            printf '4%x' $(( B%15 ))
        elif (( N == 8 ))
        then
            local C='89ab'
            printf '%c%x' ${C:$(( $RANDOM%${#C} )):1} $(( B%15 ))
        else
            printf '%02x' $B
        fi

        for T in 3 5 7 9
        do
            if (( T == N ))
            then
                printf '-'
                break
            fi
        done
    done

    echo
}


if [ $# -eq 1 ]
then
    cd $EDEN_DIR/runs

    id=`uuidfunction`
    xp=$1
    date=`date +%Y-%m-%d`

    dir=$date"_"$xp"_"$id

    if [ -d "$dir" ] 
    then 
        echo "ERROR: Directory $dir already exists." 1>&2
        exit 1
    fi

    mkdir $dir
    mkdir $dir/notes
    mkdir $dir/results
    ln -s $EDEN_DIR/data $dir/data
    cp -R $EDEN_DIR/scripts $dir/scripts

    cd $dir/scripts

    $EDEN_RUN
else
    echo "Missing arguments : eden_run [runname]" 1>&2
    exit 1
fi

