#!/bin/bash
#===================================================================================
#
#         FILE: PoCBigData_IntegrateDataForWatsonExplorer.sh
#
#        USAGE: ./PoCBigData_IntegrateDataForWatsonExplorer.sh
#
#  DESCRIPTION: Ce script permet de preparer les données pour WEX
#               
# 		AUTHOR: Ing. Gaël Yimen Yimga 
#      VERSION: 1.0
#===================================================================================


#=== FUNCTION =====================================================================
# NAME: cleaning_data_rapprochement
# DESCRIPTION: 
#==================================================================================
cleaning_data_rapprochement() {

	## Declaration de variables 
	local local_file_rappro_cv_batch="/home/biadmin/rapprochement/RAPPROCHEMENT-CVs-LAST"
	local local_file_rappro_mission_batch="/home/biadmin/rapprochement/RAPPROCHEMENT-MISSIONS-LAST"
	local local_file_rappro_cv_predict="/home/biadmin/rapprochement/PREDICTION-CV-LAST"
	local local_file_rappro_mission_predict="/home/biadmin/rapprochement/PREDICTION-MISSIONS-LAST"
	local local_file_wordcloud="/home/biadmin/rapprochement/WORDCLOUD-LAST"
	local local_folder_of_matrix_result="/home/biadmin/result-matrix"
	
	
	local hdfs_file_rappro_cv_batch="/PoCBigData/resultzone/RAPPROCHEMENT/BATCH-MODE"
	local hdfs_file_rappro_mission_batch="/PoCBigData/resultzone/RAPPROCHEMENT/BATCH-MODE"
	local hdfs_file_rappro_cv_predict="/PoCBigData/resultzone/RAPPROCHEMENT/PREDICTIVE-MODE"
	local hdfs_file_rappro_mission_predict="/PoCBigData/resultzone/RAPPROCHEMENT/PREDICTIVE-MODE"
	local hdfs_folder_of_matrix_result="/PoCBigData/resultzone/DATA-MATRIX"
	
	local PROG_HIVE="$HIVE_HOME/bin/hive"
	local PROG_HADOOP=`which hadoop`
	
	
	## Pprogramme proprement dit
	
	# suppression de la premiere ligne des fichiers 
	sed -i -e '1d' "$local_file_rappro_cv_batch"
	sed -i -e '1d' "$local_file_rappro_mission_batch"
	sed -i -e '1d' "$local_file_rappro_cv_predict"
	sed -i -e '1d' "$local_file_rappro_mission_predict"
	
	# suppression de la deuxieme ligne des fichiers
	sed -i -e "s/\"1\",\"//g" "$local_file_rappro_cv_batch"
	sed -i -e "s/\"1\",\"//g" "$local_file_rappro_mission_batch"
	sed -i -e "s/\"1\",\"//g" "$local_file_rappro_cv_predict"
	sed -i -e "s/\"1\",\"//g" "$local_file_rappro_mission_predict"
	
	#suppression de (") sur la derniere ligne du fichier 
	sed -i -e "s/\"//g" "$local_file_rappro_cv_batch"
	sed -i -e "s/\"//g" "$local_file_rappro_mission_batch"
	sed -i -e "s/\"//g" "$local_file_rappro_cv_predict"
	sed -i -e "s/\"//g" "$local_file_rappro_mission_predict"
	
	
	#suppression et ajout de fichiers sur HDFS
	if $PROG_HADOOP fs -test -e "$hdfs_file_rappro_cv_batch/RAPPROCHEMENT-CVs-LAST"; then
			$PROG_HADOOP fs -rm -r "$hdfs_file_rappro_cv_batch/RAPPROCHEMENT-CVs-LAST"
	fi
	$PROG_HADOOP fs -put "$local_file_rappro_cv_batch" "$hdfs_file_rappro_cv_batch"
	
	if $PROG_HADOOP fs -test -e "$hdfs_file_rappro_mission_batch/RAPPROCHEMENT-MISSIONS-LAST"; then
			$PROG_HADOOP fs -rm -r "$hdfs_file_rappro_mission_batch/RAPPROCHEMENT-MISSIONS-LAST"
	fi
	$PROG_HADOOP fs -put "$local_file_rappro_mission_batch" "$hdfs_file_rappro_mission_batch"
	
	if $PROG_HADOOP fs -test -e "$hdfs_file_rappro_cv_predict/PREDICTION-CV-LAST"; then
			$PROG_HADOOP fs -rm -r "$hdfs_file_rappro_cv_predict/PREDICTION-CV-LAST"
	fi
	$PROG_HADOOP fs -put "$local_file_rappro_cv_predict" "$hdfs_file_rappro_cv_predict"
	
	if $PROG_HADOOP fs -test -e "$hdfs_file_rappro_mission_predict/PREDICTION-MISSIONS-LAST"; then
			$PROG_HADOOP fs -rm -r "$hdfs_file_rappro_mission_predict/PREDICTION-MISSIONS-LAST"
	fi
	$PROG_HADOOP fs -put "$local_file_rappro_mission_predict" "$hdfs_file_rappro_mission_predict"
	
	
	#Ajout des fichiers matrice dans le repertoire sur HDFS
	$PROG_HADOOP fs -put "$local_folder_of_matrix_result/*" "$hdfs_folder_of_matrix_result"
	
}


#=== FUNCTION =====================================================================
# NAME: create_table_in_bigsql_for_wex
# DESCRIPTION: 
#==================================================================================
create_table_in_bigsql_for_wex() {

	## Declaration de variables
	local PROG_JSQSH="$JSQSH_HOME/bin/jsqsh"
	local bigsql_script_table="/home/biadmin/POC_BIGDATA_SCRIPT/base_bigsql.sql"

	
	## Programme propremen²:w
	t dit
	"$PROG_JSQSH" bigsql --user=bigsql --password=bigsql < "$bigsql_script_table"
}


#=== FUNCTION =====================================================================
# NAME: launching_crolling_on_wex
# DESCRIPTION: 
# PARAMETER 1: $1 : path of all the CV to treat
# PARAMETER 2: $2 : path of all the MISSION to treat
# PARAMETER 3: $3 : path of the dictionnary
# PARAMETER 4: $4 : path of Text Document Matrix (TDM)
# PARAMETER 5: $5 : path of the result matrix for next treatments
# PARAMETER 6: $6 : path of the result of rapprochement
#==================================================================================
launching_crolling_on_wex() {

	curl -x "http://10.24.202.237:9080/vivisimo/cgi-bin/velocity?v.function=search-collection-crawler-start&v.indent=true&collection=PoCBigData_profile&type=refresh-inplace&v.app=api-rest"
	curl -x "http://10.24.202.237:9080/vivisimo/cgi-bin/velocity?v.function=search-collection-crawler-start&v.indent=true&collection=PoCBigData_profile&type=refresh-inplace&v.app=api-rest"
	curl -x "http://10.24.202.237:9080/vivisimo/cgi-bin/velocity?v.function=search-collection-crawler-start&v.indent=true&collection=PoCBigData_profile&type=refresh-inplace&v.app=api-rest"
	curl -x "http://10.24.202.237:9080/vivisimo/cgi-bin/velocity?v.function=search-collection-crawler-start&v.indent=true&collection=PoCBigData_profile&type=refresh-inplace&v.app=api-rest"
	
}


#=== FUNCTION =====================================================================
# NAME: main
# DESCRIPTION: 
# PARAMETER 1: 
#==================================================================================
main() {
	
	##clean the result files
	cleaning_data_rapprochement
	
	##create bigsql tables
	create_table_in_bigsql_for_wex
	
	##launch the crolling
	launching_crolling_on_wex
	
}


#-----------------------------------------------------------------------------------
# Appel du programme principal
#-----------------------------------------------------------------------------------
main



