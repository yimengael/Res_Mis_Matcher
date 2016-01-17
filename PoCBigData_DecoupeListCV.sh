
#!/bin/bash
#===================================================================================
#
#         FILE: PoCBigData_DecoupeListCV.sh
#
#        USAGE: ./PoCBigData_DecoupeListCV.sh
#
#  DESCRIPTION: 
#              
# 		AUTHOR: Ing. Gaël Yimen Yimga
#      VERSION: 1.0
#    
#===================================================================================

#effacer l'ecran
clear


#=== FUNCTION =====================================================================
# NAME: decoupe_liste_fichier_cv_csv
# DESCRIPTION: 
# PARAMETER 1: 
#==================================================================================
decoupe_liste_fichier_cv_csv() {

	## Declaration des variables
	local repListCvCSV="/home/biadmin/PoCBigData/landingzone/source/CV/CSV"
	local cvFileName="CV_Base456"
	local prefix="u0001"
	
	## programme proprement dit
	fichierDesCVs="$repListCvCSV/$cvFileName"
	
	## Traitement des CV issus de la base 456
	echo "------- Lecture et traitement du fichier des CV de la base 456 --------"
	if [ -e $fichierDesCVs ] 
	then
	
		while IFS='|' read -r field1 field2 field3 field4
		do 
			line="$prefix|$field1|$field2|$field3|$field4"
			touch $repListCvCSV/$field1-$field2
	   		echo "$line" > $repListCvCSV/$field1-$field2
		done < "$fichierDesCVs"
		echo "------- Fin du traitement du fichier des CV de la base 456 -------"
		
		## Supprimer le fichier de base
		rm $fichierDesCVs
		if [ "$?" -eq "0" ]
		then
			echo "------- Suppression du fichier de base des CV -------"
		fi
	
	fi
	
	
}


#=== FUNCTION =====================================================================
# NAME: main
# DESCRIPTION: 
# PARAMETER 1: 
#==================================================================================
main() {
	decoupe_liste_fichier_cv_csv
}


#----- Appel de la fonction principale ---------
main
