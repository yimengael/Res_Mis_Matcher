#!/bin/sh
#===================================================================================
#
#         FILE: PoCBigData_ExtractDataTextFromFileInHDFS.sh
#
#        USAGE: ./PoCBigData_ExtractDataTextFromFileInHDFS.sh
#
#  DESCRIPTION: Ce script permet d'extraire le texte contenu dans les fichiers
# 				de CV, MISSION et POSTE deja uplaodé sur le HDFS. La dite 
# 				extraction s'acheve par la création d'un fichier qui regroupe
# 				tous les CV, un autre qui regroupe les missions et un autre
# 				qui regroupe les description de poste, ces trois fichiers sont
# 				sauvegardés sur le HDFS dans le Warehouse de Hive.
#
# 		AUTHOR: Ing. Gaël Yimen Yimga
#      VERSION: 1.0
#    
#====================================================================================

#effacer l'ecran
#clear


#=== FUNCTION =====================================================================
# NAME: extract_text_from_cv
# DESCRIPTION: 
# PARAMETER 1: 
#==================================================================================
extract_text_from_cv() {
	
	## Declaration des variables
	local input_file_cv="/PoCBigData/landingzone/source/CV/*"
	local output_file_cv="/PoCBigData/landingzone/cible/CV" 
	local jar_script_path="/home/biadmin/POC_BIGDATA_SCRIPT/ticka_final.jar"
	local PROG_HADOOP=`which hadoop`
		
	## Corps du programme
	if $PROG_HADOOP fs -test -d "$output_file_cv"; then
		echo "Suppression du repertoire $output_file_cv"
		$PROG_HADOOP fs -rm -r $output_file_cv
		echo "Suppression du repertoire $output_file_cv terminée"
	fi
	
	$PROG_HADOOP jar "$jar_script_path" com.ibm.imte.tika.TikaDriver "$input_file_cv" "$output_file_cv"
	if [ $? -ne 0 ];
	then
		exit 1
	fi
	
}



#=== FUNCTION =====================================================================
# NAME: extract_text_from_mission
# DESCRIPTION: 
# PARAMETER 1: 
#==================================================================================
extract_text_from_mission() {

	## Declaration des variables
	local input_file_mission="/PoCBigData/landingzone/source/MISSION-POSTE/MISSION/*"
	local output_file_mission="/PoCBigData/landingzone/cible/MISSION" 
	local jar_mission_script_path="/home/biadmin/POC_BIGDATA_SCRIPT/ticka_final_mission.jar"
	local PROG_HADOOP=`which hadoop`
	
	## Corps du programme
	if $PROG_HADOOP fs -test -d "$output_file_mission"; then
		echo "Suppression du repertoire $output_file_mission"
		$PROG_HADOOP fs -rm -r $output_file_mission
		echo "Suppression du repertoire $output_file_mission terminée"
	fi
	
	$PROG_HADOOP jar "$jar_mission_script_path" com.ibm.imte.tika.mission.TikaDriver "$input_file_mission" "$output_file_mission"
	if [ $? -ne 0 ]
	then
		exit 1
	fi
	
	
}


#=== FUNCTION =====================================================================
# NAME: extract_text_from_poste
# DESCRIPTION: 
# PARAMETER 1: 
#==================================================================================
extract_text_from_poste() {

	## Declaration des variables	
	local input_file_poste="/PoCBigData/landingzone/source/MISSION-POSTE/*/*"
	local output_file_poste="/PoCBigData/landingzone/cible/POSTE" 
	local jar_poste_script_path="/home/biadmin/POC_BIGDATA_SCRIPT/ticka_final_poste.jar"	
	local PROG_HADOOP=`which hadoop`
	
	## Corps du programme
	if $PROG_HADOOP fs -test -d "$output_file_poste"; then
		echo "Suppression du repertoire $output_file_poste"
		$PROG_HADOOP fs -rm -r $output_file_poste
		echo "Suppression du repertoire $output_file_poste terminée"
	fi
	
	## Lancement du ticka
	$PROG_HADOOP jar "$jar_poste_script_path" com.ibm.imte.tika.poste.TikaDriver "$input_file_poste" "$output_file_poste"
	if [ $? -ne 0 ]
	then
		exit 1
	fi
	
}


#=== FUNCTION =====================================================================
# NAME: migrate_files_from_source_to_definitive
# DESCRIPTION: 
# PARAMETER 1: 
#==================================================================================
migrate_files_from_source_to_definitive() {

	## Declaration de variables
	local PROG_HADOOP=`which hadoop`
	local folder_cv_to_move="/PoCBigData/landingzone/source/CV"
	local folder_cv_to_receive="/PoCBigData/landingzone/source_definitive/CV"
	local folder_metadata_to_move="/PoCBigData/landingzone/source/METADATA"
	local folder_metadata_to_receive="/PoCBigData/landingzone/source_definitive/METADATA"
	
	local folder_mission_to_move="/PoCBigData/landingzone/source/MISSION-POSTE/MISSION"
	local folder_mission_to_receive="/PoCBigData/landingzone/source_definitive/MISSION-POSTE/MISSION"
	
	local folder_poste_to_move="/PoCBigData/landingzone/source/MISSION-POSTE/POSTE"
	local folder_poste_to_receive="/PoCBigData/landingzone/source_definitive/MISSION-POSTE/POSTE"
	
	## Migration des fichiers CV
	"$PROG_HADOOP" fs -mv "$folder_cv_to_move/CSV/*" "$folder_cv_to_receive/CSV"
	"$PROG_HADOOP" fs -mv "$folder_cv_to_move/DOC/*" "$folder_cv_to_receive/DOC"
	"$PROG_HADOOP" fs -mv "$folder_cv_to_move/PDF/*" "$folder_cv_to_receive/PDF"
	"$PROG_HADOOP" fs -mv "$folder_cv_to_move/TXT/*" "$folder_cv_to_receive/TXT"
		
	## Migration des fichiers METADATA
	##"$PROG_HADOOP" fs -mv "$folder_metadata_to_move/CSV/*" "$folder_metadata_to_receive/CSV"
	
	## Migration des fichiers Missions
	"$PROG_HADOOP" fs -mv "$folder_mission_to_move/CSV/*" "$folder_mission_to_receive/CSV"
	"$PROG_HADOOP" fs -mv "$folder_mission_to_move/DOC/*" "$folder_mission_to_receive/DOC"
	"$PROG_HADOOP" fs -mv "$folder_mission_to_move/PDF/*" "$folder_mission_to_receive/PDF"
	"$PROG_HADOOP" fs -mv "$folder_mission_to_move/TXT/*" "$folder_mission_to_receive/TXT"
	"$PROG_HADOOP" fs -mv "$folder_mission_to_move/MSG/*" "$folder_mission_to_receive/MSG"
		
	## Migration des fichiers Poste
	"$PROG_HADOOP" fs -mv "$folder_poste_to_move/CSV/*" "$folder_poste_to_receive/CSV"
	"$PROG_HADOOP" fs -mv "$folder_poste_to_move/DOC/*" "$folder_poste_to_receive/DOC"
	"$PROG_HADOOP" fs -mv "$folder_poste_to_move/PDF/*" "$folder_poste_to_receive/PDF"
	"$PROG_HADOOP" fs -mv "$folder_poste_to_move/TXT/*" "$folder_poste_to_receive/TXT"
	"$PROG_HADOOP" fs -mv "$folder_poste_to_move/MSG/*" "$folder_poste_to_receive/MSG"
	
}


#=== FUNCTION =====================================================================
# NAME: main
# DESCRIPTION: 
# PARAMETER 1: 
#==================================================================================
main() {

	## Corps du programme
	echo "--- Deubut Extraction du texte des CV ---"
	extract_text_from_cv
	echo "--- Fin Extraction du texte des CV ---"

	echo "--- Debut Extraction du texte des Missions ---"
	extract_text_from_mission
	echo "--- Fin Extraction du texte des Missions ---"
	
	echo "--- Debut Extraction du texte des Postes ---"
	extract_text_from_poste
	echo "--- Fin Extraction du texte des Postes ---"
	
	echo "--- Migrer les données vers definitive ---"
	migrate_files_from_source_to_definitive
	echo "--- Fin Migrer les données vers definitive ---"

}


#-----------------------------------------------------------------------------------
# Appel du programme principal
#-----------------------------------------------------------------------------------
main



