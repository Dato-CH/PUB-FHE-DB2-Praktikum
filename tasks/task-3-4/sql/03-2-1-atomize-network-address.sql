/*
 * While unimportant, the network address can also be easily atomized,
 * because it has a consistent format consisting of a region and a city.
 * So why not atomize it too.
 *
 * Actor names however, while also not atomized, do not follow a consistent
 * format, so atomizing those would be rather difficult. But because we do 
 * not need to divide the actor names in any of the given tasks, it should 
 * not matter whether we atomize them or not.
 */

ALTER TABLE `data_atomized_characters`
ADD COLUMN `network_city` TEXT,
ADD COLUMN `network_region` TEXT;

UPDATE `data_atomized_characters`
SET 
	`network_city` = SUBSTRING_INDEX(`network_address`, ',', 1),
    `network_region` = TRIM(SUBSTRING_INDEX(`network_address`, ',', -1));
    
ALTER TABLE `data_atomized_characters`
DROP COLUMN `network_address`;

ALTER TABLE `data_atomized_characters`
RENAME `data_atomized`;