#!/bin/bash

# Run by a udev rule when my USB switch it switched away from this machine.
# Looks for the USB hub "remove" command.

/bin/echo "$(date)" "$1">> /tmp/usbswitch.log

if [ "x$1" == "xADD" ]
then
    # HDMI-2
    VID="0x0f"
elif [ "x$1" == "xREMOVE" ]
then
    # HDMI-1
    VID="0x11"
else
    /bin/echo "$(date)" "unknown operation: " "$1" >> /tmp/usbswitch.log
    exit 1
fi

/usr/bin/ddcutil setvcp 60 ${VID}
exit $?
