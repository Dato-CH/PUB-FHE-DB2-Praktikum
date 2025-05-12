/*
 * The raw data is still not atomized. In this section all voiced characters will be 
 * atomized with the help of a new table. Additionally every voiced character role will
 * receive the '(voiced)' suffix
 *
 * 'foo / bar (voiced)' -> 'foo (voiced)' and 'bar (voiced)'
 */
DROP TABLE IF EXISTS `data_raw_temp_characters_voiced`;
CREATE TABLE `data_raw_temp_characters_voiced` AS 
SELECT * FROM `data_raw_working_copy`
WHERE `data_raw_working_copy`.`character` LIKE '%(voice)';

-- Suffix gets removed and only added back after atomizing.
UPDATE `data_raw_temp_characters_voiced` SET `character` = REGEXP_REPLACE(`character`, '\\s*\\(voice\\)','');


-- Another magic recursive function is used to atomize the characters.

DROP TABLE IF EXISTS `data_raw_temp_copy_left`, `data_raw_temp_copy_right`;
CREATE TABLE `data_raw_temp_copy_left` AS SELECT * FROM `data_raw_temp_characters_voiced`;
CREATE TABLE `data_raw_temp_copy_right` AS SELECT * FROM `data_raw_temp_characters_voiced`;

DROP TABLE IF EXISTS `data_atomized_characters_voiced`;
CREATE TABLE `data_atomized_characters_voiced` AS
WITH RECURSIVE `data_raw_temp_copy_left` AS (
    SELECT 
        `title`, 
        `genre`, `genre_count`, 
        `network`, `network_address`, 
        `rating`, 
        `episode_id`, `episode_number`, `episode_title`, `release_date`, 
        `actor`, `popularity`,
        TRIM(SUBSTRING_INDEX(`character`, '/', 1)) AS `character`,
        SUBSTRING(`character`, LENGTH(SUBSTRING_INDEX(`character`, '/', 1)) + 2) AS `remaining`
    FROM `data_raw_temp_copy_right`

    UNION ALL

    SELECT 
        `title`, 
        `genre`, `genre_count`, 
        `network`, `network_address`, 
        `rating`, 
        `episode_id`, `episode_number`, `episode_title`, `release_date`, 
        `actor`, `popularity`,
        TRIM(SUBSTRING_INDEX(`remaining`, '/', 1)) AS `character`,
        SUBSTRING(`remaining`, LENGTH(SUBSTRING_INDEX(`remaining`, '/', 1)) + 2)
    FROM `data_raw_temp_copy_left`
    WHERE `remaining` IS NOT NULL AND `remaining` != ''
)
SELECT 
    `title`, 
    `genre`, `genre_count`, 
    `network`, `network_address`, 
    `rating`, 
    `episode_id`, `episode_number`, `episode_title`, `release_date`, 
    `actor`, `popularity`,
    `character`
FROM `data_raw_temp_copy_left`;


DROP TABLE `data_raw_temp_copy_left`, `data_raw_temp_copy_right`, `data_raw_temp_characters_voiced`;


-- Suffix is added back.
UPDATE data_atomized_characters_voiced SET `character` = CONCAT(`character`, ' (voice)');