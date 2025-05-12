-- A new database schema is created.
CREATE SCHEMA IF NOT EXISTS `fh-db2-praktikum`;
USE `fh-db2-praktikum`;

-- Everything that might have been created by other scripts is dropped.
DROP TABLE IF EXISTS `data_raw_working_copy`,
`data_atomized`,
`genre`,
`network`,
`series`,
`episode`,
`actor`,
`cast_main`,
`cast_guest`;

/* 
 * A working copy of the raw data is created just to have a backup if something goes wrong.
 * Alternatively one would have to reimport the table using an import wizard which is rather
 * cumbersome.
 */
DROP TABLE IF EXISTS `data_raw_working_copy`;
CREATE TABLE `data_raw_working_copy` AS SELECT * FROM `data_raw`;