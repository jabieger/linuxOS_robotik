
#!/bin/bash

SLEEP_TIME=2
#
# RESOLUTION for Monitor - Clone - Mode
# 0x0 for Autodedection of Maximum Resolution
#
RESOLUTION=0x0
#
#
# RATE Frequency for Monitor - Clone - Mode
# 0 for Autodedection
#
RATE=0

# Sleep until System has configured Resolutions
sleep $SLEEP_TIME

# Find 1. Screen
SCREEN1=$(xrandr --query | awk '/ connected /{ print $1 }' | head -1)
#echo $SCREEN1

# Find 2. Screen
SCREEN2=$(xrandr --query | awk '/ connected /{ print $1 }' | tail -1)
#echo $SCREEN2

# Set Resolution
if [ $RESOLUTION = "0x0" ];
then
        # Find Maximum Resolution in Screen 1 & Screen 2
        RESOLUTION=$(xrandr --query | awk '/^ *[0-9]*x[0-9]*/{ print $1 }' |grep -v i| sort -g -r | uniq -d | head -1)
        #echo $RESOLUTION

fi

if [ $RATE != "0" ];
then
        RATE_OPTION="--rate $RATE"
fi

# Set Clone Modus with Maximum Resolution
xrandr --output $SCREEN1 --mode $RESOLUTION $RATE_OPTION --output $SCREEN2 --mode $RESOLUTION $RATE_OPTION --same-as $SCREEN1

