#!/bin/bash
#==================================================================================
#
#         FILE: PoCBigData_MoveDataIntoHIVE.sh
#
#        USAGE: ./PoCBigData_MoveDataIntoHIVE.sh
#
#  DESCRIPTION: Ce script permet de lire les ficheirs et les rapatrier dans 
#               le warehouse HIVE pour une exploitation comme fichier plat
#               ou en utilisant des requetes Hive
# 		AUTHOR: Ing. Gaël Yimen Yimga
#      VERSION: 1.0
#    
#==================================================================================


#=== FUNCTION =====================================================================
# NAME: fix_env_variable
# DESCRIPTION: Mise a jour de la variable d'environnement HIVE_WAREHOUSE
# PARAMETER 1: 
#==================================================================================
fix_env_variable() {
	
	if [ -z $HIVE_WAREHOUSE ]; 
	then
		export HIVE_WAREHOUSE=/biginsights/hive/warehouse
		echo "HIVE_WAREHOUSE vient d'etre configurée"
		echo $HIVE_WAREHOUSE
	else
		echo "HIVE_WAREHOUSE est déjà configurée"
		$HIVE_WAREHOUSE
	fi
	
}


#=== FUNCTION =====================================================================
# NAME: update_path_with_jaql
# DESCRIPTION: Mise a jour de la variable PATH avec la variable de PIG
# PARAMETER 1: 
#==================================================================================
update_path_with_jaql() {
	export PATH=$PATH:/opt/ibm/biginsights/jaql/bin
}


#=== FUNCTION =====================================================================
# NAME: move_data_to_cv_mission_poste_and_profile_table
# DESCRIPTION: Migration des données dans le ware house HIVE
# PARAMETER 1: 
#==================================================================================
move_data_to_cv_mission_poste_and_profile_table() { 
	
	## Declaration de variables
	local files_cv_to_import="hdfs://bivm.ibm.com:9000/PoCBigData/landingzone/cible/CV/part-*"
	local files_mission_to_import="hdfs://bivm.ibm.com:9000/PoCBigData/landingzone/cible/MISSION/part-*"
	local files_poste_to_import="hdfs://bivm.ibm.com:9000/PoCBigData/landingzone/cible/POSTE/part-*"
	local files_profil_to_import="hdfs://bivm.ibm.com:9000/PoCBigData/landingzone/cible/PROFIL/part-*"
	
	local script_hql="/home/biadmin/POC_BIGDATA_SCRIPT/base_pocbigdata_ibm.hql"
	local PROG_HIVE="$HIVE_HOME/bin/hive"
	local PROG_HADOOP=`which hadoop`
	
	## Corps du programme
	# Creation des tables si elles n'existent pas
	
	## To run only the first time.
	## force execution of HQL in batch mode                            
	if [ "$1" == '0' ]; then
		$PROG_HIVE -f "$script_hql"
	fi
	suff_name=`date +%d%m%Y%H%M%S`
	
	# Copie des fichiers resultats de cv
	for i in $($PROG_HADOOP fs -ls $files_cv_to_import | awk '{print $8}')
	do
		if $PROG_HADOOP fs -test -e "$i"; then
			#suff_name=`date +%d%m%Y%H%M%S`
			$PROG_HADOOP fs -mv "$i" "$HIVE_WAREHOUSE/cv/$(basename $i)-cv-$suff_name"
		fi
	done
	
	# Copie des fichiers resultats de missions
	for j in $($PROG_HADOOP fs -ls $files_mission_to_import | awk '{print $8}')
	do
		if $PROG_HADOOP fs -test -e "$j"; then
			$PROG_HADOOP fs -mv "$j" "$HIVE_WAREHOUSE/mission/$(basename $j)-mission-$suff_name"
		fi
	done
	
	
	# Copie des fichiers resultats de postes
	for k in $($PROG_HADOOP fs -ls $files_poste_to_import | awk '{print $8}')
	do
		if $PROG_HADOOP fs -test -e "$k"; then
			$PROG_HADOOP fs -mv "$k" "$HIVE_WAREHOUSE/poste/$(basename $k)-poste-$suff_name"
		fi
	done
	
	
	# Copie des fichiers resultats de profils internes
	for l in $($PROG_HADOOP fs -ls $files_profil_to_import | awk '{print $8}')
	do
		if $PROG_HADOOP fs -test -e "$l"; then
			$PROG_HADOOP fs -mv "$l" "$HIVE_WAREHOUSE/profil/$(basename $l)-profil-int-$suff_name"
		fi
	done
	
}


#=== FUNCTION =====================================================================
# NAME: create_external_profile_from_linkedin
# DESCRIPTION: Cree le fichier de profil externe et le deplace dans le repertoire
#              HIVE des profils.
#              
# PARAMETER 1: 
#==================================================================================
create_external_profile_from_linkedin() {

	## Declaration de variabls
	local jaql_script_file="/home/biadmin/POC_BIGDATA_SCRIPT/script_jaql_profils_externes.jaql"

	## Programme propremnt dit
	jaqlshell "$jaql_script_file"
	if [ $? -ne 0 ]
	then
		exit 1
	fi
}


#=== FUNCTION =====================================================================
# NAME: purge_repertoire_source_sur_hdfs
# DESCRIPTION: 
#              
# PARAMETER 1: 
#==================================================================================
purge_repertoire_source_sur_hdfs() {

	## Declaration des variables
	local folder_cv_to_purge="/PoCBigData/landingzone/source/CV"
	local folder_metadata_to_purge="/PoCBigData/landingzone/source/METADATA"
	local folder_mission_to_purge="/PoCBigData/landingzone/source/MISSION-POSTE/MISSION"
	local folder_poste_to_purge="/PoCBigData/landingzone/source/MISSION-POSTE/POSTE"
	local PROG_HADOOP=`which hadoop`
	
	## purge
	$PROG_HADOOP fs -rm -r "$folder_cv_to_purge/CSV/*"
	$PROG_HADOOP fs -rm -r "$folder_cv_to_purge/DOC/*"
	$PROG_HADOOP fs -rm -r "$folder_cv_to_purge/PDF/*"
	$PROG_HADOOP fs -rm -r "$folder_cv_to_purge/TXT/*"
	
	$PROG_HADOOP fs -rm -r "$folder_metadata_to_purge/CSV/*"
	#$PROG_HADOOP fs -rm -r "$folder_metadata_to_purge/DOC/*"
	#$PROG_HADOOP fs -rm -r "$folder_metadata_to_purge/PDF/*"
	#$PROG_HADOOP fs -rm -r "$folder_metadata_to_purge/TXT/*"
	
	$PROG_HADOOP fs -rm -r "$folder_mission_to_purge/CSV/*"
	$PROG_HADOOP fs -rm -r "$folder_mission_to_purge/DOC/*"
	$PROG_HADOOP fs -rm -r "$folder_mission_to_purge/PDF/*"
	$PROG_HADOOP fs -rm -r "$folder_mission_to_purge/TXT/*"
	$PROG_HADOOP fs -rm -r "$folder_mission_to_purge/MSG/*"
	
	$PROG_HADOOP fs -rm -r "$folder_poste_to_purge/CSV/*"
	$PROG_HADOOP fs -rm -r "$folder_poste_to_purge/DOC/*"
	$PROG_HADOOP fs -rm -r "$folder_poste_to_purge/PDF/*"
	$PROG_HADOOP fs -rm -r "$folder_poste_to_purge/TXT/*"
	$PROG_HADOOP fs -rm -r "$folder_poste_to_purge/MSG/*"
}


#=== FUNCTION =====================================================================
# NAME: main
# DESCRIPTION: 
#              
# PARAMETER 1: 
#==================================================================================
main() {

	##fixer la variable d'environnement
	fix_env_variable
	
	##fixer la variable d'environnement jaql
	update_path_with_jaql
	
	## import des données dans Hive
	move_data_to_cv_mission_poste_and_profile_table $1
	
	## import des profiles externes dans Hive
	create_external_profile_from_linkedin
	
	## Purge des repertoires d entree
	purge_repertoire_source_sur_hdfs

}


#-----------------------------------------------------------------------------------
# Appel du programme principal
#-----------------------------------------------------------------------------------
main $1
