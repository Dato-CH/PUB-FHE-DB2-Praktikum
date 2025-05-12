/*
 * Played and voiced character tables get combined into new table.
 * New table is now the working copy. Old working copy is obsolete.
 */

DROP TABLE IF EXISTS `data_atomized_characters`;

CREATE TABLE `data_atomized_characters`
AS SELECT * FROM `data_raw_working_copy`
WHERE `character` IS NULL;

INSERT INTO `data_atomized_characters` SELECT * FROM `data_atomized_characters_voiced`;
INSERT INTO `data_atomized_characters` SELECT * FROM `data_atomized_characters_played`;

DROP TABLE IF EXISTS `data_atomized_characters_played`, `data_atomized_characters_voiced`;

DROP TABLE IF EXISTS `data_raw_working_copy`;