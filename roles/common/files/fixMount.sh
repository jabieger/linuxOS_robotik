#!/bin/bash
help=`mount -l -t overlayfs |grep "(ro"`
if [ -n "$help" ]
then
# mounted read only
   rm /home/work/work -r
   umount /home/schueler
   mount -t overlayfs -o lowerdir=/home/schueler,upperdir=/home/.schueler_rw/,workdir=/home/work /home/schueler/
   exit 0;
else
   exit 0;
fi

