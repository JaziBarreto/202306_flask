-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema base_datos_productos
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema base_datos_productos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `base_datos_productos` DEFAULT CHARACTER SET utf8 ;
USE `base_datos_productos` ;

-- -----------------------------------------------------
-- Table `base_datos_productos`.`tipos_imagenes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `base_datos_productos`.`tipos_imagenes` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(145) NULL,
  `con_transparencia` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `base_datos_productos`.`imagenes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `base_datos_productos`.`imagenes` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `imagen` VARCHAR(145) NULL,
  `tamanio` INT NULL,
  `tipo_imagen_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_imagenes_tipos_imagenes1_idx` (`tipo_imagen_id` ASC) VISIBLE,
  CONSTRAINT `fk_imagenes_tipos_imagenes1`
    FOREIGN KEY (`tipo_imagen_id`)
    REFERENCES `base_datos_productos`.`tipos_imagenes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `base_datos_productos`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `base_datos_productos`.`categorias` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(145) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `base_datos_productos`.`subcategorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `base_datos_productos`.`subcategorias` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(145) NULL,
  `categoria_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_subcategorias_categorias1_idx` (`categoria_id` ASC) VISIBLE,
  CONSTRAINT `fk_subcategorias_categorias1`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `base_datos_productos`.`categorias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `base_datos_productos`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `base_datos_productos`.`productos` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(145) NULL,
  `precio` INT NULL,
  `codigo_barra` VARCHAR(45) NULL,
  `imagen_id` INT UNSIGNED NOT NULL,
  `subcategoria_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_productos_imagenes_idx` (`imagen_id` ASC) VISIBLE,
  INDEX `fk_productos_subcategorias1_idx` (`subcategoria_id` ASC) VISIBLE,
  CONSTRAINT `fk_productos_imagenes`
    FOREIGN KEY (`imagen_id`)
    REFERENCES `base_datos_productos`.`imagenes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_subcategorias1`
    FOREIGN KEY (`subcategoria_id`)
    REFERENCES `base_datos_productos`.`subcategorias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `base_datos_productos`.`bodegas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `base_datos_productos`.`bodegas` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(145) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `base_datos_productos`.`productos_bodegas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `base_datos_productos`.`productos_bodegas` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `producto_id` INT UNSIGNED NOT NULL,
  `bodega_id` INT UNSIGNED NOT NULL,
  `cantidad` INT NULL,
  `fecha_entrega` DATETIME NULL,
  INDEX `fk_productos_has_bodegas_bodegas1_idx` (`bodega_id` ASC) VISIBLE,
  INDEX `fk_productos_has_bodegas_productos1_idx` (`producto_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_productos_has_bodegas_productos1`
    FOREIGN KEY (`producto_id`)
    REFERENCES `base_datos_productos`.`productos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_has_bodegas_bodegas1`
    FOREIGN KEY (`bodega_id`)
    REFERENCES `base_datos_productos`.`bodegas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
