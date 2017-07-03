#!/bin/bash

EDEN_DIR=`eden_env`
if [ "$EDEN_DIR" = "" ]
then
    echo "No EDEN evironnement founded" 1>&2
    exit 1
fi

ls $EDEN_DIR/.eden

declare -a menu
i=1

for e in `ls $EDEN_DIR/.eden`
do
    if [[ "$e" != "edenconfig" ]]
    then
        shortID=`echo $e | sed "s/-.*//"`
        name=`cat $EDEN_DIR/.eden/$e/.eden_parameters | grep "NAME=" | sed "s/NAME=//"`
        date=`cat $EDEN_DIR/.eden/$e/.eden_parameters | grep "DATE=" | sed "s/DATE=//"`
        
        menu[$i]=$shortID
        ((i=$i+1))
        menu[$i]="$date $name"
        ((i=$i+1))
    fi
done

column=`resize | grep "COLUMNS=" | sed "s/COLUMNS=//" | sed "s/;//"`
line=`resize | grep "LINES=" | sed "s/LINES=//" | sed "s/;//"`
whiptail --title "Menu" --menu "Choisissez" $line $column 16 "${menu[@]}"
