-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-08-2021 a las 03:37:58
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gsw`
--
CREATE DATABASE IF NOT EXISTS `gsw` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `gsw`;

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `spBuscaProducto` (IN `nombre` VARCHAR(50))  BEGIN
	IF EXISTS (SELECT prd_cve_producto FROM PRODUCTO WHERE prd_nombreProducto LIKE concat('%', nombre, '%') AND prd_estado=1) THEN
    	SELECT P.prd_cve_producto CLAVE, P.prd_nombreProducto ARTICULO, P.prd_presentacionProducto PRESENTACION, P.prd_precioVenta PRECIO, P.prd_foto FOTO, P.prd_fechaVencimientoProducto VENCIMIENTO  FROM PRODUCTO P WHERE P.prd_nombreProducto LIKE concat('%', nombre, '%') AND P.prd_estado=1;
    ELSE
    	SELECT "0" AS ID;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spConfiPedido` (IN `pedido` INT, IN `estado` INT)  NO SQL
BEGIN
	IF EXISTS (SELECT  A.ped_cve_pedido FROM PEDIDO A WHERE A.ped_estado = 2 AND A.ped_cve_pedido = pedido)
    THEN
    	SELECT "0" AS ID;
    ELSE
    	UPDATE PEDIDO SET ped_estado = estado
        WHERE ped_cve_pedido = pedido;
        SELECT "1" AS ID;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spConsCategoria` (IN `op` INT, IN `inicioPag` INT, IN `numReg` INT)  BEGIN
	IF op=0 THEN
    	SELECT C.cat_cve_categoria Clave, C.cat_nombre Categoria, C.cat_estado Activo
    	FROM CATEGORIA C 
        WHERE C.cat_estado=1
        ORDER BY Clave;
    ELSEIF op=1 THEN
    	SELECT C.cat_cve_categoria Clave, C.cat_nombre Categoria, C.cat_estado Activo
    	FROM CATEGORIA C 
        WHERE C.cat_estado=1
        ORDER BY Clave
        LIMIT inicioPag, numReg;
    ELSEIF op=2 THEN
    	SELECT C.cat_cve_categoria Clave, C.cat_nombre Categoria, C.cat_estado Activo
    	FROM CATEGORIA C 
        WHERE C.cat_estado=0
        ORDER BY Clave;
    ELSE
    	SELECT C.cat_cve_categoria Clave, C.cat_nombre Categoria, C.cat_estado Activo
    	FROM CATEGORIA C 
        WHERE C.cat_estado=0
        ORDER BY Clave
        LIMIT inicioPag, numReg;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spConsPedido` ()  NO SQL
BEGIN
    	SELECT 	A.ped_cve_pedido CLAVE, CONCAT(U.usu_nombrePila, ' ', U.usu_nombrePaterno, ' ', U.usu_nombreMaterno) NOMBRE, A.ped_fecha FECHA, A.ped_estado ESTADO
    	FROM    PEDIDO A, USUARIO U
        WHERE	U.usu_cve_usuario = A.usu_cve_usuario 
        ORDER BY CLAVE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spConsProducto` (IN `op` INT, IN `inicioPag` INT, IN `numReg` INT)  BEGIN
	IF op=0 THEN
    	SELECT 	A.prd_cve_producto CLAVE, A.prd_nombreProducto NOMBRE, A.prd_presentacionProducto PRESENTACION, A.prd_cantidadProducto CANTIDAD, A.prd_fechaVencimientoProducto CADUCIDAD, A.prd_precioVenta PRECIO_VENTA, A.prd_precioAdquisicion PRECIO_ADQUISICION, A.prd_foto FOTO, A.pro_cve_proveedor SURTIDOR, A.usu_cve_usuario EMPLEADO, A.prd_estado ACTIVO
    	FROM    PRODUCTO A
        WHERE	A.prd_estado = 1
        ORDER BY CLAVE;
    ELSEIF op=1 THEN
        SELECT 	A.prd_cve_producto CLAVE, A.prd_nombreProducto NOMBRE, A.prd_presentacionProducto PRESENTACION, A.prd_cantidadProducto CANTIDAD, A.prd_fechaVencimientoProducto CADUCIDAD, A.prd_precioVenta PRECIO_VENTA, A.prd_precioAdquisicion PRECIO_ADQUISICION, A.prd_foto FOTO, PRO.pro_nombreEmpresa SURTIDOR, A.usu_cve_usuario EMPLEADO, A.prd_estado ACTIVO
    	FROM    PRODUCTO A, PROVEEDOR PRO
        WHERE	A.prd_estado = 1 AND A.pro_cve_proveedor=PRO.pro_cve_proveedor
        ORDER BY CLAVE
     	LIMIT inicioPag, numReg;
	ELSEIF op=2 THEN
    	SELECT 	A.prd_cve_producto CLAVE, A.prd_nombreProducto NOMBRE, A.prd_presentacionProducto PRESENTACION, A.prd_cantidadProducto CANTIDAD, A.prd_fechaVencimientoProducto CADUCIDAD, A.prd_precioVenta PRECIO_VENTA, A.prd_precioAdquisicion PRECIO_ADQUISICION, A.prd_foto FOTO, A.pro_cve_proveedor SURTIDOR, A.usu_cve_usuario EMPLEADO, A.prd_estado ACTIVO
    	FROM    PRODUCTO A
        WHERE	A.prd_estado = 0
        ORDER BY CLAVE;
    ELSE
        SELECT 	A.prd_cve_producto CLAVE, A.prd_nombreProducto NOMBRE, A.prd_presentacionProducto PRESENTACION, A.prd_cantidadProducto CANTIDAD, A.prd_fechaVencimientoProducto CADUCIDAD, A.prd_precioVenta PRECIO_VENTA, A.prd_precioAdquisicion PRECIO_ADQUISICION, A.prd_foto FOTO, A.pro_cve_proveedor SURTIDOR, A.usu_cve_usuario EMPLEADO, A.prd_estado ACTIVO
    	FROM    PRODUCTO A
        WHERE	A.prd_estado = 0
        ORDER BY CLAVE
     	LIMIT inicioPag, numReg;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spConsProveedor` (IN `op` INT, IN `inicioPag` INT, IN `numReg` INT)  BEGIN
	IF op=0 THEN
    	SELECT 	A.pro_cve_proveedor CLAVE, CONCAT(A.pro_nombrePila, ' ', A.pro_nombrePaterno, ' ', A.pro_nombreMaterno) NOMBRE, A.pro_nombreEmpresa EMPRESA, A.pro_numeroTelefono CONTACTO, A.pro_correoArea CORREO, A.pro_numeroSupervisor CONTACTO_SUPERVISOR, A.pro_estado ACTIVO
    	FROM    PROVEEDOR A
        WHERE	A.pro_estado = 1
        ORDER BY CLAVE;
    ELSEIF op=1 THEN
        SELECT 	A.pro_cve_proveedor CLAVE, CONCAT(A.pro_nombrePila, ' ', A.pro_nombrePaterno, ' ', A.pro_nombreMaterno) NOMBRE, A.pro_nombreEmpresa EMPRESA, A.pro_numeroTelefono CONTACTO, A.pro_correoArea CORREO, A.pro_numeroSupervisor CONTACTO_SUPERVISOR, A.pro_estado ACTIVO
    	FROM    PROVEEDOR A
        WHERE	A.pro_estado = 1
        ORDER BY CLAVE
     	LIMIT inicioPag, numReg;
	ELSEIF op=2 THEN
    	SELECT 	A.pro_cve_proveedor CLAVE, CONCAT(A.pro_nombrePila, ' ', A.pro_nombrePaterno, ' ', A.pro_nombreMaterno) NOMBRE, A.pro_nombreEmpresa EMPRESA, A.pro_numeroTelefono CONTACTO, A.pro_correoArea CORREO, A.pro_numeroSupervisor CONTACTO_SUPERVISOR, A.pro_estado ACTIVO
    	FROM    PROVEEDOR A
        WHERE	A.pro_estado = 0
        ORDER BY CLAVE;
    ELSE
        SELECT 	A.pro_cve_proveedor CLAVE, CONCAT(A.pro_nombrePila, ' ', A.pro_nombrePaterno, ' ', A.pro_nombreMaterno) NOMBRE, A.pro_nombreEmpresa EMPRESA, A.pro_numeroTelefono CONTACTO, A.pro_correoArea CORREO, A.pro_numeroSupervisor CONTACTO_SUPERVISOR, A.pro_estado ACTIVO
    	FROM    PROVEEDOR A
        WHERE	A.pro_estado = 0
        ORDER BY CLAVE
     	LIMIT inicioPag, numReg;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spConsRelacion` (IN `op` INT, IN `inicioPag` INT, IN `numReg` INT)  BEGIN
	IF op=0 THEN
    	SELECT 	A.prd_cat_cve CLAVE, A.prd_cve_producto ARTICULO, A.cat_cve_categoria GRUPO, A.prd_cat_ubicacion UBICACION, A.prd_cat_estado ACTIVO
    	FROM    PRD_CAT A
        WHERE	A.prd_cat_estado = 1
        ORDER BY CLAVE;
    ELSEIF op=1 THEN
        SELECT 	A.prd_cat_cve CLAVE, A.prd_cve_producto ARTICULO, A.cat_cve_categoria GRUPO, A.prd_cat_ubicacion UBICACION, A.prd_cat_estado ACTIVO
    	FROM    PRD_CAT A
        WHERE	A.prd_cat_estado = 1
        ORDER BY CLAVE
     	LIMIT inicioPag, numReg;
	ELSEIF op=2 THEN
    	SELECT 	A.prd_cat_cve CLAVE, A.prd_cve_producto ARTICULO, A.cat_cve_categoria GRUPO, A.prd_cat_ubicacion UBICACION, A.prd_cat_estado ACTIVO
    	FROM    PRD_CAT A
        WHERE	A.prd_cat_estado = 0
        ORDER BY CLAVE;
    ELSE
        SELECT 	A.prd_cat_cve CLAVE, A.prd_cve_producto ARTICULO, A.cat_cve_categoria GRUPO, A.prd_cat_ubicacion UBICACION, A.prd_cat_estado ACTIVO
    	FROM    PRD_CAT A
        WHERE	A.prd_cat_estado = 0
        ORDER BY CLAVE
     	LIMIT inicioPag, numReg;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spConsUsuario` (IN `op` INT, IN `inicioPag` INT, IN `numReg` INT)  BEGIN
	IF op=0 THEN
    	SELECT 	A.usu_cve_usuario CLAVE, CONCAT(A.usu_nombrePila, ' ', A.usu_nombrePaterno, ' ', A.usu_nombreMaterno) NOMBRE, A.usu_rol ROL, A.usu_perfil PERFIL, A.usu_pswd PWD, A.usu_numeroTelefono CONTACTO, A.usu_estado ACTIVO
    	FROM    USUARIO A
        WHERE	A.usu_estado = 1
        ORDER BY CLAVE;
    ELSEIF op=1 THEN
        SELECT 	A.usu_cve_usuario CLAVE, CONCAT(A.usu_nombrePila, ' ', A.usu_nombrePaterno, ' ', A.usu_nombreMaterno) NOMBRE, A.usu_rol ROL, A.usu_perfil PERFIL, A.usu_pswd PWD, A.usu_numeroTelefono CONTACTO, A.usu_estado ACTIVO
    	FROM    USUARIO A
        WHERE	A.usu_estado = 1
        ORDER BY CLAVE
     	LIMIT inicioPag, numReg;
	ELSEIF op=2 THEN
    	SELECT 	A.usu_cve_usuario CLAVE, CONCAT(A.usu_nombrePila, ' ', A.usu_nombrePaterno, ' ', A.usu_nombreMaterno) NOMBRE, A.usu_rol ROL, A.usu_perfil PERFIL, A.usu_pswd PWD, A.usu_numeroTelefono CONTACTO, A.usu_estado ACTIVO
    	FROM    USUARIO A
        WHERE	A.usu_estado = 0
        ORDER BY CLAVE;
    ELSE
        SELECT 	A.usu_cve_usuario CLAVE, CONCAT(A.usu_nombrePila, ' ', A.usu_nombrePaterno, ' ', A.usu_nombreMaterno) NOMBRE, A.usu_rol ROL, A.usu_perfil PERFIL, A.usu_pswd PWD, A.usu_numeroTelefono CONTACTO, A.usu_estado ACTIVO
    	FROM    USUARIO A
        WHERE	A.usu_estado = 0
        ORDER BY CLAVE
     	LIMIT inicioPag, numReg;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spDelCategoria` (IN `cve` INT)  BEGIN
	IF EXISTS(SELECT cat_nombre FROM CATEGORIA WHERE cat_cve_categoria=cve AND cat_estado=1) THEN
    	UPDATE CATEGORIA SET cat_estado = 0 WHERE cat_cve_categoria = cve;
        SELECT "1" AS ID;
    ELSE
    	SELECT "0" AS ID;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spDelProdPed` (IN `cve` INT, IN `cve_ped` INT)  NO SQL
BEGIN
    	IF EXISTS (SELECT PP.prd_cve_producto FROM PED_PRO PP WHERE PP.prd_cve_producto = cve AND PP.ped_cve_pedido = cve_ped)
        THEN
        DELETE FROM PED_PRO WHERE prd_cve_producto = cve AND ped_cve_pedido = cve_ped;
        SELECT "1" AS ID;
        ELSE
        SELECT "0" AS ID;
        END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spDelProducto` (IN `cve` INT)  BEGIN
	IF EXISTS (SELECT prd_cve_producto FROM PRODUCTO WHERE prd_cve_producto=cve AND prd_estado=1)THEN
    	UPDATE PRODUCTO SET prd_estado=0 WHERE prd_cve_producto=cve;
        SELECT "1" AS ID;
    ELSE
    	SELECT "0" AS ID;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spDelProveedor` (IN `cve` INT)  BEGIN
	IF EXISTS (SELECT pro_nombreEmpresa FROM PROVEEDOR WHERE pro_cve_proveedor=cve AND pro_estado=1)THEN
        UPDATE PROVEEDOR SET pro_estado=0 WHERE pro_cve_proveedor=cve;
        SELECT "1" AS ID;
    ELSE
    	SELECT "0" AS ID;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spDelRelacion` (IN `cve` INT)  BEGIN
	IF EXISTS(SELECT prd_cat_cve FROM PRD_CAT WHERE prd_cat_cve=cve AND prd_cat_estado=1)THEN
    	UPDATE PRD_CAT SET prd_cat_estado=0 WHERE prd_cat_cve=cve;
        SELECT "1" AS ID;
    ELSE
    	SELECT "0" AS ID;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spDelUsuario` (IN `cve` INT)  BEGIN
	IF EXISTS (SELECT usu_nombrePila FROM USUARIO WHERE usu_cve_usuario=cve AND usu_estado=1)THEN
        UPDATE USUARIO SET usu_estado=0 WHERE usu_cve_usuario=cve;
        SELECT "1" AS ID;
    ELSE
    	SELECT "0" AS ID;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetCategori` (IN `cve` INT)  BEGIN
	SELECT P.cat_cve_categoria CATEGORIA_P, C.cat_nombre CATEGORIA_N, P.prd_ubicacion UBICACION 
    FROM PRODUCTO P, CATEGORIA C
    WHERE P.prd_cve_producto=cve AND P.cat_cve_categoria=C.cat_cve_categoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsCategoria` (IN `nombre` VARCHAR(50))  BEGIN
	IF EXISTS(SELECT cat_nombre FROM CATEGORIA WHERE cat_nombre=nombre) THEN
    	SELECT "0" AS ID;
    ELSE
    	INSERT INTO CATEGORIA VALUES (0, nombre, 1);
    	SELECT "1" AS ID;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsPedido` (IN `usuario` INT)  NO SQL
BEGIN
	INSERT INTO PEDIDO VALUES (NULL, usuario, 0, now());
    	SELECT MAX(ped_cve_pedido) AS ID, (SELECT ped_fecha AS FECHA  WHERE ped_cve_pedido = MAX(ped_cve_pedido)) AS FECHA FROM PEDIDO LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsProdPed` (IN `pedido` INT, IN `articulo` INT, IN `cantidad` FLOAT, IN `fecha` DATE)  NO SQL
BEGIN
	IF EXISTS (SELECT PP.ped_cve_pedido, PP.prd_cve_producto FROM PED_PRO PP WHERE PP.ped_cve_pedido = pedido AND PP.prd_cve_producto = articulo)
    THEN
    	SELECT "0" AS ID;
	ELSE
    	INSERT INTO PED_PRO VALUES (pedido, articulo, fecha, cantidad, null);
    	SELECT "1" AS ID;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsProducto` (IN `proveedor` INT, IN `presentacion` VARCHAR(20), IN `nombre` VARCHAR(50), IN `cantidad` FLOAT, IN `caducidad` TIMESTAMP, IN `usuario` INT, IN `venta` FLOAT, IN `adquisicion` FLOAT, IN `foto` VARCHAR(150), IN `categoria` INT, IN `ubicacion` TEXT)  BEGIN
	IF EXISTS (SELECT prd_cve_producto FROM PRODUCTO WHERE prd_nombreProducto=nombre AND prd_presentacionProducto=presentacion)THEN
    	SELECT "0" AS ID;
    ELSE
    	IF (EXISTS (SELECT p.pro_cve_proveedor FROM PROVEEDOR p WHERE p.pro_cve_proveedor = proveedor) AND EXISTS (SELECT u.usu_cve_usuario FROM USUARIO u WHERE u.usu_cve_usuario = usuario)) THEN
    		INSERT INTO PRODUCTO VALUES (0, proveedor, presentacion, nombre, cantidad, caducidad, usuario, venta, adquisicion, foto, 1, ubicacion, categoria);
        	SELECT "1" AS ID;
        ELSE
        	SELECT "-1" AS ID;
        END IF;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsProveedor` (IN `empresa` VARCHAR(100), IN `telefonosuper` VARCHAR(15), IN `telefono` VARCHAR(15), IN `correo` VARCHAR(50), IN `nombre` VARCHAR(50), IN `paterno` VARCHAR(50), IN `materno` VARCHAR(50))  BEGIN
	IF EXISTS (SELECT pro_cve_proveedor FROM PROVEEDOR WHERE pro_nombreEmpresa=empresa)THEN
    	SELECT "0" AS ID;
    ELSE
    	INSERT INTO PROVEEDOR VALUES (0, empresa, telefonosuper, telefono, correo, nombre, paterno, materno, 1);
        SELECT "1" AS ID;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsRelacion` (IN `producto` INT, IN `categoria` INT, IN `ubicacion` VARCHAR(100))  BEGIN
	IF EXISTS (SELECT P.prd_cve_producto FROM PRODUCTO P, CATEGORIA C WHERE P.prd_cve_producto=producto AND C.cat_cve_categoria=categoria)THEN
    	IF EXISTS(SELECT PC.prd_cat_cve FROM PRD_CAT PC WHERE PC.prd_cve_producto=producto AND PC.cat_cve_categoria=categoria) THEN
        	SELECT "0" AS ID;
        ELSE
        	INSERT INTO PRD_CAT VALUES (0, categoria, producto, ubicacion, 1);
            SELECT "1" AS ID;
        END IF;
    ELSE
        SELECT "2" AS ID;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsUsuario` (IN `nombre` VARCHAR(50), IN `paterno` VARCHAR(50), IN `materno` VARCHAR(50), IN `telefono` VARCHAR(15), IN `perfil` VARCHAR(50), IN `pswd` VARCHAR(50), IN `rol` VARCHAR(50))  BEGIN
	IF EXISTS (SELECT usu_nombrePila FROM USUARIO WHERE usu_perfil=perfil)THEN
    	SELECT "-1" AS ID;
    ELSE
    	IF EXISTS (SELECT usu_nombrePila FROM USUARIO WHERE usu_pswd=pswd)THEN
        	SELECT "0" AS ID;
        ELSE
        	INSERT INTO USUARIO VALUES (0, nombre, paterno, materno, telefono, perfil, pswd, rol, 1);
            SELECT "1" AS ID;
        END IF;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spModCategoria` (IN `cve` INT, IN `nombre` VARCHAR(50), IN `estado` INT)  BEGIN
	IF EXISTS(SELECT cat_nombre FROM CATEGORIA WHERE cat_cve_categoria=cve) THEN
    	UPDATE CATEGORIA SET cat_nombre = nombre, cat_estado = estado WHERE cat_cve_categoria = cve;
        SELECT "1" AS ID;
    ELSE
    	SELECT "0" AS ID;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spModPedPro` (IN `pedido` INT, IN `articulo` INT, IN `fechacad` DATE, IN `cantidad` FLOAT, IN `precio` FLOAT)  NO SQL
BEGIN
	UPDATE PED_PRO SET ped_pro_fechaCaducidad = fechacad, ped_pro_cantidad = cantidad, ped_pro_precio_adquisicion = precio
    WHERE ped_cve_pedido = pedido AND prd_cve_producto = articulo;
    
    UPDATE PRODUCTO SET prd_cantidadProducto = (prd_cantidadProducto + cantidad), prd_fechaVencimientoProducto = fechacad, prd_precioAdquisicion = precio, prd_estado = 1
   	WHERE prd_cve_producto = articulo;
    SELECT "1" AS ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spModProducto` (IN `cve` INT, IN `proveedor` INT, IN `presentacion` VARCHAR(50), IN `nombre` VARCHAR(50), IN `cantidad` FLOAT, IN `caducidad` TIMESTAMP, IN `usuario` INT, IN `venta` FLOAT, IN `adquisicion` FLOAT, IN `foto` VARCHAR(150), IN `estado` INT, IN `ubicacion` TEXT, IN `categoria` INT)  SP: BEGIN
	IF EXISTS (SELECT prd_cve_producto FROM PRODUCTO WHERE prd_cve_producto=cve)THEN
    	IF proveedor IS NOT NULL THEN
        	IF EXISTS (SELECT p.pro_cve_proveedor FROM PROVEEDOR p WHERE p.pro_cve_proveedor = proveedor) THEN
                UPDATE PRODUCTO SET pro_cve_proveedor = proveedor WHERE prd_cve_producto=cve;
             ELSE
             	SELECT "3" AS ID;
                LEAVE SP;
             END IF;
        END IF;
        IF presentacion != "" THEN
        	IF nombre != "" THEN
            	IF EXISTS (SELECT prd_cve_producto FROM PRODUCTO WHERE prd_presentacionProducto=presentacion AND prd_nombreProducto=nombre AND prd_cve_producto != cve)THEN
            		SELECT "2" AS ID;
                    LEAVE SP;
            	ELSE
            		UPDATE PRODUCTO SET prd_presentacionProducto = presentacion, prd_nombreProducto=nombre WHERE prd_cve_producto=cve;
            	END IF;
            ELSE
            	IF EXISTS (SELECT prd_cve_producto FROM PRODUCTO WHERE (SELECT prd_nombreProducto FROM PRODUCTO WHERE prd_cve_producto=cve) = prd_nombreProducto AND prd_presentacionProducto=presentacion AND prd_cve_producto != cve) THEN
                	SELECT "2" AS ID;
                    LEAVE SP;
                ELSE
                	UPDATE PRODUCTO SET prd_presentacionProducto = presentacion WHERE prd_cve_producto=cve;
                END IF;
            END IF;
        END IF;
        IF nombre != "" THEN
        	IF presentacion = "" THEN
            	IF EXISTS (SELECT prd_cve_producto FROM PRODUCTO WHERE (SELECT prd_presentacionProducto FROM PRODUCTO WHERE prd_cve_producto=cve) = prd_presentacionProducto AND prd_nombreProducto=nombre AND prd_cve_producto != cve) THEN
                	SELECT "2" AS ID;
                    LEAVE SP;
                ELSE
                	UPDATE PRODUCTO SET prd_nombreProducto = nombre WHERE prd_cve_producto=cve;
                END IF;
            END IF;
        END IF;
        IF cantidad IS NOT NULL THEN
        	UPDATE PRODUCTO SET prd_cantidadProducto = cantidad WHERE prd_cve_producto=cve;
        END IF;
        IF caducidad != "" THEN
        	UPDATE PRODUCTO SET prd_fechaVencimientoProducto = caducidad WHERE prd_cve_producto=cve;
        END IF;
        IF usuario IS NOT NULL THEN
            IF EXISTS (SELECT u.usu_cve_usuario FROM USUARIO u WHERE u.usu_cve_usuario = usuario) THEN
                UPDATE PRODUCTO SET usu_cve_usuario = usuario WHERE prd_cve_producto=cve;
            ELSE
            	SELECT "3" AS ID;
                LEAVE SP;
            END IF;
        END IF;
        IF venta IS NOT NULL THEN
        	UPDATE PRODUCTO SET prd_precioVenta = venta WHERE prd_cve_producto=cve;
        END IF;
        IF adquisicion IS NOT NULL THEN
        	UPDATE PRODUCTO SET prd_precioAdquisicion = adquisicion WHERE prd_cve_producto=cve;
        END IF;
        IF foto != "" THEN
        	UPDATE PRODUCTO SET prd_foto = foto WHERE prd_cve_producto=cve;
        END IF;
        IF estado IS NOT NULL THEN
        	UPDATE PRODUCTO SET prd_estado = estado WHERE prd_cve_producto=cve;
        END IF;
        IF categoria IS NOT NULL THEN
        	
        UPDATE PRODUCTO SET cat_cve_categoria = categoria WHERE prd_cve_producto=cve;
      
        END IF;
        UPDATE PRODUCTO SET prd_ubicacion = ubicacion WHERE prd_cve_producto = cve;
        SELECT "1" AS ID;
    ELSE
    	SELECT "0" AS ID;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spModProveedor` (IN `cve` INT, IN `empresa` VARCHAR(100), IN `telefonosuper` VARCHAR(15), IN `telefono` VARCHAR(15), IN `correo` VARCHAR(50), IN `nombre` VARCHAR(50), IN `paterno` VARCHAR(50), IN `materno` VARCHAR(50), IN `estado` INT)  SP: BEGIN
	SET FOREIGN_KEY_CHECKS=0;
	IF EXISTS (SELECT pro_nombreEmpresa FROM PROVEEDOR WHERE pro_cve_proveedor=cve)THEN
    	IF empresa != "" THEN
        	IF EXISTS (SELECT pro_nombreEmpresa FROM PROVEEDOR WHERE pro_nombreEmpresa=empresa AND pro_cve_proveedor!=cve) THEN
            	SELECT "2" AS ID;
                LEAVE SP;
            ELSE
            	UPDATE PROVEEDOR SET pro_nombreEmpresa=empresa WHERE pro_cve_proveedor=cve;
            END IF;
        END IF;
        IF telefonosuper != "" THEN
        	UPDATE PROVEEDOR SET pro_numeroSupervisor=telefonosuper WHERE pro_cve_proveedor=cve;
        END IF;
        IF telefono != "" THEN
        	UPDATE PROVEEDOR SET pro_numeroTelefono=telefono WHERE pro_cve_proveedor=cve;
        END IF;
        IF correo != "" THEN
        	UPDATE PROVEEDOR SET pro_correoArea=correo WHERE pro_cve_proveedor=cve;
        END IF;
        IF nombre != "" THEN
        	UPDATE PROVEEDOR SET pro_nombrePila=nombre WHERE pro_cve_proveedor=cve;
        END IF;
        IF paterno != "" THEN
        	UPDATE PROVEEDOR SET pro_nombrePaterno=paterno WHERE pro_cve_proveedor=cve;
        END IF;
        IF materno != "" THEN
        	UPDATE PROVEEDOR SET pro_nombreMaterno=materno WHERE pro_cve_proveedor=cve;
        END IF;
        IF estado IS NOT NULL THEN
        	UPDATE PROVEEDOR SET pro_estado=estado WHERE pro_cve_proveedor=cve;
        END IF;
        
        SELECT "1" AS ID;
    ELSE
    	SELECT "0" AS ID;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spModRelacion` (IN `cve` INT, IN `producto` INT, IN `categoria` INT, IN `ubicacion` VARCHAR(100), IN `estado` INT)  SP: BEGIN
	IF EXISTS(SELECT PC.prd_cat_cve 
              FROM PRD_CAT PC
              WHERE cve=PC.prd_cve_producto AND PC.prd_cat_estado=1)THEN
    	IF producto IS NOT NULL THEN
        	IF EXISTS (SELECT prd_cve_producto FROM PRODUCTO WHERE prd_cve_producto=producto)THEN
            	UPDATE PRD_CAT SET prd_cve_producto=producto WHERE prd_cve_producto=cve;
            ELSE
            	SELECT "2" AS ID;
                LEAVE SP;
            END IF;
        END IF;
        IF categoria IS NOT NULL THEN
        	IF EXISTS(SELECT cat_cve_categoria from CATEGORIA WHERE cat_cve_categoria=categoria)THEN
            	UPDATE PRD_CAT SET cat_cve_categoria=categoria WHERE prd_cve_producto=cve;
            ELSE
            	SELECT "2" AS ID;
                LEAVE SP;
            END IF;
        END IF;
        IF ubicacion != "" THEN
        	UPDATE PRD_CAT SET prd_cat_ubicacion= ubicacion WHERE prd_cve_producto=cve;
        END IF;
        IF estado IS NOT NULL THEN
        	UPDATE PRD_CAT SET prd_cat_estado= estado WHERE prd_cve_producto=cve;
        END IF;
        SELECT "1" AS ID;
    ELSE
    	SELECT "0" AS ID;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spModUsuario` (IN `cve` INT, IN `nombre` VARCHAR(50), IN `paterno` VARCHAR(50), IN `materno` VARCHAR(50), IN `telefono` VARCHAR(15), IN `perfil` VARCHAR(50), IN `pswd` VARCHAR(50), IN `rol` VARCHAR(50), IN `estado` INT)  SP: BEGIN
	IF EXISTS (SELECT usu_nombrePila FROM USUARIO WHERE usu_cve_usuario=cve)THEN
    	IF nombre != "" THEN
        	UPDATE USUARIO SET usu_nombrePila=nombre WHERE usu_cve_usuario=cve;
        END IF;
        IF paterno != "" THEN
        	UPDATE USUARIO SET usu_nombrePaterno=paterno WHERE usu_cve_usuario=cve;
        END IF;
        IF materno != "" THEN
        	UPDATE USUARIO SET usu_nombreMaterno=materno WHERE usu_cve_usuario=cve;
        END IF;
        IF telefono != "" THEN
        	UPDATE USUARIO SET usu_numeroTelefono=telefono WHERE usu_cve_usuario=cve;
        END IF;
        IF perfil != "" THEN
        	IF EXISTS (SELECT usu_cve_usuario FROM USUARIO WHERE usu_perfil=perfil AND usu_cve_usuario!=cve)THEN
            	SELECT "2" AS ID;
                LEAVE SP;
            ELSE
            	UPDATE USUARIO SET usu_perfil=perfil WHERE usu_cve_usuario=cve;
            END IF;
        END IF;
        IF pswd != "" THEN
        	IF EXISTS (SELECT usu_cve_usuario FROM USUARIO WHERE usu_pswd=pswd AND usu_cve_usuario!=cve)THEN
            	SELECT "3" AS ID;
                LEAVE SP;
            ELSE
            	UPDATE USUARIO SET usu_pswd=pswd WHERE usu_cve_usuario=cve;
            END IF;
        END IF;
        IF rol != "" THEN
        	UPDATE USUARIO SET usu_rol=rol WHERE usu_cve_usuario=cve;
        END IF;
        IF estado IS NOT NULL THEN
        	UPDATE USUARIO SET usu_estado=estado WHERE usu_cve_usuario=cve;
        END IF;
        
        SELECT "1" AS ID;
    ELSE
    	SELECT "0" AS ID;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spReportesPDF` (IN `op` INT)  BEGIN
IF (op = 0) THEN
	SELECT P.prd_nombreProducto PRODUCTO, P.prd_presentacionProducto PRESENTACION, P.prd_cantidadProducto CANTIDAD,
    	   P.prd_fechaVencimientoProducto VENCIMIENTO, (SELECT PRO.pro_nombreEmpresa PROVEEDOR FROM PROVEEDOR PRO WHERE PRO.pro_cve_proveedor = P.pro_cve_proveedor) PROVEEDOR, P.prd_precioAdquisicion PRECIO_ADQUISICION, P.prd_foto FOTO
    FROM PRODUCTO P, CATEGORIA C 
    WHERE C.cat_cve_categoria = P.cat_cve_categoria AND P.prd_estado = 1
    ORDER BY P.prd_cantidadProducto ASC;
ELSEIF (op = 1) THEN
        SELECT P.prd_nombreProducto PRODUCTO, P.prd_presentacionProducto PRESENTACION, P.prd_cantidadProducto CANTIDAD,
    	   P.prd_fechaVencimientoProducto VENCIMIENTO, (SELECT PRO.pro_nombreEmpresa PROVEEDOR FROM PROVEEDOR PRO WHERE PRO.pro_cve_proveedor = P.pro_cve_proveedor) PROVEEDOR, P.prd_precioAdquisicion PRECIO_ADQUISICION, P.prd_foto FOTO
    FROM PRODUCTO P, CATEGORIA C
    WHERE P.cat_cve_categoria = 4 AND C.cat_cve_categoria = P.cat_cve_categoria AND P.prd_estado = 1
    ORDER BY P.prd_cantidadProducto ASC;
	ELSEIF (op = 2) THEN
    	SELECT P.prd_nombreProducto PRODUCTO, P.prd_presentacionProducto PRESENTACION, P.prd_cantidadProducto CANTIDAD,
    	   P.prd_fechaVencimientoProducto VENCIMIENTO, (SELECT PRO.pro_nombreEmpresa PROVEEDOR FROM PROVEEDOR PRO WHERE PRO.pro_cve_proveedor = P.pro_cve_proveedor) PROVEEDOR, P.prd_precioAdquisicion PRECIO_ADQUISICION, P.prd_foto FOTO
    FROM PRODUCTO P, CATEGORIA C
    WHERE P.cat_cve_categoria = 1 AND C.cat_cve_categoria = 1 AND P.prd_estado = 1
    ORDER BY P.prd_cantidadProducto ASC;
    ELSEIF (op = 3) THEN
    	SELECT P.prd_nombreProducto PRODUCTO, P.prd_presentacionProducto PRESENTACION, P.prd_cantidadProducto CANTIDAD,
    	   P.prd_fechaVencimientoProducto VENCIMIENTO, (SELECT PRO.pro_nombreEmpresa PROVEEDOR FROM PROVEEDOR PRO WHERE PRO.pro_cve_proveedor = P.pro_cve_proveedor) PROVEEDOR, P.prd_precioAdquisicion PRECIO_ADQUISICION, P.prd_foto FOTO
    FROM PRODUCTO P, CATEGORIA C
    WHERE P.cat_cve_categoria = C.cat_cve_categoria AND P.prd_fechaVencimientoProducto <= date_add(now(), INTERVAL 1 MONTH) AND P.prd_fechaVencimientoProducto >= now() AND P.prd_estado = 1
    ORDER BY P.prd_cantidadProducto ASC;
    ELSE
    SELECT P.prd_nombreProducto PRODUCTO, P.prd_presentacionProducto PRESENTACION, P.prd_cantidadProducto CANTIDAD,
    	   P.prd_fechaVencimientoProducto VENCIMIENTO, (SELECT PRO.pro_nombreEmpresa PROVEEDOR FROM PROVEEDOR PRO WHERE PRO.pro_cve_proveedor = P.pro_cve_proveedor) PROVEEDOR, P.prd_precioAdquisicion PRECIO_ADQUISICION, P.prd_foto FOTO
    FROM PRODUCTO P, CATEGORIA C
    WHERE P.cat_cve_categoria = C.cat_cve_categoria AND P.prd_fechaVencimientoProducto <= now() AND P.prd_estado = 1
    ORDER BY P.prd_cantidadProducto ASC;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spSelecProduc` (IN `cat` INT)  NO SQL
BEGIN
	SELECT p.prd_cve_producto CLAVE, CONCAT(p.prd_nombreProducto, ' ', p.prd_presentacionProducto) ARTICULO
    FROM producto p
    WHERE p.cat_cve_categoria = cat;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spSelectProducto` (IN `categoria` INT)  NO SQL
BEGIN
	SELECT P.prd_cve_producto, CONCAT(P.prd_nombreProducto, ' ', P.prd_presentacionProducto) FROM PRODUCTO P WHERE P.cat_cve_categoria = categoria;    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spTraCategoria` (IN `cve` INT)  BEGIN
	SELECT U.cat_nombre NOMBRE,  U.cat_estado ESTADO 
    FROM CATEGORIA U
    WHERE U.cat_cve_categoria=cve;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spTraProducto` (IN `cve` INT)  BEGIN
	IF EXISTS(SELECT * FROM PRODUCTO WHERE prd_cve_producto=cve)THEN
    	SELECT P.pro_cve_proveedor SURTIDOR, P.prd_presentacionProducto PRESENTACION, P.prd_nombreProducto ARTICULO, P.prd_cantidadProducto CANTIDAD, P.prd_fechaVencimientoProducto CADUCIDAD, P.usu_cve_usuario EMPLEADO, P.prd_precioVenta VENTA, P.prd_precioAdquisicion ADQUISICION, P.prd_foto FOTO, P.prd_estado ESTADO FROM PRODUCTO P WHERE P.prd_cve_producto=cve;
    ELSE
    	SELECT "0" AS ID;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spTraProveedor` (IN `cve` INT)  BEGIN
	IF EXISTS(SELECT * FROM PROVEEDOR WHERE pro_cve_proveedor=cve)THEN
    	SELECT P.pro_correoArea CORREO, P.pro_nombreEmpresa EMPRESA, P.pro_nombrePila NOMBRE, P.pro_nombrePaterno PATERNO, P.pro_nombreMaterno MATERNO, P.pro_numeroTelefono TELEFONO, P.pro_numeroSupervisor TELEFONO_SUPERVISOR, P.pro_estado ESTADO FROM PROVEEDOR P WHERE P.pro_cve_proveedor=cve;
    ELSE
    	SELECT "0" AS ID;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spTraUsuario` (IN `cve` INT)  BEGIN
	SELECT U.usu_nombrePila NOMBRE, U.usu_nombrePaterno PATERNO, U.usu_nombreMaterno MATERNO, U.usu_numeroTelefono TELEFONO, U.usu_perfil PERFIL, U.usu_pswd PASS, U.usu_rol ROL, U.usu_estado ESTADO 
    FROM USUARIO U
    WHERE U.usu_cve_usuario=cve;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spUltProducto` ()  BEGIN
	SELECT MAX(prd_cve_producto) AS id FROM PRODUCTO;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spValidarAcceso` (IN `usuario` VARCHAR(50), IN `contra` VARCHAR(50))  BEGIN 
	IF EXISTS (SELECT * FROM USUARIO A WHERE A.usu_perfil = usuario AND A.usu_pswd = contra) THEN
    	SELECT U.usu_cve_usuario CLAVE,
        	   CONCAT (U.usu_nombrePila, " ", U.usu_nombrePaterno, " ", U.usu_nombreMaterno) USUARIO, 
               U.usu_rol ROL
        FROM USUARIO U
        WHERE	U.usu_perfil = usuario
        AND 	U.usu_pswd = contra; 
	ELSE 
    	SELECT "0" CLAVE;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spVerPedido` (IN `cve` INT)  NO SQL
BEGIN
    	SELECT 	P.prd_cve_producto CLAVE, CONCAT(P.prd_nombreProducto, ' ', P.prd_presentacionProducto) NOMBRE, PP.ped_pro_cantidad CANTIDAD, p.prd_foto FOTO 
    	FROM    PRODUCTO P, PED_PRO PP
        WHERE	PP.ped_cve_pedido = cve
        AND 	PP.prd_cve_producto = P.prd_cve_producto
        ORDER BY CLAVE;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `cat_cve_categoria` int(11) NOT NULL,
  `cat_nombre` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `cat_estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`cat_cve_categoria`, `cat_nombre`, `cat_estado`) VALUES
(1, 'Gaseosas', 1),
(2, 'Panes', 1),
(3, 'Botanas', 1),
(4, 'Bebidas sin alcohol', 1),
(5, 'Lácteos', 1),
(6, 'Galletas', 1),
(7, 'Huevos', 1),
(8, 'Frutas y verduras', 1),
(9, 'Otros', 1),
(10, 'Papas y chicharrones', 1),
(11, 'Nueva', 0),
(12, 'Bebidas con alcohol', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `ped_cve_pedido` int(11) NOT NULL,
  `usu_cve_usuario` int(11) DEFAULT NULL,
  `ped_estado` tinyint(4) NOT NULL,
  `ped_fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`ped_cve_pedido`, `usu_cve_usuario`, `ped_estado`, `ped_fecha`) VALUES
(28, 3, 2, '2021-08-16'),
(29, 3, 2, '2021-08-16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ped_pro`
--

CREATE TABLE `ped_pro` (
  `ped_cve_pedido` int(11) NOT NULL,
  `prd_cve_producto` int(11) NOT NULL,
  `ped_pro_fechaCaducidad` date DEFAULT NULL,
  `ped_pro_cantidad` float DEFAULT NULL,
  `ped_pro_precio_adquisicion` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `ped_pro`
--

INSERT INTO `ped_pro` (`ped_cve_pedido`, `prd_cve_producto`, `ped_pro_fechaCaducidad`, `ped_pro_cantidad`, `ped_pro_precio_adquisicion`) VALUES
(28, 2, '2021-08-03', 1, 23),
(28, 3, '2021-08-04', 15, 12),
(28, 34, '2021-08-12', 1, 1),
(29, 2, '2021-08-17', 2, 14),
(29, 29, '2021-09-03', 2, 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `prd_cve_producto` int(11) NOT NULL,
  `pro_cve_proveedor` int(11) DEFAULT NULL,
  `prd_presentacionProducto` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `prd_nombreProducto` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `prd_cantidadProducto` float NOT NULL,
  `prd_fechaVencimientoProducto` date NOT NULL DEFAULT current_timestamp(),
  `usu_cve_usuario` int(11) NOT NULL,
  `prd_precioVenta` float NOT NULL,
  `prd_precioAdquisicion` float NOT NULL,
  `prd_foto` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prd_estado` int(11) NOT NULL,
  `prd_ubicacion` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `cat_cve_categoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`prd_cve_producto`, `pro_cve_proveedor`, `prd_presentacionProducto`, `prd_nombreProducto`, `prd_cantidadProducto`, `prd_fechaVencimientoProducto`, `usu_cve_usuario`, `prd_precioVenta`, `prd_precioAdquisicion`, `prd_foto`, `prd_estado`, `prd_ubicacion`, `cat_cve_categoria`) VALUES
(1, 1, 'Chiquita', 'coca-cola', 3.2, '2021-08-09', 3, 5, 10, 'productos/1.png', 0, 'Refri 4', 1),
(2, 2, 'Mediano', 'Pan Blanco', 3, '2021-08-17', 3, 36.6, 14, 'productos/2.png', 1, 'Exhibidor Lara', 2),
(3, 3, 'Bolsasa', 'Doritos', 185, '2021-08-04', 3, 25, 12, 'productos/3.png', 1, 'En casa de Efra', 3),
(4, 13, 'paquete 10 piezas', 'Tortillinas', 25, '2022-01-07', 3, 15, 111, 'productos/4.png', 1, 'Exhibidor Lara', 9),
(5, 13, '20 piezas', 'Tortillinas', 12, '2021-03-18', 3, 25, 20, 'productos/5.png', 1, 'Casa de Efra', 9),
(10, 11, 'bolsita 50gr', 'Takis', 10, '2021-03-17', 3, 12, 10, 'productos/takis_fuego.png', 1, 'Estante de botanas', 10),
(12, 8, 'rojo', 'jitomate', 30.8, '2021-04-27', 3, 7, 5.5, 'productos/jitomate.png', 1, 'Cajones de verduras', 8),
(28, 9, '1kg', 'Huevo', 25, '2021-09-22', 3, 26, 18, 'productos/600567-C00002HUE002.png', 1, 'Exhibidor Lara', 7),
(29, 8, '75 gr', 'Deliciosas', 22, '2021-09-03', 3, 15, 8, 'productos/deliciosas.png', 1, 'Exhibidor Lara', 6),
(30, 7, '1 litro Carta Blanca', 'Bacardi', 39, '2022-01-03', 3, 160, 100, 'productos/bacardi.png', 1, 'Exhibidor de vinos y licores', 12),
(31, 13, 'de 22', 'Tortillinas', 13, '2021-08-09', 3, 23.5, 10.5, 'productos/rollos.png', 1, 'Vitrina 4', 9),
(32, 10, 'De 150 kg', 'Marci J', 4, '2021-08-26', 3, 500, 12, 'productos/20150725_190344.jpg', 0, 'En casa de Efra', 9),
(33, 10, 'grande', 'Stitch', 7, '2021-08-31', 3, 5, 1, 'productos/untitled.png', 0, 'Depa del conejo de Efra', 6),
(34, 10, 'chulo', 'Dylan', 251, '2021-08-12', 1, 100000, 1, 'productos/stairwayFrom.jpg', 0, '', 9),
(35, 14, 'de 1 Lt', 'Leche Santa Clara', 25, '2021-10-20', 3, 15, 8, 'productos/santaClaraLitro.png', 1, 'Estante de lácteos', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `pro_cve_proveedor` int(11) NOT NULL,
  `pro_nombreEmpresa` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `pro_numeroSupervisor` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `pro_numeroTelefono` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `pro_correoArea` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `pro_nombrePila` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `pro_nombrePaterno` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `pro_nombreMaterno` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `pro_estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`pro_cve_proveedor`, `pro_nombreEmpresa`, `pro_numeroSupervisor`, `pro_numeroTelefono`, `pro_correoArea`, `pro_nombrePila`, `pro_nombrePaterno`, `pro_nombreMaterno`, `pro_estado`) VALUES
(1, 'Coca-Cola', '7717752588', '7717752571', '183110356@cocacola.mx', 'Marco Antonio', 'Vega', 'Mohedona', 1),
(2, 'Bimbo', '7717752584', '7717752574', '183110356@bimbo.mx', 'Antonio', 'Vega', 'Mohedona', 1),
(3, 'Sabritas', '77177525', '7717752574', '183110356@rikolino.mx', 'Marco', 'Torres', 'Mohedona', 1),
(4, 'Rikolino', '7911105636', '5521451', '183111323@rikolino.mx', 'Andrea', 'Arriaga', 'Resendis', 1),
(5, 'Bonafina', '2234456578', '8823341234', 'marci@bonafina.com', 'Marci', 'Mendoza', 'Arriaga', 1),
(6, 'LOL', '1', '1', 'Q@gmail.com', 'N', 'N', 'N', 1),
(7, 'Corpovino', '7752354421', '7726673464', 'jescalante@gmail.com', ' Jose Luis', 'Reyes', 'Escalante', 1),
(8, 'Lara', '5517762653', '7726678781', 'agomez@gmail.com', 'Angelica', 'Gomez', 'Trejo', 1),
(9, 'San Juan', '5516677876', '7716646278', 'sr@sanjuan.com', 'Rodolfo', 'Serrano', 'Luz', 1),
(10, 'NA', '1111111111', '111111112', 'na@na.com', 'NA', 'NA', 'NA', 0),
(11, 'Barcel', '5547766538', '9947727689', 'rjorge@gmail.com', 'Jorge', 'Rojas', 'Medina', 1),
(12, 'B', '456', '123', 'B@NO', 'B', 'B', 'B', 0),
(13, 'Tia Rosa', '771584652', '771584652', 'sAngelica@stigma.com', 'Angelica', 'Franco', 'Mendez', 1),
(14, 'Santa Clara', '7911103636', '7911105656', '183111323@santaclara.com', 'Isabel', 'Arriaga', 'Resendis', 1),
(15, 'Holanda', '7726578123', '7717745626', 'angel@bonafina.com', 'Angel', 'Mendoza', 'Arriaga', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `usu_cve_usuario` int(11) NOT NULL,
  `usu_nombrePila` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `usu_nombrePaterno` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `usu_nombreMaterno` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `usu_numeroTelefono` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `usu_perfil` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `usu_pswd` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `usu_rol` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `usu_estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`usu_cve_usuario`, `usu_nombrePila`, `usu_nombrePaterno`, `usu_nombreMaterno`, `usu_numeroTelefono`, `usu_perfil`, `usu_pswd`, `usu_rol`, `usu_estado`) VALUES
(1, 'Marco Antonio', 'Sanchez', 'Parra', '7713751344', 'mparras', 'MAVPITI7A', 'Empleado', 1),
(2, 'Marco', 'Parra', 'Mohedano', '7911065636', 'mmohedano', 'MVMITI7A', 'Empleado', 0),
(3, 'Dylan Michel', 'Mendoza', 'Hernandez', '7713212884', 'dmendoza', 'DMMHITI7A', 'Administrador', 1),
(4, 'Efrain', 'Mohedona', 'Torres', '7717752584', 'etorres', 'EMTITI7A', 'Administrador', 1),
(5, 'Angelica', 'Arriaga', 'Franco', '7911063655', 'afranco', 'AAFITI7A', 'Empleado', 0),
(6, 'Beatriz', 'Arriaga', 'Franco', '7911103318', 'bfranco', 'BAFITI7A', 'Administrador', 0),
(7, 'Andrea Lizbeth', 'Arriaga', 'Resendis', '7911103318', 'aresendis', 'ALARITI7A', 'Administrador', 1),
(8, 'Francisca', 'Arriaga', 'Parra', '715642', 'farriaga', '159357', 'Empleado', 0),
(9, 'Luis', 'Perez', 'Cruz', '7717752584', 'lperez', '123h2h2', 'Empleado', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`cat_cve_categoria`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`ped_cve_pedido`),
  ADD KEY `usu_cve_usuario` (`usu_cve_usuario`);

--
-- Indices de la tabla `ped_pro`
--
ALTER TABLE `ped_pro`
  ADD PRIMARY KEY (`ped_cve_pedido`,`prd_cve_producto`),
  ADD KEY `ped_pro_ibfk_2` (`prd_cve_producto`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`prd_cve_producto`),
  ADD KEY `pro_cve_proveedor` (`pro_cve_proveedor`),
  ADD KEY `usu_cve_usuario` (`usu_cve_usuario`),
  ADD KEY `PRODUCTO_ibfk_3` (`cat_cve_categoria`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`pro_cve_proveedor`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usu_cve_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `cat_cve_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `ped_cve_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `prd_cve_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `pro_cve_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `usu_cve_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`usu_cve_usuario`) REFERENCES `usuario` (`usu_cve_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ped_pro`
--
ALTER TABLE `ped_pro`
  ADD CONSTRAINT `ped_pro_ibfk_1` FOREIGN KEY (`ped_cve_pedido`) REFERENCES `pedido` (`ped_cve_pedido`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ped_pro_ibfk_2` FOREIGN KEY (`prd_cve_producto`) REFERENCES `producto` (`prd_cve_producto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `PRODUCTO_ibfk_1` FOREIGN KEY (`pro_cve_proveedor`) REFERENCES `proveedor` (`pro_cve_proveedor`),
  ADD CONSTRAINT `PRODUCTO_ibfk_2` FOREIGN KEY (`usu_cve_usuario`) REFERENCES `usuario` (`usu_cve_usuario`),
  ADD CONSTRAINT `PRODUCTO_ibfk_3` FOREIGN KEY (`cat_cve_categoria`) REFERENCES `categoria` (`cat_cve_categoria`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
