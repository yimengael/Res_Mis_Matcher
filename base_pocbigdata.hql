---------------------------
-- Autor : Gael Yimen Y. --
---------------------------

-- Database creation in Hive
CREATE DATABASE IF NOT EXISTS pocbigdataibm
	COMMENT 'base de données pour le poc'
	LOCATION '/biginsights/hive/warehouse'
;
USE pocbigdataibm;

-- Deletion of tables if they exist
   DROP TABLE IF EXISTS cv;
   DROP TABLE IF EXISTS mission;
   DROP TABLE IF EXISTS poste;
   DROP TABLE IF EXISTS profil;


CREATE TABLE IF NOT EXISTS cv (  
  id_cv            STRING COMMENT 'id of cv',
  ggid_consultant  STRING COMMENT 'ggid of consultant',
  name_consultant  STRING COMMENT 'Name of consultant',
  cv_content       STRING COMMENT 'content of cv',
  cv_insert_date   STRING COMMENT 'insertion of cv in database',
  cv_source_path   STRING COMMENT 'path of the cv file'
)
COMMENT 'cv table'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/biginsights/hive/warehouse/cv';


CREATE TABLE IF NOT EXISTS mission (  
  id_mission            string  COMMENT 'identifiant de la mission',
  short_description     string  COMMENT 'petite description de la mission',
  project_name          string  COMMENT 'nom du projet de la mission',
  project_start_date    string  COMMENT 'date de debut du projet de la mission',
  project_end_date      string  COMMENT 'date de fin du projet de la mission',
  mission_client        string  COMMENT 'client de la mission',
  customer_req_ref      string  COMMENT 'reference de la requete client de la mission',
  grade                 string  COMMENT 'grade requis de la mission',
  internal_description  string  COMMENT 'description de la mission',
  mission_state         string  COMMENT 'etat de la mission',
  ggid_resource_manager string  COMMENT 'GGID du ressource manager de la mission',
  name_resource_manager string  COMMENT 'NAME du ressource manager de la mission',
  ggid_creator          string  COMMENT 'GGID du créateur de la mission',
  ggid_requester        string  COMMENT 'GGID du demandeur de la mission',
  ggid_project_manager  string  COMMENT 'GGID du project manager de la mission',
  ggid_project_type     string  COMMENT 'typ du project de la mission',
  internal_role         string  COMMENT 'role interne de la mission',
  requester_bu          string  COMMENT 'niveau internes de la mission',
  internal_skill        string  COMMENT 'competence internes de la mission',
  mission_language      string  COMMENT 'langue utilisée de la mission',
  creation_date         string  COMMENT 'date de creation de la mission',
  mission_jobtitle      string  COMMENT 'titre du job de la mission',
  mission_skill_1       string  COMMENT 'competence 1 de la mission',
  mission_skill_2       string  COMMENT 'competence 2 de la mission',
  mission_skill_3       string  COMMENT 'competence 3 de la mission',
  mission_skill_cmt     string  COMMENT 'commentaire sur les competences de la mission',
  mission_insert_date   STRING  COMMENT 'date insertion du mission dans la base',
  mission_source_path   string  COMMENT 'chemin du fichier source de la mission'
)
COMMENT 'mission table'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/biginsights/hive/warehouse/mission';



CREATE TABLE IF NOT EXISTS poste (  
  id_offre                   string  COMMENT 'identifiant de offre de poste ou de mission. Chaine numerique depuis la base et MD5 quelconque',
  ref_offre                  string  COMMENT 'reference de l\'offre de poste. Ce champ est NULL pour une mission',
  offre_short_description    string  COMMENT 'Courte description de l\'offre de poste ou de mission pour une offre de poste, il s\'agit de INT_OFFRE du fichier CSV des offres de poste',
  offre_project_name         string  COMMENT 'nom du projet de la mission. Elle a la valeur NULL pour une offre de poste',
  offre_start_date           string  COMMENT 'date de debut de la mission pour une offre de mission. Elle corresponds a DATE_DEB_OFFRE du fichier CSV des offres de poste',
  offre_end_date             string  COMMENT 'date de fin de la mission pour une offre de mission. Ce champ a la valeur NULL pour les offres de poste',
  offre_client               string  COMMENT 'C\'est client de la mission. Ce champ a la valeur NULL pour les offres de poste',
  customer_req_ref           string  COMMENT 'reference de la requete client de la mission. Ce champ est a NULL pour les offres de poste',
  grade                      string  COMMENT 'grade requis de la mission. Ce champ est a NULL pour les offres de poste',
  internal_description       string  COMMENT 'Ce champ est la description d\'une offre de poste ou de mission. Pour une offre de poste',
  offre_state                string  COMMENT 'etat de la mission ou de l\'offre de poste. Elle a une valeur NULL pour une offre de poste',
  ggid_resource_manager      string  COMMENT 'GGID du ressource manager de la mission Ce champ est a NULL pour les offres de poste',
  name_resource_manager      string  COMMENT 'NAME du ressource manager de la mission Ce champ est a NULL pour les offres de poste',
  ggid_creator               string  COMMENT 'GGID du créateur de la mission Ce champ est a NULL pour les offres de poste',
  ggid_requester             string  COMMENT 'GGID du demandeur de la mission Ce champ est a NULL pour les offres de poste',
  ggid_project_manager       string  COMMENT 'GGID du project manager de la mission Ce champ est a NULL pour les offres de poste',
  ggid_project_type          string  COMMENT 'types du project de la mission Ce champ est a NULL pour les offres de poste',
  internal_role              string  COMMENT 'role interne de la mission. Ce champ est vide pour les offres de poste',
  internal_skill             string  COMMENT 'competence internes de la mission',
  internal_level             string  COMMENT 'niveau internes de la mission. Ce champ correspond au champ division_ligne_service des offres de poste',
  offre_language             string  COMMENT 'langue utilisée de la mission. Ce champ est a NULL pour les offres de poste',
  creation_date              string  COMMENT 'date de creation de la mission. Ce champ est a NULL pour les offres de poste',
  offre_jobtitle             string  COMMENT 'il s\'agit du job title de la mission. Ce champ est a NULL pour les offres de poste',
  offre_skill_1              string  COMMENT 'competence 1 de la mission. Ce champ est a NULL pour les offres de poste',
  offre_skill_2              string  COMMENT 'competence 2 de la mission. Ce champ est a NULL pour les offres de poste',
  offre_skill_3              string  COMMENT 'competence 3 de la mission. Ce champ est a NULL pour les offres de poste',
  offre_skill_cmt            string  COMMENT 'commentaire sur les competences de la mission. Ce champ est a NULL pour les offres de poste',
  offre_adr_pour_postuler    string  COMMENT 'adresse email pour postuler a la proposition de offre de poste',
  offre_localisation_geo     string  COMMENT 'information geographique du poste',
  offre_duree_poste          string  COMMENT 'duree du stage pour un stage, duree de la mission pour une mission',
  offre_poste_mission_flag   string  COMMENT 'Ce champ permet de differenceir une mission et un poste P: pour offre de poste et M pour offre de mission', 
  offre_insert_date          string  COMMENT 'Date d\'insertion des données dans la base',
  offre_path                 string  COMMENT 'chemin du fichier source de la mission'
)
COMMENT 'Table des postes'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/biginsights/hive/warehouse/poste';



CREATE TABLE IF NOT EXISTS profil ( 

	profil_id               string  COMMENT 'identifiant de profil',
	profil_Type             string  COMMENT 'typ du profil externe ou interne',
	profil_id_cv            string  COMMENT 'identifiant de cv',
	profil_nom_complet      string  COMMENT 'nom complet du consultant',
	profil_nom              string  COMMENT 'nom du consultant',
	profil_prenom           string  COMMENT 'prenom du consultant',
	contenu_cv              string  COMMENT 'contenu textuel du CV du consultant',
	date_insertion          string  COMMENT 'date insertion du profil',
	source_cv               string  COMMENT 'source du cv qui peut etre externe ou interne',
	grade                   string  COMMENT 'grade du consultant',
	profil_role             string  COMMENT 'role du consultant',
	profil_key_skills       string  COMMENT 'competences du consultant',
	adresse                 string  COMMENT 'adresse du consultant',
	disponibilite           string  COMMENT 'disponibilité du consultant',
	sexe                    string  COMMENT 'sexe du consultant',
	profil_situation        string  COMMENT 'situation du consultant',
	profil_coefficient      string  COMMENT 'coefficient ',
	profil_tempsTravail     string  COMMENT 'Mitemps, Temps plein',
	etablissement           string  COMMENT '',
	profil_code_division    string  COMMENT 'Code de a division de service',
	profil_division         string  COMMENT 'Nom de la division de service',
	telephone               string  COMMENT 'telephone du consultant',
	email                   string  COMMENT 'email du consultant',
	profil_date_naissance   string  COMMENT 'date de naissance du consultant',
	diplome                 string  COMMENT 'diplome le plus eleve du consultant',
	niveau_diplome          string  COMMENT 'niveau du diplome du consultant',
	offre_resource_manager  string  COMMENT 'ressource manager du poste'
  
)
COMMENT 'Table des profils'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/biginsights/hive/warehouse/profil';


-- LOAD DATA INPATH '/pocbigdataIBM/landingzone/cible/CV/part-r-*' into table cv
-- LOAD DATA INPATH '/pocbigdataIBM/landingzone/cible/MISSION/part-r-*' into table mission
-- LOAD DATA INPATH '/pocbigdataIBM/landingzone/cible/POSTE/part-r-*' into table poste
-- LOAD DATA INPATH '/pocbigdataIBM/landingzone/cible/PROFIL/part-r-*' into table profil

-- LOAD DATA LOCAL INPATH '/home/biadmin/CV-LAST' into table cv
-- LOAD DATA LOCAL INPATH '/home/biadmin/Mission-Last' into table mission
-- LOAD DATA LOCAL INPATH '/home/biadmin/Poste-Last' into table poste
-- LOAD DATA LOCAL INPATH '/home/biadmin/Profil-Last' into table profil
