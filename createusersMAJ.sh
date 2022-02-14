#!/bin/bash
##################################################################################################################################
#				CREATE USERS LIST MAJ		     								 #
##################################################################################################################################
#									     							 #
# Auteur : VCA					     							 #
# version 1.0															 #
##################################################################################################################################
if [ -e /tmp/listusersmaj.txt ] ; then
	echo -e "***********************************\n*\nLa liste des utilisateurs est présente\n*\n*********************************"
	cr=0
##################################################################################################################################
#BLOC TP 8 															 #
##################################################################################################################################

	while read prenom dossier coque ; do
		if [ -e $coque ] ; then
			echo "Le shell $coque existe"
		else
			echo "Le shell $coque n'est pas spécifié où n'existe pas"
			echo "Affectation du shell par defaut"
			coque="/bin/bash"
		fi
		useradd -d $dossier -s $coque $prenom
		if [ $? -ne 0 ] ; then
			echo "******************************************************************************************************************************************"
			echo "La création de l'utilisateur "$prenom" à rencontré une erreur, consulter la log d'erreur suivante : /home/valentin/listerror_"$liste".log"
			echo "*****************************************************************************************************************************************"
			exit 3
		else
			echo "*****************************************************************************************************************************************"
			echo -e "- L'utilisateur $prenom à été créé avec les caractéristique suivantes :"
			echo -e "- Shell de l'utilisareur : $coque"
			echo -e "- Home directory : $dossier"
			echo "*****************************************************************************************************************************************"
			let "cr=$cr+1"
		fi
	done < /tmp/listusersmaj.txt
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
	useradd -d /home/$nom -s /bin/bash $nom 2> /home/valentin/script/erreur_creation.log
	if [ $? -eq 2 ] ; then
		echo "Erreur lors la de création de l'utilisateur, veuillez consulter la log /home/valentin/script/erreur.log"
		exit
	else
		echo "Création avec succès"
	fi 
	echo $nom
	let "cpt=$cpt + 1"
	let "num=$num +1"
done
