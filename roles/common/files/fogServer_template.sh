#!/bin/bash
# if image is restored using a fog server, run this script using /etc/rc.local on first boot.
# it will retrieve hostname from fog and change the hostname
# the given fog-api-token as well as the fog-user-token are only examples. Please adapt to accordingly.

sleep 5
fogIP="192.168.0.1"

mac=`( ip address |grep ether | cut -c 16-32)`

hostName=`curl --silent  -H 'fog-api-token: X2FjX2NiXmJiXmY4OWFhNDk4ZWXzXWFmXjk4NzNkXjExODY2NmX2YmJmNWRkYjdkXWX2ZjA3X2XwODVlYjX3YTAyYTkxZmE1YmZkXzQxXGY1Xjc3XDX3XDA2NDFjXWI3NjE1NTU3ZTBhNWQ4YWYzN2U1ODY1ZDZlXTXzNWViODk=' -H 'fog-user-token:XjUzODI1ODg2NTkwOTNmOTQ0OTYwXmJjXzFlXGUxYTNmODJkZDc1XzBlODAxNDUwNTliNGI4NWXwZWExXjk2NjX2YTJiYjQ4XzE1NTVmY2RiOThlXzJiYzRlZTkzYTQ0YmU1OTZkNTQ1OWX2XWNjYmY1Xzg4YzY2OWY3NGY4OTc' -X GET http://$fogIP/fog/host |python3 -mjson.tool|grep -E "Creat|primac" -B 2 |grep "name\|primac" | grep $mac -B1 |grep name|cut -d"\"" -f4`

echo $hostName >/etc/hostname
hostnamectl set-hostname $hostName

wget "http://www.dachsberg.at/info/setHostname.php?mac=$mac&name=$hostName"

rm /etc/rc.local

