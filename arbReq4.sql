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