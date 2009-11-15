

ALTER TABLE quest_template
  CHANGE COLUMN QuestLevel QuestLevel smallint(6) NOT NULL DEFAULT 0;


ALTER TABLE `creature_template` ADD `difficulty_entry_2` MEDIUMINT(8) unsigned
 NOT NULL default 0 AFTER `difficulty_entry_1`;

ALTER TABLE `creature_template` ADD `difficulty_entry_3` MEDIUMINT(8) unsigned
 NOT NULL default 0 AFTER `difficulty_entry_2`;

-- cause bgs now have different spawnmodes all creatures on those maps must go
-- to all spwanmodes.. maybe this isn't valid for all creatures - but i won't
-- destroy again all bgs :p
-- 0x1 = 2^0 - normal
-- 0x2 = 2^1 - difficulty_1
-- 0x4 = 2^2 - difficulty_2
-- 0x8 = 2^3 - difficulty_3

UPDATE creature SET spawnMask = (0x1 | 0x2 | 0x4 | 0x8) WHERE map IN (30, 489, 529, 566);
-- cause bgs now have different spawnmodes all gameobjects on those maps must go
-- to all spwanmodes.. maybe this isn't valid for all gameobjects - but i won't
-- destroy again all bgs :p

UPDATE gameobject SET spawnMask = (0x1 | 0x2 | 0x4 | 0x8) WHERE map IN (30, 489, 529, 566);

UPDATE creature SET spawnMask = 0x1 WHERE map IN (489, 529, 566);

UPDATE creature SET spawnMask = (0x1 | 0x2 | 0x4) WHERE map IN (30);

UPDATE gameobject SET spawnMask = 0x1 WHERE map IN (489, 529, 566);

UPDATE gameobject SET spawnMask = (0x1 | 0x2 | 0x4) WHERE map IN (30);

DELETE FROM `spell_elixir` WHERE `entry` IN (67016,67017,67018);


/* Flasks added in 3.2.x */

INSERT INTO `spell_elixir` (`entry`, `mask`) VALUES
(67016,0x3),
(67017,0x3),
(67018,0x3);

UPDATE `playercreateinfo_spell` SET `spell` = 26297 WHERE `spell` IN (20554,26296,50621);

UPDATE `playercreateinfo_action` 
 SET `action` = 26297
 WHERE `action` IN (20554,26296,50621) AND `type` = 0;

-- Change column QuestLevel to allowed -1 value.

ALTER TABLE `quest_template` CHANGE `QuestLevel` `QuestLeveltemp` INT(8);
ALTER TABLE `quest_template` ADD `QuestLevel` SMALLINT(3) AFTER `QuestLeveltemp`;

UPDATE `quest_template` SET `QuestLevel` = `QuestLeveltemp`;

ALTER TABLE `quest_template` DROP `QuestLeveltemp`;

INSERT IGNORE INTO `command` VALUES ('ticket assign', '3', 'Usage: .ticket assign $ticketid $gmname.\r\nAssigns the specified ticket to the specified Game Master.');
INSERT IGNORE INTO `command` VALUES ('ticket close', '2', 'Usage: .ticket close $ticketid.\r\nCloses the specified ticket. Does not delete permanently.');
INSERT IGNORE INTO `command` VALUES ('ticket closedlist', '1', 'Displays a list of closed GM tickets.');
INSERT IGNORE INTO `command` VALUES ('ticket comment', '2', 'Usage: .ticket comment $ticketid $comment.\r\nAllows the adding or modifying of a comment to the specified ticket.');
INSERT IGNORE INTO `command` VALUES ('ticket delete', '3', 'Usage: .ticket delete $ticketid.\r\nDeletes the specified ticket permanently. Ticket must be closed first.');
INSERT IGNORE INTO `command` VALUES ('ticket list', '1', 'Displays a list of open GM tickets.');
INSERT IGNORE INTO `command` VALUES ('ticket onlinelist', '1', 'Displays a list of open GM tickets whose owner is online.');
INSERT IGNORE INTO `command` VALUES ('ticket unassign', '3', 'Usage: .ticket unassign $ticketid.\r\nUnassigns the specified ticket from the current assigned Game Master.');
INSERT IGNORE INTO `command` VALUES ('ticket viewid', '1', 'Usage: .ticket viewid $ticketid.\r\nReturns details about specified ticket. Ticket must be open and not deleted.');
INSERT IGNORE INTO `command` VALUES ('ticket viewname', '1', 'Usage: .ticket viewname $creatorname. \r\nReturns details about specified ticket. Ticket must be open and not deleted.');
INSERT IGNORE INTO `command` VALUES ('ticket', '1', 'Syntax: .ticket $subcommand\nType .ticket to see the list of possible subcommands or .help ticket $subcommand to see info on subcommands');

INSERT IGNORE INTO `cw_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
(288, 'Tickets count: %i show new tickets: %s\n', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(289, 'New ticket from %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(290, 'Ticket of %s (Last updated: %s):\n%s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(291, 'New ticket show: ON', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(292, 'New ticket show: OFF', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(293, 'Ticket %i doesn''t exist', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(294, 'All tickets deleted.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(295, 'Character %s ticket deleted.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(296, 'Ticket deleted.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2000, '|cff00ff00New ticket from|r|cffff00ff %s.|r |cff00ff00Ticket entry:|r|cffff00ff %d.|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2001, '|cff00ff00Character|r|cffff00ff %s |r|cff00ff00edited his/her ticket:|r|cffff00ff %d.|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2002, '|cff00ff00Character|r|cffff00ff %s |r|cff00ff00abandoned ticket entry:|r|cffff00ff %d.|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2003, '|cff00ff00Closed by|r:|cff00ccff %s|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2004, '|cff00ff00Deleted by|r:|cff00ccff %s|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2005, 'Ticket not found.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2006, 'Please close ticket before deleting it permanently.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2007, 'Ticket %d is already assigned.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2008, '%u Tickets succesfully reloaded from the database.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2009, 'Showing list of open tickets.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2010, 'Showing list of open tickets whose creator is online.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2011, 'Showing list of closed tickets.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2012, 'Invalid name specified. Name should be that of an online Gamemaster.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2013, 'This ticket is already assigned to yourself. To unassign use .ticket unassign %d and then reassign.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2014, 'Ticket %d is not assigned, you cannot unassign it.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2015, 'You cannot unassign tickets from staffmembers with a higher security level than yourself.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2016, 'Cannot close ticket %d, it is assigned to another GM.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2017, '|cff00ff00Ticket|r:|cff00ccff %d.|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2018, '|cff00ff00Created by|r:|cff00ccff %s|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2019, '|cff00ff00Last change|r:|cff00ccff %s ago|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2020, '|cff00ff00Assigned to|r:|cff00ccff %s|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2021, '|cff00ff00Unassigned by|r:|cff00ccff %s|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2022, '\n|cff00ff00Message|r: "%s"|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2023, '\n|cff00ff00Comment|r: "%s"|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2024, '\n|cff00ccff%s|r |cff00ff00Added comment|r: "%s"|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2025, '|cff00ff00Created|r:|cff00ccff %s ago|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
