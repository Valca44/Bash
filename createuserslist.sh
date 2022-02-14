#!/bin/bash
##################################################################################################################################
#				CREATE USERS LIST			     							 #
##################################################################################################################################
#									     							 #
# Auteur : VCA						     							 #
# version 1.0															 #
##################################################################################################################################
if [ -e /tmp/listusers.txt ] ; then
	echo "La liste des utilisateurs est présente"
	cr=0
	for liste in $(cat /tmp/listusers.txt) ; do
		useradd -d /home/$liste -s /bin/bash $liste 2> /home/sc/listerror_"$liste".log

		if [ $? -eq 2 ] ; then
			echo "La création de l'utilisateur "$liste" à rencontré une erreur, consulter la log d'erreur suivante : /home/sc/listerror_"$liste".log"
			exit 3
		else
			echo "Utilisateur "$liste" créé"
			let "cr=$cr+1"
		fi
	done
	echo "Vous avez créé "$cr" utilisateurs"
else
###################################################################################################################################
#Prise en compte des paramètres													  #
###################################################################################################################################
#
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
###################################################################################################################################
#TEST DES VARIABLES														  #
###################################################################################################################################

	if [ -z $base ] ; then 
		echo -e "Veuillez entrer une base de nom : \n"
		read base
	fi
	if [ -z $nb ] ; then
		echo -e "Veuillez entrer un nombre d'utilisateur à créer : \n"
		read nb
	fi 
	if [ -z $num ] ; then
		num=1
	fi
fi
#################################################################################################################################
# Bouclette While - TOUCHE PAS CA PETIT CON											#
#################################################################################################################################
cpt=0
while [[ "$cpt" -ne "$nb" ]] ; do
	nom="$base-$num"
	useradd -d /home/$nom -s /bin/bash $nom 2> /home/sc/script/erreur_creation.log
	if [ $? -eq 2 ] ; then
		echo "Erreur lors la de création de l'utilisateur, veuillez consulter la log /home/sc/script/erreur.log"
		exit
	else
		echo "Création avec succès"
	fi 
	echo $nom
	let "cpt=$cpt + 1"
	let "num=$num +1"
done
