#!/bin/bash

# This will update hostname and spoofed MAC on eth0 when you're 
# connected over WiFi.  This is intended for cases where you're 
# masking your device when connecting to the wired network.
# Verify that your NIC is eth0, if  it isn't, edit this script 
# to match yours.  Originally made to function on a Raspberry 
# Pi 4 running Kali linux.
#
# I am not doing any input validation.  If you're running this, 
# it's on you to know what you're doing.  Don't bork your stuff, 
# but if you do, it's your choice, and not my fault.
# 
# Made by MidwintersTomb
# https://www.twitter.com/MidwintersTomb

# To quote Dave Kennedy, "every tool needs cool ASCII art"

echo "                                                            "
echo "                     MMMMMMMMMMMMMMMMM~                     "
echo "                 MMMM                 ZMMM                  "
echo "              NMM,                        MMM               "
echo "            MMN                              MM             "
echo "          MM                                   MM           "
echo "         MM            MM         NM            ,MM         "
echo "       MM    MM        MMMM      MMM        MM    MM        "
echo "      MM    MMMM       MM         MM       MMMMZ   MM       "
echo "     MM   8MMMMMMM=                      MMMMMMMM   MM      "
echo "    MM   MMMMMMMMMMMMD                MMMMMMMMMMMM   MM     "
echo "    M   MM8       MMM                 ~MMN       MM   MM    "
echo "   MO   M          M                   M          M7   M    "
echo "  ?M   D           ,                   ,           ,   MM   "
echo "  MM              M       MMMMMMM       M               M   "
echo "  M            ?MMM     MMMMMMMMMMM     MMMM            M   "
echo "  M       MMMMMMMZ     MMMMMMMMMMMMM     :MMMMMMM       MM  "
echo " :M       MMMMM       ,MMMMMMMMMMMMMN       MMMMM       MM  "
echo " :M       ?MMM        MMMMMM   DMMMMM        MMMM       MM  "
echo "  M        MM      ?M MMM   MMM   ~MM MM      MM:       MM  "
echo "  M        MM    ,MMMMMM    MMM    MMMMMMO    8M        M~  "
echo "  MM        M   MMMMM  MMM       NMM~ MMMMM    M        M   "
echo "  NM        M    MMMM, NMMMMMMMMMMMM  MMMM             MM   "
echo "   M~             MMMM  =MMMMMMMMMZ  ,MMMM    D        M,   "
echo "   OM             MMMM     MMMMM=    MMMM             MM    "
echo "    MM             MMM               MMM             ~M     "
echo "     MM             MM,   *=====*    MM=             M      "
echo "      MM            IMM   |DIMIR|   ZMM            :M,      "
echo "       MM            MM   *=====*   MM            MM        "
echo "        MM            MM           ?M            MM         "
echo "          MM           M           M           MM=          "
echo "            MM          M         M          MMM            "
echo "              MMD        M       D        :MM?              "
echo "                MMMM                   NMMM                 "
echo "                    MMMMMM?     +MMMMMM,                    "
echo "                           +IMII,                           "
echo "                                                            "
echo "____________________________________________________________"
echo 
# Stores original hostname for later reference
hn="$(hostname)"

# Variable for the newly chosen hostname
newhn=''

#Variable for new MAC address for MAC Changer
newmac=''

read -p 'New hostname: ' newhn
read -p 'New MAC address in XX:XX:XX:XX:XX:XX format: ' newmac

sudo hostnamectl set-hostname $newhn
sudo sed -i -e "s/127.0.0.1       $hn/127.0.0.1       $newhn/g" /etc/hosts
sudo ifconfig eth0 down
sudo macchanger --mac=$newmac eth0
sudo ifconfig eth0 up

echo "Hostname was changed to $newhn and eth0 was changed to $newmac."
exit
