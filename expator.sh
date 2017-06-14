#!/bin/bash

# We could just use uuid or dbus-uuidgen
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
ID=`uuidfunction`
DATE=`date +%Y-%m-%d`
if test $# -eq 1
then 
	DIR=$DATE"_"$1"_"$ID
	if [ -d "$DIR" ] 
	then 
		echo ERROR: Directory $DIR already exists. $jar_file.  1>&2
    		exit 1
	else 
		mkdir $DIR
		mkdir $DIR/notes
		mkdir $DIR/data
		mkdir $DIR/scripts
		mkdir $DIR/results
	fi

fi


