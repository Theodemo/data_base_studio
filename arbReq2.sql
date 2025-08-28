SELECT nomp,prenomp FROM Personnage
WHERE anime_id = (SELECT anime_id FROM Anime WHERE titre = 'Tokyo Revengers');