
PRAGMA foreign_keys = OFF;

DROP TABLE IF EXISTS Anime ;
DROP TABLE IF EXISTS Saison;
DROP TABLE IF EXISTS Personnage;
DROP TABLE IF EXISTS Personnel;
DROP TABLE IF EXISTS Personne;
DROP TABLE IF EXISTS Studio;
DROP TABLE IF EXISTS Participants;
DROP TABLE IF EXISTS Production;
PRAGMA foreign_keys = 1 ;

P

CREATE TABLE Anime
(
	anime_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
	titre varchar(20),
	nombre_saisons INTEGER,
	genre varchar(20),
	score_moyen float DEFAULT 0
);

CREATE TABLE Saison
(

	saison_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 	
	titre varchar(20),
	score float DEFAULT 0,
	nombre_visionnages INTEGER,
	date_diffusion date,
	nombre_episodes INTEGER,
	anime_id INTEGER NOT NULL,
	FOREIGN KEY (anime_id) REFERENCES Anime

 );

CREATE TABLE Personnage
(

	personnage_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 	
	role varchar(20),
	nomp varchar(20),
	prenomp varchar(20),
	anime_id INTEGER NOT NULL,
	personne_id INTEGER NOT NULL,
	FOREIGN KEY ( anime_id ) REFERENCES Anime,
 	FOREIGN KEY ( personne_id ) REFERENCES Personne




 );

CREATE TABLE Personnel
(

	personne_id INTEGER NOT NULL, 	
	role varchar(20),
	FOREIGN KEY ( personne_id ) REFERENCES Personne



 );

CREATE TABLE Personne
(

	personne_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 	
	nom varchar(20),
	prenom varchar(20),
	date_naissance date

 );

CREATE TABLE Studio
(

	studio_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 	
	nom varchar(20),
	capital float DEFAULT 0

 );

CREATE TABLE Participants
(

	saison_id INTEGER NOT NULL,
	personne_id INTEGER NOT NULL ,
	PRIMARY KEY (saison_id,personne_id),
 	FOREIGN KEY ( saison_id ) REFERENCES Saison,
	FOREIGN KEY ( personne_id ) REFERENCES Personne

 );

CREATE TABLE Production
(

	studio_id INTEGER NOT NULL ,
	saison_id INTEGER NOT NULL,
	PRIMARY KEY (studio_id,saison_id),
 	FOREIGN KEY ( studio_id ) REFERENCES Studio,
	FOREIGN KEY ( saison_id ) REFERENCES Saison

 );










