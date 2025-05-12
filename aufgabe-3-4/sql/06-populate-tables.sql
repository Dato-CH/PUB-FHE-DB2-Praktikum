/*
 * The entity-specific tables created in section 06 get populated.
 *
 * First the tables with no foreign key references, then the ones with.
 */

INSERT INTO `genre`		(`name`, `count`)
SELECT DISTINCT 	 	 `genre_name`, `genre_count`
FROM `data_atomized`;

INSERT INTO `network`		(`name`, `city`, `region`)
SELECT DISTINCT 		 `network_name`, `network_city`, `network_region`
FROM `data_atomized`;

INSERT INTO `actor`		(`name`, `popularity`)
SELECT DISTINCT 		 `actor_name`, `actor_popularity`
FROM `data_atomized`
WHERE `actor_name` IS NOT NULL;




INSERT INTO series (`name`, `rating`, `network_id`, `genre_id`)
SELECT DISTINCT d.`series_name`, d.`series_rating`, n.`id` AS `network_id`, g.`id` AS `genre_id`
FROM 
	`data_atomized` d
	JOIN `network` n ON d.`network_name` = n.`name`
	JOIN `genre` g ON d.`genre_name` = g.`name`;


INSERT INTO `episode` (`id`, `number`, `date`, `name`, `series_id`)
SELECT DISTINCT `episode_id`, `episode_number`, `episode_date`, `episode_name`, s.`id` AS `series_id`
FROM
	`data_atomized` d
    JOIN `series` s ON d.`series_name` = s.`name`
WHERE `episode_id` IS NOT NULL;

 
-- main cast is every entry with an actor but no episode listed (episode_id IS NULL)
INSERT INTO `cast_main` (`actor_id`, `series_id`, `role`)
SELECT DISTINCT  a.`id`, s.`id`, d.`actor_role`
FROM 
	`data_atomized` d
    JOIN `actor` a ON d.`actor_name` = a.`name`
    JOIN `series` s ON d.`series_name` = s.`name`
WHERE d.`episode_id` IS NULL;

-- guest cast is every entry with an actor and an episode listed (episode_id IS NOT NULL)
INSERT INTO `cast_guest`	(`actor_id`, `episode_id`, `role`)
SELECT DISTINCT  a.`id`, e.`id`, d.`actor_role`
FROM 
	`data_atomized` d
    JOIN `actor` a ON d.`actor_name` = a.`name`
    JOIN `episode` e ON d.`episode_id` = e.`id`
WHERE d.`episode_id` IS NOT NULL;

DROP TABLE IF EXISTS `data_atomized`;