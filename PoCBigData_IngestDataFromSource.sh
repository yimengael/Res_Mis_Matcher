#!/bin/bash
#===================================================================================
#
#         FILE: PoCBigData_IngestDataFromSource.sh
#
#        USAGE: ./PoCBigData_IngestDataFromSource.sh
#
#  DESCRIPTION: Ce script permet de gerer toute la partie ingestion des données
#				qui consiste a l'import des donnés de la machine gateway vers
# 				le cluster HDFS.
# 				L'ingestion des données consiste en plusisuers etapes : 
# 				la découpe des fichiers CSV de CV, la decoupe des fichiers
#   			CSV de MISSION et les metadonnées, la decoupe des fichers CSV de description
# 				de poste, le renommage des fichiers, et la verification de
# 				l'existence des fichiers sur le HDFS avant la copie.
#               
# 		AUTHOR: Ing. Gaël Yimen Yimga
#      VERSION: 1.0
#    
#===================================================================================


#=== FUNCTION =====================================================================
# NAME: copy_directory_from_srce_to_hdfs
# DESCRIPTION: 
# PARAMETER 1: 
#==================================================================================
copy_directory_from_srce_to_hdfs() {

	## Declaration de variables
	local rep_depart="sftp://biadmin:biadmin@bivm.ibm.com/home/biadmin/PoCBigData/landingzone"
	local rep_arrivee="hdfs://bivm.ibm.com:9000/PoCBigData/"
	local PROG_HADOOP=`which hadoop`

	## Copie des fichiers
	if $($PROG_HADOOP fs -test -d $rep_arrivee) 
	then
		echo "$rep_arrivee est un répertoire qui existe déjà" 
	else
		$PROG_HADOOP fs -mkdir $rep_arrivee
		echo "$rep_arrivee a été créé" 
	fi
	echo "Copie des fichiers de la source"
	$PROG_HADOOP fs -put $rep_depart $rep_arrivee
	echo "Fin de la copie des fichiers de la source"
}



#=== FUNCTION =====================================================================
# NAME: check_if_exist_in_hdfs_before_copy
# DESCRIPTION: 
# PARAMETER 1: 
#==================================================================================
check_if_exist_in_hdfs_before_copy() {

	## Declaration de variables
	local rep_depart_cv="/home/biadmin/PoCBigData/landingzone/source/CV"
	local rep_depart_mission="/home/biadmin/PoCBigData/landingzone/source/MISSION-POSTE/MISSION"
	local rep_depart_poste="/home/biadmin/PoCBigData/landingzone/source/MISSION-POSTE/POSTE"
	local rep_depart_metadata="/home/biadmin/PoCBigData/landingzone/source/METADATA"
	
	local rep_arrivee_cv="/PoCBigData/landingzone/source/CV"
	local rep_arrivee_mission="/PoCBigData/landingzone/source/MISSION-POSTE/MISSION"
	local rep_arrivee_poste="/PoCBigData/landingzone/source/MISSION-POSTE/POSTE"
	local rep_arrivee_metadata="/PoCBigData/landingzone/source/METADATA"
	
	local PROG_HADOOP=`which hadoop`

	## Copie des fichiers de CV DOC
	rep_cv_doc="$rep_depart_cv/DOC"
	ls "$rep_cv_doc"|while read -r; do 
		# Si le fichier existe dans HDFS
		if $PROG_HADOOP fs -test -e "$rep_arrivee_cv/DOC/$REPLY"; then        	
			echo "** Fichier existant dans HDFS ** :" "$REPLY";
			# suppresion du fichier dans HDFS 
			$PROG_HADOOP fs -rm "$rep_arrivee_cv/DOC/$REPLY";
			echo "Le fichier $REPLY à été supprimé du HDFS";
			echo "Copie de la nouvelle version du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_cv_doc/$REPLY" "$rep_arrivee_cv/DOC/"
		else
			echo "Copie du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_cv_doc/$REPLY" "$rep_arrivee_cv/DOC/$REPLY"
		fi
	done
	
	
	## Copie des fichiers de CV PDF
	rep_cv_pdf="$rep_depart_cv/PDF"
	ls "$rep_cv_pdf"|while read -r; do 
		# Si le fichier existe dans HDFS
		if $PROG_HADOOP fs -test -e "$rep_arrivee_cv/PDF/$REPLY"; then        	
			echo "** Fichier existant dans HDFS ** :" "$REPLY";
			# suppresion du fichier dans HDFS 
			$PROG_HADOOP fs -rm "$rep_arrivee_cv/PDF/$REPLY";
			echo "Le fichier $REPLY à été supprimé du HDFS";
			echo "Copie de la nouvelle version du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_cv_pdf/$REPLY" "$rep_arrivee_cv/PDF/"
		else
			echo "Copie du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_cv_pdf/$REPLY" "$rep_arrivee_cv/PDF/$REPLY"
		fi
	done
	
	
	## Copie des fichiers de CV CSV
	rep_cv_csv="$rep_depart_cv/CSV"
	ls "$rep_cv_csv"|while read -r; do 
		# Si le fichier existe dans HDFS
		if $PROG_HADOOP fs -test -e "$rep_arrivee_cv/CSV/$REPLY"; then        	
			echo "** Fichier existant dans HDFS ** :" "$REPLY";
			# suppresion du fichier dans HDFS 
			$PROG_HADOOP fs -rm "$rep_arrivee_cv/CSV/$REPLY";
			echo "Le fichier $REPLY à été supprimé du HDFS";
			echo "Copie de la nouvelle version du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_cv_csv/$REPLY" "$rep_arrivee_cv/CSV/"
		else
			echo "Copie du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_cv_csv/$REPLY" "$rep_arrivee_cv/CSV/$REPLY"
		fi
	done
	
	
	## Copie des fichiers de CV TXT
	rep_cv_txt="$rep_depart_cv/TXT"
	ls "$rep_cv_txt"|while read -r; do 
		# Si le fichier existe dans HDFS
		if $PROG_HADOOP fs -test -e "$rep_arrivee_cv/TXT/$REPLY"; then        	
			echo "** Fichier existant dans HDFS ** :" "$REPLY";
			# suppresion du fichier dans HDFS 
			$PROG_HADOOP fs -rm "$rep_arrivee_cv/TXT/$REPLY";
			echo "Le fichier $REPLY à été supprimé du HDFS";
			echo "Copie de la nouvelle version du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_cv_txt/$REPLY" "$rep_arrivee_cv/TXT/"
		else
			echo "Copie du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_cv_txt/$REPLY" "$rep_arrivee_cv/TXT/$REPLY"
		fi
	done
	
	
	
	## Copie des fichiers de MISSION DOC
	rep_mission_doc="$rep_depart_mission/DOC"
	ls "$rep_mission_doc"|while read -r; do 
		# Si le fichier existe dans HDFS
		if $PROG_HADOOP fs -test -e "$rep_arrivee_mission/DOC/$REPLY"; then        	
			echo "** Fichier existant dans HDFS ** :" "$REPLY";
			# suppresion du fichier dans HDFS 
			$PROG_HADOOP fs -rm "$rep_arrivee_mission/DOC/$REPLY";
			echo "Le fichier $REPLY à été supprimé du HDFS";
			echo "Copie de la nouvelle version du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_mission_doc/$REPLY" "$rep_arrivee_mission/DOC/"
		else
			echo "Copie du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_mission_doc/$REPLY" "$rep_arrivee_mission/DOC/$REPLY"
		fi
	done
	
	
	## Copie des fichiers de MISSION PDF
	rep_mission_pdf="$rep_depart_mission/PDF"
	ls "$rep_mission_pdf"|while read -r; do 
		# Si le fichier existe dans HDFS
		if $PROG_HADOOP fs -test -e "$rep_arrivee_mission/PDF/$REPLY"; then        	
			echo "** Fichier existant dans HDFS ** :" "$REPLY";
			# suppresion du fichier dans HDFS 
			$PROG_HADOOP fs -rm "$rep_arrivee_mission/PDF/$REPLY";
			echo "Le fichier $REPLY à été supprimé du HDFS";
			echo "Copie de la nouvelle version du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_mission_pdf/$REPLY" "$rep_arrivee_mission/PDF/"
		else
			echo "Copie du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_mission_pdf/$REPLY" "$rep_arrivee_mission/PDF/$REPLY"
		fi
	done
	
	
	## Copie des fichiers de MISSION CSV
	rep_mission_csv="$rep_depart_mission/CSV"
	ls "$rep_mission_csv"|while read -r; do 
		# Si le fichier existe dans HDFS
		if $PROG_HADOOP fs -test -e "$rep_arrivee_mission/CSV/$REPLY"; then        	
			echo "** Fichier existant dans HDFS ** :" "$REPLY";
			# suppresion du fichier dans HDFS 
			$PROG_HADOOP fs -rm "$rep_arrivee_mission/CSV/$REPLY";
			echo "Le fichier $REPLY à été supprimé du HDFS";
			echo "Copie de la nouvelle version du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_mission_csv/$REPLY" "$rep_arrivee_mission/CSV/"
		else
			echo "Copie du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_mission_csv/$REPLY" "$rep_arrivee_mission/CSV/$REPLY"
		fi
	done
	
	
	## Copie des fichiers de MISSION MSG
	rep_mission_msg="$rep_depart_mission/MSG"
	ls "$rep_mission_msg"|while read -r; do 
		# Si le fichier existe dans HDFS
		if $PROG_HADOOP fs -test -e "$rep_arrivee_mission/MSG/$REPLY"; then        	
			echo "** Fichier existant dans HDFS ** :" "$REPLY";
			# suppresion du fichier dans HDFS 
			$PROG_HADOOP fs -rm "$rep_arrivee_mission/MSG/$REPLY";
			echo "Le fichier $REPLY à été supprimé du HDFS";
			echo "Copie de la nouvelle version du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_mission_msg/$REPLY" "$rep_arrivee_mission/MSG/"
		else
			echo "Copie du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_mission_msg/$REPLY" "$rep_arrivee_mission/MSG/$REPLY"
		fi
	done
	
	
	## Copie des fichiers de MISSION TXT
	rep_mission_txt="$rep_depart_mission/TXT"
	ls "$rep_mission_txt"|while read -r; do 
		# Si le fichier existe dans HDFS
		if $PROG_HADOOP fs -test -e "$rep_arrivee_mission/TXT/$REPLY"; then        	
			echo "** Fichier existant dans HDFS ** :" "$REPLY";
			# suppresion du fichier dans HDFS 
			$PROG_HADOOP fs -rm "$rep_arrivee_mission/TXT/$REPLY";
			echo "Le fichier $REPLY à été supprimé du HDFS";
			echo "Copie de la nouvelle version du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_mission_txt/$REPLY" "$rep_arrivee_mission/TXT/"
		else
			echo "Copie du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_mission_txt/$REPLY" "$rep_arrivee_mission/TXT/$REPLY"
		fi
	done
	
	
	## Copie des fichiers de POSTE CSV
	rep_poste_csv="$rep_depart_poste/CSV"
	ls "$rep_poste_csv"|while read -r; do 
		# Si le fichier existe dans HDFS
		if $PROG_HADOOP fs -test -e "$rep_arrivee_poste/CSV/$REPLY"; then        	
			echo "** Fichier existant dans HDFS ** :" "$REPLY";
			# suppresion du fichier dans HDFS 
			$PROG_HADOOP fs -rm "$rep_arrivee_poste/CSV/$REPLY";
			echo "Le fichier $REPLY à été supprimé du HDFS";
			echo "Copie de la nouvelle version du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_poste_csv/$REPLY" "$rep_arrivee_poste/CSV/"
		else
			echo "Copie du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_poste_csv/$REPLY" "$rep_arrivee_poste/CSV/$REPLY"
		fi
	done
	
	
	## Copie des fichiers de POSTE MSG
	rep_poste_msg="$rep_depart_poste/MSG"
	ls "$rep_poste_msg"|while read -r; do 
		# Si le fichier existe dans HDFS
		if $PROG_HADOOP fs -test -e "$rep_arrivee_poste/MSG/$REPLY"; then        	
			echo "** Fichier existant dans HDFS ** :" "$REPLY";
			# suppresion du fichier dans HDFS 
			$PROG_HADOOP fs -rm "$rep_arrivee_poste/MSG/$REPLY";
			echo "Le fichier $REPLY à été supprimé du HDFS";
			echo "Copie de la nouvelle version du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_poste_msg/$REPLY" "$rep_arrivee_poste/MSG/"
		else
			echo "Copie du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_poste_msg/$REPLY" "$rep_arrivee_poste/MSG/$REPLY"
		fi
	done
	
	
	## Copie des fichiers de POSTE DOC
	rep_poste_doc="$rep_depart_poste/DOC"
	ls "$rep_poste_doc"|while read -r; do 
		# Si le fichier existe dans HDFS
		if $PROG_HADOOP fs -test -e "$rep_arrivee_poste/DOC/$REPLY"; then        	
			echo "** Fichier existant dans HDFS ** :" "$REPLY";
			# suppresion du fichier dans HDFS 
			$PROG_HADOOP fs -rm "$rep_arrivee_poste/DOC/$REPLY";
			echo "Le fichier $REPLY à été supprimé du HDFS";
			echo "Copie de la nouvelle version du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_poste_doc/$REPLY" "$rep_arrivee_poste/DOC/"
		else
			echo "Copie du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_poste_doc/$REPLY" "$rep_arrivee_poste/DOC/$REPLY"
		fi
	done
	
	## Copie des fichiers de POSTE PDF
	rep_poste_pdf="$rep_depart_poste/PDF"
	ls "$rep_poste_pdf"|while read -r; do 
		# Si le fichier existe dans HDFS
		if $PROG_HADOOP fs -test -e "$rep_arrivee_poste/PDF/$REPLY"; then        	
			echo "** Fichier existant dans HDFS ** :" "$REPLY";
			# suppresion du fichier dans HDFS 
			$PROG_HADOOP fs -rm "$rep_arrivee_poste/PDF/$REPLY";
			echo "Le fichier $REPLY à été supprimé du HDFS";
			echo "Copie de la nouvelle version du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_poste_pdf/$REPLY" "$rep_arrivee_poste/PDF/"
		else
			echo "Copie du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_poste_pdf/$REPLY" "$rep_arrivee_poste/PDF/$REPLY"
		fi
	done
	
	## Copie des fichiers de POSTE TXT
	rep_poste_txt="$rep_depart_poste/TXT"
	ls "$rep_poste_txt"|while read -r; do 
		# Si le fichier existe dans HDFS
		if $PROG_HADOOP fs -test -e "$rep_arrivee_poste/TXT/$REPLY"; then        	
			echo "** Fichier existant dans HDFS ** :" "$REPLY";
			# suppresion du fichier dans HDFS 
			$PROG_HADOOP fs -rm "$rep_arrivee_poste/TXT/$REPLY";
			echo "Le fichier $REPLY à été supprimé du HDFS";
			echo "Copie de la nouvelle version du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_poste_txt/$REPLY" "$rep_arrivee_poste/TXT/"
		else
			echo "Copie du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_poste_txt/$REPLY" "$rep_arrivee_poste/TXT/$REPLY"
		fi
	done
	
	
	## Copie des fichiers de METADATA CSV
	rep_metadata_csv="$rep_depart_metadata/CSV"
	ls "$rep_metadata_csv"|while read -r; do 
		# Si le fichier existe dans HDFS
		if $PROG_HADOOP fs -test -e "$rep_arrivee_metadata/CSV/$REPLY"; then        	
			echo "** Fichier existant dans HDFS ** :" "$REPLY";
			# suppresion du fichier dans HDFS 
			$PROG_HADOOP fs -rm "$rep_arrivee_metadata/CSV/$REPLY";
			echo "Le fichier $REPLY à été supprimé du HDFS";
			echo "Copie de la nouvelle version du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_metadata_csv/$REPLY" "$rep_arrivee_metadata/CSV/"
		else
			echo "Copie du fichier : $REPLY"
			$PROG_HADOOP fs -put "$rep_metadata_csv/$REPLY" "$rep_arrivee_metadata/CSV/$REPLY"
		fi
	done
	
	
}


#=== FUNCTION =====================================================================
# NAME: main
# DESCRIPTION: 
# PARAMETER 1: 
#==================================================================================
main() {

	echo "-------- Decoupage CV en provenance de la base ----------"
	./PoCBigData_DecoupeListCV.sh
	echo "-------- Fin Decoupage CV en provenance de la base  ----------"
	
	sleep 10s
	
	echo "-------- Decoupage MISSION en provenance de la base ----------"
	./PoCBigData_DecoupeListMISS.sh
	echo "-------- Fin Decoupage MISSION en provenance de la base  ----------"

	sleep 10s
	
	echo "-------- Decoupage POSTE en provenance de la base ----------"
	./PoCBigData_DecoupeListPOSTE.sh
	echo "-------- Fin Decoupage POSTE en provenance de la base  ----------"

	sleep 10s
	
	echo "-------- Decoupage MISSION en provenance de la base ----------"
	./PoCBigData_RenameFileWithUnderScore.sh
	echo "-------- Fin Decoupage MISSION en provenance de la base  ----------"

	sleep 10s
	
	#copy_directory_from_srce_to_hdfs
	echo "-------- Chargement CV, MISSIONS, POSTE, et METADATA sous d'autres formats ----------"
	check_if_exist_in_hdfs_before_copy
	echo "-------- Fin chargement CV, MISSIONS, POSTE et METADATA sous d'autres formats ----------"
	
}


#----- Appel de la fonction principale ---------
main
 

