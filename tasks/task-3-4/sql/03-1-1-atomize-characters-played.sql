/*
 * The raw data is not atomized. In this section first all played (not voiced) characters 
 * will be atomized with the help of a new table.
 */
DROP TABLE IF EXISTS `data_raw_temp_characters_played`;
CREATE TABLE `data_raw_temp_characters_played` AS 
SELECT * FROM `data_raw_working_copy`
WHERE `data_raw_working_copy`.`character` NOT LIKE '%(voice)';


-- A magic recursive function is used to atomize the characters.

DROP TABLE IF EXISTS `data_raw_temp_copy_left`, `data_raw_temp_copy_right`;
CREATE TABLE `data_raw_temp_copy_left` AS SELECT * FROM `data_raw_temp_characters_played`;
CREATE TABLE `data_raw_temp_copy_right` AS SELECT * FROM `data_raw_temp_characters_played`;

DROP TABLE IF EXISTS `data_atomized_characters_played`;
CREATE TABLE `data_atomized_characters_played` AS
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
        TRIM(SUBSTRING_INDEX(remaining, '/', 1)) AS `character`,
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

DROP TABLE `data_raw_temp_copy_left`, `data_raw_temp_copy_right`, `data_raw_temp_characters_played`;

