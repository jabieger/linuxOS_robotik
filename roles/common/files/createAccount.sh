#!/bin/bash
# add new user account

# modify USER before running script!!!
USER=user

export DISPLAY=:0
sudo -i -u $USER xhost +si:localuser:root
export $(cat /proc/$(pgrep -u $USER gnome-session -n)/environ| tr '\0' '\n' | grep "DBUS_SESSION_BUS_ADDRESS=")

strLen=0
while (( strLen < 4 ||  pwd1 != pwd2 )); do
   myInfo=$(/usr/bin/zenity --forms --title="Benutzer hinzufügen" --text="Gib deine Zugangsdaten ein" \
      --add-entry="Login" \
      --add-entry="Password" \
      --add-entry="Confirm Password")


   login=$(awk -F'\|' '{print $1}' <<<$myInfo)
   strLen=${#login}
   pwd1=$(awk -F'\|' '{print $2}' <<<$myInfo)
   pwd2=$(awk -F'\|' '{print $3}' <<<$myInfo)
done


#echo $login
#echo $pwd1
#echo $pwd2

pass=$(openssl passwd -1 ${pwd1})
#pass=$(perl -e 'print crypt($pwd1, "098212ATG")' $password)
useradd -m -p "$pass" "$login" -s /bin/bash 
[ $? -eq 0 ] &&  zenity --info --text="Der Benutzer wurde hinzugefügt."|| zenity --info --text="Der Benutzer konnte nicht erzeugt werden"

usermod -aG sudo $login
mkdir /home/$login/GemeinsamerOrdner
chown $login:$login /home/$login/GemeinsamerOrdner

#####
# Register laptop with serial, mac and hostname in database

#SERIAL
SERIAL=$(sudo dmidecode -t system | grep "Serial" | awk '{print $3}')

#MACs be aware of english/german systems
LAN=$(/usr/bin/lshw -class network |grep "logi" -i |grep "en" | awk '/ame:/ {print $3}')
MAC_LAN=$(ip link show $LAN | awk '/ether/ {print $2}')
WLAN=$(/usr/bin/lshw -class network |grep "logi" -i |grep "wl" | awk '/ame:/ {print $3}')
MAC_WLAN=$(ip link show $WLAN | awk '/ether/ {print $2}')

wget "REGISTER_SERIAL_URLmacL=$MAC_LAN&macW=$MAC_WLAN&serial=$SERIAL&name=$login"
## make sure appropriate server-side exists

# remove script
# add entry to /etc/fstab
if grep -Rq Gemeinsam /etc/fstab; then
  echo "Already there"
else
   echo "/home/$login/GemeinsamerOrdner /home/$USER/GemeinsamerOrdner fuse.bindfs nonempty,force-user=schule,force-group=schule,create-for-user=$login,create-for-group=$login 0 0" >>/etc/fstab
fi
echo '#!bin/bash' >/usr/local/bin/runOnce.sh
/sbin/reboot
