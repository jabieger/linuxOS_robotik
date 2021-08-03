#!/bin/sh

# cleanup-script soll nur weiterlaufen, wenn
immutable=`mount |grep 'none on /home/schueler type overlay (rw,relatime,lowerdir=/home/schueler,upperdir=/home/.schueler_rw,workdir=/home/work'`
test -n "$immutable" || exit 0;

# Lösch-Funktion, welcher zusätzliche find-Argumente übergeben werden können
loeschen (){
  # Wird dieses Script als root ausgeführt, kann das folgende "rm -rf" sehr gefährlich werden --
  # insbesondere zu Testzwecken auf einem normalen Arbeitsrechner. Mit der folgenden Kombination
  # ist sichergestellt, dass wirklich nur der Inhalt von .schueler_rw gelöscht wird.
  cd /home/.schueler_rw && find . -maxdepth 1 -mindepth 1 $zusatz -print0|xargs -0 rm -rf
}

(sleep 3; loeschen)
#mount -o remount /home/schueler

