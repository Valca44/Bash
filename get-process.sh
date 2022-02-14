#!/bin/bash
#Q1
if [$# -gt 1] ; then
	echo "Utilisation : <get-process.sh> [nom_process]"
	exit 3
fi
#FIN Q1
echo $1
#A3

#Q2
if [ -z "$1"] ; then
	read -p "Entrer un nom d'utilisateur" nom
	if [ -z "$nom"] ; then
		set "$LOGNAME" $(uname -n)
	fi
fi
		
	#Q3
		#A5
	#FINQ3
#FINQ2

#A6

#A7

#A8

#A9
