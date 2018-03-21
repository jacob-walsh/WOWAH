USE [WOWAH]
GO
--Gather all info on all players in 2006
SELECT * INTO wow06
	FROM 
	(SELECT * FROM [wow06-1] UNION ALL
	SELECT * FROM [wow06-2] UNION ALL
	SELECT * FROM [wow06-3] UNION ALL
	SELECT * FROM [wow06-4]) n

--When read in, the character variables race, class, and zone all head a leading space - this removes it.
UPDATE [wow06-1] SET  race=replace(race, ' ', ''), class=replace(class, ' ', ''), zone=replace(zone, ' ', '');
UPDATE [wow06-2] SET  race=replace(race, ' ', ''), class=replace(class, ' ', ''), zone=replace(zone, ' ', '');
UPDATE [wow06-3] SET  race=replace(race, ' ', ''), class=replace(class, ' ', ''), zone=replace(zone, ' ', '');
UPDATE [wow06-4] SET  race=replace(race, ' ', ''), class=replace(class, ' ', ''), zone=replace(zone, ' ', '');

--Erroneous character classes/races removed
DELETE FROM [wow06] WHERE race NOT IN ('Orc', 'Tauren', 'Troll', 'Undead') OR class NOT IN ('Druid', 'Hunter', 'Mage', 'Priest', 'Rogue', 'Shaman', 'Warlock', 'Warrior')

 -- Create table with distinct ID, race, class attribute
SELECT DISTINCT(ID), race, class
	INTO Chars
	FROM (SELECT DISTINCT(ID) as ID,
				 race,
				 class
			FROM [wow06]) n


 -- Detecting any player ID that appears with different classes (was reclassed)
SELECT * 
	INTO doubles
		FROM (
		  SELECT DISTINCT(ID), rn=row_number() OVER(PARTITION BY ID ORDER BY ID)
		  FROM [Chars] 
		) x
		WHERE rn > 1

SELECT *
	FROM doubles d JOIN UniqueChars u ON d.ID=u.ID
	ORDER BY d.ID



 -- Create a new table with Unique Character ID's not including players that were reclassed

SELECT * INTO UniqueChars 
	FROM Chars
		WHERE ID NOT IN (SELECT DISTINCT(ID) FROM doubles)



 -- Gather information on players, ID, Race, Class, Number of Observations in Q1, Q2, Q3, Q4, minimum level, maximum level, and total number of observations (n).

SELECT 
	w.ID, 
	w.race, 
	w.class, 
	ISNULL(w1.n, 0) n1, 
	ISNULL(w2.n, 0) n2, 
	ISNULL(w3.n, 0) n3, 
	ISNULL(w4.n, 0) n4, 
	--find the min level of a player
	(SELECT MIN(level)
        FROM (VALUES (minlevel1),(minlevel2), (minlevel3),(minlevel4)) AS minlevel(level)) minlevel,
	--find the max level of a player
	(SELECT MAX(level)
        FROM (VALUES (maxlevel1),(maxlevel2), (maxlevel3),(maxlevel4)) AS maxlevel(level)) maxlevel,
	--find the number of levels gained by a player
	(SELECT MAX(level)
        FROM (VALUES (maxlevel1),(maxlevel2), (maxlevel3),(maxlevel4)) AS maxlevel(level)) - 
	(SELECT MIN(level)
        FROM (VALUES (minlevel1),(minlevel2), (minlevel3),(minlevel4)) AS minlevel(level)) levelup,
	--find the total number of times a player was observed online for a 10 minute period
	(ISNULL(w1.n, 0)+ ISNULL(w2.n, 0)+ ISNULL(w3.n, 0)+ISNULL(w4.n, 0)) n
INTO wownobs
FROM
	(SELECT ID, race, class FROM [Uniquechars]) w LEFT JOIN
	(SELECT DISTINCT(ID) as ID, COUNT(ID) as n, min(level) as minlevel1, max(level) as maxlevel1 FROM [wow06-1] GROUP BY ID) w1 on w.ID=w1.ID LEFT JOIN 
	(SELECT DISTINCT(ID) as ID, COUNT(ID) as n, min(level) as minlevel2, max(level) as maxlevel2 FROM [wow06-2] GROUP BY ID) w2 ON w.ID=w2.ID LEFT JOIN
	(SELECT DISTINCT(ID) as ID, COUNT(ID) as n, min(level) as minlevel3, max(level) as maxlevel3 FROM [wow06-3] GROUP BY ID) w3 ON w.ID=w3.ID LEFT JOIN
	(SELECT DISTINCT(ID) as ID, COUNT(ID) as n, min(level) as minlevel4, max(level) as maxlevel4 FROM [wow06-4] GROUP BY ID) w4 ON w.ID=w4.ID
GROUP BY w.ID, w.race, w.class, w1.n, w2.n, w3.n, w4.n, 
	minlevel1, maxlevel1, 
	minlevel2, maxlevel2, 
	minlevel3, maxlevel3,
	minlevel4, maxlevel4

ORDER BY ID

--Select all players that are level 60 and averaged between 5 and 15 hours per week on the year. 
--Each observation is 10  mins, therefore: 5 hrs / wk = 300 mins / wk = 15600 mins / yr = 1560 observations / yr
	-- Please note that observations were done every 10 minutes, this doesn't necessarily mean that a player was online for the entire 10 minutes.  This estimation potentially slightly overestimates the actual log time.

SELECT t.time,w.ID, t.level, w.race, w.class,  t.zone
	FROM [wownobs] w JOIN [wow06] t ON w.ID=t.ID AND t.level=60 AND w.n BETWEEN 1560 AND 4680
	ORDER BY w.ID
	
	