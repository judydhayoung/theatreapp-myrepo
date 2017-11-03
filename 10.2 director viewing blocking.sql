/*

10.2. DB (5)  As a director I need to be able to see blocking instructions for a specific scene
select by scenes, in acts, and play.
select blocking instructions
permission level: director

*/

-- if statement https://stackoverflow.com/questions/5951157/if-in-select-statement-choose-output-value-based-on-column-values

TheatreAppSuite.

-- This use case only reads. I'm ignoring:
	--Create, update, delete
	--read=select


CREATE TABLE IF NOT EXISTS `TheatreAppSuite`.`Permissions` (
  `UserID` INT NOT NULL,
  `PlayID` INT NOT NULL,
  `Director` BIT NULL,
  `StageManager` BIT NULL,
  `AsstStageManager` BIT NULL,
  `Light` BIT NULL,
  `Sound` BIT NULL,
  `StageCrew` BIT NULL,
  `Actor` BIT NULL,
  INDEX `UserID_idx` (`UserID` ASC),
  INDEX `PlayID_idx` (`PlayID` ASC),
  CONSTRAINT `PermissionsUserID`
  FOREIGN KEY (`UserID`)
    REFERENCES `TheatreAppSuite`.`User` (`UserID`)
    ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT `PermissionsPlayID`
    FOREIGN KEY (`PlayID`)
	REFERENCES `TheatreAppSuite`.`Play` (`PlayID`)
	ON DELETE CASCADE
	ON UPDATE CASCADE)
	ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `TheatreAppSuite`.`Blocking` (
  `CharacterID` INT NOT NULL,
  `LineID` INT NOT NULL,
  `Origin` VARCHAR(10) NULL,
  `Destination` VARCHAR(10) NULL,
  `MovementType` VARCHAR(20) NULL,
  INDEX `CharacterID_idx` (`CharacterID` ASC),
  INDEX `LineID_idx` (`LineID` ASC),
  CONSTRAINT `BlockingCharacterID`
    FOREIGN KEY (`CharacterID`)
    REFERENCES `TheatreAppSuite`.`Character` (`CharacterID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `BlockingLineID`
    FOREIGN KEY (`LineID`)
    REFERENCES `TheatreAppSuite`.`Line` (`LineID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


--check if 
Select
 `CharacterID`,
  `LineID`,
  `Origin`,
  `Destination`,
  `MovementType`,
  `CharacterID_idx` (`CharacterID` ASC),
  `LineID_idx` (`LineID` ASC),
  BlockingCharacterID,
  `BlockingLineID`
  from TheatreAppSuite.Blocking;

