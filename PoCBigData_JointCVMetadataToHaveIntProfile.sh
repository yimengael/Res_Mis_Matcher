#!/bin/bash
#==================================================================================
#
#         FILE: PoCBigData_JointCVMetadataToHaveIntProfile.sh
#
#        USAGE: ./PoCBigData_JointCVMetadataToHaveIntProfile.sh
#
#  DESCRIPTION: 
#
# 		AUTHOR: Ing. Gaël Yimen Yimga
#      VERSION: 1.0
#    
#==================================================================================


#=== FUNCTION =====================================================================
# NAME: update_path_with_pig
# DESCRIPTION: Mise a jour de la variable PATH avec la variable de PIG
# PARAMETER 1: 
#==================================================================================
update_path_with_pig() {
	export PATH=$PATH:/opt/ibm/biginsights/pig/bin
}


#=== FUNCTION =====================================================================
# NAME: create_internal_profile_by_joining
# DESCRIPTION: Cree le fichier de profil interne par jointure des metadonnées et
#              des CVs
# PARAMETER 1: 
#==================================================================================
create_internal_profile_by_joining() {

	## Declaration des variables	
	local output_file_metadata="/PoCBigData/landingzone/cible/METADATA"
	local output_file_profil="/PoCBigData/landingzone/cible/PROFIL" 
	local pig_parameter_file="/home/biadmin/POC_BIGDATA_SCRIPT/Pig_Parameters.txt"
	local pig_script_file="/home/biadmin/POC_BIGDATA_SCRIPT/script_jointure_metaAndCV_v2.pig"
	local PROG_HADOOP=`which hadoop`
		
	## Corps du programme
	if $PROG_HADOOP fs -test -d "$output_file_metadata"; then
		echo "Suppression du repertoire $output_file_metadata"
		"$PROG_HADOOP" fs -rm -r "$output_file_metadata"
		echo "Suppression du repertoire $output_file_metadata terminée"
	fi
	
	if $PROG_HADOOP fs -test -d "$output_file_profil"; then
		echo "Suppression du repertoire $output_file_profil"
		"$PROG_HADOOP" fs -rm -r "$output_file_profil"
		echo "Suppression du repertoire $output_file_profil terminée"
	fi
	
	## Corps du programme
	pig -param_file "$pig_parameter_file" -x mapreduce "$pig_script_file"
	if [ $? -ne 0 ]
	then
		exit 1
	fi
}





#-----------------------------------------------------------------------------------
# Programme principal
#-----------------------------------------------------------------------------------
main() {
	echo "Mise à jour des variables PIG_HOME"
	update_path_with_pig
	echo "Fin Mise à jour des variables PIG_HOME"
	
	echo "Creation des profiles internes par jointure"
	create_internal_profile_by_joining
	echo "Fin creation des profiles internes par jointure"
}


#-----------------------------------------------------------------------------------
# Appel du programme principal
#-----------------------------------------------------------------------------------
main

