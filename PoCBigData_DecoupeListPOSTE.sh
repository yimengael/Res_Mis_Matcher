#!/bin/bash
#===================================================================================
#
#         FILE: PoCBigData_DecoupeListPOSTE.sh
#
#        USAGE: ./PoCBigData_DecoupeListPOSTE.sh
#
#  DESCRIPTION: Ce script permet de lire un fichier CSV de description de poste
#               issu des ressurces humaines. Ensuite il va decouper le fichier
#               en plusieurs petit fichiers dont le contenu est une ligne du 
#       		fichier de depart
#
# 		AUTHOR: Ing. Gaël Yimen Yimga
#      VERSION: 1.0
#    
#===================================================================================

#effacer l'ecran
clear


#=== FUNCTION =====================================================================
# NAME: decoupe_liste_fichier_poste_csv
# DESCRIPTION: 
# PARAMETER 1: 
#==================================================================================
decoupe_liste_fichier_poste_csv() {

	## Declaration des variables
	local repListPosteCSV="/home/biadmin/PoCBigData/landingzone/source/MISSION-POSTE/POSTE/CSV"
	local posteFileName="POSTE_BaseRH"
	local prefix="u0001"
	
	## programme proprement dit
	fichierDesPostes="$repListPosteCSV/$posteFileName"
	echo $fichierDesPostes
	
	## Traitement des POSTES issus de la base RH
	echo "------- Lecture et traitement du fichier des POSTES de la base RH --------"
	if [ -e $fichierDesPostes ] 
	then
	
		while IFS='|' read -r field1 field2 field3 field4 field5 field6 field7 field8 field9 field10 field11 field12
		do 
			line="$prefix|$field1|$field2|$field3|$field4|$field5|$field6|$field7|$field8|$field9|$field10|$field11|$field12"
			touch "$repListPosteCSV/$field1"
	   		echo "$line" > "$repListPosteCSV/$field1"
		done < "$fichierDesPostes"
		echo "------- Fin du traitement du fichier des Postes de la base RH -------"
		
		## Supprimer le fichier de base
		rm $fichierDesPostes
		if [ "$?" -eq "0" ]
		then
			echo "------- Suppression du fichier de base des Postes -------"
		fi
	
	fi
	
	
}


#=== FUNCTION =====================================================================
# NAME: main
# DESCRIPTION: 
# PARAMETER 1: 
#==================================================================================
main() {
	decoupe_liste_fichier_poste_csv
}


#----- Appel de la fonction principale ---------
main

