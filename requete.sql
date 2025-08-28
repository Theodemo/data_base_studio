.headers on
.mode colum on
.tables



DROP TABLE IF EXISTS R1;
DROP TABLE IF EXISTS R2;
DROP TABLE IF EXISTS R3;
DROP TABLE IF EXISTS R4;
DROP TABLE IF EXISTS R5;


SELECT * FROM Anime;
SELECT * FROM Saison;
SELECT * FROM Personne;
SELECT * FROM Personnage;
SELECT * FROM Personnel;
SELECT * FROM Studio;
SELECT * FROM Participants;


.print '1 nom et capital pour les studios dont le capital est compris entre 0.00 € et 10000€'
SELECT nom , capital FROM Studio
WHERE capital BETWEEN 0.00 AND 10000.00 ;


.print '2 nom et prenom de tous les personnages de l’animé "Tokyo Revengers'
SELECT nomp,prenomp FROM Personnage
WHERE anime_id = (SELECT anime_id FROM Anime WHERE titre = 'Tokyo Revengers');



.print '3 le nom et prenom des personnes qui ont participé à la saison 1 de "Tokyo Revengers" et qui ne sont pas des doubleurs'
SELECT nom FROM Personne
WHERE personne_id = (SELECT personne_id FROM Participants
		     WHERE personne_id NOT IN (SELECT personne_id FROM Personnel  WHERE role ="doubleur")
                     AND saison_id = (SELECT saison_id FROM Saison WHERE titre ='Tokyo Revengers S1'));





.print "4 le nom des personnes ayant doubler tout les personnage dans la saison 1 de Tokyo Revengers"


CREATE VIEW R1 AS
SELECT nom FROM Personne;


CREATE VIEW R2 AS 
SELECT nom,personne_id FROM R1 ,Personnage 
WHERE personne_id = (SELECT personne_id FROM Participants 
                        WHERE saison_id = (SELECT saison_id FROM Saison
                                        WHERE titre ='Tokyo Revengers S1'));

CREATE VIEW R3 AS

SELECT nom,personne_id FROM R2
EXCEPT
SELECT nom,personne_id FROM Personne;

CREATE VIEW R4 AS
SELECT nom FROM R3;


CREATE VIEW R5 AS
SELECT * FROM R1
EXCEPT
SELECT * FROM R4;

SELECT * FROM R5;



--5 le nombre de participants à la saison 1 de "Tokyo Revengers"


SELECT COUNT(personne_id) FROM Participants
WHERE saison_id = (SELECT saison_id FROM Saison WHERE titre ='Tokyo Revengers S1');

--6 Le nombre de personnage par anime


SELECT titre,COUNT(personnage_id) FROM Personnage p,Anime a
WHERE a.anime_id = p.anime_id
GROUP BY titre;

--7 Le nombre de personnage par anime ayant au moins 3 personnages

SELECT titre,COUNT(personnage_id) FROM Personnage p,Anime a
WHERE a.anime_id = p.anime_id
GROUP BY titre
HAVING COUNT(personnage_id) >= 1;