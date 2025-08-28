.headers on
.mode colum on
.tables



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
	nom varchar(20),
	prenom varchar(20),
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



-- insertion d’un animé
INSERT INTO Anime (titre,nombre_saisons,genre,score_moyen ) 
VALUES ('Tokyo Revengers',1,'Action',8.0);

-- insertion d'une saison
-- insertion d’un animé
INSERT INTO Anime (titre,nombre_saisons,genre,score_moyen ) 
VALUES ('Tokyo Revengers',1,'Action',8.0);

-- insertion d'une saison
INSERT INTO Saison (titre,score,nombre_visionnages,date_diffusion,nombre_episodes,anime_id) 
VALUES ('Tokyo Revengers S1',8.41,200000,5/03/2012,12,(SELECT anime_id FROM Anime WHERE titre='Tokyo Revengers'));


-- insertion d’une personne
INSERT INTO Personne (nom, prenom,date_naissance) 
VALUES ('Yuuki','Shin',5/02/1995);
INSERT INTO Personne (nom, prenom,date_naissance)  
VALUES ('Weber Segarra','Yann',13/12/2002); 

-- insertion d’un personnage
INSERT INTO Personnage (role,nom,prenom,anime_id,personne_id) 
VALUES ('Personnage principal','Takemichi','Hanagaki',(SELECT anime_id FROM Anime WHERE titre='Tokyo Revengers'),
	(SELECT personne_id FROM Personne WHERE nom = 'Yuuki' AND prenom= 'Shin'));


-- insertion d’un personnel
INSERT INTO Personnel(personne_id,role) 
VALUES ((SELECT personne_id FROM Personne WHERE nom='Yuuki' AND prenom='Shin'),'doubleur');

INSERT INTO Personnel(personne_id,role) 
VALUES ((SELECT personne_id FROM Personne WHERE nom='Weber Segarra' AND prenom='Yann'),'dessinateur');  

-- insertion d’un studio
INSERT INTO Studio (nom, capital) 
VALUES ('LIDENFILMS',10000);

-- insertion d’un participant
INSERT INTO Participants(saison_id,personne_id)
VALUES((SELECT saison_id FROM Saison WHERE titre= 'Tokyo Revengers S1'),
	   (SELECT personne_id FROM Personne 	   		
	   	WHERE nom = 'Weber Segarra'
	   	AND prenom = 'Yann')
	   );

INSERT INTO Participants(saison_id,personne_id)
VALUES((SELECT saison_id FROM Saison WHERE titre= 'Tokyo Revengers S1'),
	   (SELECT personne_id FROM Personne WHERE nom='Yuuki' AND prenom='Shin')
	   
	   );



SELECT * FROM Anime;
SELECT * FROM Saison;
SELECT * FROM Personne;
SELECT * FROM Personnel;
SELECT * FROM Studio;
SELECT * FROM Participants;




.print '2 nom et prenom de tous les personnages de l’animé "Tokyo Revengers'
SELECT nom,prenom FROM Personnage
WHERE anime_id = (SELECT anime_id FROM Anime WHERE titre = 'Tokyo Revengers');



.print '3 le nom et prenom des personnes qui ont participé à la saison 1 de "Tokyo Revengers" et qui ne sont pas des doubleurs'
SELECT nom FROM Personne
WHERE personne_id = (SELECT personne_id FROM Participants
					 WHERE personne_id NOT IN (SELECT personne_id FROM Personnel  WHERE role ="doubleur")
                     AND saison_id = (SELECT saison_id FROM Saison
										WHERE titre ='Tokyo Revengers S1'));