#!/usr/bin/env bash

#TODO: 
# - Gérer les entrées pour choisir la bonne fonction. 
# - Se documenter pour faire un code propre ici. 
# - Réfléchir au choix technologique pour coder : python, bash, go, autre ? 
# - Go serait intéressant pour apprendre un nouveau langage et avoir de la bouteille pour 
# embeter mayeul :P 

# FONCTIONS: 
# - init [nomProjet] : Permet d'initialiser un dossier. Fonctionnalité de création de dossier automatique. 
# - run/launch [Path du fichier à run] [arguments de ce fichier] : 

# Idees:
# - .eden_run_history : Je propose de faire un dossier .eden_history (ou fichier) qui permette de se souvenir
# de tous les run lancés. Ca ou un fichier qui se met à chaque run mais qui sera plus chiant à aller chercher. 
# (ou les deux)

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


