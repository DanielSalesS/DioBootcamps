-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Client` (
  `idClient` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(15) NULL,
  `LastName` VARCHAR(30) NULL,
  `CPF` VARCHAR(14) NULL,
  `BirthDate` DATE NULL,
  PRIMARY KEY (`idClient`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vehicle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vehicle` (
  `idVehicle` INT NOT NULL AUTO_INCREMENT,
  `Brand` VARCHAR(45) NULL,
  `Model` VARCHAR(45) NULL,
  `Year` VARCHAR(45) NULL,
  `Client_idClient` INT NOT NULL,
  PRIMARY KEY (`idVehicle`, `Client_idClient`),
  INDEX `fk_Vehicle_Client1_idx` (`Client_idClient` ASC) VISIBLE,
  CONSTRAINT `fk_Vehicle_Client1`
    FOREIGN KEY (`Client_idClient`)
    REFERENCES `mydb`.`Client` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MechanicsTeam`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MechanicsTeam` (
  `idMechanicsTeam` INT NOT NULL AUTO_INCREMENT,
  `Code` VARCHAR(45) NULL,
  PRIMARY KEY (`idMechanicsTeam`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OS` (
  `idOS` INT NOT NULL AUTO_INCREMENT,
  `Number` INT NULL,
  `Status` ENUM('Esperando Aprovação', 'Aprovado') CHARACTER SET 'utf8' NOT NULL,
  `Value` FLOAT NULL,
  `IssueDate` DATE NULL,
  `Data de Entrega` DATE NULL,
  `MechanicsTeam_idMechanicsTeam` INT NOT NULL,
  PRIMARY KEY (`idOS`),
  INDEX `fk_OS_MechanicsTeam1_idx` (`MechanicsTeam_idMechanicsTeam` ASC) VISIBLE,
  CONSTRAINT `fk_OS_MechanicsTeam1`
    FOREIGN KEY (`MechanicsTeam_idMechanicsTeam`)
    REFERENCES `mydb`.`MechanicsTeam` (`idMechanicsTeam`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Service` (
  `idService` INT NOT NULL AUTO_INCREMENT,
  `Type` TINYTEXT NULL,
  `price` VARCHAR(45) NULL,
  PRIMARY KEY (`idService`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Part`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Part` (
  `idPart` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Type` TINYTEXT NULL,
  PRIMARY KEY (`idPart`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Mechanic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Mechanic` (
  `idMechanic` INT NOT NULL AUTO_INCREMENT,
  `Code` INT NULL,
  `Name` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `specialty` VARCHAR(45) NULL,
  `MechanicsTeam_idMechanicsTeam` INT NOT NULL,
  `MechanicsTeam_idMechanicsTeam1` INT NOT NULL,
  PRIMARY KEY (`idMechanic`, `MechanicsTeam_idMechanicsTeam`, `MechanicsTeam_idMechanicsTeam1`),
  INDEX `fk_Mechanic_MechanicsTeam1_idx` (`MechanicsTeam_idMechanicsTeam1` ASC) VISIBLE,
  CONSTRAINT `fk_Mechanic_MechanicsTeam1`
    FOREIGN KEY (`MechanicsTeam_idMechanicsTeam1`)
    REFERENCES `mydb`.`MechanicsTeam` (`idMechanicsTeam`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vehicle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vehicle` (
  `idVehicle` INT NOT NULL AUTO_INCREMENT,
  `Brand` VARCHAR(45) NULL,
  `Model` VARCHAR(45) NULL,
  `Year` VARCHAR(45) NULL,
  `Client_idClient` INT NOT NULL,
  PRIMARY KEY (`idVehicle`, `Client_idClient`),
  INDEX `fk_Vehicle_Client1_idx` (`Client_idClient` ASC) VISIBLE,
  CONSTRAINT `fk_Vehicle_Client1`
    FOREIGN KEY (`Client_idClient`)
    REFERENCES `mydb`.`Client` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Service_has_Part`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Service_has_Part` (
  `Service_idService` INT NOT NULL,
  `Part_idPart` INT NOT NULL,
  PRIMARY KEY (`Service_idService`, `Part_idPart`),
  INDEX `fk_Service_has_Part_Part1_idx` (`Part_idPart` ASC) VISIBLE,
  INDEX `fk_Service_has_Part_Service1_idx` (`Service_idService` ASC) VISIBLE,
  CONSTRAINT `fk_Service_has_Part_Service1`
    FOREIGN KEY (`Service_idService`)
    REFERENCES `mydb`.`Service` (`idService`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Service_has_Part_Part1`
    FOREIGN KEY (`Part_idPart`)
    REFERENCES `mydb`.`Part` (`idPart`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OS_has_Service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OS_has_Service` (
  `OS_idOS` INT NOT NULL,
  `Service_idService` INT NOT NULL,
  PRIMARY KEY (`OS_idOS`, `Service_idService`),
  INDEX `fk_OS_has_Service_Service1_idx` (`Service_idService` ASC) VISIBLE,
  INDEX `fk_OS_has_Service_OS1_idx` (`OS_idOS` ASC) VISIBLE,
  CONSTRAINT `fk_OS_has_Service_OS1`
    FOREIGN KEY (`OS_idOS`)
    REFERENCES `mydb`.`OS` (`idOS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OS_has_Service_Service1`
    FOREIGN KEY (`Service_idService`)
    REFERENCES `mydb`.`Service` (`idService`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vehicle_has_MechanicsTeam`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vehicle_has_MechanicsTeam` (
  `Vehicle_idVehicle` INT NOT NULL,
  `MechanicsTeam_idMechanicsTeam` INT NOT NULL,
  PRIMARY KEY (`Vehicle_idVehicle`, `MechanicsTeam_idMechanicsTeam`),
  INDEX `fk_Vehicle_has_MechanicsTeam_MechanicsTeam1_idx` (`MechanicsTeam_idMechanicsTeam` ASC) VISIBLE,
  INDEX `fk_Vehicle_has_MechanicsTeam_Vehicle1_idx` (`Vehicle_idVehicle` ASC) VISIBLE,
  CONSTRAINT `fk_Vehicle_has_MechanicsTeam_Vehicle1`
    FOREIGN KEY (`Vehicle_idVehicle`)
    REFERENCES `mydb`.`Vehicle` (`idVehicle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vehicle_has_MechanicsTeam_MechanicsTeam1`
    FOREIGN KEY (`MechanicsTeam_idMechanicsTeam`)
    REFERENCES `mydb`.`MechanicsTeam` (`idMechanicsTeam`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
