#!/bin/bash
##############################################################################
#Definition des variables
##############################################################################
#
#
#
echo $1
if [ -z $1 ] ; then
	echo -e "Indiquer la base du nom : \n"
	read base
else
	base=${1:?}
fi
if [ -z $2 ] ; then
	echo -e "Indiquer le numero du premier utilisateur ( par defaut 1) : \n"
	read num
else
	num=${2:?}
fi
if [ -z $3 ] ; then
	echo -e "Indiquer le nombre d'utilisateur à créer : \n"
	read nb
else
	nb=${3:?}
fi
cpt=0
###########################################################################
# Verif variable base
###########################################################################
if [ -z $base ] ; then 
	echo -e "Veuillez entrer une base de nom : \n"
	read base
fi
###########################################################################
# Verif variable nb
###########################################################################
if [ -z $nb ] ; then
	echo -e "Veuillez entrer un nombre d'utilisateur à créer : \n"
	read nb
fi 
if [ -z $num ] ; then
	num=1
fi
##########################################################################
# Boucle Compteur et création utilisateurs
##########################################################################
while [ $cpt -ne $nb ] ; do
	nom="$base-$num"
	useradd -d /home/$nom -s /bin/bash -g "Users" $nom 2> /home/valentin/script/erreur_creation.log
	if [ $? -eq 2 ] ; then
		echo "Erreur lors la de création de l'utilisateur, veuillez consulter la log /home/valentin/script/erreur.log"
		exit
	else
		echo "Création avec succès"
	fi 
	echo $nom
	let "cpt=$cpt + 1"
	let "num=$num +1"
#	echo $cpt
done
