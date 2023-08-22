-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: base_datos_productos
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bodegas`
--

DROP TABLE IF EXISTS `bodegas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bodegas` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(145) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(145) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `imagenes`
--

DROP TABLE IF EXISTS `imagenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `imagenes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `imagen` varchar(145) DEFAULT NULL,
  `tamanho` varchar(145) DEFAULT NULL,
  `tipo_imagen_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_imagenes_tipos_imagenes1_idx` (`tipo_imagen_id`),
  CONSTRAINT `fk_imagenes_tipos_imagenes1` FOREIGN KEY (`tipo_imagen_id`) REFERENCES `tipos_imagenes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `precio` int DEFAULT NULL,
  `codigo_barra` varchar(45) DEFAULT NULL,
  `nombre` varchar(145) DEFAULT NULL,
  `imagen_id` int unsigned NOT NULL,
  `subcategoria_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_producto_imagenes_idx` (`imagen_id`),
  KEY `fk_producto_subcategorias1_idx` (`subcategoria_id`),
  CONSTRAINT `fk_producto_imagenes` FOREIGN KEY (`imagen_id`) REFERENCES `imagenes` (`id`),
  CONSTRAINT `fk_producto_subcategorias1` FOREIGN KEY (`subcategoria_id`) REFERENCES `subcategorias` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `producto_bodegas`
--

DROP TABLE IF EXISTS `producto_bodegas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto_bodegas` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `producto_id` int unsigned NOT NULL,
  `bodega_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_producto_has_bodegas_bodegas1_idx` (`bodega_id`),
  KEY `fk_producto_has_bodegas_producto1_idx` (`producto_id`),
  CONSTRAINT `fk_producto_has_bodegas_bodegas1` FOREIGN KEY (`bodega_id`) REFERENCES `bodegas` (`id`),
  CONSTRAINT `fk_producto_has_bodegas_producto1` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subcategorias`
--

DROP TABLE IF EXISTS `subcategorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subcategorias` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(145) DEFAULT NULL,
  `categoria_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_subcategorias_categorias1_idx` (`categoria_id`),
  CONSTRAINT `fk_subcategorias_categorias1` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipos_imagenes`
--

DROP TABLE IF EXISTS `tipos_imagenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_imagenes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(145) DEFAULT NULL,
  `con_transparencia` tinyint DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-20 23:28:38
