SELECT COUNT(personne_id) FROM Participants
WHERE saison_id = (SELECT saison_id FROM Saison WHERE titre ='Tokyo Revengers S1');
