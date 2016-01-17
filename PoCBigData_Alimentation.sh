#!/bin/bash
#===================================================================================
#
#         FILE: PoCBigData_Alimentation.sh
#
#        USAGE: ./PoCBigData_Alimentation.sh
#
#  DESCRIPTION: Ce script permet d'integrer tous les scripts du projet.
#               C'est le fichier principal de gestion de l'alimentation
#               Il appelle le script d'ingestion des données de depart,
#               le script d'extraction des données des CV, MISSION et des 
#               DESCRIPTION DE POSTE, et enfin fait la migration des données
#               dans le warehouse HIVE.

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
	echo "Debut de Ingestion et archivage : $now"
	
	## Ingestion des données
	echo "-------- Depart Ingestion des données  ----------"
	./PoCBigData_IngestDataFromSource.sh
	echo "-------- Arrivée Ingestion des données  ----------"
	
	sleep 10s
	
	## Archivage et Purge locales des données
	echo "-------- Archivage et purge des données locales  ----------"
	./PoCBigData_ArchiveAndPurgeFileInLocal.sh
	echo "-------- Fin Archivage et purge des données locales  ----------"
	
	now=$(date +"%T")
	echo "Fin de Ingestion et archivage : $now"
	
	sleep 10s
	
	now=$(date +"%T")
	echo "Debut de l'extraction : $now"
	
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
	
	## Migration vers Hive
	echo "-------- Depart Import des données dans Hive ----------"
	./PoCBigData_MoveDataIntoHIVE.sh 1
	echo "-------- Arrivée Import des données dans Hive ----------"
	
	now=$(date +"%T")
	echo "Debut de l'extraction : $now"
	
	echo "### Fin du processus d'alimentation du BigInsights ###"

}


#-----------------------------------------------------------------------------------
# Appel du programme principal
#-----------------------------------------------------------------------------------
main



