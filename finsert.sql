.headers on
.mode colum on
.tables

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
INSERT INTO Personnage (role,nomp,prenomp,anime_id,personne_id) 
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

