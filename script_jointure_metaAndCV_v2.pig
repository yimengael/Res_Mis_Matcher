/* chargement de fichier csv (L01) */
meta1 = LOAD '$INPUT_FILE_METADATA/CSV/L01.csv' using PigStorage('$SEMI_COLON_SEPARATOR') as (ggid:chararray,nom:chararray,prenom:chararray,qualite:chararray,sexe:chararray,situation:chararray,Date_entree:chararray,date_sortie:chararray,nature:chararray,qualification:chararray,position:chararray, coefficient:chararray,tempsContractuel:chararray,payees_tmp:chararray,code_unite_org:chararray,unite_org:chararray,societe:chararray,codeDivision:chararray,division:chararray, codeEtablissement:chararray,etablissement:chararray,centreCout:chararray,affectation:chararray,codeRole:chararray,role:chararray,grade:chararray,codeNOP:chararray,profession:chararray,metier:chararray, discipline:chararray,adresse:chararray,complementAdresse:chararray,bureauDistributeur:chararray,codePays:chararray,telephone:chararray,email:chararray,NbreEnfants:chararray, Nationalite:chararray,dateNaissance:chararray,typeDiplome:chararray,niveauDiplome:chararray,codeEcole:chararray,groupeEcole:chararray,dateDiplome:chararray);
/* Champs importants du fichier L01 */
meta1_F = FOREACH meta1 GENERATE $0 as ggid, $1 as nom,$2 as prenom,$4 as sexe, $5 as situation, $11 as coefficient ,$24 as role, $25 as grade, $30 as adresse, $34 as tel,$35 as email, $38 as dateNaissance,$39 as typeDiplome,$40 as niveauDiplome,$12 as tempsContractuel,$20 as etablissement,$18 as division;


/* Chargement de fichier csv (Retain) */
meta2 = LOAD '$INPUT_FILE_METADATA/CSV/Retain.csv' using PigStorage('$SEMI_COLON_SEPARATOR') as (lastName:chararray,firstName:chararray,grade:chararray,role:chararray,officeBase:chararray,peopleMgrName:chararray,skills:chararray,personalAddress:chararray,ggid:chararray, globalpractice:chararray,subBUResource:chararray,availableDate:chararray,notes:chararray,mainProject:chararray);
/* Champs importants du fichier Retain */
meta2_F = FOREACH meta2 GENERATE $8 as ggid,$6 as skills,$9 as globalpractice,$11 as availableDate,$10 as subBUResource;


/* Jointure entre les metadonnes L01 et Retain*/
x = JOIN meta1_F by ggid FULL, meta2_F BY ggid;
y = FOREACH x {GENERATE ($0 is not null?$0:$17) as ggid, 'interne' as typeProfil,'' as idCV,'' as nomComplet,$1 as nomUsuel,$2 as prenom,'' as CV,'' as cheminCV,$7 as grade,$6 as role,$18 as skills, $8 as adresse , $20 as dateDispo  ,$3 as sexe,$4 as situation ,$5 as coefficient, $15 as etablissement, $16 as division,$9 as tel,$10 as email,$11 as dateNaissance, $12 as typeDiplome, $13 as niveauDiplome, $14 as tempsContractuel,$21 as subBUResource ;}


/* Enregistrement des resultats dans HDFS */
STORE y INTO  '$OUTPUT_FILE_METADATA' USING PigStorage('$PIPE_SEPARATOR');


/* chargement de fichier des CVs depuis HDFS */
c = LOAD '$OUTPUT_FILE_CV/part-r-*' using PigStorage('$PIPE_SEPARATOR') as (idCV:chararray,ggid:chararray,nom:chararray,cv:chararray,date:chararray,chemin:chararray);


/* Jointure entre les metadonnes et CVs */
z = join y by ggid FULL, c by ggid;
rs = FOREACH z {GENERATE ($0 is not null?$0:$26) as ggid, 'interne' as typeProfil,($25 is not null?$25:'int03') as idCV,$27 as nomComplet,$4 as nomUsuel,$5 as prenom,($28 is not null?$28:'--') as CV,$29 as dateStore,$30 as cheminCV,$8 as grade,$9 as role,$10 as skills, $11 as adresse , $12 as dateDispo  ,$13 as sexe,$14 as situation ,$15 as coefficient, $23 as tempsContractuel, $16 as etablissement, $17 as division,$18 as tel,$19 as email,$20 as dateNaissance, $21 as typeDiplome, $22 as niveauDiplome,$24 as subBUResource;}


/*Store data into HDFS*/
STORE rs INTO  '$OUTPUT_FILE_PROFIL' USING PigStorage('$PIPE_SEPARATOR');


