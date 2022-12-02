#!/bin/bash
# adapt user "schueler" accordingly

export $(cat /proc/$(pgrep -u schueler gnome-session -n)/environ| tr '\0' '\n' | grep "DISPLAY=")
sudo -i -u schueler xhost +si:localuser:root
export $(cat /proc/$(pgrep -u schueler gnome-session -n)/environ| tr '\0' '\n' | grep "DBUS_SESSION_BUS_ADDRESS=")
#shutdown -h +5 "Shutdown in 5 min."
/usr/bin/zenity --question --text="Der Computer wird in 5 Minuten automatisch ausgeschaltet." --ok-label="Herunterfahren verhindern" --cancel-label="Herunterfahren" --timeout=300

if [ $? -eq 0 ]; then
   /sbin/shutdown -c
else
   /sbin/shutdown -h now
fi
