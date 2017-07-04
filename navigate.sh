#!/bin/bash

EDEN_DIR=`eden_env`
if [ "$EDEN_DIR" = "" ]
then
    echo "No EDEN evironnement founded" 1>&2
    exit 1
fi

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
selectID=$(whiptail --title "Menu" --menu "Choisissez" $line $column 16 "${menu[@]}" 3>&1 1>&2 2>&3)

selectRun=($(ls $EDEN_DIR/.eden | grep $selectID))

if [ ${#selectRun[@]} -gt 1 ]
then
    #TODO : handle collision (with option to setup shortid length ?)
    echo "Collision uuid error"
    exit 1
fi

cd $EDEN_DIR/.eden/${selectRun[0]}
exec bash
