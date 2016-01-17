#!/bin/bash
#===================================================================================
#
#         FILE: PoCBigData_Process_Recurrent.sh
#
#        USAGE: ./PoCBigData_Process_Reccurrent.sh
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
# NAME: main
# DESCRIPTION: 
# PARAMETER 1: 
#==================================================================================
main() {	

	## Declaration de variables
	local rep_depart_cv="/home/biadmin/PoCBigData/landingzone/source/CV"
	local rep_depart_mission="/home/biadmin/PoCBigData/landingzone/source/MISSION-POSTE/MISSION"
	local rep_depart_poste="/home/biadmin/PoCBigData/landingzone/source/MISSION-POSTE/POSTE"
	local rep_depart_metadata="/home/biadmin/PoCBigData/landingzone/source/METADATA"
	
	
	## verifier que l'un des repertoires n'est pas vide
	if [[ "$(ls -A $rep_depart_cv)" ]] || [[ "$(ls -A $rep_depart_mission)" ]] || [[ "$(ls -A $rep_depart_poste)" ]] || [[ "$(ls -A $rep_depart_metadata)" ]]; then
    	#echo "$DIR is not Empty"
    	
    	now=$(date +"%T")
		echo "Debut de Alimentation predictive : $now"
    	
    	echo "### Debut du processus d'alimentation du BigInsights ###"
	
		## Ingestion des données
		echo "-------- Depart Ingestion des données  ----------"
		./PoCBigData_IngestDataFromSource.sh
		echo "-------- Arrivée Ingestion des données  ----------"
	
		sleep 10s
	
		## Archivage et Purge locales des données
		echo "-------- Archivage et purge des données locales  ----------"
		./PoCBigData_ArchiveAndPurgeFileInLocal.sh
		echo "-------- Fin Archivage et purge des données locales  ----------"
	
		sleep 10s
	
		## Extraction des données
		echo "-------- Depart Extraction des données CV, Missions, Postes ----------"
		./PoCBigData_ExtractDataTextFromFileInHDFS.sh
		echo "-------- Arrivée Extraction des données CV, Missions, Postes ----------"
	
		sleep 10s
	
		## Extraction des profils
		echo "-------- Depart Extraction des Profils Internes  ----------"
		./PoCBigData_JointCVMetadataToHaveIntProfile.sh
		echo "-------- Arrivée Extraction des Profils Internes  ----------"
	
		sleep 10s
	
		## Migration vers Hive - 0 : batch mode, 1 : recurrent mode
		echo "-------- Depart Import des données dans Hive ----------"
		./PoCBigData_MoveDataIntoHIVE.sh 1
		echo "-------- Arrivée Import des données dans Hive ----------"
	
		sleep 10s
		
		now=$(date +"%T")
		echo "Fin de Alimentation predictive : $now"
		
		now=$(date +"%T")
		echo "Debut de R predictif : $now"
	
		## Lancement du script R pour le mode RECURRENT
		echo "-------- Depart Script R pour le mode RECURRENT ----------"
		./PoCBigData_RunRAlgoInRecurrentMode.sh
		echo "-------- Arrivée Script R pour le mode RECURRENT ----------"
		
		now=$(date +"%T")
		echo "Fin de R Predictif : $now"
		
		sleep 10s
		
		now=$(date +"%T")
		echo "Debut preparation pour WEX : $now"
		
		## Lancement du script pour preparer les données de WATSON
		echo "-------- Depart Prétraitement pour WEX ----------"
		./PoCBigData_IntegrateDataForWatsonExplorer.sh
		echo "-------- Fin Prétraitement pour WEX ----------"
		
		now=$(date +"%T")
		echo "Fin preparation pour WEX : $now"
    	
    	
	else
    	echo "$DIR is Empty"
	fi

}


#-----------------------------------------------------------------------------------
# Appel du programme principal
#-----------------------------------------------------------------------------------
main

