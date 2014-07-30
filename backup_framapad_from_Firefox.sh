#!/bin/bash

##############################################################################################
#     This script retreive all lite framapad from your Firefox's history and bookmarks,      #
#                       and download them in txt to have local backup                        #
##############################################################################################
# by Framartin

# Install sqlite3 before exectuting this script : sudo apt-get install sqlite3

cd ~/.mozilla/firefox/*.default # TODO : add profiles support ?
sqlite3 places.sqlite 'SELECT url FROM moz_places WHERE url LIKE "%lite%framapad.org/p/%" AND url NOT LIKE "%/timeslider%" AND url NOT LIKE "%/";' > /tmp/list_framapad.txt
if [ ! -d ~/Sauvegardes/lite.framapad.org ] ; then
   mkdir -p ~/Sauvegardes/lite.framapad.org
fi
cd ~/Sauvegardes/lite.framapad.org
echo "Téléchargement en cours..."
while read line
do
   echo "Téléchargement de $line"
   nameFile=${line/"framapad.org/p/"/}
   nameFile=${nameFile/"http://"/backup.}
   nameFile=${nameFile/"https://"/backup.}
   line+="/export/txt"
   wget --quiet --no-check-certificate $line -O $nameFile.txt
done < /tmp/list_framapad.txt
echo "Framapads lite visités via Firefox sauvergardés dans ~/Sauvegardes/lite.framapad.org !"

# other solution : retreive from bookmarks backups in ~/.mozilla/firefox/*.default/bookmarkbackups/
