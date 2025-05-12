/*
 * As stated in the readme, all data was imported as string/varchar/text.
 * Now that all data is atomized and correctly formatted it should be safe
 * to be casted to the proper data types.
 */

ALTER TABLE `data_atomized` CHANGE `title` 			`series_name`       TEXT;
ALTER TABLE `data_atomized` CHANGE `genre` 			`genre_name`        TEXT;
ALTER TABLE `data_atomized` CHANGE `genre_count` 	`genre_count`       INT;
ALTER TABLE `data_atomized` CHANGE `network`		`network_name`      TEXT;
ALTER TABLE `data_atomized` CHANGE `rating` 		`series_rating`     INT;
ALTER TABLE `data_atomized` CHANGE `episode_id` 	`episode_id`        INT;
ALTER TABLE `data_atomized` CHANGE `episode_number` `episode_number`    INT;
ALTER TABLE `data_atomized` CHANGE `episode_title` 	`episode_name`      TEXT;
ALTER TABLE `data_atomized` CHANGE `release_date` 	`episode_date`      DATE;
ALTER TABLE `data_atomized` CHANGE `actor`		 	`actor_name`        TEXT;
ALTER TABLE `data_atomized` CHANGE `popularity` 	`actor_popularity`  DOUBLE;
ALTER TABLE `data_atomized` CHANGE `character` 	    `actor_role`        TEXT;
