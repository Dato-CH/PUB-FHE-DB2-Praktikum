/*
 * Now all individual entity tables get created.
 * 
 * Normally the 'cast_main' and 'cast_guest' tables would have a key consisting
 * of three columns, but this is ugly to work and query with, so instead those
 * tables get artificial keys.
 *
 * For consistency every other table also gets an artificial id key.
 */

CREATE TABLE genre (
	`id` 		INT PRIMARY KEY AUTO_INCREMENT,
    `name` 		VARCHAR(255),
    `count` 	INT
); 
CREATE TABLE network (
	`id`	 	INT PRIMARY KEY AUTO_INCREMENT,
    `name`		VARCHAR(255),
    `city`		VARCHAR(255),
    `region` 	VARCHAR(255)
);
CREATE TABLE series (
	`id` 			INT PRIMARY KEY AUTO_INCREMENT,
    `name` 			VARCHAR(255),
    `rating` 		INT,
    `network_id` 	INT REFERENCES `network`(`id`),
    `genre_id` 		INT REFERENCES `genre`(`id`)
); 
CREATE TABLE episode (
    `id` 			INT PRIMARY KEY AUTO_INCREMENT,
    `number` 		INT,
    `date`	 		DATE,
    `name`	 		VARCHAR(255),
    `series_id`		INT REFERENCES `series`(`id`)
); 
CREATE TABLE actor (
    `id` 			INT PRIMARY KEY AUTO_INCREMENT,
    `name` 			VARCHAR(255),
    `popularity` 	DOUBLE
);
CREATE TABLE cast_main (
    `id` 			INT PRIMARY KEY AUTO_INCREMENT,
    `actor_id` 		INT REFERENCES `actor`(`id`),
    `series_id`		INT REFERENCES `series`(`id`),
    `role` 			VARCHAR(255)
);
CREATE TABLE cast_guest (
    `id` 			INT PRIMARY KEY AUTO_INCREMENT,
    `actor_id` 		INT REFERENCES `actor`(`id`),
    `episode_id`	INT REFERENCES `episode`(`id`),
    `role`	 		VARCHAR(255)
);