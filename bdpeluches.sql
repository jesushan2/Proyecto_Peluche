-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-06-2025 a las 15:05:06
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
  `estado_activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `administradores`
--

INSERT INTO `administradores` (`id_admin`, `nombres`, `apellidos`, `telefono`, `correo`, `clave`, `estado_activo`) VALUES
(1, 'Juan Esteban', 'Alvarado Gomez', '987654321', 'DemoscreationD@hotmail.com', 'amor0123', 1),
(2, 'Abraham Mario', 'Alvarado Gomez', '987654321', 'GenesisE@hotmail.com', 'amor0123', 1),
(3, 'Alexander Mario', 'Cordova Rodriguez', '988542622', 'BastonesE2@hotmail.com', 'amor0123', 1),
(4, 'Axel Mercer', 'Navarro Bustamante', '987654321', 'JugadoresE2@hotmail.com', 'amor0123', 1),
(5, 'Evelyn Annie', 'Rojas Flores', '999002932', 'Floresrojas1A@hotmail.com', 'amor0123', 1),
(6, 'Albert Melvin', 'Romero Human', '987654321', 'CaballeroE2@hotmail.com', 'amor0123', 1),
(7, 'MARYORIE ANN ', 'Romero Human', '987654321', 'DemoscreationS@hotmail.com', 'amor0123', 1);

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
(1, 2, 2, 1, 30),
(2, 2, 1, 1, 20),
(3, 2, 3, 1, 20),
(4, 2, 4, 1, 25),
(5, 3, 1, 2, 20),
(6, 3, 2, 1, 30),
(7, 3, 3, 2, 20),
(8, 4, 1, 1, 20),
(9, 4, 2, 1, 30),
(10, 5, 5, 1, 20),
(11, 5, 2, 1, 30),
(12, 6, 1, 2, 20),
(13, 6, 2, 1, 30),
(14, 7, 3, 1, 20),
(15, 7, 4, 1, 25),
(16, 8, 1, 1, 20),
(17, 9, 5, 1, 20),
(18, 9, 6, 1, 20);

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
(2, 'Confirmada'),
(3, 'Cancelada');

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
(2, 'Marvel', 1),
(3, 'DC Universos', 1),
(4, 'San Rio', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_reservas`
--

CREATE TABLE `historial_reservas` (
  `id_historial` int(11) NOT NULL,
  `id_reserva` int(11) NOT NULL,
  `id_admin` int(11) NOT NULL,
  `id_estado_anterior` int(11) NOT NULL,
  `id_estado_nuevo` int(11) NOT NULL,
  `fecha_cambio` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, 1, 'Mickey Mouse', 'Un ratón peluche.', '5 cm', 'Negro', 3, 20, 'mickey.png', 1),
(2, 1, 'Pluto', 'Un perro amarillo', '4 cm', 'Amarillo', 5, 30, 'pluto.png', 1),
(3, 2, 'Spiderman', 'El hombre araña de marvel', '5 cm', 'Rojo', 16, 20, 'araña.png', 1),
(4, 2, 'Capitán America', 'El capitán America salvador de la patria.', '5 cm', 'Azul', 18, 25, 'america.png', 1),
(5, 1, 'Goffy', 'El mejor amigo de Mickey y Donal.', '3 cm', 'Negro', 8, 20, 'Goffy.png', 1),
(6, 4, 'Hello Kity', 'Una conejita rosada', '4 cm', 'Rosado', 9, 20, 'kitty.png', 1);

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
(2, 1, 1, 2, '2025-06-02 02:10:56', 95, 1),
(3, 2, 1, 2, '2025-06-05 14:07:36', 110, 1),
(4, 1, 1, 1, '2025-06-05 21:18:54', 50, 1),
(5, 1, 1, NULL, '2025-06-09 13:17:23', 50, 1),
(6, 1, 1, NULL, '2025-06-09 13:27:09', 70, 1),
(7, 2, 1, NULL, '2025-06-09 13:28:58', 45, 1),
(8, 2, 1, NULL, '2025-06-09 18:17:46', 20, 1),
(9, 2, 1, NULL, '2025-06-09 19:24:42', 40, 1);

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
(1, 'Angel Miguel', 'Romero Celis', '906258463', 'PalomaV1@hotmail.com', 'amor0123', '2025-06-01 23:40:33', 1),
(2, 'Andrea Sofia', 'Flores Nuñez', '998564733', 'Rosasf@hotmail.com', 'amor0123', '2025-06-05 14:06:44', 1);

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
  `estado_activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vendedores`
--

INSERT INTO `vendedores` (`id_vendedor`, `nombres`, `apellidos`, `telefono`, `correo`, `clave`, `estado_activo`) VALUES
(1, 'Ana Marisol', 'Cordova Romero', '987542633', 'MilagrosE2@hotmail.com', 'amor0123', 1),
(2, 'Maryori Estrella', 'Huaman Rojas', '987654321', 'Maryu1@hotmail.com', 'amor0123', 1),
(3, 'MARYORIE ANN ', 'Romero Human', '987654321', 'DemoscreationJ@hotmail.com', 'amor0123', 1);

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
  ADD KEY `id_estado_nuevo` (`id_estado_nuevo`);

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
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `detalles_reserva`
--
ALTER TABLE `detalles_reserva`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `estados_reserva`
--
ALTER TABLE `estados_reserva`
  MODIFY `id_estado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `franquicias`
--
ALTER TABLE `franquicias`
  MODIFY `id_franquicia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `historial_reservas`
--
ALTER TABLE `historial_reservas`
  MODIFY `id_historial` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id_reserva` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `vendedores`
--
ALTER TABLE `vendedores`
  MODIFY `id_vendedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  ADD CONSTRAINT `historial_reservas_ibfk_1` FOREIGN KEY (`id_reserva`) REFERENCES `reservas` (`id_reserva`),
  ADD CONSTRAINT `historial_reservas_ibfk_2` FOREIGN KEY (`id_admin`) REFERENCES `administradores` (`id_admin`),
  ADD CONSTRAINT `historial_reservas_ibfk_3` FOREIGN KEY (`id_estado_anterior`) REFERENCES `estados_reserva` (`id_estado`),
  ADD CONSTRAINT `historial_reservas_ibfk_4` FOREIGN KEY (`id_estado_nuevo`) REFERENCES `estados_reserva` (`id_estado`);

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
