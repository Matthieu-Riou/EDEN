#!/bin/bash

EDEN_DIR=`eden_load`
if [ "$EDEN_DIR" = "" ]
then
    echo "No EDEN evironnement founded" 1>&2
    exit 1
fi

if [[ $# -eq 1 ]]
then
    param="$1"

    case $param in
        run.dir)
        cat $EDEN_DIR/.eden.cfg | grep "EDEN_RUN_DIR" | cut -f 2 -d "="
        ;;
        run.name)
        cat $EDEN_DIR/.eden.cfg | grep "EDEN_RUN_NAME" | cut -f 2 -d "="
        ;;
        run.cmd)
        cat $EDEN_DIR/.eden.cfg | grep "EDEN_RUN_CMD" | cut -f 2 -d "=" | sed "s/\"//g"
        ;;
        *)
        ;;
    esac
fi

if [[ $# -gt 1 ]]
then
    param="$1"
    shift
    value="$@"
    err=""

    case $param in
        run.dir)
        ERROR=$(sed -i "s|EDEN_RUN_DIR=.*|EDEN_RUN_DIR=$value|" $EDEN_DIR/.eden.cfg 2>&1)
        if [ ! -d $EDEN_DIR/runs/$value ]
        then
            mkdir -p $EDEN_DIR/runs/$value
        fi
        ;;
        run.name)
        ERROR=$(sed -i "s/EDEN_RUN_NAME=.*/EDEN_RUN_NAME=$value/" $EDEN_DIR/.eden.cfg 2>&1)
        ;;
        run.cmd)
        ERROR=$(sed -i "s|EDEN_RUN_CMD=.*|EDEN_RUN_CMD=\"$value\"|" $EDEN_DIR/.eden.cfg 2>&1)
        ;;
        *)
        ;;
    esac

    if [ "$ERROR" != "" ]
    then
        #TODO : better error messages
        echo "Error : $ERROR" 1>&2
        exit 1
    fi
fi
