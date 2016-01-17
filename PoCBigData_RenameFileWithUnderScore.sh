#!/bin/bash
#===================================================================================
#
#         FILE: PoCBigData_RenameFileWithUnderScore.sh
#
#        USAGE: ./PoCBigData_RenameFileWithUnderScore.sh
#
#  DESCRIPTION: Ce script permet lit les noms de fichiers et les nettoies des 
#				espaces en remplacant les espaces par des UNDERSCORE.
#               Il y a trois fonctions dans ce script, une pour les CV,
#               une pour les MISSION et une pour les descriptions de postes
#                
# 		AUTHOR: Ing. Gaël Yimen Yimga 
#      VERSION: 1.0
#===================================================================================


#effacer l'ecran
clear

#=== FUNCTION =====================================================================
# NAME: rename_file_with_underscore_for_mission
# DESCRIPTION: 
# PARAMETER 1: 
#==================================================================================
rename_file_with_underscore_for_mission() {

	## Declaration de variables
	local rep_des_fichiers_mission_doc="/home/biadmin/PoCBigData/landingzone/source/MISSION-POSTE/MISSION/DOC"
	local rep_des_fichiers_mission_msg="/home/biadmin/PoCBigData/landingzone/source/MISSION-POSTE/MISSION/MSG"
	local rep_des_fichiers_mission_csv="/home/biadmin/PoCBigData/landingzone/source/MISSION-POSTE/MISSION/CSV"
	local rep_des_fichiers_mission_pdf="/home/biadmin/PoCBigData/landingzone/source/MISSION-POSTE/MISSION/PDF"
	local rep_des_fichiers_mission_txt="/home/biadmin/PoCBigData/landingzone/source/MISSION-POSTE/MISSION/TXT"
	
	## Script pour gerer le DOC
	ls "$rep_des_fichiers_mission_doc"|while read -r; do 
	
		#obtenir les nom des fichiers
		oldfilename="$REPLY"
		newfilename=`echo "$REPLY" | sed 's/ /_/g'`
		
		if [ "$REPLY" == "${REPLY//[\' ]/}" ]; then 
   			#absence d'espaces
   			echo
		else
   			#presence d'espaces
   			#faire la copie des fichiers
			cp "$rep_des_fichiers_mission_doc/$REPLY" "$rep_des_fichiers_mission_doc/$newfilename"
			echo "** Copie du fichier existant effectuée ** :" "$newfilename";
			if [ $? -eq 0 ]; then
				rm -r "$rep_des_fichiers_mission_doc/$REPLY"
				echo "** Suppression de l'ancien fichier ** :" "$oldfilename";
			fi	
		fi
		
	done
	
	## Script pour gerer le MSG
	ls "$rep_des_fichiers_mission_msg"|while read -r; do 
	
		#obtenir les nom des fichiers
		oldfilename="$REPLY"
		newfilename=`echo "$REPLY" | sed 's/ /_/g'`
		
		if [ "$REPLY" == "${REPLY//[\' ]/}" ]; then 
   			#absence d'espaces
   			echo
		else
   			#presence d'espaces
   			#faire la copie des fichiers
			cp "$rep_des_fichiers_mission_msg/$REPLY" "$rep_des_fichiers_mission_msg/$newfilename"
			echo "** Copie du fichier existant effectuée ** :" "$newfilename";
			if [ $? -eq 0 ]; then
				rm -r "$rep_des_fichiers_mission_msg/$REPLY"
				echo "** Suppression de l'ancien fichier ** :" "$oldfilename";
			fi	
		fi
		
	done
	
	## Script pour gerer le PDF
	ls "$rep_des_fichiers_mission_pdf"|while read -r; do 
	
		#obtenir les nom des fichiers
		oldfilename="$REPLY"
		newfilename=`echo "$REPLY" | sed 's/ /_/g'`
		
		if [ "$REPLY" == "${REPLY//[\' ]/}" ]; then 
   			#absence d'espaces
   			echo
		else
   			#presence d'espaces
   			#faire la copie des fichiers
			cp "$rep_des_fichiers_mission_pdf/$REPLY" "$rep_des_fichiers_mission_pdf/$newfilename"
			echo "** Copie du fichier existant effectuée ** :" "$newfilename";
			if [ $? -eq 0 ]; then
				rm -r "$rep_des_fichiers_mission_pdf/$REPLY"
				echo "** Suppression de l'ancien fichier ** :" "$oldfilename";
			fi	
		fi
		
	done
	
	## Script pour gerer le CSV
	ls "$rep_des_fichiers_mission_csv"|while read -r; do 
	
		#obtenir les nom des fichiers
		oldfilename="$REPLY"
		newfilename=`echo "$REPLY" | sed 's/ /_/g'`
		
		if [ "$REPLY" == "${REPLY//[\' ]/}" ]; then 
   			#absence d'espaces
   			echo
		else
   			#presence d'espaces
   			#faire la copie des fichiers
			cp "$rep_des_fichiers_mission_csv/$REPLY" "$rep_des_fichiers_mission_csv/$newfilename"
			echo "** Copie du fichier existant effectuée ** :" "$newfilename";
			if [ $? -eq 0 ]; then
				rm -r "$rep_des_fichiers_mission_csv/$REPLY"
				echo "** Suppression de l'ancien fichier ** :" "$oldfilename";
			fi	
		fi
		
	done
	
	
	## Script pour gerer le TXT
	ls "$rep_des_fichiers_mission_txt"|while read -r; do 
	
		#obtenir les nom des fichiers
		oldfilename="$REPLY"
		newfilename=`echo "$REPLY" | sed 's/ /_/g'`
		
		if [ "$REPLY" == "${REPLY//[\' ]/}" ]; then 
   			#absence d'espaces
   			echo
		else
   			#presence d'espaces
   			#faire la copie des fichiers
			cp "$rep_des_fichiers_mission_txt/$REPLY" "$rep_des_fichiers_mission_txt/$newfilename"
			echo "** Copie du fichier existant effectuée ** :" "$newfilename";
			if [ $? -eq 0 ]; then
				rm -r "$rep_des_fichiers_mission_txt/$REPLY"
				echo "** Suppression de l'ancien fichier ** :" "$oldfilename";
			fi	
		fi
		
	done
	
}


#=== FUNCTION =====================================================================
# NAME: rename_file_with_underscore_for_cv
# DESCRIPTION: 
# PARAMETER 1: 
#==================================================================================
rename_file_with_underscore_for_cv() {

	## Declaration de variables
	local rep_des_fichiers_cv_doc="/home/biadmin/PoCBigData/landingzone/source/CV/DOC"
	local rep_des_fichiers_cv_csv="/home/biadmin/PoCBigData/landingzone/source/CV/CSV"
	local rep_des_fichiers_cv_pdf="/home/biadmin/PoCBigData/landingzone/source/CV/PDF"
	local rep_des_fichiers_cv_txt="/home/biadmin/PoCBigData/landingzone/source/CV/TXT"
	
	
	## Script pour gerer le DOC
	ls "$rep_des_fichiers_cv_doc"|while read -r; do 
	
		#obtenir les nom des fichiers
		oldfilename="$REPLY"
		newfilename=`echo "$REPLY" | sed 's/ /_/g'`
		
		if [ "$REPLY" == "${REPLY//[\' ]/}" ]; then 
   			#absence d'espaces
   			echo
		else
   			#presence d'espaces
   			#faire la copie des fichiers
			cp "$rep_des_fichiers_cv_doc/$REPLY" "$rep_des_fichiers_cv_doc/$newfilename"
			echo "** Copie du fichier existant effectuée ** :" "$newfilename";
			if [ $? -eq 0 ]; then
				rm -r "$rep_des_fichiers_cv_doc/$REPLY"
				echo "** Suppression de l'ancien fichier ** :" "$oldfilename";
			fi	
		fi
		
	done
	
	## Script pour gerer le CSV
	ls "$rep_des_fichiers_cv_csv"|while read -r; do 
	
		#obtenir les nom des fichiers
		oldfilename="$REPLY"
		newfilename=`echo "$REPLY" | sed 's/ /_/g'`
		
		if [ "$REPLY" == "${REPLY//[\' ]/}" ]; then 
   			#absence d'espaces
   			echo
		else
   			#presence d'espaces
   			#faire la copie des fichiers
			cp "$rep_des_fichiers_cv_csv/$REPLY" "$rep_des_fichiers_cv_csv/$newfilename"
			echo "** Copie du fichier existant effectuée ** :" "$newfilename";
			if [ $? -eq 0 ]; then
				rm -r "$rep_des_fichiers_cv_csv/$REPLY"
				echo "** Suppression de l'ancien fichier ** :" "$oldfilename";
			fi	
		fi
		
	done
	
	## Script pour gerer le PDF
	ls "$rep_des_fichiers_cv_pdf"|while read -r; do 
	
		#obtenir les nom des fichiers
		oldfilename="$REPLY"
		newfilename=`echo "$REPLY" | sed 's/ /_/g'`
		
		if [ "$REPLY" == "${REPLY//[\' ]/}" ]; then 
   			#absence d'espaces
   			echo
		else
   			#presence d'espaces
   			#faire la copie des fichiers
			cp "$rep_des_fichiers_cv_pdf/$REPLY" "$rep_des_fichiers_cv_pdf/$newfilename"
			echo "** Copie du fichier existant effectuée ** :" "$newfilename";
			if [ $? -eq 0 ]; then
				rm -r "$rep_des_fichiers_cv_pdf/$REPLY"
				echo "** Suppression de l'ancien fichier ** :" "$oldfilename";
			fi	
		fi
		
	done
	
	## Script pour gerer le TXT
	ls "$rep_des_fichiers_cv_txt"|while read -r; do 
	
		#obtenir les nom des fichiers
		oldfilename="$REPLY"
		newfilename=`echo "$REPLY" | sed 's/ /_/g'`
		
		if [ "$REPLY" == "${REPLY//[\' ]/}" ]; then 
   			#absence d'espaces
   			echo
		else
   			#presence d'espaces
   			#faire la copie des fichiers
			cp "$rep_des_fichiers_cv_txt/$REPLY" "$rep_des_fichiers_cv_txt/$newfilename"
			echo "** Copie du fichier existant effectuée ** :" "$newfilename";
			if [ $? -eq 0 ]; then
				rm -r "$rep_des_fichiers_cv_txt/$REPLY"
				echo "** Suppression de l'ancien fichier ** :" "$oldfilename";
			fi	
		fi
		
	done
	
}




#=== FUNCTION =====================================================================
# NAME: rename_file_with_underscore_for_metadata
# DESCRIPTION: 
# PARAMETER 1: 
#==================================================================================
rename_file_with_underscore_for_metadata() {

	## Declaration de variables
	local rep_des_fichiers_metadata_csv="/home/biadmin/PoCBigData/landingzone/source/METADATA/CSV"
	
	
	## Script pour gerer le CSV
	ls "$rep_des_fichiers_metadata_csv"|while read -r; do 
	
		#obtenir les nom des fichiers
		oldfilename="$REPLY"
		newfilename=`echo "$REPLY" | sed 's/ /_/g'`
		
		if [ "$REPLY" == "${REPLY//[\' ]/}" ]; then 
   			#absence d'espaces
   			echo
		else
   			#presence d'espaces
   			#faire la copie des fichiers
			cp "$rep_des_fichiers_metadata_csv/$REPLY" "$rep_des_fichiers_metadata_csv/$newfilename"
			echo "** Copie du fichier existant effectuée ** :" "$newfilename";
			if [ $? -eq 0 ]; then
				rm -r "$rep_des_fichiers_metadata_csv/$REPLY"
				echo "** Suppression de l'ancien fichier ** :" "$oldfilename";
			fi	
		fi
		
	done
}




#=== FUNCTION =====================================================================
# NAME: rename_file_with_underscore_for_poste
# DESCRIPTION: 
# PARAMETER 1: 
#==================================================================================
rename_file_with_underscore_for_poste() {

	## Declaration de variables
	local rep_des_fichiers_poste_doc="/home/biadmin/PoCBigData/landingzone/source/MISSION-POSTE/POSTE/DOC"
	local rep_des_fichiers_poste_msg="/home/biadmin/PoCBigData/landingzone/source/MISSION-POSTE/POSTE/MSG"
	local rep_des_fichiers_poste_csv="/home/biadmin/PoCBigData/landingzone/source/MISSION-POSTE/POSTE/CSV"
	local rep_des_fichiers_poste_pdf="/home/biadmin/PoCBigData/landingzone/source/MISSION-POSTE/POSTE/PDF"
	local rep_des_fichiers_poste_txt="/home/biadmin/PoCBigData/landingzone/source/MISSION-POSTE/POSTE/TXT"
	
	## Script pour gerer le DOC
	ls "$rep_des_fichiers_poste_doc"|while read -r; do 
	
		#obtenir les nom des fichiers
		oldfilename="$REPLY"
		newfilename=`echo "$REPLY" | sed 's/ /_/g'`
		
		if [ "$REPLY" == "${REPLY//[\' ]/}" ]; then 
   			#absence d'espaces
   			echo
		else
   			#presence d'espaces
   			#faire la copie des fichiers
			cp "$rep_des_fichiers_poste_doc/$REPLY" "$rep_des_fichiers_poste_doc/$newfilename"
			echo "** Copie du fichier existant effectuée ** :" "$newfilename";
			if [ $? -eq 0 ]; then
				rm -r "$rep_des_fichiers_poste_doc/$REPLY"
				echo "** Suppression de l'ancien fichier ** :" "$oldfilename";
			fi	
		fi
		
	done
	
	## Script pour gerer le MSG
	ls "$rep_des_fichiers_poste_msg"|while read -r; do 
	
		#obtenir les nom des fichiers
		oldfilename="$REPLY"
		newfilename=`echo "$REPLY" | sed 's/ /_/g'`
		
		if [ "$REPLY" == "${REPLY//[\' ]/}" ]; then 
   			#absence d'espaces
   			echo
		else
   			#presence d'espaces
   			#faire la copie des fichiers
			cp "$rep_des_fichiers_poste_msg/$REPLY" "$rep_des_fichiers_poste_msg/$newfilename"
			echo "** Copie du fichier existant effectuée ** :" "$newfilename";
			if [ $? -eq 0 ]; then
				rm -r "$rep_des_fichiers_poste_msg/$REPLY"
				echo "** Suppression de l'ancien fichier ** :" "$oldfilename";
			fi	
		fi
		
	done
	
	## Script pour gerer le PDF
	ls "$rep_des_fichiers_poste_pdf"|while read -r; do 
	
		#obtenir les nom des fichiers
		oldfilename="$REPLY"
		newfilename=`echo "$REPLY" | sed 's/ /_/g'`
		
		if [ "$REPLY" == "${REPLY//[\' ]/}" ]; then 
   			#absence d'espaces
   			echo
		else
   			#presence d'espaces
   			#faire la copie des fichiers
			cp "$rep_des_fichiers_poste_pdf/$REPLY" "$rep_des_fichiers_poste_pdf/$newfilename"
			echo "** Copie du fichier existant effectuée ** :" "$newfilename";
			if [ $? -eq 0 ]; then
				rm -r "$rep_des_fichiers_poste_pdf/$REPLY"
				echo "** Suppression de l'ancien fichier ** :" "$oldfilename";
			fi	
		fi
		
	done
	
	## Script pour gerer le CSV
	ls "$rep_des_fichiers_poste_csv"|while read -r; do 
	
		#obtenir les nom des fichiers
		oldfilename="$REPLY"
		newfilename=`echo "$REPLY" | sed 's/ /_/g'`
		
		if [ "$REPLY" == "${REPLY//[\' ]/}" ]; then 
   			#absence d'espaces
   			echo
		else
   			#presence d'espaces
   			#faire la copie des fichiers
			cp "$rep_des_fichiers_poste_csv/$REPLY" "$rep_des_fichiers_poste_csv/$newfilename"
			echo "** Copie du fichier existant effectuée ** :" "$newfilename";
			if [ $? -eq 0 ]; then
				rm -r "$rep_des_fichiers_poste_csv/$REPLY"
				echo "** Suppression de l'ancien fichier ** :" "$oldfilename";
			fi	
		fi
		
	done
	
	
	## Script pour gerer le TXT
	ls "$rep_des_fichiers_poste_txt"|while read -r; do 
	
		#obtenir les nom des fichiers
		oldfilename="$REPLY"
		newfilename=`echo "$REPLY" | sed 's/ /_/g'`
		
		if [ "$REPLY" == "${REPLY//[\' ]/}" ]; then 
   			#absence d'espaces
   			echo
		else
   			#presence d'espaces
   			#faire la copie des fichiers
			cp "$rep_des_fichiers_poste_txt/$REPLY" "$rep_des_fichiers_poste_txt/$newfilename"
			echo "** Copie du fichier existant effectuée ** :" "$newfilename";
			if [ $? -eq 0 ]; then
				rm -r "$rep_des_fichiers_poste_txt/$REPLY"
				echo "** Suppression de l'ancien fichier ** :" "$oldfilename";
			fi	
		fi
		
	done
	
}



#=== FUNCTION =====================================================================
# NAME: main
# DESCRIPTION: 
# PARAMETER 1: 
#==================================================================================
main() {

	##appel de la focntion de renommage des mission
	rename_file_with_underscore_for_mission
	
	##appel de la fonction de renommage des cv
	rename_file_with_underscore_for_cv
	
	##appel de la fonction de renommage des metadata
	rename_file_with_underscore_for_metadata
	
	##appel de la fonction de renommage des postes
	rename_file_with_underscore_for_poste

}


#----- Appel de la fonction principale ---------
main



