-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Pet_Training_School
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Pet_Training_School
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pet_Training_School` DEFAULT CHARACTER SET utf8 ;
USE `Pet_Training_School` ;

-- -----------------------------------------------------
-- Table `Pet_Training_School`.`Owner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pet_Training_School`.`Owner` (
  `owner_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(20) NULL,
  `email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`owner_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pet_Training_School`.`Pet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pet_Training_School`.`Pet` (
  `pet_id` INT NOT NULL AUTO_INCREMENT,
  `pet_name` VARCHAR(45) NOT NULL,
  `species` VARCHAR(45) NOT NULL,
  `breed` VARCHAR(45) NULL,
  `date_of_birth` DATE NULL,
  `owner_id` INT NOT NULL,
  PRIMARY KEY (`pet_id`),
  INDEX `fk_Pet_Owner_idx` (`owner_id` ASC) VISIBLE,
  CONSTRAINT `fk_Pet_Owner`
    FOREIGN KEY (`owner_id`)
    REFERENCES `Pet_Training_School`.`Owner` (`owner_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pet_Training_School`.`Trainer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pet_Training_School`.`Trainer` (
  `trainer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(20) NULL,
  `email` VARCHAR(100) NOT NULL,
  `specialty` VARCHAR(100) NULL,
  PRIMARY KEY (`trainer_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pet_Training_School`.`Training_Class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pet_Training_School`.`Training_Class` (
  `class_id` INT NOT NULL AUTO_INCREMENT,
  `class_name` VARCHAR(100) NOT NULL,
  `training_level` VARCHAR(45) NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `price` DECIMAL(8,2) NOT NULL,
  `trainer_id` INT NOT NULL,
  PRIMARY KEY (`class_id`),
  INDEX `fk_Training_Class_Trainer1_idx` (`trainer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Training_Class_Trainer1`
    FOREIGN KEY (`trainer_id`)
    REFERENCES `Pet_Training_School`.`Trainer` (`trainer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pet_Training_School`.`Enrollment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pet_Training_School`.`Enrollment` (
  `enrollment_id` INT NOT NULL AUTO_INCREMENT,
  `enrollment_date` DATE NOT NULL,
  `status` VARCHAR(20) NOT NULL,
  `pet_id` INT NOT NULL,
  `class_id` INT NOT NULL,
  PRIMARY KEY (`enrollment_id`),
  INDEX `fk_Enrollment_Pet1_idx` (`pet_id` ASC) VISIBLE,
  INDEX `fk_Enrollment_Training_Class1_idx` (`class_id` ASC) VISIBLE,
  CONSTRAINT `fk_Enrollment_Pet1`
    FOREIGN KEY (`pet_id`)
    REFERENCES `Pet_Training_School`.`Pet` (`pet_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Enrollment_Training_Class1`
    FOREIGN KEY (`class_id`)
    REFERENCES `Pet_Training_School`.`Training_Class` (`class_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pet_Training_School`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pet_Training_School`.`Payment` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `payment_date` DATE NOT NULL,
  `amount` DECIMAL(8,2) NOT NULL,
  `payment_method` VARCHAR(45) NOT NULL,
  `enrollment_id` INT NOT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `fk_Payment_Enrollment1_idx` (`enrollment_id` ASC) VISIBLE,
  UNIQUE INDEX `enrollment_id_UNIQUE` (`enrollment_id` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_Enrollment1`
    FOREIGN KEY (`enrollment_id`)
    REFERENCES `Pet_Training_School`.`Enrollment` (`enrollment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
