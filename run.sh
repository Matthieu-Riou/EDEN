#!/bin/bash

EDEN_DIR=`eden_env`
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


if [ $# -gt 1 ]
then
    cd $EDEN_DIR/runs/$EDEN_RUN_DIR

    id=`uuidfunction`
    date=`date +%Y-%m-%d`
    xp=$1
    shift
    params="$@"

    dir=`echo "$EDEN_RUN_NAME" | sed -e "s/ID/$id/g" | sed -e "s/XP/$xp/g" | sed -e "s/DATE/$date/g"`

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

    $EDEN_RUN_CMD $params
else
    echo "Missing arguments : eden_run [runname]" 1>&2
    exit 1
fi

