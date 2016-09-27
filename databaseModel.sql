-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema OOPBlog
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema OOPBlog
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `OOPBlog` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema OOPBlog
-- -----------------------------------------------------
USE `OOPBlog` ;

-- -----------------------------------------------------
-- Table `OOPBlog`.`people`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OOPBlog`.`people` (
  `authorID` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`authorID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OOPBlog`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OOPBlog`.`tags` (
  `tagID` INT NOT NULL AUTO_INCREMENT,
  `tagName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tagID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OOPBlog`.`posts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OOPBlog`.`posts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` VARCHAR(45) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `body` TEXT(1000) NOT NULL,
  `people_authorID` INT NOT NULL,
  `tags_tagID` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_posts_people_idx` (`people_authorID` ASC),
  INDEX `fk_posts_tags1_idx` (`tags_tagID` ASC),
  CONSTRAINT `fk_posts_people`
    FOREIGN KEY (`people_authorID`)
    REFERENCES `OOPBlog`.`people` (`authorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_posts_tags1`
    FOREIGN KEY (`tags_tagID`)
    REFERENCES `OOPBlog`.`tags` (`tagID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
