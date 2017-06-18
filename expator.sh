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
   for N in `seq 0 15`
   do
      local B=$(( $RANDOM%255 ))

      case N in
         6)
            printf '4%x' $(( B%15 ))
            ;;
         8)
            local C='89ab'
            printf '%c%x' ${C:$(( $RANDOM%${#C} )):1} $(( B%15 ))
            ;;
         *)
            printf '%02x' $B
            ;;
      esac

      for T in `seq 3 2 9`
      do
         if ((T == N))
         then
            printf '-'
            break
         fi
      done
   done
}

function init()
{
   ID=`uuidfunction`
   DATE=`date +%Y-%m-%d`
   if [ $# -eq 1 ]
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
}

function parse_args()
{
   local EXP_NAME
   while [[ $# -gt 0 ]]
   do
      key="$1"
      case $key in
         init)
            if [ -z $2 ]
            then
               EXP_NAME="newExp"
               shift
            else
               EXP_NAME=$2
               shift
               shift
            fi
            init "${EXP_NAME}"
            ;;
         run)
            shift # past argument
            $*
            break
            ;;
         *)
            echo "Unknown option."
            ;;
      esac
      shift # past argument or value
   done
}

# --- MAIN ---
parse_args $*
