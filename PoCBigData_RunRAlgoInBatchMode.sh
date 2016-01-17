#!/bin/bash
#===================================================================================
#
#         FILE: PoCBigData_RunRAlgoInBatchMode.sh
#
#        USAGE: ./PoCBigData_RunRAlgoInBatchMode.sh
#
#  DESCRIPTION: Ce script permet d'executer le script R en mode BATCH
#               
# 		AUTHOR: Ing. Gaël Yimen Yimga
# 	   COMPANY: CAPGEMINI TECHNOLOGY SERVICES
#      VERSION: 1.0
#    
#===================================================================================

#=== FUNCTION =====================================================================
# NAME: run_r_algorithm_in_batch_mode
# DESCRIPTION: 
# PARAMETER 1: $1 : path of all the CV to treat
# PARAMETER 2: $2 : path of all the MISSION to treat
# PARAMETER 3: $3 : path of the dictionnary
# PARAMETER 4: $4 : path of Text Document Matrix (TDM)
# PARAMETER 5: $5 : path of the result matrix for next treatments
# PARAMETER 6: $6 : path of the result of rapprochement
#sed 's#\x01#|#g' "$auxiliary_local_path/000000_0" > "$auxiliary_local_path/000000_0_cv"
#==================================================================================
run_r_algorithm_in_batch_mode() {
	
	## Delaration de variables
	local path_of_all_cv="/PoCBigData/interzone/CV"
	local path_of_all_mission="/PoCBigData/interzone/MISSION"
	local path_of_all_poste="/PoCBigData/interzone/POSTE"
	local path_of_all_profil="/PoCBigData/interzone/PROFIL"
	
	
	local auxiliary_local_path="/home/biadmin/auxiliary"
	local r_script_path="/home/biadmin/POC_BIGDATA_SCRIPT/RScript/Matching_CV_Offres_RHadoop_test_time_2gram_6.r"
	local path_of_dictionary="/home/biadmin/POC_BIGDATA_SCRIPT/RScript/reserved_terms.csv"
	local path_result_rapprochement="/home/biadmin/rapprochement"
	local path_of_result_matrix="/home/biadmin/result-matrix"
	
	local PROG_HIVE="$HIVE_HOME/bin/hive"
	local PROG_HADOOP=`which hadoop`
	
	## Construire le jeu de données de CV
	local cv_query="select distinct(id_cv), ggid_consultant, name_consultant, cv_content, cv_insert_date, cv_source_path from PoCBigData.cv where (id_cv is not NULL or id_cv <> '') and (cv_content is not NULL or cv_content <> '')"
	$HIVE_HOME/bin/hive -e "\"$cv_query\"" | sed 's/[\t]/|/g' > "$auxiliary_local_path/000000_0_cv"
	if $PROG_HADOOP fs -test -e "$path_of_all_cv/000000_0_cv"; then        	
		$PROG_HADOOP fs -rm -r "$path_of_all_cv/000000_0_cv";
	fi
	$PROG_HADOOP fs -put "$auxiliary_local_path/000000_0_cv" "$path_of_all_cv/"
		
	## Construire le jeu de données de MISSION
	local mission_query="select distinct(id_mission), short_description, project_name, project_start_date, project_end_date, mission_client, customer_req_ref, grade, internal_description, mission_state, ggid_resource_manager, name_resource_manager, ggid_creator, ggid_requester, ggid_project_manager, ggid_project_type, internal_role, requester_bu, internal_skill, mission_language, creation_date, mission_jobtitle, mission_skill_1, mission_skill_2, mission_skill_3, mission_skill_cmt, mission_insert_date, mission_source_path from PoCBigData.mission where (id_mission is not NULL or id_mission <> '') and (internal_description is not NULL or internal_description <> '')"
	$HIVE_HOME/bin/hive -e "\"$mission_query\"" | sed 's/[\t]/|/g' > "$auxiliary_local_path/000000_0_mission"
	if $PROG_HADOOP fs -test -e "$path_of_all_mission/000000_0_mission"; then        	
		$PROG_HADOOP fs -rm -r "$path_of_all_mission/000000_0_mission";
	fi
	$PROG_HADOOP fs -put "$auxiliary_local_path/000000_0_mission" "$path_of_all_mission/"
	
	## Construire le jeu de données des profils
	local profil_query="select distinct(profil_id_cv), profil_type, profil_id_cv, profil_nom_complet, profil_nom, profil_prenom, contenu_cv, date_insertion, source_cv, grade, profil_role, profil_key_skills, adresse, disponibilite, sexe, profil_situation, profil_coefficient, profil_tempstravail, etablissement, profil_code_division, profil_division, telephone, email, profil_date_naissance, diplome, niveau_diplome, offre_resource_manager from PoCBigData.profil where (profil_id_cv is not NULL or profil_id_cv <> '') and (contenu_cv is not NULL or contenu_cv <> '')"
	$HIVE_HOME/bin/hive -e "\"$profil_query\"" | sed 's/[\t]/|/g' > "$auxiliary_local_path/000000_0_profil"
	if $PROG_HADOOP fs -test -e "$path_of_all_profil/000000_0_profil"; then        	
		$PROG_HADOOP fs -rm -r "$path_of_all_profil/000000_0_profil";
	fi
	$PROG_HADOOP fs -put "$auxiliary_local_path/000000_0_profil" "$path_of_all_profil/"
	
	## Construire le jeu de données des postes
	local poste_query="select distinct(id_offre), ref_offre, offre_short_description, offre_project_name, offre_start_date, offre_end_date, offre_client, customer_req_ref, grade, internal_description, offre_state, ggid_resource_manager, name_resource_manager, ggid_creator, ggid_requester, ggid_project_manager, ggid_project_type, internal_role, internal_skill, internal_level, offre_language, creation_date, offre_jobtitle, offre_skill_1, offre_skill_2, offre_skill_3, offre_skill_cmt, offre_adr_pour_postuler, offre_localisation_geo, offre_duree_poste, offre_poste_mission_flag, offre_insert_date, offre_path from PoCBigData.poste where (id_offre is not NULL or id_offre <> '') and (internal_description is not NULL or internal_description <> '')"
	$HIVE_HOME/bin/hive -e "\"$poste_query\"" | sed 's/[\t]/|/g' > "$auxiliary_local_path/000000_0_poste"
	if $PROG_HADOOP fs -test -e "$path_of_all_poste/000000_0_poste"; then        	
		$PROG_HADOOP fs -rm -r "$path_of_all_poste/000000_0_poste";
	fi
	$PROG_HADOOP fs -put "$auxiliary_local_path/000000_0_poste" "$path_of_all_poste/"
	
	## Appel de la commande RSCRIPT en mode BATCH
	RBS="Rscript \"$r_script_path\" \"$path_of_all_profil/000000_0_profil\" \"$path_of_all_poste/000000_0_poste\" \"$path_of_dictionary\" \"$path_result_rapprochement\" \"$path_of_result_matrix\""
	eval $RBS
}


#=== FUNCTION =====================================================================
# NAME: main
# DESCRIPTION: 
# PARAMETER 1: 
#==================================================================================
main() {
	run_r_algorithm_in_batch_mode
}


#-----------------------------------------------------------------------------------
# Appel du programme principal
#-----------------------------------------------------------------------------------
main



