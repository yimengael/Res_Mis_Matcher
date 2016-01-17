#!/bin/bash
#===================================================================================
#
#         FILE: PoCBigData_DecoupeListMISS.sh
#
#        USAGE: ./PoCBigData_DecoupeListMISS.sh
#
#  DESCRIPTION: 

# 		AUTHOR: Ing. Gaël Yimen Yimga (BIM), gael.yimen-yimga@capgemini.com
#      VERSION: 1.0
#    
#===================================================================================

#effacer l'ecran
clear


#=== FUNCTION =====================================================================
# NAME: decoupe_liste_fichier_mission_csv
# DESCRIPTION: 
# PARAMETER 1: 
#==================================================================================
decoupe_liste_fichier_mission_csv() {

	## Declaration des variables
	local repListMissCSV="/home/biadmin/PoCBigData/landingzone/source/MISSION-POSTE/MISSION/CSV"
	local missFileName="MISSION_BaseWWS"
	local prefix="u0001"
	
	## programme proprement dit
	fichierDesMiss="$repListMissCSV/$missFileName"
	
	## Traitement des MISSIONS issus de la base WWS
	echo "------- Lecture et traitement du fichier des MISSIONS de la base WWS --------"
	if [ -e $fichierDesMiss ] 
	then
	
		while IFS='|' read -r field1 field2 field3 field4 field5 field6 field7 field8 field9 field10 field11 field12 field13 \
								field14 field15 field16 field17 field18 field19 field20 field21 field22 field23 field24 field25 field26 \
								field27 field28 field29 field30 field31 field32 field33 field34 field35 field36 field37 field38 field39 \
								field40 field41 field42 field43 field44 field45 field46 field47 field48 field49 field50 field51 field52 \
								field53 field54 field55 field56 field57 field58 field59 field60 field61 field62 field63 field64 field65 \
								field66 field67 field68 field69 field70 field71 field72 field73 field74 field75 field76 field77 field78 \
								field79 field80 field81 field82 field83 field84 field85 field86 field87 field88 field89 field90 field91 \
								field92 field93 field94 field95 field96 field97 field98 field99 field100 field101 field102 field103 field104 \
								field105 field106 field107 field108 field109 field110 field111 field112 field113 field114 field115 field116 field117 \
								field118 field119 field120 field121 field122 field123 field124
		do 
			line="$prefix|$field1|$field3|$field4|$field5|$field6|$field9|$field10|$field11|$field16|$field27|$field28|$field29|$field34|$field41|$field47|$field59|$field70|$field71|$field73|$field75|$field76|$field112|$field113|$field114|$field115|$field118"
			touch $repListMissCSV/$field1
	   		echo "$line" > $repListMissCSV/$field1
		done < "$fichierDesMiss"
		echo "------- Fin du traitement du fichier des Missions de la base WWS -------"
		
		## Supprimer le fichier de base
		rm $fichierDesMiss
		if [ "$?" -eq "0" ]
		then
			echo "------- Suppression du fichier de base des Missions -------"
		fi
	
	fi
	
	
}


#=== FUNCTION =====================================================================
# NAME: main
# DESCRIPTION: 
# PARAMETER 1: 
#==================================================================================
main() {
	decoupe_liste_fichier_mission_csv
}


#----- Appel de la fonction principale ---------
main

