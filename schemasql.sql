﻿-- -----------------------------------------------------
-- Schema theatreappsuite
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `theatreappsuite` DEFAULT CHARACTER SET utf8 ;
USE `theatreappsuite` ;

-- -----------------------------------------------------
-- Table `theatreappsuite`.`character`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `theatreappsuite`.`character` (
  `CharacterID` INT(11) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`CharacterID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `theatreappsuite`.`play`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `theatreappsuite`.`play` (
  `PlayID` INT(11) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `FilePath` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`PlayID`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `theatreappsuite`.`line`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `theatreappsuite`.`line` (
  `LineID` INT(11) NOT NULL AUTO_INCREMENT,
  `PlayID` INT(11) NOT NULL,
  `ActNum` INT(11) NOT NULL,
  `SceneNum` INT(11) NOT NULL,
  `LineNum` INT(11) NOT NULL,
  `Text` VARCHAR(500) NOT NULL,
  `DirectorNote` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`LineID`),
  INDEX `PlayID_idx` (`PlayID` ASC),
  CONSTRAINT `LinePlayID`
    FOREIGN KEY (`PlayID`)
    REFERENCES `theatreappsuite`.`play` (`PlayID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `theatreappsuite`.`blocking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `theatreappsuite`.`blocking` (
  `CharacterID` INT(11) NOT NULL,
  `LineID` INT(11) NOT NULL,
  `Origin` VARCHAR(10) NULL DEFAULT NULL,
  `Destination` VARCHAR(10) NULL DEFAULT NULL,
  `MovementType` VARCHAR(20) NULL DEFAULT NULL,
  INDEX `CharacterID_idx` (`CharacterID` ASC),
  INDEX `LineID_idx` (`LineID` ASC),
  CONSTRAINT `BlockingCharacterID`
    FOREIGN KEY (`CharacterID`)
    REFERENCES `theatreappsuite`.`character` (`CharacterID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `BlockingLineID`
    FOREIGN KEY (`LineID`)
    REFERENCES `theatreappsuite`.`line` (`LineID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `theatreappsuite`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `theatreappsuite`.`user` (
  `UserID` INT(11) NOT NULL AUTO_INCREMENT,
  `UserName` VARCHAR(10) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `FirstName` VARCHAR(45) NULL DEFAULT NULL,
  `LastName` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`UserID`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `theatreappsuite`.`characteruser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `theatreappsuite`.`characteruser` (
  `UserID` INT(11) NOT NULL,
  `CharacterID` INT(11) NOT NULL,
  INDEX `UserID_idx` (`UserID` ASC),
  INDEX `CharacterID_idx` (`CharacterID` ASC),
  CONSTRAINT `CUCharacterID`
    FOREIGN KEY (`CharacterID`)
    REFERENCES `theatreappsuite`.`character` (`CharacterID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `CUUserID`
    FOREIGN KEY (`UserID`)
    REFERENCES `theatreappsuite`.`user` (`UserID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `theatreappsuite`.`costume`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `theatreappsuite`.`costume` (
  `CostumeID` INT(11) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`CostumeID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `theatreappsuite`.`costumecue`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `theatreappsuite`.`costumecue` (
  `CostumeID` INT(11) NOT NULL,
  `LineID` INT(11) NOT NULL,
  `CharacterID` INT(11) NULL DEFAULT NULL,
  `Note` VARCHAR(200) NULL DEFAULT NULL,
  INDEX `CostumeID_idx` (`CostumeID` ASC),
  INDEX `LineID_idx` (`LineID` ASC),
  INDEX `CharacterID_idx` (`CharacterID` ASC),
  CONSTRAINT `CostumeCueCharacterID`
    FOREIGN KEY (`CharacterID`)
    REFERENCES `theatreappsuite`.`character` (`CharacterID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `CostumeCueCostumeID`
    FOREIGN KEY (`CostumeID`)
    REFERENCES `theatreappsuite`.`costume` (`CostumeID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `CostumeCueLineID`
    FOREIGN KEY (`LineID`)
    REFERENCES `theatreappsuite`.`line` (`LineID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `theatreappsuite`.`light`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `theatreappsuite`.`light` (
  `LightID` INT(11) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Type` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`LightID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `theatreappsuite`.`lightingcue`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `theatreappsuite`.`lightingcue` (
  `LightID` INT(11) NOT NULL,
  `LineID` INT(11) NOT NULL,
  `UserID` INT(11) NULL DEFAULT NULL,
  `Location` VARCHAR(10) NOT NULL,
  `Status` VARCHAR(3) NULL DEFAULT NULL,
  INDEX `LightID_idx` (`LightID` ASC),
  INDEX `LineID_idx` (`LineID` ASC),
  INDEX `UserID_idx` (`UserID` ASC),
  CONSTRAINT `LightingCueLightID`
    FOREIGN KEY (`LightID`)
    REFERENCES `theatreappsuite`.`light` (`LightID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `LightingCueLineID`
    FOREIGN KEY (`LineID`)
    REFERENCES `theatreappsuite`.`line` (`LineID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `LightingCueUserID`
    FOREIGN KEY (`UserID`)
    REFERENCES `theatreappsuite`.`user` (`UserID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `theatreappsuite`.`permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `theatreappsuite`.`permissions` (
  `UserID` INT(11) NOT NULL,
  `PlayID` INT(11) NOT NULL,
  `Director` BIT(1) NOT NULL DEFAULT b'0',
  `StageManager` BIT(1) NOT NULL DEFAULT b'0',
  `AsstStageManager` BIT(1) NOT NULL DEFAULT b'0',
  `Light` BIT(1) NOT NULL DEFAULT b'0',
  `Sound` BIT(1) NOT NULL DEFAULT b'0',
  `StageCrew` BIT(1) NOT NULL DEFAULT b'0',
  `Actor` BIT(1) NOT NULL DEFAULT b'0',
  INDEX `UserID_idx` (`UserID` ASC),
  INDEX `PlayID_idx` (`PlayID` ASC),
  CONSTRAINT `PermissionsPlayID`
    FOREIGN KEY (`PlayID`)
    REFERENCES `theatreappsuite`.`play` (`PlayID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PermissionsUserID`
    FOREIGN KEY (`UserID`)
    REFERENCES `theatreappsuite`.`user` (`UserID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `theatreappsuite`.`prop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `theatreappsuite`.`prop` (
  `PropID` INT(11) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`PropID`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `theatreappsuite`.`propmovement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `theatreappsuite`.`propmovement` (
  `PropID` INT(11) NOT NULL,
  `LineID` INT(11) NOT NULL,
  `UserID` INT(11) NULL DEFAULT NULL,
  `DestinationLocation` VARCHAR(45) NOT NULL,
  INDEX `PropID_idx` (`PropID` ASC),
  INDEX `LineID_idx` (`LineID` ASC),
  INDEX `UserID_idx` (`UserID` ASC),
  CONSTRAINT `PropMovememntUserID`
    FOREIGN KEY (`UserID`)
    REFERENCES `theatreappsuite`.`user` (`UserID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `PropMovementLineID`
    FOREIGN KEY (`LineID`)
    REFERENCES `theatreappsuite`.`line` (`LineID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PropMovementPropID`
    FOREIGN KEY (`PropID`)
    REFERENCES `theatreappsuite`.`prop` (`PropID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `theatreappsuite`.`sound`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `theatreappsuite`.`sound` (
  `SoundID` INT(11) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`SoundID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `theatreappsuite`.`soundcue`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `theatreappsuite`.`soundcue` (
  `SoundID` INT(11) NOT NULL,
  `LineID` INT(11) NOT NULL,
  `UserID` INT(11) NULL DEFAULT NULL,
  `Note` VARCHAR(200) NULL DEFAULT NULL,
  INDEX `SoundID_idx` (`SoundID` ASC),
  INDEX `LineID_idx` (`LineID` ASC),
  INDEX `UserID_idx` (`UserID` ASC),
  CONSTRAINT `SoundCueLineID`
    FOREIGN KEY (`LineID`)
    REFERENCES `theatreappsuite`.`line` (`LineID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `SoundCueSoundID`
    FOREIGN KEY (`SoundID`)
    REFERENCES `theatreappsuite`.`sound` (`SoundID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `SoundCueUserID`
    FOREIGN KEY (`UserID`)
    REFERENCES `theatreappsuite`.`user` (`UserID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;