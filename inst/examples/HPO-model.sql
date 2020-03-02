-- MySQL Script generated by MySQL Workbench
-- Mon Mar 11 11:05:57 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema HPO
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema HPO
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `HPO` DEFAULT CHARACTER SET utf8 ;
USE `HPO` ;

-- -----------------------------------------------------
-- Table `HPO`.`HPO_hp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HPO`.`HPO_hp` (
  `id` VARCHAR(45) NOT NULL COMMENT 'HP identifier',
  `name` VARCHAR(45) NOT NULL COMMENT 'HP name',
  `description` VARCHAR(45) NULL COMMENT 'HP description',
  `level` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HPO`.`HPO_altId`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HPO`.`HPO_altId` (
  `id` VARCHAR(45) NOT NULL COMMENT 'HP identifier',
  `alt` VARCHAR(45) NOT NULL COMMENT 'Alternative identifier',
  INDEX `fk_HPO_altId_HPO_hp1_idx` (`id` ASC),
  CONSTRAINT `fk_HPO_altId_HPO_hp1`
    FOREIGN KEY (`id`)
    REFERENCES `HPO`.`HPO_hp` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HPO`.`HPO_sourceFiles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HPO`.`HPO_sourceFiles` (
  `url` VARCHAR(45) NOT NULL COMMENT 'Source file URL',
  `current` DATE NOT NULL COMMENT 'The date of the current source file',
  PRIMARY KEY (`url`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HPO`.`HPO_diseases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HPO`.`HPO_diseases` (
  `db` VARCHAR(45) NOT NULL COMMENT 'Disease database',
  `id` VARCHAR(45) NOT NULL COMMENT 'Disease ID',
  `label` VARCHAR(45) NOT NULL COMMENT 'Disease lable (preferred synonym)',
  PRIMARY KEY (`db`, `id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HPO`.`HPO_diseaseHP`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HPO`.`HPO_diseaseHP` (
  `db` VARCHAR(45) NOT NULL COMMENT 'Disease database',
  `id` VARCHAR(45) NOT NULL COMMENT 'Disease ID',
  `hp` VARCHAR(45) NOT NULL COMMENT 'HP identifier',
  INDEX `fk_HPO_diseaseHp_HPO_hp1_idx` (`hp` ASC),
  INDEX `fk_HPO_diseaseHp_HPO_diseases1_idx` (`db` ASC, `id` ASC),
  CONSTRAINT `fk_HPO_diseaseHp_HPO_hp1`
    FOREIGN KEY (`hp`)
    REFERENCES `HPO`.`HPO_hp` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_HPO_diseaseHp_HPO_diseases1`
    FOREIGN KEY (`db` , `id`)
    REFERENCES `HPO`.`HPO_diseases` (`db` , `id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HPO`.`HPO_diseaseSynonyms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HPO`.`HPO_diseaseSynonyms` (
  `db` VARCHAR(45) NOT NULL COMMENT 'Disease database',
  `id` VARCHAR(45) NOT NULL COMMENT 'Disease ID',
  `synonym` VARCHAR(45) NOT NULL COMMENT 'Disease synonym',
  `preferred` TINYINT NOT NULL COMMENT 'Is synonym preferred',
  INDEX `fk_HPO_diseaseSynonyms_HPO_diseases1_idx` (`db` ASC, `id` ASC),
  CONSTRAINT `fk_HPO_diseaseSynonyms_HPO_diseases1`
    FOREIGN KEY (`db` , `id`)
    REFERENCES `HPO`.`HPO_diseases` (`db` , `id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HPO`.`HPO_parents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HPO`.`HPO_parents` (
  `id` VARCHAR(45) NOT NULL COMMENT 'HP identifier',
  `parent` VARCHAR(45) NOT NULL COMMENT 'Parent identifier',
  INDEX `fk_HPO_altId_HPO_hp1_idx` (`id` ASC),
  INDEX `parent_idx` (`parent` ASC),
  CONSTRAINT `fk_HPO_altId_HPO_hp10`
    FOREIGN KEY (`id`)
    REFERENCES `HPO`.`HPO_hp` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `parent`
    FOREIGN KEY (`parent`)
    REFERENCES `HPO`.`HPO_hp` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HPO`.`HPO_descendants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HPO`.`HPO_descendants` (
  `id` VARCHAR(45) NOT NULL COMMENT 'HP identifier',
  `descendant` VARCHAR(45) NOT NULL COMMENT 'Descendant (child or child of child...) HP ID',
  INDEX `fk_HPO_altId_HPO_hp1_idx` (`id` ASC),
  INDEX `parent_idx` (`descendant` ASC),
  CONSTRAINT `fk_HPO_altId_HPO_hp100`
    FOREIGN KEY (`id`)
    REFERENCES `HPO`.`HPO_hp` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `descendant`
    FOREIGN KEY (`descendant`)
    REFERENCES `HPO`.`HPO_hp` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HPO`.`HPO_synonyms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HPO`.`HPO_synonyms` (
  `id` VARCHAR(45) NOT NULL COMMENT 'HP identifier',
  `synonym` VARCHAR(100) NOT NULL COMMENT 'HP synonym',
  `type` VARCHAR(45) NOT NULL COMMENT 'Synonym type',
  CONSTRAINT `id`
    FOREIGN KEY (`id`)
    REFERENCES `HPO`.`HPO_hp` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;