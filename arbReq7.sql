SELECT titre,COUNT(personnage_id) FROM Personnage p,Anime a
WHERE a.anime_id = p.anime_id
GROUP BY titre
HAVING COUNT(personnage_id) >= 1;