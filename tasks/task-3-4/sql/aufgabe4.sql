-- 4a Wie lauten die Titel der Episoden, die am 23.11.2022 veröffentlicht wurden?
SELECT `name`
FROM `episode` 
WHERE `date` = "2022-11-23";

-- 4b Wer ist der populärste Schauspieler?
SELECT `name`
FROM `actor`
ORDER BY `popularity` DESC
LIMIT 1;

-- 4c Wie werden alle verfügbaren Serien durchschnittlich von der Community bewertet?
SELECT AVG(rating)
FROM series;

-- 4d Wie lautet der Name des Produktionsnetzwerks, das die Serie mit der besten Bewertung produzierte?
SELECT n.`name`
FROM `series` s JOIN `network` n ON s.`network_id` = n.`id`
ORDER BY `rating` DESC
LIMIT 1;

-- 4e Bestimmen Sie den Namen des Schauspielers, der die meisten Gastauftritte verzeichnet.
SELECT a.`name`
FROM `cast_guest` cg JOIN `actor` a ON cg.`actor_id` = a.`id`
GROUP BY a.`name`
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 4f Bestimmen Sie, wie viele Episoden jedem einzelnen Genre zugeordnet werden.
SELECT g.`name`
FROM 
	`episode` e 
    JOIN `series` s ON e.`series_id` = s.`id` 
    JOIN `genre` g ON s.`genre_id` = g.`id`
GROUP BY g.`name`
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 4g Wie populär sind die Darsteller der Stammbesetzung der einzelnen Serien im Durchschnitt?
-- Erstellen Sie eine Statistik, die den Titel der Serie und den Durchschnitt enthält.
SELECT s.`name`, ROUND(AVG(a.`popularity`), 3) AS 'average rating'
FROM 
	`cast_main` cm 
    JOIN `actor` a ON cm.`actor_id` = a.`id`
    JOIN `series` s ON cm.`series_id` = s.`id`
GROUP BY s.`name`;


-- 4h Welche Serie verzeichnet im Durchschnitt über alle Folgen die meisten Gastauftritte?
SELECT s.`name`
FROM 
	`cast_guest` cg
    JOIN `episode` e ON cg.`episode_id` = e.`id`
    JOIN `series` s ON e.`series_id` = s.`id`
GROUP BY s.`name`
ORDER BY COUNT(*) DESC
LIMIT 1;