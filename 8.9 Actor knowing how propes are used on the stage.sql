/*
8.9 DB (1) As an Actor I want to know how the properties are going to be used on the stage.

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

INSERT INTO THEATREAPPSUITE.PROPS (PlayID, Name, FilePath)
VALUES ([playid parameter], [play name parameter], [filepath parameter]) ;

--READ script
---Read everything
SELECT * FROM THEATREAPPSUITE.PLAY
ORDER BY PlayID;

---Read filepaths that belong to a specific play
SELECT
	`PlayID`,
	`Name`,
	`FilePath`,
FROM THEATREAPPSUITE.PLAY
WHERE PlayID = [playID parameter]
ORDER BY PlayID;


--UPDATE
---Use this one primarily.
---If you know the ID of the play:
UPDATE THEATREAPPSUITE.Play
SET FilePath = [filepath parameter]
WHERE PlayID = [playID parameter];
---If you know part of the name of the play:
UPDATE THEATREAPPSUITE.Play
SET FilePath = [filepath parameter]
WHERE Name like '%[any word of play name]%';


--DELETE
--Deletes Filepath but keeps PlayID and Name.
UPDATE TEHATREAPPSUITE.PLAY
SET FilePath = null
WHERE PlayId = [playid parameter];
