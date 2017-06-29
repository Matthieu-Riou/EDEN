#!/bin/bash

EDEN_DIR=`eden_env`
if [ "$EDEN_DIR" = "" ]
then
    echo "No EDEN evironnement founded" 1>&2
    exit 1
else
    source $EDEN_DIR/.eden/edenconfig
fi

#TODO : generer id sur le hash des fichier (comme git)
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


if [ $# -ge 1 ]
then

    id=`uuidfunction`
    date=`date +%Y-%m-%d`
    xp=$1
    shift
    params="$@"


    if [ -d $id ]
    then
        echo "ERROR: Directory $id already exists. Collision on id generation function" 1>&2
        exit 1
    fi

    mkdir $EDEN_DIR/.eden/$id
    mkdir $EDEN_DIR/.eden/$id/notes
    mkdir $EDEN_DIR/.eden/$id/results
    ln -s $EDEN_DIR/data $EDEN_DIR/.eden/$id/data
    cp -R $EDEN_DIR/scripts $EDEN_DIR/.eden/$id/scripts
    
    echo "ID=$id" >> $EDEN_DIR/.eden/$id/.eden_parameters
    echo "DATE=$date" >> $EDEN_DIR/.eden/$id/.eden_parameters
    echo "NAME=$xp" >> $EDEN_DIR/.eden/$id/.eden_parameters
    echo "CMD=$EDEN_RUN_CMD $params" >> $EDEN_DIR/.eden/$id/.eden_parameters
    
    dir=$date"_"$xp"_"$id

    if [ -d "$EDEN_DIR/runs/$dir" ] 
    then 
        echo "ERROR: Directory $dir already exists." 1>&2
        exit 1
    fi

    ln -s $EDEN_DIR/.eden/$id $EDEN_DIR/runs/$dir
    
    
    cd $EDEN_DIR/.eden/$id/scripts

    $EDEN_RUN_CMD $params
else
    echo "Missing arguments : eden_run [runname]" 1>&2
    exit 1
fi

