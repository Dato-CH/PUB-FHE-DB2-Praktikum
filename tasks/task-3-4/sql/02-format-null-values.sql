/*
 * All data was imported as a string/varchar/text, thus all null values got replaced with
 * an empty string ''. Here the empty string just gets replaced with null.
 */
UPDATE `data_raw_working_copy` SET `episode_number` = NULL WHERE `episode_number`   = '';
UPDATE `data_raw_working_copy` SET `episode_id`     = NULL WHERE `episode_id`       = '';
UPDATE `data_raw_working_copy` SET `episode_title`  = NULL WHERE `episode_title`    = '';
UPDATE `data_raw_working_copy` SET `release_date`   = NULL WHERE `release_date`     = '';
UPDATE `data_raw_working_copy` SET `actor`          = NULL WHERE `actor`            = '';
UPDATE `data_raw_working_copy` SET `popularity`     = NULL WHERE `popularity`       = '';
UPDATE `data_raw_working_copy` SET `character`      = NULL WHERE `character`        = '';