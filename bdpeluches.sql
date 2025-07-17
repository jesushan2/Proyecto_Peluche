-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-07-2025 a las 17:42:28
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bdpeluches`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_admin` (IN `id_in` INT, IN `nombres_in` VARCHAR(100), IN `apellidos_in` VARCHAR(100), IN `telefono_in` VARCHAR(20), IN `correo_in` VARCHAR(100))   BEGIN
    UPDATE administradores
    SET nombres = nombres_in,
        apellidos = apellidos_in,
        telefono = telefono_in,
        correo = correo_in
    WHERE id_admin = id_in;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_franquicia` (IN `id` INT, IN `nuevoNombre` VARCHAR(255), IN `estado` INT)   BEGIN
    UPDATE franquicias
    SET nombre_fran = nuevoNombre, estado_activo = estado
    WHERE id_franquicia = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_usuario` (IN `p_id` INT, IN `p_nombres` VARCHAR(100), IN `p_apellidos` VARCHAR(100), IN `p_telefono` VARCHAR(20), IN `p_correo` VARCHAR(100))   BEGIN
    UPDATE usuarios
    SET nombres = p_nombres,
        apellidos = p_apellidos,
        telefono = p_telefono,
        correo = p_correo
    WHERE id_usuario = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_vendedor` (IN `id_in` INT, IN `nombres_in` VARCHAR(100), IN `apellidos_in` VARCHAR(100), IN `telefono_in` VARCHAR(20), IN `correo_in` VARCHAR(100))   BEGIN
    UPDATE vendedores
    SET nombres = nombres_in,
        apellidos = apellidos_in,
        telefono = telefono_in,
        correo = correo_in
    WHERE id_vendedor = id_in;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_correo_admin_existe` (IN `correo_in` VARCHAR(100))   BEGIN
    SELECT id_admin FROM administradores WHERE correo = correo_in LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_correo_vendedor_existe` (IN `correo_in` VARCHAR(100))   BEGIN
    SELECT id_vendedor FROM vendedores WHERE correo = correo_in LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_desactivar_admin` (IN `id_in` INT)   BEGIN
    UPDATE administradores SET estado_activo = 0 WHERE id_admin = id_in;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_desactivar_producto` (IN `p_id_producto` INT)   BEGIN
    UPDATE productos SET estado_activo = 0 WHERE id_producto = p_id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_desactivar_reserva` (IN `pid` INT)   BEGIN
    UPDATE reservas SET estado_activo = 0 WHERE id_reserva = pid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_desactivar_usuario` (IN `p_id` INT)   BEGIN
    UPDATE usuarios
    SET estado_activo = 0
    WHERE id_usuario = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_desactivar_vendedor` (IN `id_in` INT)   BEGIN
    UPDATE vendedores SET estado_activo = 0 WHERE id_vendedor = id_in;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_producto` (IN `p_id_producto` INT, IN `p_id_franquicia` INT, IN `p_nombre_prod` VARCHAR(100), IN `p_descripcion` TEXT, IN `p_altura` VARCHAR(50), IN `p_color` VARCHAR(50), IN `p_stock` INT, IN `p_precio` DECIMAL(10,2), IN `p_imagen` VARCHAR(255))   BEGIN
    UPDATE productos SET 
        id_franquicia = p_id_franquicia,
        nombre_prod = p_nombre_prod,
        descripcion = p_descripcion,
        altura = p_altura,
        color = p_color,
        stock = p_stock,
        precio = p_precio,
        imagen = p_imagen
    WHERE id_producto = p_id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_reserva` (IN `pid_reserva` INT, IN `pid_estado_nuevo` INT, IN `pid_vendedor` INT)   BEGIN
    UPDATE reservas
    SET id_estado = pid_estado_nuevo,
        id_vendedor = IF(pid_vendedor = 0, NULL, pid_vendedor)
    WHERE id_reserva = pid_reserva;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_franquicia` (IN `id` INT)   BEGIN
    UPDATE franquicias SET estado_activo = 0 WHERE id_franquicia = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_admins_activos` ()   BEGIN
    SELECT * FROM administradores WHERE estado_activo = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_admin_por_id` (IN `id_in` INT)   BEGIN
    SELECT * FROM administradores WHERE id_admin = id_in;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_estados_reserva` ()   BEGIN
    SELECT * FROM estados_reserva;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_franquicias_activas` ()   BEGIN
    SELECT * FROM franquicias WHERE estado_activo = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_franquicia_por_id` (IN `id` INT)   BEGIN
    SELECT * FROM franquicias WHERE id_franquicia = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_historial_reserva` (IN `pid_reserva` INT)   BEGIN
    SELECT h.id_historial, 
           h.id_estado_anterior, 
           ea.nombre_est AS estado_anterior, 
           h.id_estado_nuevo, 
           en.nombre_est AS estado_nuevo, 
           h.fecha_cambio,
           a.nombres AS admin,
           v.nombres AS vendedor
    FROM historial_reservas h
    JOIN estados_reserva ea ON h.id_estado_anterior = ea.id_estado
    JOIN estados_reserva en ON h.id_estado_nuevo = en.id_estado
    LEFT JOIN administradores a ON h.id_admin = a.id_admin
    LEFT JOIN vendedores v ON h.id_vendedor = v.id_vendedor
    WHERE h.id_reserva = pid_reserva
    ORDER BY h.fecha_cambio DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_id_usuario_por_reserva` (IN `pid_reserva` INT)   BEGIN
    SELECT id_usuario FROM reservas WHERE id_reserva = pid_reserva;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_nombre_estado_por_id` (IN `pid_estado` INT)   BEGIN
    SELECT nombre_est FROM estados_reserva WHERE id_estado = pid_estado;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_producto_por_id` (IN `p_id_producto` INT)   BEGIN
    SELECT * FROM productos WHERE id_producto = p_id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_reservas_por_vendedor` (IN `pid_vendedor` INT)   BEGIN
    SELECT r.id_reserva, r.fecha_reserva, r.total,
           u.nombres AS nombre_usuario,
           e.nombre_est AS nombre_estado,
           r.id_estado
    FROM reservas r
    JOIN usuarios u ON r.id_usuario = u.id_usuario
    JOIN estados_reserva e ON r.id_estado = e.id_estado
    WHERE r.id_vendedor = pid_vendedor AND r.estado_activo = 1
    ORDER BY r.id_reserva DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_reserva_por_id` (IN `pid` INT)   BEGIN
    SELECT r.*, e.nombre_est AS nombre_estado
    FROM reservas r
    JOIN estados_reserva e ON r.id_estado = e.id_estado
    WHERE r.id_reserva = pid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_todas_reservas` ()   BEGIN
    SELECT r.id_reserva, r.fecha_reserva, r.total, r.id_vendedor,
           u.nombres AS nombre_usuario,
           v.nombres AS nombre_vendedor,
           e.nombre_est AS nombre_estado,
           r.id_estado
    FROM reservas r
    JOIN usuarios u ON r.id_usuario = u.id_usuario
    LEFT JOIN vendedores v ON r.id_vendedor = v.id_vendedor
    JOIN estados_reserva e ON r.id_estado = e.id_estado
    WHERE r.estado_activo = 1
    ORDER BY r.id_reserva DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_todos_productos` ()   BEGIN
    SELECT p.*, f.nombre_fran 
    FROM productos p
    JOIN franquicias f ON p.id_franquicia = f.id_franquicia
    WHERE p.estado_activo = 1
    ORDER BY p.id_producto DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_usuarios_activos` ()   BEGIN
    SELECT * FROM usuarios
    WHERE estado_activo = 1
    ORDER BY id_usuario DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_usuario_login` (IN `p_correo` VARCHAR(100))   BEGIN
    SELECT id_admin AS id, nombres, clave, rol
    FROM administradores
    WHERE correo = p_correo

    UNION

    SELECT id_vendedor AS id, nombres, clave, rol
    FROM vendedores
    WHERE correo = p_correo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_usuario_por_id` (IN `p_id` INT)   BEGIN
    SELECT * FROM usuarios
    WHERE id_usuario = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_vendedores_activos` ()   BEGIN
    SELECT * FROM vendedores WHERE estado_activo = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_vendedores_reserva` ()   BEGIN
    SELECT id_vendedor, nombres FROM vendedores;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_vendedor_por_id` (IN `id_in` INT)   BEGIN
    SELECT * FROM vendedores WHERE id_vendedor = id_in;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_administrador` (IN `nombres_in` VARCHAR(100), IN `apellidos_in` VARCHAR(100), IN `telefono_in` VARCHAR(20), IN `correo_in` VARCHAR(100), IN `clave_in` VARCHAR(255))   BEGIN
    INSERT INTO administradores (nombres, apellidos, telefono, correo, clave, estado_activo, rol)
    VALUES (nombres_in, apellidos_in, telefono_in, correo_in, clave_in, 1, 'admin');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_franquicia` (IN `nombre` VARCHAR(255))   BEGIN
    INSERT INTO franquicias (nombre_fran, estado_activo)
    VALUES (nombre, 1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_historial_reserva` (IN `pid_reserva` INT, IN `pid_estado_anterior` INT, IN `pid_estado_nuevo` INT, IN `pid_admin` INT, IN `pid_vendedor` INT)   BEGIN
    INSERT INTO historial_reservas 
    (id_reserva, id_admin, id_vendedor, id_estado_anterior, id_estado_nuevo, fecha_cambio) 
    VALUES (pid_reserva, pid_admin, pid_vendedor, pid_estado_anterior, pid_estado_nuevo, NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_notificacion` (IN `pid_usuario` INT, IN `pid_reserva` INT, IN `pmensaje` TEXT)   BEGIN
    INSERT INTO notificaciones (id_usuario, id_reserva, mensaje, leido, fecha_creacion)
    VALUES (pid_usuario, pid_reserva, pmensaje, 0, NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_producto` (IN `p_id_franquicia` INT, IN `p_nombre_prod` VARCHAR(100), IN `p_descripcion` TEXT, IN `p_altura` VARCHAR(50), IN `p_color` VARCHAR(50), IN `p_stock` INT, IN `p_precio` DECIMAL(10,2), IN `p_imagen` VARCHAR(255))   BEGIN
    INSERT INTO productos (id_franquicia, nombre_prod, descripcion, altura, color, stock, precio, imagen, estado_activo)
    VALUES (p_id_franquicia, p_nombre_prod, p_descripcion, p_altura, p_color, p_stock, p_precio, p_imagen, 1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_usuario` (IN `p_nombres` VARCHAR(255), IN `p_apellidos` VARCHAR(255), IN `p_telefono` VARCHAR(255), IN `p_correo` VARCHAR(255), IN `p_contraseña` VARCHAR(255), IN `p_fecha` DATETIME, IN `p_estado_activo` INT)   BEGIN
    INSERT INTO usuarios (nombres, apellidos, telefono, correo, contraseña, fecha_registro, estado_activo)
    VALUES (p_nombres, p_apellidos, p_telefono, p_correo, p_contraseña, p_fecha, p_estado_activo);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_vendedor` (IN `nombres_in` VARCHAR(100), IN `apellidos_in` VARCHAR(100), IN `telefono_in` VARCHAR(20), IN `correo_in` VARCHAR(100), IN `clave_in` VARCHAR(255))   BEGIN
    INSERT INTO vendedores (nombres, apellidos, telefono, correo, clave, estado_activo, rol)
    VALUES (nombres_in, apellidos_in, telefono_in, correo_in, clave_in, 1, 'vendedor');
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administradores`
--

CREATE TABLE `administradores` (
  `id_admin` int(11) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `telefono` varchar(9) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `clave` varchar(100) NOT NULL,
  `estado_activo` tinyint(1) DEFAULT 1,
  `rol` enum('admin') NOT NULL DEFAULT 'admin'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `administradores`
--

INSERT INTO `administradores` (`id_admin`, `nombres`, `apellidos`, `telefono`, `correo`, `clave`, `estado_activo`, `rol`) VALUES
(1, 'Jesus Giampier', 'Arce Celis', '902045967', 'principal@hotmail.com', '$2y$10$iv7iBKQq6oWTKa.u/HYJju63P4u/pWJR13CkVBPOz7OK0IHIsHfWK', 1, 'admin');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_reserva`
--

CREATE TABLE `detalles_reserva` (
  `id_detalle` int(11) NOT NULL,
  `id_reserva` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalles_reserva`
--

INSERT INTO `detalles_reserva` (`id_detalle`, `id_reserva`, `id_producto`, `cantidad`, `precio_unitario`) VALUES
(2, 2, 1, 2, 15),
(3, 2, 2, 2, 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados_reserva`
--

CREATE TABLE `estados_reserva` (
  `id_estado` int(11) NOT NULL,
  `nombre_est` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estados_reserva`
--

INSERT INTO `estados_reserva` (`id_estado`, `nombre_est`) VALUES
(1, 'Pendiente'),
(2, 'En proceso'),
(3, 'Completado'),
(4, 'Cancelado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `franquicias`
--

CREATE TABLE `franquicias` (
  `id_franquicia` int(11) NOT NULL,
  `nombre_fran` varchar(255) DEFAULT NULL,
  `estado_activo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `franquicias`
--

INSERT INTO `franquicias` (`id_franquicia`, `nombre_fran`, `estado_activo`) VALUES
(1, 'Disney', 1),
(2, 'San Rio', 1),
(3, 'My Little Pony', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_reservas`
--

CREATE TABLE `historial_reservas` (
  `id_historial` int(11) NOT NULL,
  `id_reserva` int(11) NOT NULL,
  `id_admin` int(11) DEFAULT NULL,
  `id_vendedor` int(11) DEFAULT NULL,
  `id_estado_anterior` int(11) NOT NULL,
  `id_estado_nuevo` int(11) NOT NULL,
  `fecha_cambio` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `historial_reservas`
--

INSERT INTO `historial_reservas` (`id_historial`, `id_reserva`, `id_admin`, `id_vendedor`, `id_estado_anterior`, `id_estado_nuevo`, `fecha_cambio`) VALUES
(1, 2, 1, NULL, 1, 2, '2025-07-17 10:09:47'),
(2, 2, 1, NULL, 2, 3, '2025-07-17 10:29:07'),
(3, 2, NULL, 1, 3, 4, '2025-07-17 10:40:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logs_web`
--

CREATE TABLE `logs_web` (
  `id_log` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `accion` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `ip_usuario` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `logs_web`
--

INSERT INTO `logs_web` (`id_log`, `id_usuario`, `accion`, `descripcion`, `ip_usuario`, `user_agent`, `fecha`) VALUES
(1, NULL, 'vista_login', 'Ingreso a la página de login', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-09 12:32:11'),
(2, NULL, 'vista_login', 'Ingreso a la página de login', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-09 12:33:28'),
(3, 1, 'registro_exitoso', 'Registro exitoso: PrincesaV2@hotmail.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-09 12:34:15'),
(4, NULL, 'vista_login', 'Ingreso a la página de login', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-09 12:34:15'),
(5, 1, 'login_exitoso', 'Inicio de sesión exitoso', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-09 12:35:13'),
(6, 1, 'vista_home', 'Acceso público a la página principal', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-09 12:35:13'),
(7, 1, 'vista_catalogo', 'Acceso al catálogo de productos', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-09 12:35:21'),
(8, 1, 'vista_home', 'Acceso público a la página principal', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-09 12:39:59'),
(9, 1, 'vista_catalogo', 'Acceso al catálogo de productos', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-09 12:40:00'),
(10, 1, 'carrito_agregado', 'Producto 1 agregado (1 unidades)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-09 12:40:11'),
(11, 1, 'vista_catalogo', 'Acceso al catálogo de productos', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-09 12:40:11'),
(12, 1, 'dao_error', 'DAOreserva->insertarReserva: SQLSTATE[23000]: Integrity constraint violation: 1452 Cannot add or update a child row: a foreign key constraint fails (`bdpeluches`.`reservas`, CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`id_estado`) REFERENCES `estados_reserva` (`id_estado`))', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-09 12:40:18'),
(13, 1, 'dao_error', 'DAOreserva->insertarDetalleReserva: SQLSTATE[23000]: Integrity constraint violation: 1452 Cannot add or update a child row: a foreign key constraint fails (`bdpeluches`.`detalles_reserva`, CONSTRAINT `detalles_reserva_ibfk_1` FOREIGN KEY (`id_reserva`) REFERENCES `reservas` (`id_reserva`))', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-09 12:40:18'),
(14, 1, 'reserva_exitosa', 'Reserva #0 completada', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-09 12:40:18'),
(15, 1, 'vista_catalogo', 'Acceso al catálogo de productos', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-09 12:40:40'),
(16, 1, 'vista_catalogo', 'Acceso al catálogo de productos', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-09 12:43:33'),
(17, 1, 'carrito_agregado', 'Producto 1 agregado (2 unidades)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-09 12:43:41'),
(18, 1, 'vista_catalogo', 'Acceso al catálogo de productos', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-09 12:43:41'),
(19, 1, 'carrito_agregado', 'Producto 2 agregado (2 unidades)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-09 12:43:49'),
(20, 1, 'vista_catalogo', 'Acceso al catálogo de productos', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-09 12:43:49'),
(21, 1, 'reserva_exitosa', 'Reserva #2 completada', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-09 12:43:59'),
(22, 1, 'vista_catalogo', 'Acceso al catálogo de productos', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-09 12:44:17'),
(23, 1, 'logout', 'Usuario cerró sesión.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-09 12:44:59'),
(24, NULL, 'vista_login', 'Ingreso a la página de login', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-09 12:44:59'),
(25, NULL, 'Vista', 'Vista de login abierta', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 09:43:43'),
(26, NULL, 'Vista', 'Vista de login abierta', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 09:44:23'),
(27, NULL, 'Error', 'Intento fallido de login con correo: principal@hotmail.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 09:52:03'),
(28, NULL, 'Vista', 'Vista de login abierta', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 09:52:03'),
(29, NULL, 'Error', 'Intento fallido de login con correo: principal@hotmail.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:06:49'),
(30, NULL, 'Vista', 'Vista de login abierta', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:06:49'),
(31, 1, 'Login', 'Acceso exitoso como admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:07:22'),
(32, 1, 'Vista', 'Ingresó al panel de inicio del administrador', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:07:22'),
(33, 1, 'Listar', 'Listado de reservas mostrado', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:07:30'),
(34, 1, 'Editar', 'Formulario de edición abierto para reserva ID: 2', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:07:33'),
(35, 1, 'Formulario', 'Accedió al formulario de registro de producto', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:07:47'),
(36, 1, 'Listado', 'Listado de productos mostrado', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:07:49'),
(37, 1, 'Vista', 'Listó franquicias', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:07:55'),
(38, 1, 'Vista', 'Accedió al formulario de registro de franquicia', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:07:56'),
(39, 1, 'Registro', 'Registró franquicia: My Little Pony', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:08:01'),
(40, 1, 'Vista', 'Accedió al formulario de registro de franquicia', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:08:01'),
(41, 1, 'Vista', 'Listó franquicias', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:08:03'),
(42, NULL, 'Listar', 'Listado de clientes visualizado', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:08:13'),
(43, NULL, 'Ver Admins', 'Se listaron administradores activos', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:08:15'),
(44, NULL, 'Registro Vendedor', 'Vendedor registrado: CorazonesV2@hotmail.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:09:24'),
(45, NULL, 'Ver Vendedores', 'Se listaron vendedores activos', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:09:27'),
(46, 1, 'Historial', 'Vista de historial de reservas accedida', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:09:35'),
(47, 1, 'Listar', 'Listado de reservas mostrado', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:09:40'),
(48, 1, 'Editar', 'Formulario de edición abierto para reserva ID: 2', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:09:42'),
(49, 1, 'Vista', 'Ingresó al panel de inicio del administrador', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:28:57'),
(50, 1, 'Listar', 'Listado de reservas mostrado', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:29:00'),
(51, 1, 'Editar', 'Formulario de edición abierto para reserva ID: 2', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:29:03'),
(52, 1, 'Actualizar', 'Reserva #2 actualizada de estado 2 a 3', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:29:07'),
(53, 1, 'Listar', 'Listado de reservas mostrado', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:29:07'),
(54, 1, 'Historial', 'Vista de historial de reservas accedida', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:29:16'),
(55, 1, 'Historial', 'Historial accedido para reserva ID: 2', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:29:19'),
(56, 1, 'Ver', 'Vista reservas visualizada', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:29:37'),
(57, 1, 'Vista', 'Vista general de productos visualizada', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:29:38'),
(58, 1, 'Ver', 'Vista reservas visualizada', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:29:40'),
(59, 1, 'Historial', 'Vista de historial de reservas accedida', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:29:42'),
(60, NULL, 'Listar', 'Listado de clientes visualizado', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:29:51'),
(61, NULL, 'Ver Admins', 'Se listaron administradores activos', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:29:52'),
(62, NULL, 'Ver Vendedores', 'Se listaron vendedores activos', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:29:53'),
(63, 1, 'Vista', 'Listó franquicias', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:29:57'),
(64, 1, 'Listado', 'Listado de productos mostrado', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:30:01'),
(65, 1, 'Ver', 'Vista reservas visualizada', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:30:08'),
(66, 1, 'Vista', 'Ingresó al panel de inicio del administrador', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:37:34'),
(67, 1, 'Ver', 'Vista reservas visualizada', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:37:37'),
(68, 1, 'Vista', 'Vista general de productos visualizada', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:37:39'),
(69, 1, 'Vista', 'Ingresó al panel de inicio del administrador', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:39:18'),
(70, 1, 'Vista', 'Vista general de productos visualizada', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:39:21'),
(71, NULL, 'Ver Admins', 'Se listaron administradores activos', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:39:35'),
(72, NULL, 'Ver Vendedores', 'Se listaron vendedores activos', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:39:36'),
(73, 1, 'Logout', 'Cierre de sesión', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:39:44'),
(74, NULL, 'Vista', 'Vista de login abierta', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:39:44'),
(75, 1, 'Login', 'Acceso exitoso como vendedor', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:39:57'),
(76, 1, 'Vista', 'Ingresó al panel de inicio del administrador', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:39:57'),
(77, 1, 'Listar', 'Listado de reservas asignadas al vendedor mostrado', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:40:07'),
(78, 1, 'Acceso', 'Formulario de cambio de estado para reserva #2 accedido por vendedor', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:40:10'),
(79, 1, 'Actualizar', 'Vendedor actualizó estado de reserva #2 de 3 a 4', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:40:14'),
(80, 1, 'Listar', 'Listado de reservas asignadas al vendedor mostrado', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', '2025-07-17 10:40:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id_notificacion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_reserva` int(11) NOT NULL,
  `mensaje` text NOT NULL,
  `leido` tinyint(1) DEFAULT 0,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `leida` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `notificaciones`
--

INSERT INTO `notificaciones` (`id_notificacion`, `id_usuario`, `id_reserva`, `mensaje`, `leido`, `fecha_creacion`, `leida`) VALUES
(1, 1, 2, 'Tu reserva #2 ha cambiado de estado: En proceso → Completado.', 0, '2025-07-17 10:29:07', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `id_franquicia` int(11) NOT NULL,
  `nombre_prod` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `altura` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `stock` int(11) NOT NULL,
  `precio` double NOT NULL,
  `imagen` varchar(255) NOT NULL,
  `estado_activo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `id_franquicia`, `nombre_prod`, `descripcion`, `altura`, `color`, `stock`, `precio`, `imagen`, `estado_activo`) VALUES
(1, 1, 'Mickey', 'Un ratón juguetón y tu gran amigo.', '30 cm', 'Negro con Rojo.', 48, 15, 'mickey.png', 1),
(2, 2, 'Hello Kity', 'Una gatita rosa muy bonita.', '30 cm', 'Rosado y blanco', 48, 20, 'kitty.png', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `id_reserva` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_estado` int(11) NOT NULL,
  `id_vendedor` int(11) DEFAULT NULL,
  `fecha_reserva` datetime DEFAULT current_timestamp(),
  `total` double DEFAULT NULL,
  `estado_activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`id_reserva`, `id_usuario`, `id_estado`, `id_vendedor`, `fecha_reserva`, `total`, `estado_activo`) VALUES
(2, 1, 4, 1, '2025-07-09 12:43:59', 70, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombres` varchar(255) DEFAULT NULL,
  `apellidos` varchar(255) DEFAULT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  `correo` varchar(255) DEFAULT NULL,
  `contraseña` varchar(255) DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp(),
  `estado_activo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombres`, `apellidos`, `telefono`, `correo`, `contraseña`, `fecha_registro`, `estado_activo`) VALUES
(1, 'Angie Cristal', 'Arce Flores', '902837045', 'PrincesaV2@hotmail.com', '$2y$10$dqn05MnhvWDpBrb1oLb33u27wmfRP/cr1KLFIIH1M0TmmMtEBfxty', '2025-07-09 19:34:14', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vendedores`
--

CREATE TABLE `vendedores` (
  `id_vendedor` int(11) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `telefono` varchar(9) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `clave` varchar(150) NOT NULL,
  `estado_activo` tinyint(1) DEFAULT 1,
  `rol` enum('vendedor') NOT NULL DEFAULT 'vendedor'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vendedores`
--

INSERT INTO `vendedores` (`id_vendedor`, `nombres`, `apellidos`, `telefono`, `correo`, `clave`, `estado_activo`, `rol`) VALUES
(1, 'Gabriel Angel', 'Arce Flores', '987654321', 'CorazonesV2@hotmail.com', '$2y$10$RIWQWtTvUqCypm5kqqYB7urJcKPNZJcCpDp1SRFuwA.MrAnjWSWN6', 1, 'vendedor');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_productos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_productos` (
`id_producto` int(11)
,`nombre_prod` varchar(255)
,`descripcion` varchar(255)
,`altura` varchar(255)
,`color` varchar(255)
,`stock` int(11)
,`precio` double
,`imagen` varchar(255)
,`estado_activo` int(11)
,`nombre_franquicia` varchar(255)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_resumen_reservas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_resumen_reservas` (
`id_reserva` int(11)
,`nombre_usuario` varchar(255)
,`producto` varchar(255)
,`cantidad` int(11)
,`precio_unitario` double
,`subtotal` double
,`total` double
,`fecha_reserva` datetime
,`estado_reserva` int(11)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_productos`
--
DROP TABLE IF EXISTS `vista_productos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_productos`  AS SELECT `p`.`id_producto` AS `id_producto`, `p`.`nombre_prod` AS `nombre_prod`, `p`.`descripcion` AS `descripcion`, `p`.`altura` AS `altura`, `p`.`color` AS `color`, `p`.`stock` AS `stock`, `p`.`precio` AS `precio`, `p`.`imagen` AS `imagen`, `p`.`estado_activo` AS `estado_activo`, `f`.`nombre_fran` AS `nombre_franquicia` FROM (`productos` `p` join `franquicias` `f` on(`p`.`id_franquicia` = `f`.`id_franquicia`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_resumen_reservas`
--
DROP TABLE IF EXISTS `vista_resumen_reservas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_resumen_reservas`  AS SELECT `r`.`id_reserva` AS `id_reserva`, `u`.`nombres` AS `nombre_usuario`, `p`.`nombre_prod` AS `producto`, `d`.`cantidad` AS `cantidad`, `d`.`precio_unitario` AS `precio_unitario`, `d`.`cantidad`* `d`.`precio_unitario` AS `subtotal`, `r`.`total` AS `total`, `r`.`fecha_reserva` AS `fecha_reserva`, `r`.`id_estado` AS `estado_reserva` FROM (((`reservas` `r` join `usuarios` `u` on(`r`.`id_usuario` = `u`.`id_usuario`)) join `detalles_reserva` `d` on(`r`.`id_reserva` = `d`.`id_reserva`)) join `productos` `p` on(`d`.`id_producto` = `p`.`id_producto`)) WHERE `r`.`estado_activo` = 1 ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administradores`
--
ALTER TABLE `administradores`
  ADD PRIMARY KEY (`id_admin`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- Indices de la tabla `detalles_reserva`
--
ALTER TABLE `detalles_reserva`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_reserva` (`id_reserva`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `estados_reserva`
--
ALTER TABLE `estados_reserva`
  ADD PRIMARY KEY (`id_estado`);

--
-- Indices de la tabla `franquicias`
--
ALTER TABLE `franquicias`
  ADD PRIMARY KEY (`id_franquicia`);

--
-- Indices de la tabla `historial_reservas`
--
ALTER TABLE `historial_reservas`
  ADD PRIMARY KEY (`id_historial`),
  ADD KEY `id_reserva` (`id_reserva`),
  ADD KEY `id_admin` (`id_admin`),
  ADD KEY `id_estado_anterior` (`id_estado_anterior`),
  ADD KEY `id_estado_nuevo` (`id_estado_nuevo`),
  ADD KEY `fk_historial_vendedor` (`id_vendedor`);

--
-- Indices de la tabla `logs_web`
--
ALTER TABLE `logs_web`
  ADD PRIMARY KEY (`id_log`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`id_notificacion`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_reserva` (`id_reserva`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_franquicia` (`id_franquicia`);

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id_reserva`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_estado` (`id_estado`),
  ADD KEY `id_vendedor` (`id_vendedor`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- Indices de la tabla `vendedores`
--
ALTER TABLE `vendedores`
  ADD PRIMARY KEY (`id_vendedor`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `administradores`
--
ALTER TABLE `administradores`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `detalles_reserva`
--
ALTER TABLE `detalles_reserva`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `estados_reserva`
--
ALTER TABLE `estados_reserva`
  MODIFY `id_estado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `franquicias`
--
ALTER TABLE `franquicias`
  MODIFY `id_franquicia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `historial_reservas`
--
ALTER TABLE `historial_reservas`
  MODIFY `id_historial` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `logs_web`
--
ALTER TABLE `logs_web`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id_notificacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id_reserva` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `vendedores`
--
ALTER TABLE `vendedores`
  MODIFY `id_vendedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalles_reserva`
--
ALTER TABLE `detalles_reserva`
  ADD CONSTRAINT `detalles_reserva_ibfk_1` FOREIGN KEY (`id_reserva`) REFERENCES `reservas` (`id_reserva`),
  ADD CONSTRAINT `detalles_reserva_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`);

--
-- Filtros para la tabla `historial_reservas`
--
ALTER TABLE `historial_reservas`
  ADD CONSTRAINT `fk_historial_vendedor` FOREIGN KEY (`id_vendedor`) REFERENCES `vendedores` (`id_vendedor`),
  ADD CONSTRAINT `historial_reservas_ibfk_1` FOREIGN KEY (`id_reserva`) REFERENCES `reservas` (`id_reserva`),
  ADD CONSTRAINT `historial_reservas_ibfk_2` FOREIGN KEY (`id_admin`) REFERENCES `administradores` (`id_admin`),
  ADD CONSTRAINT `historial_reservas_ibfk_3` FOREIGN KEY (`id_estado_anterior`) REFERENCES `estados_reserva` (`id_estado`),
  ADD CONSTRAINT `historial_reservas_ibfk_4` FOREIGN KEY (`id_estado_nuevo`) REFERENCES `estados_reserva` (`id_estado`);

--
-- Filtros para la tabla `logs_web`
--
ALTER TABLE `logs_web`
  ADD CONSTRAINT `logs_web_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE SET NULL;

--
-- Filtros para la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD CONSTRAINT `notificaciones_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `notificaciones_ibfk_2` FOREIGN KEY (`id_reserva`) REFERENCES `reservas` (`id_reserva`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_franquicia`) REFERENCES `franquicias` (`id_franquicia`);

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`id_estado`) REFERENCES `estados_reserva` (`id_estado`),
  ADD CONSTRAINT `reservas_ibfk_3` FOREIGN KEY (`id_vendedor`) REFERENCES `vendedores` (`id_vendedor`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
