#!/bin/bash
#set -x  # echo on


# Usage:
#  $ "./fix-permissions.sh" -f="my-ssh-keys.csv"
#  $ "./fix-permissions.sh" --file="my-ssh-keys.csv"


inputdata="my-ssh-keys.csv"


for i in "$@"; do
	case $i in
		-f=*|--file=*)
			inputdata="${i#*=}"
			shift # past argument=value
			;;
		--default)
			inputdata="my-ssh-keys.csv"
			shift # past argument with no value
			;;
		*)
		  # unknown option
		;;
	esac
done


sudo chmod 700 ~/.ssh
# rwx --- ---
# Owner can read, write, execute. No one else has any rights.


sudo chmod 600 ~/.ssh/config


while IFS=, read -r privatekey publickey
do

	sudo chmod 600 ~/.ssh/$privatekey

	sudo chmod 644 ~/.ssh/$publickey
	# rw- r-- r--
	# Owner can read, write. Everyone else can read.

done < "$inputdata"


sudo chown $USER:$USER ~/.ssh -R

