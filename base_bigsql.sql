---------------------------
-- Autor : Gael Yimen Y. --
---------------------------

-- schema import
use pocbigdata;

-----------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------- Table of profiles --------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------

-- Deletion of profiles's tables
drop table pocbigdata.profiles;

-- Profiles table creation 
create hadoop table pocbigdata.profiles
(  
  id_profil                String,
  type_profil  	           String,
  id_cv                    String,
  nom_complet              String,
  nom_dusage	             String,	
  prenom                   String,
  contenue_cv              String,
  insert_date			         String,
  chemin_cv                String,
  grade                    String,
  role                     String,
  key_skills               String,
  adresse                  String,
  date_de_disponibilite    String,
  sexe                     String,
  situation                String,
  coefficient              String,
  temps_contractuel        String,
  etablissement 		       String,	
  division                 String,
  telephone                String,
  adresse_mail             String,
  date_de_naissance        String,
  type_de_diplome          String,
  niveau_du_diplome        String,  
  resource_manager		     String
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LOCATION '/biginsights/bigsql/warehouse/profiles';


-- Feeding of table Profiles from HDFS
LOAD HADOOP USING FILE '/pocbigdataIBM/interzone/CV/000000_0_profil'
WITH SOURCE PROPERTIES ( 
   'date.time.format' = 'dd/mm/yyyy', 
   'field.delimiter'='|'
)
INTO TABLE  pocbigdata.profiles OVERWRITE ;

-- Alimentation en Append de la table profils a partir du fichier PROFILS-EXT-LAST sur HDFS

--LOAD HADOOP USING FILE 
--'/user/PROFILS-EXT-LAST'
--WITH SOURCE PROPERTIES ( 
--   'date.time.format' = 'dd/mm/yyyy', 
--   'field.delimiter'='|'
--)
--INTO TABLE  pocbigdata.profiles APPEND ;
	
-----------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------- Raprochement Table -------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------

-- Suppression of rapprochement table
drop table pocbigdata.rapprochement;

-- Creation de la table rapprochement 
create hadoop table pocbigdata.rapprochement
(  
  id_mission       String,
  id_cv            String,
  score_init	     Double,
  score 		       Double
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LOCATION '/biginsights/bigsql/warehouse/rapprochement';


-- Feeding of rapprochement table from HDFS File after computation
LOAD HADOOP USING FILE '/user/RAPPROCHEMENT-CVs-LAST'
WITH SOURCE PROPERTIES ( 
   'date.time.format' = 'dd/mm/yyyy', 
    'field.delimiter'='|'
)
INTO TABLE  pocbigdata.rapprochement OVERWRITE ;

-----------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------- poste table --------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------

-- Suppression de la table mission
drop table pocbigdata.poste;

-- Creation de la table mission
create hadoop table pocbigdata.poste(  
  id_offre                   String,
  ref_offre                  String,
  offre_short_description    String,
  offre_project_name         String,
  offre_start_date           String,
  offre_end_date             String,
  offre_client               String,
  customer_req_ref           String,
  grade                      String,
  internal_description       String,
  offre_state                String,
  ggid_resource_manager      String,
  name_resource_manager      String,
  ggid_creator               String,
  ggid_requester             String,
  ggid_project_manager       String,
  ggid_project_type          String,
  internal_role              String,
  internal_skill             String,
  requester_bu               String,
  offre_language             String,
  creation_date              String,
  offre_jobtitle             String,
  offre_skill_1              String,
  offre_skill_2              String,
  offre_skill_3              String,
  offre_skill_cmt            String,
  offre_adr_pour_postuler    String,
  offre_localisation_geo     String,
  offre_duree_poste          String,
  offre_postemissionflag    String,
  offre_insert_date          TIMESTAMP,
  offre_path                 String
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LOCATION '/biginsights/bigsql/warehouse/poste';


-- Alimentation de la table mission a partir du fichier MISSION-LAST sur HDFS
LOAD HADOOP USING FILE '/pocbigdataIBM/interzone/POSTE/000000_0_poste'
WITH SOURCE PROPERTIES ( 
   'date.time.format' = 'dd/mm/yyyy', 
   'field.delimiter'='|',
   'ignore.extra.fields'='true'
)
INTO TABLE  pocbigdata.poste OVERWRITE ;

-----------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------- Wordcloud table ----------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------
-- Suppression de la table mission
drop table pocbigdata.wordCloud;

create hadoop table pocbigdata.wordCloud(  
  id_profil                   String,
  word1		                  String,
  word2		                  String,
  word3		                  String,
  word4		                  String,
  word5		                  String,
  word6		                  String,
  word7		                  String,
  word8		                  String,
  word9		                  String,
  word10		              String,
  word11		              String,
  word12		              String,
  word13		              String,
  word14		              String,
  word15		              String,
  word16		              String,
  word17		              String,
  word18		              String,
  word19		              String,
  word20		              String,  
  
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LOCATION '/biginsights/bigsql/warehouse/wordCloud';

-- Feeding of wordcloud table from HDFS file
LOAD HADOOP USING FILE '/pocbigdataIBM/resultzone/RAPPROCHEMENT/WORDCLOUD/WORDCLOUD-LAST'
WITH SOURCE PROPERTIES ( 
   'date.time.format' = 'dd/mm/yyyy', 
   'field.delimiter'='|',
   'ignore.extra.fields'='true'
)
INTO TABLE  pocbigdata.wordCloud OVERWRITE ;

-----------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------- Table MISSION -----------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------

-- Deletion of mission table
 drop table pocbigdata.mission;

-- Creation of table mission
 create hadoop table pocbigdata.mission(  
   id_mission            String,
   short_description     String,
   project_name          String,
   project_start_date    String,
   project_end_date      String,
   missionclient        String,
   customer_req_ref      String,
   grade                 String,
   internal_description  String,
   missionstate         String,
   ggid_resource_manager String,
   name_resource_manager String,
   ggid_creator          String,
   ggid_requester        String,
   ggid_project_manager  String,
   ggid_project_type     String,
   internal_role         String,
   internal_skill        String,
   internal_level        String,
   missionlanguage      String,
   creation_date         String,
   missionjobtitle      String,
   missionskill_1       String,
   missionskill_2       String,
   missionskill_3       String,
   missionskill_cmt     String,
   insert_date           String,
   missionsource_path   String
 )
 ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
 LOCATION '/biginsights/bigsql/warehouse/mission';


-- Feeding of mission table from HDFS File
 LOAD HADOOP USING FILE '/pocbigdataIBM/interzone/MISSION/000000_0_mission'
 WITH SOURCE PROPERTIES ( 
  'date.time.format' = 'dd/mm/yyyy', 
  'field.delimiter'='|',
  'ignore.extra.fields'='true'
 )
 INTO TABLE  pocbigdata.mission OVERWRITE ;

---------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------ Table CV -----------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------

-- Deletion of cv table
 drop table pocbigdata.cv;

 Creation de la table cv 
 create hadoop table pocbigdata.cv
 (  
  id_cv            String,
  ggid_consultant  String,
  name_consultant  String,
  cv_content       String,
  insert_date     TIMESTAMP,
  cv_source_path   String

 )
 ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
 LOCATION '/biginsights/bigsql/warehouse/cv';


-- Feeding of table CV from HDFS file
 LOAD HADOOP USING FILE '/pocbigdataIBM/interzone/CV/000000_0_cv'
 WITH SOURCE PROPERTIES ( 
  'date.time.format' = 'dd/mm/yyyy', 
  'field.delimiter'='|'
 )
 INTO TABLE  pocbigdata.cv OVERWRITE ;
