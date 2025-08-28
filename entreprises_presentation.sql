.headers on
.mode column


DROP TABLE IF EXISTS entreprises;
DROP TABLE IF EXISTS departements;
DROP TABLE IF EXISTS personnes;
DROP TABLE IF EXISTS contacts;
DROP TABLE IF EXISTS employes;
DROP TABLE IF EXISTS postes;

CREATE TABLE entreprises (
                          id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
                          nom varchar(20),
                          capital float DEFAULT 0
                        );
CREATE TABLE departements (
                           id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
                           nom varchar(20),
                           entreprise_id INTEGER,
                           responsable_id INTEGER,
                           FOREIGN KEY (entreprise_id) REFERENCES entreprises
                           FOREIGN KEY (responsable_id) REFERENCES employes
                          );
CREATE TABLE personnes (
                        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
                        nom varchar(20),
                        prenom varchar(20)
                       );
CREATE TABLE contacts (
                        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
                        mail varchar(30),
                        personne_id INTEGER,
                        FOREIGN KEY (personne_id) REFERENCES personnes
                       );
CREATE TABLE employes (
                       personne_id INTEGER NOT NULL PRIMARY KEY,
                       salaire SMALLINT,
                       entreprise_id INTEGER,
                       poste_id INTEGER,
                       chef_id  INTEGER,
                       FOREIGN KEY (personne_id) REFERENCES personnes,
                       FOREIGN KEY (entreprise_id) REFERENCES entreprises,
                       FOREIGN KEY (poste_id) REFERENCES postes,
                       FOREIGN KEY (chef_id) REFERENCES personnes
                      );
CREATE TABLE postes (
                     id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
                     nom varchar(20),
                     departement_id  INTEGER,
                     FOREIGN KEY (departement_id) REFERENCES departements
                   );

INSERT INTO entreprises(nom) VALUES ('BIEN');

INSERT INTO departements(nom,entreprise_id,responsable_id)
VALUES ('Informatique',(SELECT id FROM entreprises WHERE nom='BIEN'),NULL);
INSERT INTO departements(nom,entreprise_id,responsable_id)
VALUES ('Electronique',(SELECT id FROM entreprises WHERE nom='BIEN'),NULL);

INSERT INTO personnes(nom,prenom) VALUES ('Dupont','Jean');
INSERT INTO personnes(nom,prenom) VALUES ('Durand','Albert');
INSERT INTO personnes(nom,prenom) VALUES ('Dupond','Alfred');

INSERT INTO contacts(mail,personne_id)
VALUES ('jean.dupont@BIEN.fr',(SELECT id FROM personnes WHERE nom='Dupont' AND prenom='Jean'));
INSERT INTO contacts(mail,personne_id)
VALUES ('jean.dupont@gmail.com',(SELECT id FROM personnes WHERE nom='Dupont' AND prenom='Jean'));
INSERT INTO contacts(mail,personne_id)
VALUES ('albert.durand@BIEN.fr',(SELECT id FROM personnes WHERE nom='Durand' AND prenom='Albert'));

INSERT INTO employes(personne_id,salaire,entreprise_id,poste_id,chef_id)
VALUES (
        (SELECT id FROM personnes WHERE nom='Dupont' AND prenom='Jean'),
        30000,
        (SELECT id FROM entreprises WHERE nom='BIEN'),
        NULL,
        NULL
);
INSERT INTO employes(personne_id,salaire,entreprise_id,poste_id,chef_id)
VALUES (
        (SELECT id FROM personnes WHERE nom='Durand' AND prenom='Albert'),
        60000,
        (SELECT id FROM entreprises WHERE nom='BIEN'),
        NULL,
        NULL
);

INSERT INTO postes(nom,departement_id) VALUES ('MdC',(SELECT id FROM departements WHERE nom='Informatique'));
UPDATE employes SET poste_id=(SELECT id FROM postes WHERE nom='MdC') WHERE  personne_id=1;
INSERT INTO postes(nom,departement_id) VALUES ('PRAG',(SELECT id FROM departements WHERE nom='Electronique'));
INSERT INTO postes(nom,departement_id) VALUES ('PU',(SELECT id FROM departements WHERE nom='Electronique'));

.print "1)  Nom des personnes qui ne sont pas des employes dans l entreprise BIEN ---"

.print "L entreprise BIEN : "
SELECT * FROM entreprises WHERE nom='BIEN';
.print "Les personnes : "
SELECT * FROM personnes;
.print "Les employes dans l entreprise 'BIEN' : ";
SELECT * FROM employes emp INNER JOIN entreprises e ON (emp.entreprise_id=e.id) WHERE e.nom='BIEN';
.print "Requete : Nom des personnes qui ne sont pas des employes dans l entreprise BIEN ---"
SELECT nom
FROM personnes
WHERE id NOT IN (
                 SELECT emp.personne_id
                 FROM entreprises e INNER JOIN employes emp 
                                ON (e.id = emp.entreprise_id )
                WHERE e.nom='BIEN'
);
.print "Requete : Fin de la requete ---"

DROP VIEW super_responsable;
CREATE VIEW super_responsable AS
SELECT p.nom
FROM personnes p , employes e1
WHERE p.id = e1.personne_id
     AND NOT EXISTS (
                     SELECT *
                      FROM departements d , entreprises e
                      WHERE d.entreprise_id=e.id 
                       AND e.nom ='BIEN'
                       AND NOT EXISTS (
                                       SELECT *
                                       FROM employes e2
                                       WHERE e2.personne_id=d.responsable_id
                                        AND e1.personne_id=e2.personne_id
                      )
);

.print "-2) Nom des employes responsables de tous les départements dans l entreprise BIEN ---"

.print "Requete : Nom des employes responsables de tous les départements dans l entreprise BIEN-------"
SELECT * FROM super_responsable;
.print "Requete : Fin de la requete ------"
.print "les departements de l  entreprise 'BIEN' :"
SELECT * FROM departements d INNER JOIN entreprises e ON (d.entreprise_id=e.id) WHERE e.nom='BIEN';

UPDATE departements SET responsable_id=(SELECT id FROM personnes WHERE nom="Dupont" AND prenom="Jean") WHERE nom="Electronique";
.print "les departements de l  entreprise 'BIEN' :"
SELECT * FROM departements d INNER JOIN entreprises e ON (d.entreprise_id=e.id) WHERE e.nom='BIEN';
.print "Requete : Nom des employes responsables de tous les départements dans l entreprise BIEN-------"
SELECT * FROM super_responsable;
.print "Requete : Fin de la requete ------"

UPDATE departements SET responsable_id=(SELECT id FROM personnes WHERE nom="Dupont" AND prenom="Jean") WHERE nom="Informatique";
.print "les departements de l  entreprise 'BIEN' :"
SELECT * FROM departements d INNER JOIN entreprises e ON (d.entreprise_id=e.id) WHERE e.nom='BIEN';
.print "Requete : Nom des employes responsables de tous les départements dans l entreprise BIEN-------"
SELECT * FROM super_responsable;
.print "Requete : Fin de la requete ------"
SELECT e.personne_id, p.nom FROM personnes p INNER JOIN employes e ON(p.id=e.personne_id);

