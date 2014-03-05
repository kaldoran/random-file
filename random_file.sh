#!/bin/bash

# Made by Nicolas R 06 june 2013
# Tire un fichier au hasard dans un dossier
# Sort random file [ work with space in file name ]

function print_usage()
{
  echo -e "\n\t\t\t\033[01;05mRANDOM FILE NAME BY REYNAUD NICOLAS\E[0m\nPlease DO NOT delete the previous sentence.Thx\n\n"
  echo -e "\n\033[01;05mNAME\E[0m\n\trandom_file - search for a random file in a directory hierarchy\n"
  echo -e "\033[01;05mSYNOPSIS\E[0m\n\tUsage : $0 [-v] [-h] [-r] [ -d DEEP ] [ -n EXTENSIONNAME  ] [PATH]\n"
  echo -e "\033[01;05mOPTION\E[0m\n"
  echo -e "\t-r\t Recurcive without deep limit\n"
  echo -e "\t-d\t Deep of the search.By default search with -d 1\n\t\t Example : -d 2 will search in . and ./*/\n"
  echo -e "\t-n\t Search for a special exentension.\n\t\t Example : -n sh will search all *.sh\n"
  echo -e "\t-v\t Diplay the current Version of the program\n"
  echo -e "\t-h\t Display this help.\n\n"
}

if (( $# < 1 )) ; then
   print_usage | more
   exit -1
else
   name="*.*"
   rec="-maxdepth 1"
   
   while getopts :rvn:d:h option
   do
      case $option in

         n)  name="*.$OPTARG";;
         r)  rec="" ;;
         v)  echo -e "Random_file by REYNAUD Nicolas - Version 2.0"; exit 1;;
         d) if [[ $OPTARG =~ ^[0-9]+$ ]] && [[ $OPTARG -gt 0 ]]; then
                  rec="-maxdepth $OPTARG"
               else
                  echo "Erreur : -r need a number > 0"
                  exit -1
               fi
           ;;
         h) print_usage | more; exit 1 ;;
         \?) print_usage | more ; exit -1 ;;
      esac
   done

shift $(($OPTIND - 1 ))
   nbligne=$(find $1 $rec -name "$name" -type f | wc -l)

   if (( $nbligne == 0 )); then
      echo "No result"
      exit 0
   else
      line=$(($RANDOM%$nbligne))
      line=$((line + 1)) 

      find $1 $rec -name "$name" -type f | nl | while read a b
      do
         if [ "$a" = "$line" ] ; then echo $b; fi;
      done
   fi
fi
