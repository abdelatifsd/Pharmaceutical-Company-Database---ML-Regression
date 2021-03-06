-- MySQL Script generated by MySQL Workbench
-- Sun Dec  3 21:32:53 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema bioMed3
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bioMed3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bioMed3` DEFAULT CHARACTER SET utf8 ;
USE `bioMed3` ;

-- -----------------------------------------------------
-- Table `bioMed3`.`Company`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bioMed3`.`Company` ;

CREATE TABLE IF NOT EXISTS `bioMed3`.`Company` (
  `CompanyID` INT NOT NULL AUTO_INCREMENT,
  `ContactFName` VARCHAR(45) NULL,
  `CompanyLName` VARCHAR(45) NULL,
  `CompanyStreetAddress` VARCHAR(45) NULL,
  `CompanyPostalCode` VARCHAR(45) NULL,
  `CompanyType` VARCHAR(45) NULL,
  PRIMARY KEY (`CompanyID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bioMed3`.`Supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bioMed3`.`Supplier` ;

CREATE TABLE IF NOT EXISTS `bioMed3`.`Supplier` (
  `SupplierID` INT NOT NULL AUTO_INCREMENT,
  `IndustryRating` INT(1) NULL,
  `Company_CompanyID` INT NOT NULL,
  PRIMARY KEY (`SupplierID`),
  INDEX `fk_Supplier_Company1_idx` (`Company_CompanyID` ASC),
  CONSTRAINT `fk_Supplier_Company1`
    FOREIGN KEY (`Company_CompanyID`)
    REFERENCES `bioMed3`.`Company` (`CompanyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bioMed3`.`RawMaterial`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bioMed3`.`RawMaterial` ;

CREATE TABLE IF NOT EXISTS `bioMed3`.`RawMaterial` (
  `RawMaterialID` INT NOT NULL AUTO_INCREMENT,
  `MaterialName` VARCHAR(45) NULL,
  `MaterialOrigin` VARCHAR(45) NULL,
  PRIMARY KEY (`RawMaterialID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bioMed3`.`Produces`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bioMed3`.`Produces` ;

CREATE TABLE IF NOT EXISTS `bioMed3`.`Produces` (
  `Supplier_SupplierID` INT NOT NULL,
  `RawMaterial_RawMaterialID` INT NOT NULL,
  `SupplierType` VARCHAR(45) NULL,
  INDEX `fk_Supplier_has_RawMaterial_RawMaterial1_idx` (`RawMaterial_RawMaterialID` ASC),
  INDEX `fk_Supplier_has_RawMaterial_Supplier_idx` (`Supplier_SupplierID` ASC),
  CONSTRAINT `fk_Supplier_has_RawMaterial_Supplier`
    FOREIGN KEY (`Supplier_SupplierID`)
    REFERENCES `bioMed3`.`Supplier` (`SupplierID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Supplier_has_RawMaterial_RawMaterial1`
    FOREIGN KEY (`RawMaterial_RawMaterialID`)
    REFERENCES `bioMed3`.`RawMaterial` (`RawMaterialID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bioMed3`.`ProcessingFacilities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bioMed3`.`ProcessingFacilities` ;

CREATE TABLE IF NOT EXISTS `bioMed3`.`ProcessingFacilities` (
  `ProcessingFacilitiesID` INT NOT NULL,
  `Company_CompanyID` INT NOT NULL,
  PRIMARY KEY (`ProcessingFacilitiesID`),
  INDEX `fk_ProcessingFacilities_Company1_idx` (`Company_CompanyID` ASC),
  CONSTRAINT `fk_ProcessingFacilities_Company1`
    FOREIGN KEY (`Company_CompanyID`)
    REFERENCES `bioMed3`.`Company` (`CompanyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bioMed3`.`FacilitiesLicenseNumber`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bioMed3`.`FacilitiesLicenseNumber` ;

CREATE TABLE IF NOT EXISTS `bioMed3`.`FacilitiesLicenseNumber` (
  `FlnID` INT NOT NULL AUTO_INCREMENT,
  `RawMaterial_RawMaterialID` INT NOT NULL,
  `ProcessingFacilities_ProcessingFacilitiesID` INT NOT NULL,
  `FacilitiesLicenseNumber` VARCHAR(9) NOT NULL,
  INDEX `fk_RawMaterial_has_ProcessingFacilities_ProcessingFacilitie_idx` (`ProcessingFacilities_ProcessingFacilitiesID` ASC),
  INDEX `fk_RawMaterial_has_ProcessingFacilities_RawMaterial1_idx` (`RawMaterial_RawMaterialID` ASC),
  PRIMARY KEY (`FlnID`),
  CONSTRAINT `fk_RawMaterial_has_ProcessingFacilities_RawMaterial1`
    FOREIGN KEY (`RawMaterial_RawMaterialID`)
    REFERENCES `bioMed3`.`RawMaterial` (`RawMaterialID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RawMaterial_has_ProcessingFacilities_ProcessingFacilities1`
    FOREIGN KEY (`ProcessingFacilities_ProcessingFacilitiesID`)
    REFERENCES `bioMed3`.`ProcessingFacilities` (`ProcessingFacilitiesID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bioMed3`.`Products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bioMed3`.`Products` ;

CREATE TABLE IF NOT EXISTS `bioMed3`.`Products` (
  `ProductID` INT NOT NULL AUTO_INCREMENT,
  `ProductName` VARCHAR(45) NULL,
  `ProductPrice` INT NULL,
  `Treatment` TEXT NULL,
  PRIMARY KEY (`ProductID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bioMed3`.`Distributors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bioMed3`.`Distributors` ;

CREATE TABLE IF NOT EXISTS `bioMed3`.`Distributors` (
  `DistributorID` INT NOT NULL AUTO_INCREMENT,
  `YearsWithUs` INT NULL,
  `Company_CompanyID` INT NOT NULL,
  PRIMARY KEY (`DistributorID`),
  INDEX `fk_Distributors_Company1_idx` (`Company_CompanyID` ASC),
  CONSTRAINT `fk_Distributors_Company1`
    FOREIGN KEY (`Company_CompanyID`)
    REFERENCES `bioMed3`.`Company` (`CompanyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bioMed3`.`Distributors_has_Products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bioMed3`.`Distributors_has_Products` ;

CREATE TABLE IF NOT EXISTS `bioMed3`.`Distributors_has_Products` (
  `Distributors_DistributorID` INT NOT NULL,
  `Products_ProductID` INT NOT NULL,
  INDEX `fk_Distributors_has_Products_Products1_idx` (`Products_ProductID` ASC),
  INDEX `fk_Distributors_has_Products_Distributors1_idx` (`Distributors_DistributorID` ASC),
  CONSTRAINT `fk_Distributors_has_Products_Distributors1`
    FOREIGN KEY (`Distributors_DistributorID`)
    REFERENCES `bioMed3`.`Distributors` (`DistributorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Distributors_has_Products_Products1`
    FOREIGN KEY (`Products_ProductID`)
    REFERENCES `bioMed3`.`Products` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bioMed3`.`Retailer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bioMed3`.`Retailer` ;

CREATE TABLE IF NOT EXISTS `bioMed3`.`Retailer` (
  `RetailerID` INT NOT NULL AUTO_INCREMENT,
  `Company_CompanyID` INT NOT NULL,
  PRIMARY KEY (`RetailerID`),
  INDEX `fk_Retailer_Company1_idx` (`Company_CompanyID` ASC),
  CONSTRAINT `fk_Retailer_Company1`
    FOREIGN KEY (`Company_CompanyID`)
    REFERENCES `bioMed3`.`Company` (`CompanyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bioMed3`.`RetailLicenseNumber`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bioMed3`.`RetailLicenseNumber` ;

CREATE TABLE IF NOT EXISTS `bioMed3`.`RetailLicenseNumber` (
  `RlnID` INT NOT NULL AUTO_INCREMENT,
  `Distributors_DistributorID` INT NOT NULL,
  `Retailer_RetailerID` INT NOT NULL,
  `RetailLicenseNumber` VARCHAR(10) NULL,
  INDEX `fk_Distributors_has_Retailer_Retailer1_idx` (`Retailer_RetailerID` ASC),
  INDEX `fk_Distributors_has_Retailer_Distributors1_idx` (`Distributors_DistributorID` ASC),
  PRIMARY KEY (`RlnID`),
  CONSTRAINT `fk_Distributors_has_Retailer_Distributors1`
    FOREIGN KEY (`Distributors_DistributorID`)
    REFERENCES `bioMed3`.`Distributors` (`DistributorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Distributors_has_Retailer_Retailer1`
    FOREIGN KEY (`Retailer_RetailerID`)
    REFERENCES `bioMed3`.`Retailer` (`RetailerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bioMed3`.`Doctor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bioMed3`.`Doctor` ;

CREATE TABLE IF NOT EXISTS `bioMed3`.`Doctor` (
  `DoctorID` INT NOT NULL AUTO_INCREMENT,
  `DoctorName` VARCHAR(45) NULL,
  `DoctorPhoneNumber` VARCHAR(45) NULL,
  `StreetAddress` VARCHAR(45) NULL,
  `InstitutionDegree` VARCHAR(45) NULL,
  `PostalCode` VARCHAR(45) NULL,
  PRIMARY KEY (`DoctorID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bioMed3`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bioMed3`.`Customer` ;

CREATE TABLE IF NOT EXISTS `bioMed3`.`Customer` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `CustomerName` VARCHAR(45) NULL,
  `CustomerPhoneNumber` VARCHAR(45) NULL,
  `StreetAddress` VARCHAR(45) NULL,
  `Age` INT NULL,
  `Gender` VARCHAR(45) NULL,
  `BloodType` VARCHAR(2) NULL,
  `PostalCode` VARCHAR(45) NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bioMed3`.`Perscription`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bioMed3`.`Perscription` ;

CREATE TABLE IF NOT EXISTS `bioMed3`.`Perscription` (
  `PerscriptionID` INT NOT NULL AUTO_INCREMENT,
  `PerscriptionNotes` TEXT NULL,
  `Doctor_DoctorID` INT NOT NULL,
  `Customer_CustomerID` INT NOT NULL,
  `PerscriptionDate` DATE NULL,
  `PerscriptionQuantity` INT NULL,
  PRIMARY KEY (`PerscriptionID`),
  INDEX `fk_Perscription_Doctor1_idx` (`Doctor_DoctorID` ASC),
  INDEX `fk_Perscription_Customer1_idx` (`Customer_CustomerID` ASC),
  CONSTRAINT `fk_Perscription_Doctor1`
    FOREIGN KEY (`Doctor_DoctorID`)
    REFERENCES `bioMed3`.`Doctor` (`DoctorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Perscription_Customer1`
    FOREIGN KEY (`Customer_CustomerID`)
    REFERENCES `bioMed3`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bioMed3`.`Retailer_Perscription`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bioMed3`.`Retailer_Perscription` ;

CREATE TABLE IF NOT EXISTS `bioMed3`.`Retailer_Perscription` (
  `Retailer_RetailerID` INT NOT NULL,
  `Perscription_PerscriptionID` INT NOT NULL,
  INDEX `fk_Retailer_has_Perscription_Perscription1_idx` (`Perscription_PerscriptionID` ASC),
  INDEX `fk_Retailer_has_Perscription_Retailer1_idx` (`Retailer_RetailerID` ASC),
  CONSTRAINT `fk_Retailer_has_Perscription_Retailer1`
    FOREIGN KEY (`Retailer_RetailerID`)
    REFERENCES `bioMed3`.`Retailer` (`RetailerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Retailer_has_Perscription_Perscription1`
    FOREIGN KEY (`Perscription_PerscriptionID`)
    REFERENCES `bioMed3`.`Perscription` (`PerscriptionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bioMed3`.`Products_has_ProcessingFacilities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bioMed3`.`Products_has_ProcessingFacilities` ;

CREATE TABLE IF NOT EXISTS `bioMed3`.`Products_has_ProcessingFacilities` (
  `Products_ProductID` INT NOT NULL,
  `ProcessingFacilities_ProcessingFacilitiesID` INT NOT NULL,
  INDEX `fk_Products_has_ProcessingFacilities_ProcessingFacilities1_idx` (`ProcessingFacilities_ProcessingFacilitiesID` ASC),
  INDEX `fk_Products_has_ProcessingFacilities_Products1_idx` (`Products_ProductID` ASC),
  CONSTRAINT `fk_Products_has_ProcessingFacilities_Products1`
    FOREIGN KEY (`Products_ProductID`)
    REFERENCES `bioMed3`.`Products` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Products_has_ProcessingFacilities_ProcessingFacilities1`
    FOREIGN KEY (`ProcessingFacilities_ProcessingFacilitiesID`)
    REFERENCES `bioMed3`.`ProcessingFacilities` (`ProcessingFacilitiesID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
