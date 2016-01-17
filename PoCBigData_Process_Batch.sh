#!/bin/bash
#===================================================================================
#
#         FILE: PoCBigData_Process_Batch.sh
#
#        USAGE: ./PoCBigData_Process_Batch.sh
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

	
	echo "### Debut du processus d'alimentation du BigInsights ###"
	
	now=$(date +"%T")
	echo "Debut de Alimentation predictive : $now"
	
	## Ingestion des données
	echo "-------- Depart Ingestion des données  ----------"
	#./PoCBigData_IngestDataFromSource.sh
	echo "-------- Arrivée Ingestion des données  ----------"
	
	sleep 10s
	
	## Archivage et Purge locales des données
	echo "-------- Archivage et purge des données locales  ----------"
	#./PoCBigData_ArchiveAndPurgeFileInLocal.sh
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
	./PoCBigData_MoveDataIntoHIVE.sh 0
	echo "-------- Arrivée Import des données dans Hive ----------"
	
	now=$(date +"%T")
	echo "Fin de Alimentation : $now"
	
	sleep 10s
	
	now=$(date +"%T")
	echo "Debut de R batch : $now"
	
	## Lancement du script R pour le mode BATCH
	echo "-------- Depart Script R pour le mode BATCH ----------"
	./PoCBigData_RunRAlgoInBatchMode.sh
	echo "-------- Arrivée Script R pour le mode BATCH ----------"
	
	now=$(date +"%T")
	echo "Fin de R batch : $now"
	
	sleep 10s
	
	now=$(date +"%T")
	echo "Debut de pretraitement WEX batch : $now"
	
	## Lancement du script pour preparer les données de WATSON
	echo "-------- Depart Prétraitement pour WEX ----------"
	./PoCBigData_IntegrateDataForWatsonExplorer.sh
	echo "-------- Fin Prétraitement pour WEX ----------"
	
	now=$(date +"%T")
	echo "Debut de pretraitement WEX batch : $now"
	

}


#-----------------------------------------------------------------------------------
# Appel du programme principal
#-----------------------------------------------------------------------------------
main

