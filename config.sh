#!/bin/bash

EDEN_DIR=`eden_env`
if [ "$EDEN_DIR" = "" ]
then
    echo "No EDEN evironnement founded" 1>&2
    exit 1
fi

if [[ $# -eq 0 ]]
then
    #TODO : arguments message
    echo "Need config parameters" 1>&2
    exit 1
fi


config_file=$EDEN_DIR/.eden.cfg
if [[ "$1" == --* ]]
then
    option="$1"
    shift

    case $option in
        --local)
        config_file=$EDEN_DIR/.eden.cfg
        ;;
        --global)
        config_file=~/.edenconfig
        if [[ ! -f ~/.edenconfig ]]
        then
            cp /etc/edenconfig ~/.edenconfig
        fi
        ;;
        --system)
        config_file=/etc/edenconfig
        ;;
        *)
        echo "Option $option unknown" 1>&2
        exit 1
        ;;
    esac
fi

echo $#

if [[ $# -eq 1 ]]
then
    param="$1"

    case $param in
        run.dir)
        cat $config_file | grep "EDEN_RUN_DIR" | cut -f 2 -d "="
        ;;
        run.name)
        cat $config_file | grep "EDEN_RUN_NAME" | cut -f 2 -d "="
        ;;
        run.cmd)
        cat $config_file | grep "EDEN_RUN_CMD" | cut -f 2 -d "=" | sed "s/\"//g"
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
        ERROR=$(sed -i "s|EDEN_RUN_DIR=.*|EDEN_RUN_DIR=$value|" $config_file 2>&1)
        if [ ! -d $EDEN_DIR/runs/$value ]
        then
            mkdir -p $EDEN_DIR/runs/$value
        fi
        ;;
        run.name)
        ERROR=$(sed -i "s/EDEN_RUN_NAME=.*/EDEN_RUN_NAME=$value/" $config_file 2>&1)
        ;;
        run.cmd)
        ERROR=$(sed -i "s|EDEN_RUN_CMD=.*|EDEN_RUN_CMD=\"$value\"|" $config_file 2>&1)
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
