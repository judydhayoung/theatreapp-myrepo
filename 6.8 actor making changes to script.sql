/*
6.8DB (10) As an actor, I want to be able press a button and save any changes that I make to the script(I.e stage or voice recordings) so that they will be there next time I open the app.

Write scripts to CRUD filepath in the database.
anything inside [] should be replaced with variables


Table 'Play' DDL:
		CREATE TABLE IF NOT EXISTS `TheatreAppSuite`.`Play` (
		  `PlayID` INT NOT NULL AUTO_INCREMENT,
		  `Name` VARCHAR(100) NULL,
		  `FilePath` VARCHAR(100) NULL,
		  PRIMARY KEY (`PlayID`))
		ENGINE = InnoDB;

written by: Judy Kwon
*/


--CREATE script
/*Standard insert into Table
But PlayID and Name will likely be populated when creating PlayID, so you won't really use this.
To insert into FilePath column only, refer to the update script below.*/

--INSERT INTO 

--changes to what app?

