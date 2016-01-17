#!/bin/bash
#===================================================================================
#
#         FILE: PoCBigData_RunRAlgoInRecurrentMode.sh
#
#        USAGE: ./PoCBigData_RunRAlgoInRecurrentMode.sh
#
#  DESCRIPTION: Ce script permet d'executer le script R en mode RECURRENT
#               
# 		AUTHOR: Ing. Gaël Yimen Yimga
#      VERSION: 1.0
#    
#===================================================================================

#=== FUNCTION =====================================================================
# NAME: run_r_algorithm_in_recurrent_mode
# DESCRIPTION: 
# PARAMETER 1: $1 : path of all the CV to treat
# PARAMETER 2: $2 : path of all the MISSION to treat
# PARAMETER 3: $3 : path of the dictionnary
# PARAMETER 4: $4 : path of Text Document Matrix (TDM)
# PARAMETER 5: $5 : path of the result matrix for next treatments
# PARAMETER 6: $6 : path of the result of rapprochement
#==================================================================================
run_r_algorithm_in_recurrent_mode() {
	
	local r_script_path="/home/biadmin/POC_BIGDATA_SCRIPT/RScript/Prediction2_parametrise.r"
	local path_of_dictionary="/home/biadmin/POC_BIGDATA_SCRIPT/RScript/reserved_terms.csv"
	local path_result_rapprochement="/home/biadmin/rapprochement"
	local path_of_result_matrix="/home/biadmin/result-matrix"
	
	local path_of_all_cv="/PoCBigData/interzone/CV"
	local path_of_all_mission="/PoCBigData/interzone/MISSION"
	local path_of_all_poste="/PoCBigData/interzone/POSTE"
	local path_of_all_profil="/PoCBigData/interzone/PROFIL"
	
	local srce_of_all_cv="/biginsights/hive/warehouse/cv"
	local srce_of_all_mission="/biginsights/hive/warehouse/mission"
	local srce_of_all_poste="/biginsights/hive/warehouse/poste"
	local srce_of_all_profil="/biginsights/hive/warehouse/profil"
	
	
	local PROG_HIVE="$HIVE_HOME/bin/hive"
	local PROG_HADOOP=`which hadoop`
	
	## Construire le jeu de données de CV
	fichAux=`$PROG_HADOOP fs -ls -R $srce_of_all_cv | sort -k 7,7n -k 6,6M | tail -1 | awk '{print $8}'`
	echo "$fichAux"
	if $PROG_HADOOP fs -test -e "$path_of_all_cv/000000_0_cv"; then
			$PROG_HADOOP fs -rm -r "$path_of_all_cv/000000_0_cv"
	fi
	$PROG_HADOOP fs -cp "$fichAux" "$path_of_all_cv/000000_0_cv"
	
	## Construire le jeu de données de MISSION
	fichAux=`$PROG_HADOOP fs -ls -R $srce_of_all_mission | sort -k 7,7n -k 6,6M | tail -1 | awk '{print $8}'`
	echo "$fichAux"
	if $PROG_HADOOP fs -test -e "$path_of_all_mission/000000_0_mission"; then
			$PROG_HADOOP fs -rm -r "$path_of_all_mission/000000_0_mission"
	fi
	$PROG_HADOOP fs -cp "$fichAux" "$path_of_all_mission/000000_0_mission"
	
	## Construire le jeu de données de POSTE
	fichAux=`$PROG_HADOOP fs -ls -R $srce_of_all_poste | sort -k 7,7n -k 6,6M | tail -1 | awk '{print $8}'`
	echo "$fichAux"
	if $PROG_HADOOP fs -test -e "$path_of_all_poste/000000_0_poste"; then
			$PROG_HADOOP fs -rm -r "$path_of_all_poste/000000_0_poste"
	fi
	$PROG_HADOOP fs -cp "$fichAux" "$path_of_all_poste/000000_0_poste"
	
	
	## Construire le jeu de données de PROFIL
	if $PROG_HADOOP fs -test -e "$path_of_all_profil/000000_0_profil"; then
			$PROG_HADOOP fs -rm -r "$path_of_all_profil/000000_0_profil"
	fi
	for i in $($PROG_HADOOP fs -ls -R $srce_of_all_profil | sort -k 7,7n -k 6,6M | tail -2 | awk '{print $8}')
	do	
		if $PROG_HADOOP fs -test -e "$i"; then
			$PROG_HADOOP fs -cp "$i" "$path_of_all_profil/$(basename $i)"
		fi
	done
	$PROG_HADOOP fs -cat "$path_of_all_profil/*" | $PROG_HADOOP fs -put - "$path_of_all_profil/000000_0_profil"
	$PROG_HADOOP fs -rm -r "$path_of_all_profil/part-r-0000*"
	
	## Appel de la commande RSCRIPT en mode RECURRENT
	RRS="Rscript \"$r_script_path\" \"$path_of_all_profil/000000_0_profil\" \"$path_of_all_poste/000000_0_poste\" \"$path_of_dictionary\" \"$path_result_rapprochement\" \"$path_of_result_matrix\""
	eval $RRS
}


#=== FUNCTION =====================================================================
# NAME: main
# DESCRIPTION: 
# PARAMETER 1: 
#==================================================================================
main() {
	run_r_algorithm_in_recurrent_mode
}


#-----------------------------------------------------------------------------------
# Appel du programme principal
#-----------------------------------------------------------------------------------
main



