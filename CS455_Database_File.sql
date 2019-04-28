-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema emr455
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema emr455
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `emr455` DEFAULT CHARACTER SET utf8 ;
USE `emr455` ;

-- -----------------------------------------------------
-- Table `emr455`.`Doctor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `emr455`.`Doctor` ;

CREATE TABLE IF NOT EXISTS `emr455`.`Doctor` (
  `Ssn` INT(9) NOT NULL,
  `Start_Date` DATE NULL,
  `Address` VARCHAR(60) NULL,
  `Phone_Number` CHAR(11) NULL,
  `Name` VARCHAR(30) NOT NULL,
  `ID` CHAR(13) NOT NULL,
  `Dept_ID` CHAR(6) NOT NULL,
  UNIQUE INDEX `Ssn_UNIQUE` (`Ssn` ASC) VISIBLE,
  PRIMARY KEY (`ID`),
  INDEX `Dept_ID_idx` (`Dept_ID` ASC) VISIBLE,
  CONSTRAINT `Doc_Dept_ID`
    FOREIGN KEY (`Dept_ID`)
    REFERENCES `emr455`.`Department` (`Dept_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `emr455`.`Institution`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `emr455`.`Institution` ;

CREATE TABLE IF NOT EXISTS `emr455`.`Institution` (
  `Institution_Name` VARCHAR(45) NOT NULL,
  `Phone_Number` CHAR(11) NULL,
  `Adress` VARCHAR(60) NULL,
  `Inst_ID` CHAR(4) NOT NULL,
  PRIMARY KEY (`Inst_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `emr455`.`Department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `emr455`.`Department` ;

CREATE TABLE IF NOT EXISTS `emr455`.`Department` (
  `D_Number` INT NOT NULL,
  `D_Name` VARCHAR(30) NOT NULL,
  `Phone_Number` CHAR(11) NULL,
  `Head_ID` CHAR(13) NOT NULL,
  `Inst_ID` CHAR(4) NOT NULL,
  `Dept_ID` CHAR(13) NOT NULL,
  PRIMARY KEY (`Dept_ID`),
  INDEX `Head_ID_idx` (`Head_ID` ASC) VISIBLE,
  INDEX `Dept_Instd_ID_idx` (`Inst_ID` ASC) VISIBLE,
  CONSTRAINT `Head_ID`
    FOREIGN KEY (`Head_ID`)
    REFERENCES `emr455`.`Doctor` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Dept_Instd_ID`
    FOREIGN KEY (`Inst_ID`)
    REFERENCES `emr455`.`Institution` (`Inst_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `emr455`.`Patient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `emr455`.`Patient` ;

CREATE TABLE IF NOT EXISTS `emr455`.`Patient` (
  `Name` VARCHAR(30) NOT NULL,
  `Gender` VARCHAR(10) NULL,
  `Phone_Number` CHAR(11) NULL,
  `Birth_Date` DATE NOT NULL,
  `Address` VARCHAR(60) NULL,
  `Insurance_ID` CHAR(10) NULL,
  `Ssn` INT(9) NOT NULL,
  `Age` INT NULL,
  `ID` CHAR(13) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `emr455`.`Medical_Record`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `emr455`.`Medical_Record` ;

CREATE TABLE IF NOT EXISTS `emr455`.`Medical_Record` (
  `Height` DECIMAL(3,1) NULL,
  `Weight` DECIMAL(4,1) NULL,
  `Family_Med_History` VARCHAR(64) NULL,
  `Allergies` VARCHAR(64) NULL,
  `Pre_Exist_Cond` VARCHAR(64) NULL,
  `Treatment_History` VARCHAR(128) NULL,
  `Pat_ID` CHAR(13) NOT NULL,
  INDEX `Pat_ID_idx` (`Pat_ID` ASC) VISIBLE,
  CONSTRAINT `MR_Pat_ID`
    FOREIGN KEY (`Pat_ID`)
    REFERENCES `emr455`.`Patient` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `emr455`.`Secretary`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `emr455`.`Secretary` ;

CREATE TABLE IF NOT EXISTS `emr455`.`Secretary` (
  `ID` CHAR(13) NOT NULL,
  `Phone_Number` CHAR(11) NULL,
  `Address` VARCHAR(60) NULL,
  `Start_Date` DATE NULL,
  `Name` VARCHAR(30) NOT NULL,
  `Dept_ID` CHAR(6) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `Dept_ID_idx` (`Dept_ID` ASC) VISIBLE,
  CONSTRAINT `Sec_Dept_ID`
    FOREIGN KEY (`Dept_ID`)
    REFERENCES `emr455`.`Department` (`Dept_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `emr455`.`Appointment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `emr455`.`Appointment` ;

CREATE TABLE IF NOT EXISTS `emr455`.`Appointment` (
  `Date` DATE NOT NULL,
  `Time` TIME NOT NULL,
  `Doc_ID` CHAR(13) NULL,
  `Pat_ID` CHAR(13) NOT NULL,
  `Inst_ID` CHAR(4) NOT NULL,
  INDEX `Pat_ID_idx` (`Pat_ID` ASC) VISIBLE,
  INDEX `Appt_Inst_ID_idx` (`Inst_ID` ASC) VISIBLE,
  CONSTRAINT `Appt_Pat_ID`
    FOREIGN KEY (`Pat_ID`)
    REFERENCES `emr455`.`Patient` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Appt_Inst_ID`
    FOREIGN KEY (`Inst_ID`)
    REFERENCES `emr455`.`Institution` (`Inst_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `emr455`.`Prescription`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `emr455`.`Prescription` ;

CREATE TABLE IF NOT EXISTS `emr455`.`Prescription` (
  `Start_Date` DATE NOT NULL,
  `End_Date` DATE NOT NULL,
  `Medication` VARCHAR(30) NOT NULL,
  `Dosage` INT NOT NULL,
  `Doc_ID` CHAR(13) NOT NULL,
  `Prescript_ID` CHAR(15) NOT NULL,
  `Pat_ID` CHAR(13) NOT NULL,
  `Interval` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Prescript_ID`),
  INDEX `Doctor_ID_idx` (`Doc_ID` ASC) VISIBLE,
  INDEX `Pat_ID_idx` (`Pat_ID` ASC) VISIBLE,
  CONSTRAINT `Pres_Doc_ID`
    FOREIGN KEY (`Doc_ID`)
    REFERENCES `emr455`.`Doctor` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Pres_Pat_ID`
    FOREIGN KEY (`Pat_ID`)
    REFERENCES `emr455`.`Patient` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `emr455`.`Pharmacy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `emr455`.`Pharmacy` ;

CREATE TABLE IF NOT EXISTS `emr455`.`Pharmacy` (
  `Name` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(60) NOT NULL,
  `Phone_Number` CHAR(11) NULL,
  PRIMARY KEY (`Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `emr455`.`Payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `emr455`.`Payment` ;

CREATE TABLE IF NOT EXISTS `emr455`.`Payment` (
  `Amount` DECIMAL(6,2) NOT NULL,
  `Reason` VARCHAR(45) NULL,
  `Date` DATE NULL,
  `Status` CHAR(1) NOT NULL,
  `Insurance_ID` CHAR(10) NULL,
  `Pat_ID` CHAR(13) NOT NULL,
  `Paid` DECIMAL(6,2) NOT NULL,
  INDEX `Pat_ID_idx` (`Pat_ID` ASC) VISIBLE,
  CONSTRAINT `Pay_Pat_ID`
    FOREIGN KEY (`Pat_ID`)
    REFERENCES `emr455`.`Patient` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `emr455`.`Supply_Medicine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `emr455`.`Supply_Medicine` ;

CREATE TABLE IF NOT EXISTS `emr455`.`Supply_Medicine` (
  `Pharmacy_Name` VARCHAR(30) NOT NULL,
  `Prescript_ID` CHAR(15) NOT NULL,
  INDEX `Pharm_Name_idx` (`Pharmacy_Name` ASC) VISIBLE,
  INDEX `Prescript_ID_idx` (`Prescript_ID` ASC) VISIBLE,
  CONSTRAINT `Pharm_Name`
    FOREIGN KEY (`Pharmacy_Name`)
    REFERENCES `emr455`.`Pharmacy` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `SM_Pres_ID`
    FOREIGN KEY (`Prescript_ID`)
    REFERENCES `emr455`.`Prescription` (`Prescript_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `emr455`.`Nurse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `emr455`.`Nurse` ;

CREATE TABLE IF NOT EXISTS `emr455`.`Nurse` (
  `Phone_Number` CHAR(11) NULL,
  `ID` CHAR(13) NOT NULL,
  `Name` VARCHAR(30) NOT NULL,
  `Start_Date` DATE NULL,
  `Address` VARCHAR(60) NULL,
  `Dept_ID` CHAR(6) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `Dept_ID_idx` (`Dept_ID` ASC) VISIBLE,
  CONSTRAINT `Nurse_Dept_ID`
    FOREIGN KEY (`Dept_ID`)
    REFERENCES `emr455`.`Department` (`Dept_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `emr455`.`Doctor`
-- -----------------------------------------------------
START TRANSACTION;
USE `emr455`;
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (720290767, '1985-06-19', '624 29th St NW, Rochester, MN', '19045430481', 'Molly Leonard', 'XGB2AGQ3CHAGP', 'XHJMKR');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (953346601, '2017-08-15', '1975 White Bridge Rd. NW, Oronoco, MN', '19046208457', 'Felicia Pope', 'GV40I3MZQJBXW', 'XHJMKR');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (392222689, '2016-12-09', 'Cone Marketplace Pne Sartell, MN', '19109892200', 'Pedro Glover', 'IBUHEPSIK9IQ6', 'XHJMKR');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (601672481, '1999-03-31', '205 2nd Ave. NW, Bertha, MN', '19378360010', 'Alton Bowman', '7J9KE4S0DONJQ', 'BSR6NC');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (705873716, '2012-03-02', '17741 Fairlawn Ave, Prior Lake, MN', '19522031057', 'Kent Bryant', '4ROY4BYQ2UFYS', 'BSR6NC');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (999635610, '1986-06-20', '2732 Brunswick Ave. S, Minneapolis, MN', '19522174975', 'Shyann Pacheco', '0FHJ711RRKCU6', 'BSR6NC');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (509798346, '2016-12-06', '8646 Carriage Hill Ct, Savage, MN', '19522175556', 'Ari Leonard', 'NYLGXD2IUO58B', '6FXWF5');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (866509099, '1995-01-05', '14225 Fountain Hills Ct. NE, Prior Lake, MN', '19522175565', 'Dallas Moody', '4XIQR8K6I66EU', '6FXWF5');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (647023154, '1986-02-25', '14996 Mustang Path, Savage, MN', '13148303823', 'Alissa Wilkins', 'B4FOLXFTYRAEN', '6FXWF5');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (434595737, '1981-08-08', '401 7th St. S #106, Waite Park, MN', '13202020892', 'Enrique Hanson', 'FEDJV53SIL1PL', '6FXWF5');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (134037522, '2003-08-11', '248 3rd St. S. #313B, Waite Park, MN', '13202021841', 'Nigel Tucker', '3WDUZBXQAO3CO', 'QZS60A');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (281168689, '2016-04-17', '2523 Ocarina Dr, Sauk Rapids, MN', '13202022976', 'Teagan Hernandez', 'DNPIONQPQS1H4', 'QZS60A');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (404155908, '2017-11-20', '1817 64th Ave. N, Saint Cloud, MN', '13202027709', 'Miley Salinas', 'EL62S8JEIXSHP', 'QZS60A');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (621140259, '2003-04-12', '128 9th Ave. N, Waite Park, MN', '13202029705', 'Jasmine Ware', 'QUQBRW489ZRYI', 'HCAE2O');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (601316927, '1981-03-05', '909 Celebration Cir, Sartell, MN', '13202031266', 'Aditya Oconnor', 'XZ1OO5KYWZIGZ', 'HCAE2O');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (324724889, '1992-10-07', '430 Park Meadows Dr. #104, Waite Park, MN', '13202031477', 'Adalyn Herring', '0KUOAAC5G4CDO', 'FUGY3Z');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (313897191, '2016-04-22', 'Po Box 578, Alexandria, MN', '12603501051', 'Sergio Flowers', 'GT8B0FK3UULWV', 'FUGY3Z');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (537498755, '1990-07-28', '150 Oral Lake Road, Minneapolis, MN', '17632280542', 'Serenity Farrell', '3L06LSBW94OEV', 'F8MAUE');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (313980093, '2014-01-31', '4323 Post Avenue, Wadena, MN', '12189812724', 'Holden Sosa', 'USH8DVCXPGZ1X', 'F8MAUE');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (393058502, '2002-09-05', '1611 Orchard Street, Webster, MN', '19526526798', 'America Chase', 'ULHGKP3U3R1AN', 'F8MAUE');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (869485909, '1992-07-17', '2161 Ferrell Street, Gary, MN', '12183569954', 'Malaki Tapia', 'D8WGQZN3AFG66', 'X5ONCN');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (973918783, '2011-09-12', '4911 Bryan Avenue, Minneapolis, MN', '16512863482', 'Erica Wolfe', 'BANRCIJWNU1TE', 'X5ONCN');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (447313106, '1998-06-14', '3346 Red Hawk Road, Cerro Gordo, MN', '13207524713', 'Keyla Barron', 'VV85338CD33W2', 'U8TPHS');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (499518795, '2009-09-29', '1566 Pritchard Court, Owatonna, MN', '15074462106', 'Lewis Mullins', 'BTAG8N6EN7Z0G', 'U8TPHS');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (528799699, '2002-05-01', '281 Murphy Court, Minneapolis, MN', '19522327803', 'Lennon Macias', 'I22O9063LJ9K5', 'Q1KD1M');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (455012071, '2002-09-06', '2327 Hillcrest Circle, Brooklyn Center, MN', '17635850217', 'Liberty Townsend', 'XQ74V3RF7CVL3', 'Q1KD1M');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (329656917, '1999-09-02', '1251 Laurel Lee, Burnsville, MN', '16518908618', 'Gabriel Barajas', '3U7HHBFZ5M814', '8OJYOV');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (142981558, '1995-01-28', '3780 Oral Lake Road, Wayzata, MN', '16122513687', 'Lina Wade', '4ZSQEC2JSGXT1', '8OJYOV');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (326681804, '1986-02-22', '1243 Rosewood Court, Owatonna, MN', '15073143882', 'Kaleigh Webb', '8X3NTUV1U0HW4', 'AYDH7A');
INSERT INTO `emr455`.`Doctor` (`Ssn`, `Start_Date`, `Address`, `Phone_Number`, `Name`, `ID`, `Dept_ID`) VALUES (273601590, '1996-07-11', '180 Raintree Boulevard, Coon Rapid, MN', '17637579629', 'Diya Mills', '8HDOBPHN537RM', 'AYDH7A');

COMMIT;


-- -----------------------------------------------------
-- Data for table `emr455`.`Institution`
-- -----------------------------------------------------
START TRANSACTION;
USE `emr455`;
INSERT INTO `emr455`.`Institution` (`Institution_Name`, `Phone_Number`, `Adress`, `Inst_ID`) VALUES ('Sanford Bemidji Medical Center', '8008338979', '1300 Anne St. NW, Bemidji, MN', '3241');
INSERT INTO `emr455`.`Institution` (`Institution_Name`, `Phone_Number`, `Adress`, `Inst_ID`) VALUES ('Fairview Ridges Hospital', '9528922000', '201 E Nicollet Blvd, Burnsville, MN', '9478');
INSERT INTO `emr455`.`Institution` (`Institution_Name`, `Phone_Number`, `Adress`, `Inst_ID`) VALUES ('Sanford Thief River Falls Medical Center', '2186814240', '3001 Sanford Parkway, Thief River Falls, MN', '8643');

COMMIT;


-- -----------------------------------------------------
-- Data for table `emr455`.`Department`
-- -----------------------------------------------------
START TRANSACTION;
USE `emr455`;
INSERT INTO `emr455`.`Department` (`D_Number`, `D_Name`, `Phone_Number`, `Head_ID`, `Inst_ID`, `Dept_ID`) VALUES (1, 'Intensive Care', '8008335635', 'XGB2AGQ3CHAGP', '3241', 'XHJMKR');
INSERT INTO `emr455`.`Department` (`D_Number`, `D_Name`, `Phone_Number`, `Head_ID`, `Inst_ID`, `Dept_ID`) VALUES (2, 'Burn Center', '8008339852', '7J9KE4S0DONJQ', '3241', 'BSR6NC');
INSERT INTO `emr455`.`Department` (`D_Number`, `D_Name`, `Phone_Number`, `Head_ID`, `Inst_ID`, `Dept_ID`) VALUES (3, 'Psychiatric', '8008335311', 'NYLGXD2IUO58B', '3241', '6FXWF5');
INSERT INTO `emr455`.`Department` (`D_Number`, `D_Name`, `Phone_Number`, `Head_ID`, `Inst_ID`, `Dept_ID`) VALUES (5, 'Coronary Care', '9528922220', '3WDUZBXQAO3CO', '9478', 'QZS60A');
INSERT INTO `emr455`.`Department` (`D_Number`, `D_Name`, `Phone_Number`, `Head_ID`, `Inst_ID`, `Dept_ID`) VALUES (6, 'Emergency', '9528925662', 'QUQBRW489ZRYI', '9478', 'HCAE2O');
INSERT INTO `emr455`.`Department` (`D_Number`, `D_Name`, `Phone_Number`, `Head_ID`, `Inst_ID`, `Dept_ID`) VALUES (7, 'Intensive Care', '9528929753', '0KUOAAC5G4CDO', '9478', 'FUGY3Z');
INSERT INTO `emr455`.`Department` (`D_Number`, `D_Name`, `Phone_Number`, `Head_ID`, `Inst_ID`, `Dept_ID`) VALUES (8, 'Physical Therapy', '9528926677', '3L06LSBW94OEV', '9478', 'F8MAUE');
INSERT INTO `emr455`.`Department` (`D_Number`, `D_Name`, `Phone_Number`, `Head_ID`, `Inst_ID`, `Dept_ID`) VALUES (10, 'Emergency', '2186814991', 'D8WGQZN3AFG66', '8643', 'X5ONCN');
INSERT INTO `emr455`.`Department` (`D_Number`, `D_Name`, `Phone_Number`, `Head_ID`, `Inst_ID`, `Dept_ID`) VALUES (11, 'Acute Medical', '2186817777', 'VV85338CD33W2', '8643', 'U8TPHS');
INSERT INTO `emr455`.`Department` (`D_Number`, `D_Name`, `Phone_Number`, `Head_ID`, `Inst_ID`, `Dept_ID`) VALUES (12, 'Pediatric Intensive Care', '2186815463', 'I22O9063LJ9K5', '8643', 'Q1KD1M');
INSERT INTO `emr455`.`Department` (`D_Number`, `D_Name`, `Phone_Number`, `Head_ID`, `Inst_ID`, `Dept_ID`) VALUES (13, 'Burn Center', '2186816411', '3U7HHBFZ5M814', '8643', '8OJYOV');
INSERT INTO `emr455`.`Department` (`D_Number`, `D_Name`, `Phone_Number`, `Head_ID`, `Inst_ID`, `Dept_ID`) VALUES (14, 'Endoscopy', '2186810039', '8X3NTUV1U0HW4', '8643', 'AYDH7A');

COMMIT;


-- -----------------------------------------------------
-- Data for table `emr455`.`Patient`
-- -----------------------------------------------------
START TRANSACTION;
USE `emr455`;
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Ryker Grimes', 'Male', '14049954574', '1935-01-08', '9031 Greenview Drive Duluth, MN', 'XRIJN8IEVZ', 941379263, NULL, 'M0B43BYQI2VV8');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Melvin Hoover', 'Male', '13758545241', '1939-02-04', '7853 Bay Lane Luverne, MN', 'KW0IXSHSTQ', 374275587, NULL, 'MXVIUM4DWCUA3');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Griffin Mueller', 'Male', '12947270696', '1941-04-30', '37 Champion Ave. Moorhead, MN', 'TBOSWTHBEG', 460236545, NULL, 'LLSP91IDBF49T');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Frederick Hampton', 'Male', '10657947396', '1944-10-10', '75 Edgefield Lane Rochester, MN', '3551IBYBYL', 111594704, NULL, '1Y2WBG5S5LUP4');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Allisson Valentine', 'Female', '19662945231', '1946-08-27', '299 West Front St. Ormsby, MN', 'WPPO60VJO2', 630313342, NULL, 'HH5C3A6KKYCKL');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Ace Cardenas', 'Male', '12135901735', '1953-04-03', '8807 Royalty St. Homer, MN', 'KU2A5W4RPS', 462545236, NULL, 'B2A74AG6HJ7D7');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Dean Burnett', 'Male', '12880561409', '1956-02-15', '318 West Theater Lane Battle Lake, MN', 'GXSCYTXJWY', 243096799, NULL, '9TXZPRZTX3N3W');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Lucy Marks', 'Female', '13014516851', '1959-10-19', '7 West St Paul Ave. Stewartville, MN', 'E1KTG9U7AX', 104525442, NULL, 'LSVQTCUN1RYTY');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Tessa Sharp', 'Female', '13543397097', '1965-12-07', '7006 Marble Drive Minneapolis, MN', 'T2GK7KRTII', 845707805, NULL, 'RG946TN8QW5BO');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Jayla Duke', 'Female', '18990622565', '1973-01-18', '97 Lees Creek St. Glyndon, MN', 'MDDMJ7NYV0', 715250328, NULL, 'YEWRDIQ6XK2QZ');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Ronin Baxter', 'Female', '14319610007', '1975-09-11', '25 North Cedar Ave. Hollandale, MN', 'WAJ7DJ0AU3', 904556940, NULL, 'NHDQU81T7LSJ4');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Rory Mccarthy', 'Female', '19057069994', '1977-10-08', '6 West Rose Rd. Alexandria, MN', '2LYDI7U395', 286376138, NULL, 'W04JOIOKRJ5P9');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Rachel Hamilton', 'Female', '11082767776', '1978-01-27', '7435 Second Drive Echo, MN', 'PNGRK1QPKP', 948976029, NULL, 'LOLUW1UQONF27');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Aryan Rodriguez', 'Male', '11984379309', '1982-03-24', '7392 East 4th Lane Wendell, MN', '157SBVSQ8J', 313085391, NULL, 'LOWMM1Z062HS5');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Nigel Lang', 'Male', '6166432843', '1985-11-06', '527 Overlook Rd. Minneapolis, MN', '9FCGLAAO6L', 184015139, NULL, 'LYVA9750EEYWG');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Kenyon Le', 'Male', '11113247712', '1992-06-06', '66 Autumn Ave. Goodhue, MN', 'O4IGBRIJT4', 996655955, NULL, '5E1ZBJW2D8710');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Mohammad Barton', 'Male', '12055839255', '2002-01-26', '556 South Cactus St. Saint Paul, MN', 'RXPCYBIOLH', 857245412, NULL, 'NBVRJ6EF09PFI');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Wayne Caldwell', 'Male', '18415700670', '2004-08-15', '729 Rockcrest Rd. Duluth, MN', 'ZBO28OZBQU', 387532632, NULL, 'QNZTOMO029NC2');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Remington Conner', 'Male', '12241253211', '2006-11-25', '81 Aurora Lane Eden Valley, MN', 'JZHDV2BVKB', 223409191, NULL, 'H9S1UTP6HN3DZ');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Eli Prince', 'Male', '13122470944', '2008-01-13', '7885 Princeton Court Upsala, MN', 'DYFXT140S3', 880995612, NULL, 'DR674E5T8D0FT');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Lilly Stephenson', 'Female', '12918548330', '2008-10-11', '7217 Heather St. Greenwald, MN', 'MVF3Z9RB96', 208354650, NULL, 'W7B5E2SKOKJWN');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Natalie Kline', 'Female', '13695522163', '2011-06-21', '716 Manor Ave. Kenyon, MN', '7B5NQ4PQV8', 887722848, NULL, 'RNJT74R2UBT59');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Julianne Andersen', 'Female', '12361185850', '2012-04-26', '857 West Walt Whitman Street Young America, MN', 'CI0RBD3ZXM', 506184686, NULL, 'MYAJZJY2545QZ');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Trevin Farrell', 'Male', '10101811603', '2012-09-14', '9947 Arch Court Minneapolis, MN', 'VGEZEYL36M', 970975263, NULL, '883NCCUQS0M1X');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Shaun Hayes', 'Male', '19456540623', '2013-12-14', '8073 Heritage Street Clements, MN', '7C21FWEUAK', 474370653, NULL, 'FTSUVOPAXQQUF');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Madden Kaufman', 'Female', '17436353683', '1933-07-14', '9196 Arrowhead St. Garvin, MN', '31EZ09ZOTL', 158553773, NULL, 'VOBODSI1LLBIZ');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Aurora Horton', 'Female', '13636345296', '1935-02-05', '23 Starfall St. Woodstock, MN', 'QP0PKHGB31', 367172481, NULL, 'GW8Y250D6DPOG');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Kirsten Mcpherson', 'Female', '17854437490', '1942-05-13', '845 Glen Creek St. Plainview, MN', 'P1D6HM2B50', 226474885, NULL, '0TCLHZJDUN47O');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Trinity Moore', 'Female', '17413807667', '1953-07-12', '547 Military Street Mora, MN', '5EEQ4ARIZQ', 731581451, NULL, 'I2DX25FEIQK3B');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Declan Wiley', 'Male', '14895560209', '1954-07-26', '9226 Olive Road Lake Elmo, MN', 'POQBVQBYZL', 537056733, NULL, 'GMUKNFJT1YLVM');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Nathen Sanford', 'Male', '11579274089', '1954-12-30', '712 Justice St. Minneapolis, MN', 'YVBKTTX0NA', 408483781, NULL, 'MILYDP0F5SZ5D');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Adonis Donaldson', 'Male', '16464614051', '1955-05-04', '975 South Wilson Road Waterville, MN', 'HTGU7HRURT', 475733068, NULL, 'VHYIAU0FVLGRD');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Maia Moss', 'Female', '11338960421', '1956-12-29', '756 Canal Lane Ceylon, MN', 'RGO3V6VZX0', 830642527, NULL, '5WUSFBZ0FPKZF');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Kaylen Wells', 'Female', '13660852837', '1958-12-21', '30 Frost Ave. Brook Park, MN', '5OOEU24JG8', 835634176, NULL, '49IZDU3SXNM2Q');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Joe Lambert', 'Male', '16099861370', '1959-04-10', '65 Columbia Road Homer, MN', 'M1J1603S3E', 663790174, NULL, 'E6S4GZSJPBQ0S');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Douglas Knapp', 'Male', '17655960196', '1961-05-02', '714 NE. Judge Dr. Burnsville, MN', '8J7W92OLOD', 994719809, NULL, 'BFI33ZFOLOQ5B');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Memphis Mcclure', 'Male', '11967985841', '1961-07-31', '9165 Serenity St. Albertville, MN', '5IF1TAUNJM', 728831340, NULL, 'SLF1QP07OHZF7');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Maci Shaffer', 'Female', '10407396294', '1962-06-21', '496 Philmont Road Hill City, MN', '3PYX5WNIHC', 131869730, NULL, 'IR1MVVV8RSU5Z');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Nolan Hebert', 'Male', '10866419332', '1963-02-02', '381 Garden Lane Minneapolis, MN', '6PJAUGDQBS', 610662628, NULL, 'PDVPRTKTT2GSC');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Jadon Mcguire', 'Male', '16404377552', '1963-08-27', '40 Broom Dr. Newport, MN', '9ZMDT7V7CN', 452474073, NULL, 'CZQB5OGDKFBBB');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Cadence Bartlett', 'Female', '18027422256', '1965-04-14', '17 Cross St. Canyon, MN', 'TFCKUKMH0C', 785479514, NULL, 'Z76PKBJ156WLK');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Nolan Crawford', 'Male', '18905784081', '1980-08-12', '834 Railway Court Saint Paul, MN', 'G2FJFB1KXB', 501730602, NULL, 'X4LLZBR1G8KRP');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Kadence Walker', 'Female', '13538770467', '1981-04-06', '139 Shadow Brook St. Belview, MN', 'OB1ONH21IY', 751835293, NULL, 'B00DP1V1XEMOL');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Asa Lynn', 'Female', '13251860451', '1981-06-22', '7701 East Arnold Street Trimont, MN', '6XEYM4FQZ9', 903836150, NULL, 'ZXZRTJ4Z8FYE1');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Maritza Savage', 'Female', '13651587350', '1988-11-12', '466 Smith Store Ave. Minneapolis, MN', '7KIZEGJWYY', 132243340, NULL, 'XSW90MJ46B01T');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Alanna Lawrence', 'Female', '19455757601', '1995-03-30', '39 Henry Smith Avenue Duluth, MN', 'IO6QS04K75', 139675646, NULL, '5D82O0URTE38Q');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Marie Hebert', 'Female', '16348766206', '1997-12-01', '9866 West Dew Dr. Lindstrom, MN', 'RT7IU3AZPT', 254317125, NULL, 'BQPCBFUU8UFQC');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Carly Abbott', 'Female', '10542962318', '2002-10-08', '7280 West Windsor Ave. Squaw Lake, MN', '0CRP4MCIJ1', 206159037, NULL, 'CW7HIG31YIZHO');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Rudy Fletcher', 'Female', '19993008723', '2010-11-16', '8623 El Dorado Lane Kerkhoven, MN', 'OF725B7G44', 854256881, NULL, '1Z3K7VC3WN29J');
INSERT INTO `emr455`.`Patient` (`Name`, `Gender`, `Phone_Number`, `Birth_Date`, `Address`, `Insurance_ID`, `Ssn`, `Age`, `ID`) VALUES ('Aydin Patton', 'Male', '13140167384', '2018-12-22', '8619 S. Bradford St. Saint Joseph, MN', 'BV8U3MFCFR', 871897209, NULL, 'ZT4B5GA873FDD');

COMMIT;


-- -----------------------------------------------------
-- Data for table `emr455`.`Medical_Record`
-- -----------------------------------------------------
START TRANSACTION;
USE `emr455`;
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (57.4, 167.8, 'diabetes, stroke', 'urticaria', 'sleep apnea', NULL, 'M0B43BYQI2VV8');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (74.7, 185.2, 'heart disease', 'dermatitis', NULL, NULL, 'MXVIUM4DWCUA3');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (69, 293.7, 'heart disease', 'rhinitis', 'COPD', NULL, 'LLSP91IDBF49T');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (69.4, 189.1, 'high blood pressure', 'eczema', NULL, NULL, '1Y2WBG5S5LUP4');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (83.8, 120.2, NULL, 'asthma', 'diabetes', NULL, 'HH5C3A6KKYCKL');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (75.9, 248.7, NULL, NULL, NULL, NULL, 'B2A74AG6HJ7D7');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (69.8, 199.6, 'diabetes', 'urticaria', 'COPD', NULL, '9TXZPRZTX3N3W');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (78.8, 270.4, NULL, 'dermatitis', 'sleep apnea', NULL, 'LSVQTCUN1RYTY');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (68.8, 284.5, 'high blood pressure, stroke', 'food allergy', NULL, NULL, 'RG946TN8QW5BO');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (73.4, 240.5, NULL, NULL, 'diabetes', NULL, 'YEWRDIQ6XK2QZ');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (63.7, 180.9, NULL, NULL, NULL, NULL, 'NHDQU81T7LSJ4');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (70.3, 182.3, 'stroke', NULL, 'diabetes', NULL, 'W04JOIOKRJ5P9');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (65.3, 255.9, 'high blood pressure', NULL, NULL, NULL, 'LOLUW1UQONF27');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (57.2, 143.3, 'high blood pressure', 'food allergy', NULL, NULL, 'LOWMM1Z062HS5');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (82.3, 275.7, 'heart disease', NULL, NULL, NULL, 'LYVA9750EEYWG');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (55.6, 135, 'diabetes', NULL, NULL, NULL, '5E1ZBJW2D8710');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (57.6, 118.1, NULL, 'urticaria', 'COPD', NULL, 'NBVRJ6EF09PFI');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (80.5, 184, NULL, NULL, NULL, NULL, 'QNZTOMO029NC2');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (78.4, 252.4, NULL, 'asthma', NULL, NULL, 'H9S1UTP6HN3DZ');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (71.5, 280.8, 'heart disease', NULL, 'diabetes', NULL, 'DR674E5T8D0FT');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (59.6, 280.5, 'diabetes, stroke', 'dermatitis', NULL, NULL, 'W7B5E2SKOKJWN');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (79.6, 292, 'diabetes', 'dermatitis', NULL, NULL, 'RNJT74R2UBT59');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (75.7, 240.3, 'diabetes', 'eczema', 'COPD', NULL, 'MYAJZJY2545QZ');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (75.3, 290.9, 'stroke', 'rhinitis', NULL, NULL, '883NCCUQS0M1X');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (73.5, 170.7, 'stroke', 'rhinitis', NULL, NULL, 'FTSUVOPAXQQUF');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (82.9, 114.2, 'high blood pressure', NULL, NULL, NULL, 'VOBODSI1LLBIZ');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (71.4, 148.2, NULL, 'food allergy', NULL, NULL, 'GW8Y250D6DPOG');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (82.4, 149.1, 'stroke', NULL, 'sleep apnea', NULL, '0TCLHZJDUN47O');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (71.1, 101.9, NULL, NULL, NULL, NULL, 'I2DX25FEIQK3B');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (81, 298, 'heart disease, stroke', 'asthma', NULL, NULL, 'GMUKNFJT1YLVM');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (63.1, 117.6, NULL, 'urticaria', NULL, NULL, 'MILYDP0F5SZ5D');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (68.9, 125.2, NULL, 'dermatitis', NULL, NULL, 'VHYIAU0FVLGRD');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (82.7, 274.8, NULL, 'rhinitis', 'diabetes', NULL, '5WUSFBZ0FPKZF');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (62.7, 195.9, 'diabetes', NULL, 'diabetes', NULL, '49IZDU3SXNM2Q');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (55.1, 263.2, NULL, 'rhinitis', NULL, NULL, 'E6S4GZSJPBQ0S');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (78.9, 166.8, 'high blood pressure', NULL, 'COPD', NULL, 'BFI33ZFOLOQ5B');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (69.9, 163.3, NULL, NULL, NULL, NULL, 'SLF1QP07OHZF7');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (79.9, 125, NULL, 'eczema', 'sleep apnea', NULL, 'IR1MVVV8RSU5Z');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (63.9, 158.6, 'stroke', 'food allergy', NULL, NULL, 'PDVPRTKTT2GSC');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (56.5, 247.6, 'heart disease', NULL, NULL, NULL, 'CZQB5OGDKFBBB');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (75.5, 268.3, 'high blood pressure', NULL, 'COPD', NULL, 'Z76PKBJ156WLK');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (57.6, 152.6, 'high blood pressure, stroke', NULL, NULL, NULL, 'X4LLZBR1G8KRP');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (63.1, 153, NULL, 'dermatitis', NULL, NULL, 'B00DP1V1XEMOL');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (64.8, 182.4, 'diabetes', 'asthma', 'COPD', NULL, 'ZXZRTJ4Z8FYE1');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (71.8, 286.2, NULL, 'rhinitis', NULL, NULL, 'XSW90MJ46B01T');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (73, 154.2, 'heart disease', NULL, 'diabetes', NULL, '5D82O0URTE38Q');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (72.3, 220.1, NULL, 'food allergy', NULL, NULL, 'BQPCBFUU8UFQC');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (69.1, 266.7, 'stroke', 'eczema', 'sleep apnea', NULL, 'CW7HIG31YIZHO');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (71.3, 282.8, 'heart disease, stroke', 'asthma', NULL, NULL, '1Z3K7VC3WN29J');
INSERT INTO `emr455`.`Medical_Record` (`Height`, `Weight`, `Family_Med_History`, `Allergies`, `Pre_Exist_Cond`, `Treatment_History`, `Pat_ID`) VALUES (66.8, 189.3, 'diabetes', NULL, NULL, NULL, 'ZT4B5GA873FDD');

COMMIT;


-- -----------------------------------------------------
-- Data for table `emr455`.`Secretary`
-- -----------------------------------------------------
START TRANSACTION;
USE `emr455`;
INSERT INTO `emr455`.`Secretary` (`ID`, `Phone_Number`, `Address`, `Start_Date`, `Name`, `Dept_ID`) VALUES ('UOO4N4ZCW1RF6', '17375094218', '8275 Grime Road Ponemah, MN', '1992-04-02', 'Leyla Bradford', 'XHJMKR');
INSERT INTO `emr455`.`Secretary` (`ID`, `Phone_Number`, `Address`, `Start_Date`, `Name`, `Dept_ID`) VALUES ('KL0KEI16N70BZ', '18979295754', '8242 Innovation Street Alexandria, MN', '1998-11-03', 'Elliot Bowen', 'BSR6NC');
INSERT INTO `emr455`.`Secretary` (`ID`, `Phone_Number`, `Address`, `Start_Date`, `Name`, `Dept_ID`) VALUES ('X68TVEOYT225Y', '14718448838', '93 West Windmill St. Clontarf, MN', '2014-09-07', 'Marianna Moyer', '6FXWF5');
INSERT INTO `emr455`.`Secretary` (`ID`, `Phone_Number`, `Address`, `Start_Date`, `Name`, `Dept_ID`) VALUES ('OVDCUXAII1LR2', '12101740963', '425 Shirley Ave. Duluth, MN', '1993-03-14', 'Angie Reed', 'QZS60A');
INSERT INTO `emr455`.`Secretary` (`ID`, `Phone_Number`, `Address`, `Start_Date`, `Name`, `Dept_ID`) VALUES ('TNQKC0VTM4KXC', '11842172988', '79 Columbia Dr. Belle Plaine, MN', '2003-10-20', 'Alfonso Noble', 'HCAE2O');
INSERT INTO `emr455`.`Secretary` (`ID`, `Phone_Number`, `Address`, `Start_Date`, `Name`, `Dept_ID`) VALUES ('QSL10FMRY8M20', '10282734987', '7583 Richardson Ave. Duluth, MN', '2014-01-17', 'Katrina Mcintosh', 'FUGY3Z');
INSERT INTO `emr455`.`Secretary` (`ID`, `Phone_Number`, `Address`, `Start_Date`, `Name`, `Dept_ID`) VALUES ('RHIS03R0LKN75', '11967357906', '679 North Oxford Street Browns Valley, MN', '1992-07-15', 'Samson Hays', 'F8MAUE');
INSERT INTO `emr455`.`Secretary` (`ID`, `Phone_Number`, `Address`, `Start_Date`, `Name`, `Dept_ID`) VALUES ('NY3MREP78MCZX', '16986594347', '652 Fairway Rd. West Concord, MN', '2017-08-01', 'Caroline Bradford', 'X5ONCN');
INSERT INTO `emr455`.`Secretary` (`ID`, `Phone_Number`, `Address`, `Start_Date`, `Name`, `Dept_ID`) VALUES ('KG2KMYBWHDBS5', '16290545070', '219 Princess Street Carlos, MN', '1991-05-12', 'Taylor Avila', 'U8TPHS');
INSERT INTO `emr455`.`Secretary` (`ID`, `Phone_Number`, `Address`, `Start_Date`, `Name`, `Dept_ID`) VALUES ('ZVGADBTTMXIDL', '18555068785', '9257 South Lakeview Ave. Bowstring, MN', '1994-10-31', 'Carlie Case', 'Q1KD1M');
INSERT INTO `emr455`.`Secretary` (`ID`, `Phone_Number`, `Address`, `Start_Date`, `Name`, `Dept_ID`) VALUES ('00PLHUBD6XZPJ', '10550839006', '7827 South Cambridge Ave. Clarkfield, MN', '2006-08-18', 'Tania Powers', '8OJYOV');
INSERT INTO `emr455`.`Secretary` (`ID`, `Phone_Number`, `Address`, `Start_Date`, `Name`, `Dept_ID`) VALUES ('LNOYN11KBIXZY', '12154456748', '9642 Campus St. Young America, MN', '1991-07-27', 'Skyler Tapia', 'AYDH7A');

COMMIT;


-- -----------------------------------------------------
-- Data for table `emr455`.`Appointment`
-- -----------------------------------------------------
START TRANSACTION;
USE `emr455`;
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-02', '10:45', '3WDUZBXQAO3CO', '1Y2WBG5S5LUP4', '3241');
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-07', '12:30', '3U7HHBFZ5M814', 'W04JOIOKRJ5P9', '3241');
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-09', '13:15', 'GV40I3MZQJBXW', 'YEWRDIQ6XK2QZ', '9478');
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-13', '15:15', 'XZ1OO5KYWZIGZ', 'LOWMM1Z062HS5', '8643');
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-14', '16:15', 'IBUHEPSIK9IQ6', 'NBVRJ6EF09PFI', '8643');
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-03', '08:30', 'NYLGXD2IUO58B', 'H9S1UTP6HN3DZ', '3241');
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-06', '09:15', 'D8WGQZN3AFG66', 'DR674E5T8D0FT', '3241');
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-13', '10:00', '3U7HHBFZ5M814', '883NCCUQS0M1X', '3241');
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-15', '14:00', 'DNPIONQPQS1H4', '0TCLHZJDUN47O', '9478');
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-16', '17:00', 'NYLGXD2IUO58B', 'MILYDP0F5SZ5D', '8643');
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-02', '10:15', 'DNPIONQPQS1H4', 'VHYIAU0FVLGRD', '3241');
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-03', '14:00', 'D8WGQZN3AFG66', '49IZDU3SXNM2Q', '9478');
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-07', '14:15', 'IBUHEPSIK9IQ6', 'E6S4GZSJPBQ0S', '9478');
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-08', '14:30', 'DNPIONQPQS1H4', 'BFI33ZFOLOQ5B', '9478');
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-15', '15:00', 'B4FOLXFTYRAEN', 'SLF1QP07OHZF7', '9478');
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-01', '11:45', '3WDUZBXQAO3CO', 'Z76PKBJ156WLK', '3241');
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-06', '13:00', 'XZ1OO5KYWZIGZ', 'X4LLZBR1G8KRP', '3241');
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-10', '14:30', 'IBUHEPSIK9IQ6', 'B00DP1V1XEMOL', '9478');
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-13', '15:45', 'B4FOLXFTYRAEN', 'ZXZRTJ4Z8FYE1', '8643');
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-16', '17:00', 'GV40I3MZQJBXW', 'XSW90MJ46B01T', '8643');
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-01', '13:00', 'BANRCIJWNU1TE', 'BQPCBFUU8UFQC', '3241');
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-03', '13:15', 'BTAG8N6EN7Z0G', 'CW7HIG31YIZHO', '9478');
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-08', '15:45', 'B4FOLXFTYRAEN', '5D82O0URTE38Q', '8643');
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-13', '16:30', 'BANRCIJWNU1TE', '1Z3K7VC3WN29J', '8643');
INSERT INTO `emr455`.`Appointment` (`Date`, `Time`, `Doc_ID`, `Pat_ID`, `Inst_ID`) VALUES ('2019-05-16', '16:45', 'BTAG8N6EN7Z0G', 'ZT4B5GA873FDD', '8643');

COMMIT;


-- -----------------------------------------------------
-- Data for table `emr455`.`Prescription`
-- -----------------------------------------------------
START TRANSACTION;
USE `emr455`;
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-01-14', '2019-02-14', 'Oxycoxitrol', 25, 'XGB2AGQ3CHAGP', 'P7LLDI6VNE4MOZ3', 'M0B43BYQI2VV8', 'daily');
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-01-31', '2019-03-30', 'Podoracil', 20, '3L06LSBW94OEV', 'JPHE9G4C1PCONYI', 'MXVIUM4DWCUA3', 'twice a week');
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-02-05', '2019-05-25', 'Solalinum Afinitone', 5, '3L06LSBW94OEV', 'F81571IUN1JEYK8', 'LLSP91IDBF49T', 'one a week');
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-04-10', '2019-05-15', 'Aflutiza', 75, 'XGB2AGQ3CHAGP', '4J1NH0NND6Q0OZO', '1Y2WBG5S5LUP4', 'daily');
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-05-01', '2019-06-29', 'Amansate Trixane', 25, 'D8WGQZN3AFG66', 'HPE4RFG2SY808T1', 'HH5C3A6KKYCKL', 'daily');
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-01-11', '2019-03-18', 'Aflutiza', 10, '3L06LSBW94OEV', '1N0A9LJ2QHTLQ3I', 'B2A74AG6HJ7D7', 'twice daily');
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-01-28', '2019-02-28', 'Etocane Palotant', 20, 'VV85338CD33W2', 'Q1Y75SYQ0N50KAZ', '9TXZPRZTX3N3W', 'one a week');
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-02-18', '2019-04-24', 'Oxycoxitrol', 75, 'I22O9063LJ9K5', '8CBQOMCDLPJYW2U', 'LSVQTCUN1RYTY', 'twice a week');
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-03-07', '2019-06-08', 'Solalinum Afinitone', 10, '3U7HHBFZ5M814', 'QK2VEGYFCNIT7GL', 'RG946TN8QW5BO', 'daily');
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-04-02', '2019-07-01', 'Podoracil', 25, 'I22O9063LJ9K5', '3AB9K7YH5FZ8W0O', 'YEWRDIQ6XK2QZ', 'daily');
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-01-25', '2019-04-24', 'Transsine', 15, 'XGB2AGQ3CHAGP', 'YM6KBB7ACDCNUI2', 'NHDQU81T7LSJ4', 'twice daily');
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-02-26', '2019-04-27', 'Methinium Agalnuma', 20, '3WDUZBXQAO3CO', 'F1BGR0RJE9QF1NB', 'W04JOIOKRJ5P9', 'one a week');
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-03-04', '2019-06-24', 'Transsine', 5, 'D8WGQZN3AFG66', 'MT0D0DRQ12NSTLK', 'LOLUW1UQONF27', 'twice a week');
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-03-08', '2019-07-22', 'Oxycoxitrol', 45, 'QUQBRW489ZRYI', 'QGZN8H5074YBREP', 'LOWMM1Z062HS5', 'daily');
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-03-15', '2019-06-11', 'Transsine', 75, 'I22O9063LJ9K5', 'KWQRX2BQDBI8U0X', 'LYVA9750EEYWG', 'twice daily');
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-02-19', '2019-05-19', 'Cyprodafinil', 45, '3WDUZBXQAO3CO', 'NRH6LSS69UQ2D0F', '5E1ZBJW2D8710', 'daily');
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-02-22', '2019-03-05', 'Methinium Agalnuma', 25, 'XZ1OO5KYWZIGZ', '8VFTW88FS7W6KVS', 'NBVRJ6EF09PFI', 'one a week');
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-03-26', '2019-06-06', 'Zysone', 10, '3WDUZBXQAO3CO', 'G46R5U5SYY2FXLT', 'QNZTOMO029NC2', 'twice daily');
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-04-16', '2019-07-07', 'Cyprodafinil', 5, 'D8WGQZN3AFG66', 'ZBHWQ76ILV3DOUP', 'H9S1UTP6HN3DZ', 'daily');
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-04-30', '2019-07-04', 'Podoracil', 10, 'QUQBRW489ZRYI', '5H3PCXKTLKLB11X', 'DR674E5T8D0FT', 'twice a week');
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-02-04', '2019-03-16', 'Etocane Palotant', 75, 'XZ1OO5KYWZIGZ', 'WJAQT7I9BBGHC1J', 'W7B5E2SKOKJWN', 'twice daily');
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-02-11', '2019-04-11', 'Zysone', 20, 'VV85338CD33W2', 'FANCNQPX6T2EN56', 'RNJT74R2UBT59', 'one a week');
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-03-26', '2019-05-12', 'Cyprodafinil', 15, 'XZ1OO5KYWZIGZ', 'RIKZQ9X8K5S13NK', 'MYAJZJY2545QZ', 'one a week');
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-04-16', '2019-06-26', 'Amansate Trixane', 5, 'QUQBRW489ZRYI', 'DNRJJKWG1H1PUDX', '883NCCUQS0M1X', 'twice a week');
INSERT INTO `emr455`.`Prescription` (`Start_Date`, `End_Date`, `Medication`, `Dosage`, `Doc_ID`, `Prescript_ID`, `Pat_ID`, `Interval`) VALUES ('2019-04-23', '2019-04-30', 'Etocane Palotant', 5, 'VV85338CD33W2', 'Q6GSXIFZKWIWORC', 'FTSUVOPAXQQUF', 'twice daily');

COMMIT;


-- -----------------------------------------------------
-- Data for table `emr455`.`Pharmacy`
-- -----------------------------------------------------
START TRANSACTION;
USE `emr455`;
INSERT INTO `emr455`.`Pharmacy` (`Name`, `Address`, `Phone_Number`) VALUES ('Sanford Pharmacy', '3001 Sanford Parkway, Thief River Falls, MN', '12186832725');
INSERT INTO `emr455`.`Pharmacy` (`Name`, `Address`, `Phone_Number`) VALUES ('Fairview Pharmacy', '14101 Fairview Dr, Burnsville, MN', '19524055630');
INSERT INTO `emr455`.`Pharmacy` (`Name`, `Address`, `Phone_Number`) VALUES ('CVS Pharmacy Mankato', '1850 Adams St., Mankato, MN', '15076259009');
INSERT INTO `emr455`.`Pharmacy` (`Name`, `Address`, `Phone_Number`) VALUES ('Sanford Pharmacy Bemidji', '1233 34th St. NW, Bemidji, MN', '12183335265');
INSERT INTO `emr455`.`Pharmacy` (`Name`, `Address`, `Phone_Number`) VALUES ('Guidepoint Pharmacy', '108 S 6th St.', '12188290347');

COMMIT;


-- -----------------------------------------------------
-- Data for table `emr455`.`Payment`
-- -----------------------------------------------------
START TRANSACTION;
USE `emr455`;
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (1201.54, 'heart transplant', '2019-01-08', 'u', NULL, 'ZT4B5GA873FDD', 1000.0);
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (409.48, 'physical therapy', '2019-01-10', 'p', NULL, '1Z3K7VC3WN29J', 409.48);
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (461.42, 'physical therapy', '2019-01-24', 'p', NULL, 'CW7HIG31YIZHO', 461.42);
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (719.13, 'lung transplant', '2019-01-29', 'u', NULL, 'BQPCBFUU8UFQC', 125.00);
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (1676.44, 'medication', '2019-01-31', 'u', NULL, '5D82O0URTE38Q', 400.00);
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (978.28, 'hair transplant', '2019-02-04', 'p', NULL, 'XSW90MJ46B01T', 978.28);
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (1136.2, 'physical therapy', '2019-02-11', 'u', NULL, 'ZXZRTJ4Z8FYE1', 0.00);
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (859.13, 'physical therapy', '2019-02-20', 'u', NULL, 'B00DP1V1XEMOL', 666.66);
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (819.96, 'physical therapy', '2019-02-21', 'u', NULL, 'X4LLZBR1G8KRP', 505.55);
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (790.26, 'physical therapy', '2019-02-26', 'p', NULL, 'Z76PKBJ156WLK', 790.26);
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (536.91, 'medication', '2019-02-27', 'u', NULL, 'CZQB5OGDKFBBB', 0.00);
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (971.47, 'surgery', '2019-02-28', 'u', NULL, 'PDVPRTKTT2GSC', 0.00);
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (161.42, 'physical therapy', '2019-03-01', 'p', NULL, 'IR1MVVV8RSU5Z', 161.42);
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (1179.97, 'surgery', '2019-03-07', 'u', NULL, 'SLF1QP07OHZF7', 0.00);
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (501.4, 'medication', '2019-03-14', 'u', NULL, 'BFI33ZFOLOQ5B', 0.00);
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (535.17, 'medication', '2019-03-21', 'p', NULL, 'E6S4GZSJPBQ0S', 535.17);
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (994.74, 'surgery', '2019-03-26', 'p', NULL, '49IZDU3SXNM2Q', 994.74);
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (125.3, 'physical therapy', '2019-03-29', 'p', NULL, '5WUSFBZ0FPKZF', 125.3);
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (831.94, 'medication', '2019-04-05', 'u', NULL, 'VHYIAU0FVLGRD', 0.0);
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (405.95, 'medication', '2019-04-08', 'p', NULL, 'M0B43BYQI2VV8', 405.95);
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (1723.53, 'surgery', '2019-04-09', 'p', NULL, 'MXVIUM4DWCUA3', 1723.53);
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (920.54, 'surgery', '2019-04-10', 'u', NULL, 'LLSP91IDBF49T', 0.0);
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (1264.71, 'physical therapy', '2019-04-11', 'u', NULL, '1Y2WBG5S5LUP4', 0.0);
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (1708.12, 'medication', '2019-04-17', 'u', NULL, 'HH5C3A6KKYCKL', 0.0);
INSERT INTO `emr455`.`Payment` (`Amount`, `Reason`, `Date`, `Status`, `Insurance_ID`, `Pat_ID`, `Paid`) VALUES (122.71, 'physical checkup', '2019-04-19', 'p', NULL, 'B2A74AG6HJ7D7', 122.71);

COMMIT;


-- -----------------------------------------------------
-- Data for table `emr455`.`Supply_Medicine`
-- -----------------------------------------------------
START TRANSACTION;
USE `emr455`;
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('Q6GSXIFZKWIWORC', 'P7LLDI6VNE4MOZ3');
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('Q6GSXIFZKWIWORC', 'JPHE9G4C1PCONYI');
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('Q6GSXIFZKWIWORC', 'F81571IUN1JEYK8');
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('Q6GSXIFZKWIWORC', '4J1NH0NND6Q0OZO');
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('Q6GSXIFZKWIWORC', 'HPE4RFG2SY808T1');
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('Fairview Pharmacy', '1N0A9LJ2QHTLQ3I');
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('Fairview Pharmacy', 'Q1Y75SYQ0N50KAZ');
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('Fairview Pharmacy', '8CBQOMCDLPJYW2U');
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('Fairview Pharmacy', 'QK2VEGYFCNIT7GL');
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('Fairview Pharmacy', '3AB9K7YH5FZ8W0O');
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('CVS Pharmacy Mankato', 'YM6KBB7ACDCNUI2');
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('CVS Pharmacy Mankato', 'F1BGR0RJE9QF1NB');
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('CVS Pharmacy Mankato', 'MT0D0DRQ12NSTLK');
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('CVS Pharmacy Mankato', 'QGZN8H5074YBREP');
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('CVS Pharmacy Mankato', 'KWQRX2BQDBI8U0X');
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('Sanford Pharmacy Bemidji', 'NRH6LSS69UQ2D0F');
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('Sanford Pharmacy Bemidji', '8VFTW88FS7W6KVS');
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('Sanford Pharmacy Bemidji', 'G46R5U5SYY2FXLT');
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('Sanford Pharmacy Bemidji', 'ZBHWQ76ILV3DOUP');
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('Sanford Pharmacy Bemidji', '5H3PCXKTLKLB11X');
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('Guidepoint Pharmacy', 'WJAQT7I9BBGHC1J');
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('Guidepoint Pharmacy', 'FANCNQPX6T2EN56');
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('Guidepoint Pharmacy', 'RIKZQ9X8K5S13NK');
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('Guidepoint Pharmacy', 'DNRJJKWG1H1PUDX');
INSERT INTO `emr455`.`Supply_Medicine` (`Pharmacy_Name`, `Prescript_ID`) VALUES ('Guidepoint Pharmacy', 'Q6GSXIFZKWIWORC');

COMMIT;


-- -----------------------------------------------------
-- Data for table `emr455`.`Nurse`
-- -----------------------------------------------------
START TRANSACTION;
USE `emr455`;
INSERT INTO `emr455`.`Nurse` (`Phone_Number`, `ID`, `Name`, `Start_Date`, `Address`, `Dept_ID`) VALUES ('14943245414', 'A5NS3Q9C35KXW', 'Cassidy Little', '1983-12-20', '4756  Oral Lake Road, Golden Valley, MN', 'XHJMKR');
INSERT INTO `emr455`.`Nurse` (`Phone_Number`, `ID`, `Name`, `Start_Date`, `Address`, `Dept_ID`) VALUES ('17671478186', '0TXV11PQSBWH5', 'Davin Kaiser', '1988-09-14', '645 Fieldstone Street Minneapolis, MN', 'XHJMKR');
INSERT INTO `emr455`.`Nurse` (`Phone_Number`, `ID`, `Name`, `Start_Date`, `Address`, `Dept_ID`) VALUES ('17960021643', '49RO77FWYO7R3', 'Gilberto Petersen', '2002-09-02', '718 South Somerset Ave. Dexter, MN', 'BSR6NC');
INSERT INTO `emr455`.`Nurse` (`Phone_Number`, `ID`, `Name`, `Start_Date`, `Address`, `Dept_ID`) VALUES ('12291950782', '7FVIYZH3XZHQZ', 'Fiona Joseph', '2003-10-06', '90 Glendale Street Gary, MN', 'BSR6NC');
INSERT INTO `emr455`.`Nurse` (`Phone_Number`, `ID`, `Name`, `Start_Date`, `Address`, `Dept_ID`) VALUES ('16026238201', 'O5SH0CA2SSO6T', 'Lesly Knox', '1985-10-29', '80 West Stonybrook Lane Garrison, MN', '6FXWF5');
INSERT INTO `emr455`.`Nurse` (`Phone_Number`, `ID`, `Name`, `Start_Date`, `Address`, `Dept_ID`) VALUES ('16057171509', 'WICUEBGDF1XTR', 'Dayana Molina', '1998-10-31', '74 Penn Drive West Union, MN', '6FXWF5');
INSERT INTO `emr455`.`Nurse` (`Phone_Number`, `ID`, `Name`, `Start_Date`, `Address`, `Dept_ID`) VALUES ('16759792149', 'C270SLWQJC3SP', 'Bridget Page', '2019-02-17', '269 South Bellow Lane Canby, MN', 'QZS60A');
INSERT INTO `emr455`.`Nurse` (`Phone_Number`, `ID`, `Name`, `Start_Date`, `Address`, `Dept_ID`) VALUES ('17772512264', '055BEHLN0Y8MX', 'Elyse Wang', '1980-08-19', '61 Spruce Ave. Holdingford, MN', 'QZS60A');
INSERT INTO `emr455`.`Nurse` (`Phone_Number`, `ID`, `Name`, `Start_Date`, `Address`, `Dept_ID`) VALUES ('14040571451', 'JVVL4QQODKD2T', 'Aryan Gregory', '1986-06-30', '220 North Little Lane Hardwick, MN', 'HCAE2O');
INSERT INTO `emr455`.`Nurse` (`Phone_Number`, `ID`, `Name`, `Start_Date`, `Address`, `Dept_ID`) VALUES ('19427386542', 'R23XEWF55G5M6', 'Karli Hunt', '1988-06-03', '716 E. Spruce Dr. Fairfax, MN', 'HCAE2O');
INSERT INTO `emr455`.`Nurse` (`Phone_Number`, `ID`, `Name`, `Start_Date`, `Address`, `Dept_ID`) VALUES ('19897333280', 'URCBAOOFR32WS', 'Bella Mccarthy', '1993-10-18', '607 N. Estate St. Mabel, MN', 'FUGY3Z');
INSERT INTO `emr455`.`Nurse` (`Phone_Number`, `ID`, `Name`, `Start_Date`, `Address`, `Dept_ID`) VALUES ('17344863961', 'GFZ9NCQCSVWO0', 'Kendrick Pham', '2010-10-02', '903 St Paul Road Young America, MN', 'FUGY3Z');
INSERT INTO `emr455`.`Nurse` (`Phone_Number`, `ID`, `Name`, `Start_Date`, `Address`, `Dept_ID`) VALUES ('13807158176', 'ZLRIZ1W40VAAL', 'Gregory Weiss', '2012-10-09', '632 West Glendale Street Saint Paul, MN', 'F8MAUE');
INSERT INTO `emr455`.`Nurse` (`Phone_Number`, `ID`, `Name`, `Start_Date`, `Address`, `Dept_ID`) VALUES ('19091040931', '8PELCIBKZN428', 'Brock Bernard', '2000-12-08', '28 Fortune Ave. Sanborn, MN', 'F8MAUE');
INSERT INTO `emr455`.`Nurse` (`Phone_Number`, `ID`, `Name`, `Start_Date`, `Address`, `Dept_ID`) VALUES ('14810597659', 'QC09ZCCI8JPCJ', 'Kaylah Levine', '1999-05-31', '32 Lawn Street Correll, MN', 'X5ONCN');
INSERT INTO `emr455`.`Nurse` (`Phone_Number`, `ID`, `Name`, `Start_Date`, `Address`, `Dept_ID`) VALUES ('13487860464', 'JJGRV4WM2PB71', 'Charlotte Schmidt', '2004-03-09', '7916 Angel St. Saint Paul, MN', 'X5ONCN');
INSERT INTO `emr455`.`Nurse` (`Phone_Number`, `ID`, `Name`, `Start_Date`, `Address`, `Dept_ID`) VALUES ('16082263857', 'KGW4SWQEX1EJM', 'Aidan Baird', '2016-08-28', '6 Sycamore Ave. Pengilly, MN', 'U8TPHS');
INSERT INTO `emr455`.`Nurse` (`Phone_Number`, `ID`, `Name`, `Start_Date`, `Address`, `Dept_ID`) VALUES ('19523493260', 'X4VRT5VT200YK', 'Eli Torres', '1988-09-09', '472 Ruby Road Young America, MN', 'U8TPHS');
INSERT INTO `emr455`.`Nurse` (`Phone_Number`, `ID`, `Name`, `Start_Date`, `Address`, `Dept_ID`) VALUES ('13803737517', 'DEKDHS5F79F04', 'Leonidas Pitts', '2002-04-09', '55 Ferry Lane Becker, MN', 'Q1KD1M');
INSERT INTO `emr455`.`Nurse` (`Phone_Number`, `ID`, `Name`, `Start_Date`, `Address`, `Dept_ID`) VALUES ('17414718398', 'RBQIIDTF3YOL5', 'Brent Crane', '2018-08-02', '745 Royalty St. Bigfork, MN', 'Q1KD1M');
INSERT INTO `emr455`.`Nurse` (`Phone_Number`, `ID`, `Name`, `Start_Date`, `Address`, `Dept_ID`) VALUES ('12099543553', 'NF3VJK0GNVFOM', 'Iris Harrell', '1991-04-25', '654 Glenlake St. Saint Paul, MN', '8OJYOV');
INSERT INTO `emr455`.`Nurse` (`Phone_Number`, `ID`, `Name`, `Start_Date`, `Address`, `Dept_ID`) VALUES ('13963947043', '3PSXOMF49B4W1', 'Ariel Shea', '1994-01-03', '338 Carriage Ave. Minneapolis, MN', '8OJYOV');
INSERT INTO `emr455`.`Nurse` (`Phone_Number`, `ID`, `Name`, `Start_Date`, `Address`, `Dept_ID`) VALUES ('15563101387', '1BR8YBY53UPMR', 'Janet Wood', '2019-02-17', '8644 Birchpond St. Cloquet, MN', 'AYDH7A');
INSERT INTO `emr455`.`Nurse` (`Phone_Number`, `ID`, `Name`, `Start_Date`, `Address`, `Dept_ID`) VALUES ('12731185690', 'KCVROM2BJ0505', 'Reese Walls', '1995-09-06', '873 Hilldale St. Wayzata, MN', 'AYDH7A');

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
