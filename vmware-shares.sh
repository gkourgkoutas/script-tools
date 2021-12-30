#!/bin/bash

USAGE="Usage: sudo vmware_shares.sh -u <user> -s <sharename>"

# --- Options processing -------------------------------------------
if [ $# == 0 ] ; then
	echo $USAGE
	exit 1;
fi

while getopts u:s: flag
do
	case "${flag}" in
		u) username=${OPTARG};;
		s) sharename=${OPTARG};;
	esac
done

if /usr/bin/vmhgfs-fuse .host:/ /home/$username/$sharename -o subtype=vmhgfs-fuse,allow_other; then
    [ -d "/home/$username/$sharename/" ]
    echo "Share is mounted under /home/$username/$sharename"
else
    echo "Something went wrong. Check the error message above."
fi


