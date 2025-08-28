SELECT nom FROM Personne
WHERE personne_id = (SELECT personne_id FROM Participants
		     WHERE personne_id NOT IN (SELECT personne_id FROM Personnel  WHERE role ="doubleur")
                     AND saison_id = (SELECT saison_id FROM Saison WHERE titre ='Tokyo Revengers S1'));
