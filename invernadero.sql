-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-02-2020 a las 06:12:46
-- Versión del servidor: 10.1.38-MariaDB
-- Versión de PHP: 7.3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `invernadero`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `crecimiento`
--

CREATE TABLE `crecimiento` (
  `idcrecimiento` int(10) UNSIGNED NOT NULL,
  `planta_idplanta` int(10) UNSIGNED NOT NULL,
  `nombrefase` varchar(255) DEFAULT NULL,
  `observacion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cultivo`
--

CREATE TABLE `cultivo` (
  `idcultivo` int(10) UNSIGNED NOT NULL,
  `enfermedades_idenfermedades` int(10) UNSIGNED NOT NULL,
  `plaga_idplaga` int(10) UNSIGNED NOT NULL,
  `cultivoinvernadero_idcultivoinver` int(10) UNSIGNED NOT NULL,
  `estado_idestado` int(10) UNSIGNED NOT NULL,
  `invernadero_idinvernadero` int(10) UNSIGNED NOT NULL,
  `nombrecultivo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cultivoinvernadero`
--

CREATE TABLE `cultivoinvernadero` (
  `idcultivoinver` int(10) UNSIGNED NOT NULL,
  `nombrecultivo` varchar(255) DEFAULT NULL,
  `tipocultivo` varchar(255) DEFAULT NULL,
  `distanciaentrecultivo` varchar(255) DEFAULT NULL,
  `tecnicaSembrio` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dano_plaen`
--

CREATE TABLE `dano_plaen` (
  `iddano_plaenf` int(10) UNSIGNED NOT NULL,
  `nombre_dano_plaenf` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dano_plaen_has_enfermedades`
--

CREATE TABLE `dano_plaen_has_enfermedades` (
  `enfermedades_idenfermedades` int(10) UNSIGNED NOT NULL,
  `dano_plaen_iddano_plaenf` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dano_plaen_has_plaga`
--

CREATE TABLE `dano_plaen_has_plaga` (
  `plaga_idplaga` int(10) UNSIGNED NOT NULL,
  `dano_plaen_iddano_plaenf` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `enfermedades`
--

CREATE TABLE `enfermedades` (
  `idenfermedades` int(10) UNSIGNED NOT NULL,
  `estado_idestado` int(10) UNSIGNED NOT NULL,
  `crecimiento_idcrecimiento` int(10) UNSIGNED NOT NULL,
  `nombreenferm` varchar(20) DEFAULT NULL,
  `sintomenferm` varchar(255) DEFAULT NULL,
  `colorhojaenferm` varchar(255) DEFAULT NULL,
  `observacionenferm` varchar(255) DEFAULT NULL,
  `caracteristcagenenferm` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado`
--

CREATE TABLE `estado` (
  `idestado` int(10) UNSIGNED NOT NULL,
  `cultivoinvernadero_idcultivoinver` int(10) UNSIGNED NOT NULL,
  `planta_idplanta` int(10) UNSIGNED NOT NULL,
  `resultadoestado` varchar(255) DEFAULT NULL,
  `observacionestado` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_cosecha`
--

CREATE TABLE `estado_cosecha` (
  `idestado_cosecha` int(10) UNSIGNED NOT NULL,
  `planta_idplanta` int(10) UNSIGNED NOT NULL,
  `enfermedades_idenfermedades` int(10) UNSIGNED NOT NULL,
  `plaga_idplaga` int(10) UNSIGNED NOT NULL,
  `cultivoinvernadero_idcultivoinver` int(10) UNSIGNED NOT NULL,
  `ciclo_planta` int(10) UNSIGNED DEFAULT NULL,
  `mercado_idmercado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_humedad`
--

CREATE TABLE `estado_humedad` (
  `id_humedad` int(11) NOT NULL,
  `dato_humedad` varchar(10) DEFAULT NULL,
  `fecha_humedad` date DEFAULT NULL,
  `hora_humedad` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `estado_humedad`
--

INSERT INTO `estado_humedad` (`id_humedad`, `dato_humedad`, `fecha_humedad`, `hora_humedad`) VALUES
(5, '0', '2019-12-18', '09:33:00'),
(6, '', '2019-12-18', '09:52:00'),
(7, '0', '2019-12-18', '10:03:00'),
(8, '0', '2019-12-18', '10:03:00'),
(9, '0', '2019-12-18', '10:59:00'),
(10, '9', '2019-12-18', '11:01:00'),
(11, '9', '2019-12-18', '11:01:00'),
(12, '78', '2019-12-18', '11:02:00'),
(13, '78', '2019-12-18', '11:02:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_tanque`
--

CREATE TABLE `estado_tanque` (
  `id_tanque` int(11) NOT NULL,
  `dato_tanque` varchar(10) DEFAULT NULL,
  `fecha_tanque` date DEFAULT NULL,
  `hora_tanque` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `estado_tanque`
--

INSERT INTO `estado_tanque` (`id_tanque`, `dato_tanque`, `fecha_tanque`, `hora_tanque`) VALUES
(2, '0', '2019-12-18', '09:33:00'),
(3, '0', '2019-12-18', '10:03:00'),
(4, '0', '2019-12-18', '10:03:00'),
(5, '0', '2019-12-18', '10:59:00'),
(6, '2', '2019-12-18', '11:01:00'),
(7, '2', '2019-12-18', '11:01:00'),
(8, '0', '2019-12-18', '11:02:00'),
(9, '0', '2019-12-18', '11:02:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_temperatura`
--

CREATE TABLE `estado_temperatura` (
  `id_temperatura` int(11) NOT NULL,
  `dato_temperatura` varchar(10) DEFAULT NULL,
  `fecha_temperatura` date DEFAULT NULL,
  `hora_temperatura` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `estado_temperatura`
--

INSERT INTO `estado_temperatura` (`id_temperatura`, `dato_temperatura`, `fecha_temperatura`, `hora_temperatura`) VALUES
(1, '0', '2004-12-08', '00:00:00'),
(2, '0', '2019-12-18', '09:33:00'),
(3, '0', '2019-12-18', '10:03:00'),
(4, '0', '2019-12-18', '10:03:00'),
(5, '0', '2019-12-18', '10:59:00'),
(6, '8', '2019-12-18', '11:01:00'),
(7, '8', '2019-12-18', '11:01:00'),
(8, '0', '2019-12-18', '11:02:00'),
(9, '0', '2019-12-18', '11:02:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fotos`
--

CREATE TABLE `fotos` (
  `idfotos` int(10) UNSIGNED NOT NULL,
  `enfermedades_idenfermedades` int(10) UNSIGNED NOT NULL,
  `nombrefotos` varchar(255) DEFAULT NULL,
  `fotoplanta` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `invernadero`
--

CREATE TABLE `invernadero` (
  `idinvernadero` int(10) UNSIGNED NOT NULL,
  `ubicacioninvernadero` varchar(255) DEFAULT NULL,
  `tamanoinvernadero` varchar(255) DEFAULT NULL,
  `alturainvernadero` double DEFAULT NULL,
  `anchoinvernadero` double DEFAULT NULL,
  `largoinvernadero` double DEFAULT NULL,
  `materialinvernadero` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `invernadero_has_cultivoinvernadero`
--

CREATE TABLE `invernadero_has_cultivoinvernadero` (
  `invernadero_idinvernadero` int(10) UNSIGNED NOT NULL,
  `cultivoinvernadero_idcultivoinver` int(10) UNSIGNED NOT NULL,
  `numcamascultivo` int(11) DEFAULT NULL,
  `caminocentralinvernadero` varchar(255) DEFAULT NULL,
  `distanciacamainver` varchar(255) DEFAULT NULL,
  `distanciaInvernaderoCultivo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicion`
--

CREATE TABLE `medicion` (
  `idMediciones` int(10) UNSIGNED NOT NULL,
  `invernadero_idinvernadero` int(10) UNSIGNED NOT NULL,
  `cultivoinvernadero_idcultivoinver` int(10) UNSIGNED NOT NULL,
  `CoordenadasCultivo` longblob,
  `numeroTotalCultivo` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicionsuelo`
--

CREATE TABLE `medicionsuelo` (
  `idmedicion` int(10) UNSIGNED NOT NULL,
  `kmedicion` double DEFAULT NULL,
  `pmedicion` double DEFAULT NULL,
  `nmedicion` double DEFAULT NULL,
  `humedadmedicion` double DEFAULT NULL,
  `temperaturamedicion` double DEFAULT NULL,
  `phmedicion` double DEFAULT NULL,
  `suelomedicion` varchar(255) DEFAULT NULL,
  `lugarmedicion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mercado`
--

CREATE TABLE `mercado` (
  `id_mercado` int(11) NOT NULL,
  `tipo_mercado` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `nombrerosa_mercado` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `nombrecientifico_mercado` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `tamanoboton_mercado` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fotoplanta_mercado` longblob,
  `rutafoto_mercado` varchar(255) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plaga`
--

CREATE TABLE `plaga` (
  `idplaga` int(10) UNSIGNED NOT NULL,
  `nombre_plaga` varchar(255) DEFAULT NULL,
  `caracteristica_general_plaga` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planta`
--

CREATE TABLE `planta` (
  `idplanta` int(10) UNSIGNED NOT NULL,
  `nombreplanta` varchar(255) DEFAULT NULL,
  `nombrecientificoplanta` varchar(255) DEFAULT NULL,
  `fechasiembraplanta` varchar(255) DEFAULT NULL,
  `aturamaxplanta` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `quimico`
--

CREATE TABLE `quimico` (
  `idquimico` int(10) UNSIGNED NOT NULL,
  `nombre_quimico` varchar(255) DEFAULT NULL,
  `cantidad_quimico` varchar(255) DEFAULT NULL,
  `descripcion_quimico` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `quimico_has_tratamiento`
--

CREATE TABLE `quimico_has_tratamiento` (
  `idquimico_has_tratamiento` int(10) UNSIGNED NOT NULL,
  `tratamiento_plaga_idplaga` int(10) UNSIGNED NOT NULL,
  `tratamiento_enfermedades_idenfermedades` int(10) UNSIGNED NOT NULL,
  `tratamiento_idtratamiento` int(10) UNSIGNED NOT NULL,
  `quimico_idquimico` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro`
--

CREATE TABLE `registro` (
  `idregistro` int(10) UNSIGNED NOT NULL,
  `estado_cosecha_idestado_cosecha` int(10) UNSIGNED NOT NULL,
  `estado_cosecha_enfermedades_idenfermedades` int(10) UNSIGNED NOT NULL,
  `estado_cosecha_planta_idplanta` int(10) UNSIGNED NOT NULL,
  `estado_cosecha_plaga_idplaga` int(10) UNSIGNED NOT NULL,
  `estado_cosecha_cultivoinvernadero_idcultivoinver` int(10) UNSIGNED NOT NULL,
  `nombre_usuario` varchar(20) DEFAULT NULL,
  `email_usuario` varchar(20) DEFAULT NULL,
  `contrasena_usuario` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_riego`
--

CREATE TABLE `registro_riego` (
  `id_registro_riego` int(11) NOT NULL,
  `id_humedad` int(11) DEFAULT NULL,
  `id_temperatura` int(11) DEFAULT NULL,
  `id_tanque` int(11) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `inicio_riego` time DEFAULT NULL,
  `fin_riego` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resultadosuelo`
--

CREATE TABLE `resultadosuelo` (
  `idresultadosuelo` int(10) UNSIGNED NOT NULL,
  `medicionsuelo_idmedicion` int(10) UNSIGNED NOT NULL,
  `sueloestandar_idsueloestandar` int(10) UNSIGNED NOT NULL,
  `kresultado` double DEFAULT NULL,
  `presultado` double DEFAULT NULL,
  `nresultado` double DEFAULT NULL,
  `humedadresultado` double DEFAULT NULL,
  `temperaturaresultado` double DEFAULT NULL,
  `phresultado` double DEFAULT NULL,
  `fecharesultado` date DEFAULT NULL,
  `lugarresultado` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sueloestandar`
--

CREATE TABLE `sueloestandar` (
  `idsueloestandar` int(10) UNSIGNED NOT NULL,
  `k` double DEFAULT NULL,
  `p` double DEFAULT NULL,
  `n` double DEFAULT NULL,
  `humedad` double DEFAULT NULL,
  `temperatura` double DEFAULT NULL,
  `ph` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `sueloestandar`
--

INSERT INTO `sueloestandar` (`idsueloestandar`, `k`, `p`, `n`, `humedad`, `temperatura`, `ph`) VALUES
(1, 15, 15, 15, 19, 25, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tratamiento`
--

CREATE TABLE `tratamiento` (
  `idtratamiento` int(10) UNSIGNED NOT NULL,
  `enfermedades_idenfermedades` int(10) UNSIGNED NOT NULL,
  `plaga_idplaga` int(10) UNSIGNED NOT NULL,
  `tipo_tratamiento` varchar(50) DEFAULT NULL,
  `umfumi_tratamiento` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `crecimiento`
--
ALTER TABLE `crecimiento`
  ADD PRIMARY KEY (`idcrecimiento`),
  ADD KEY `crecimiento_FKIndex1` (`planta_idplanta`);

--
-- Indices de la tabla `cultivo`
--
ALTER TABLE `cultivo`
  ADD PRIMARY KEY (`idcultivo`,`enfermedades_idenfermedades`,`plaga_idplaga`,`cultivoinvernadero_idcultivoinver`),
  ADD KEY `cultivo_FKIndex2` (`cultivoinvernadero_idcultivoinver`),
  ADD KEY `cultivo_FKIndex3` (`invernadero_idinvernadero`),
  ADD KEY `cultivo_FKIndex4` (`estado_idestado`),
  ADD KEY `cultivo_FKIndex5` (`enfermedades_idenfermedades`),
  ADD KEY `cultivo_FKIndex6` (`plaga_idplaga`);

--
-- Indices de la tabla `cultivoinvernadero`
--
ALTER TABLE `cultivoinvernadero`
  ADD PRIMARY KEY (`idcultivoinver`);

--
-- Indices de la tabla `dano_plaen`
--
ALTER TABLE `dano_plaen`
  ADD PRIMARY KEY (`iddano_plaenf`);

--
-- Indices de la tabla `dano_plaen_has_enfermedades`
--
ALTER TABLE `dano_plaen_has_enfermedades`
  ADD PRIMARY KEY (`enfermedades_idenfermedades`,`dano_plaen_iddano_plaenf`),
  ADD KEY `dano_plaen_has_enfermedades_FKIndex1` (`dano_plaen_iddano_plaenf`),
  ADD KEY `dano_plaen_has_enfermedades_FKIndex2` (`enfermedades_idenfermedades`);

--
-- Indices de la tabla `dano_plaen_has_plaga`
--
ALTER TABLE `dano_plaen_has_plaga`
  ADD PRIMARY KEY (`plaga_idplaga`,`dano_plaen_iddano_plaenf`),
  ADD KEY `dano_plaen_has_plaga_FKIndex1` (`dano_plaen_iddano_plaenf`),
  ADD KEY `dano_plaen_has_plaga_FKIndex2` (`plaga_idplaga`);

--
-- Indices de la tabla `enfermedades`
--
ALTER TABLE `enfermedades`
  ADD PRIMARY KEY (`idenfermedades`),
  ADD KEY `enfermedades_FKIndex1` (`crecimiento_idcrecimiento`),
  ADD KEY `enfermedades_FKIndex2` (`estado_idestado`);

--
-- Indices de la tabla `estado`
--
ALTER TABLE `estado`
  ADD PRIMARY KEY (`idestado`),
  ADD KEY `estado_FKIndex1` (`planta_idplanta`),
  ADD KEY `estado_FKIndex2` (`cultivoinvernadero_idcultivoinver`);

--
-- Indices de la tabla `estado_cosecha`
--
ALTER TABLE `estado_cosecha`
  ADD PRIMARY KEY (`idestado_cosecha`,`planta_idplanta`,`enfermedades_idenfermedades`,`plaga_idplaga`,`cultivoinvernadero_idcultivoinver`),
  ADD KEY `estado_cosecha_FKIndex1` (`cultivoinvernadero_idcultivoinver`),
  ADD KEY `estado_cosecha_FKIndex2` (`planta_idplanta`),
  ADD KEY `estado_cosecha_FKIndex3` (`plaga_idplaga`),
  ADD KEY `estado_cosecha_FKIndex4` (`enfermedades_idenfermedades`),
  ADD KEY `tiene` (`mercado_idmercado`);

--
-- Indices de la tabla `estado_humedad`
--
ALTER TABLE `estado_humedad`
  ADD PRIMARY KEY (`id_humedad`);

--
-- Indices de la tabla `estado_tanque`
--
ALTER TABLE `estado_tanque`
  ADD PRIMARY KEY (`id_tanque`);

--
-- Indices de la tabla `estado_temperatura`
--
ALTER TABLE `estado_temperatura`
  ADD PRIMARY KEY (`id_temperatura`);

--
-- Indices de la tabla `fotos`
--
ALTER TABLE `fotos`
  ADD PRIMARY KEY (`idfotos`),
  ADD KEY `fotos_FKIndex1` (`enfermedades_idenfermedades`);

--
-- Indices de la tabla `invernadero`
--
ALTER TABLE `invernadero`
  ADD PRIMARY KEY (`idinvernadero`);

--
-- Indices de la tabla `invernadero_has_cultivoinvernadero`
--
ALTER TABLE `invernadero_has_cultivoinvernadero`
  ADD PRIMARY KEY (`invernadero_idinvernadero`,`cultivoinvernadero_idcultivoinver`),
  ADD KEY `invernadero_has_cultivoinvernadero_FKIndex1` (`invernadero_idinvernadero`),
  ADD KEY `invernadero_has_cultivoinvernadero_FKIndex2` (`cultivoinvernadero_idcultivoinver`);

--
-- Indices de la tabla `medicion`
--
ALTER TABLE `medicion`
  ADD PRIMARY KEY (`idMediciones`),
  ADD KEY `medicion_FKIndex1` (`cultivoinvernadero_idcultivoinver`),
  ADD KEY `medicion_FKIndex2` (`invernadero_idinvernadero`);

--
-- Indices de la tabla `medicionsuelo`
--
ALTER TABLE `medicionsuelo`
  ADD PRIMARY KEY (`idmedicion`);

--
-- Indices de la tabla `mercado`
--
ALTER TABLE `mercado`
  ADD PRIMARY KEY (`id_mercado`);

--
-- Indices de la tabla `plaga`
--
ALTER TABLE `plaga`
  ADD PRIMARY KEY (`idplaga`);

--
-- Indices de la tabla `planta`
--
ALTER TABLE `planta`
  ADD PRIMARY KEY (`idplanta`);

--
-- Indices de la tabla `quimico`
--
ALTER TABLE `quimico`
  ADD PRIMARY KEY (`idquimico`);

--
-- Indices de la tabla `quimico_has_tratamiento`
--
ALTER TABLE `quimico_has_tratamiento`
  ADD PRIMARY KEY (`idquimico_has_tratamiento`),
  ADD KEY `quimico_has_tratamiento_FKIndex1` (`quimico_idquimico`),
  ADD KEY `quimico_has_tratamiento_FKIndex2` (`tratamiento_idtratamiento`,`tratamiento_enfermedades_idenfermedades`,`tratamiento_plaga_idplaga`);

--
-- Indices de la tabla `registro`
--
ALTER TABLE `registro`
  ADD PRIMARY KEY (`idregistro`,`estado_cosecha_idestado_cosecha`,`estado_cosecha_enfermedades_idenfermedades`,`estado_cosecha_planta_idplanta`,`estado_cosecha_plaga_idplaga`,`estado_cosecha_cultivoinvernadero_idcultivoinver`),
  ADD KEY `registro_FKIndex1` (`estado_cosecha_idestado_cosecha`,`estado_cosecha_planta_idplanta`,`estado_cosecha_enfermedades_idenfermedades`,`estado_cosecha_plaga_idplaga`,`estado_cosecha_cultivoinvernadero_idcultivoinver`);

--
-- Indices de la tabla `registro_riego`
--
ALTER TABLE `registro_riego`
  ADD PRIMARY KEY (`id_registro_riego`),
  ADD KEY `id_humedad` (`id_humedad`),
  ADD KEY `id_temperatura` (`id_temperatura`),
  ADD KEY `id_tanque` (`id_tanque`);

--
-- Indices de la tabla `resultadosuelo`
--
ALTER TABLE `resultadosuelo`
  ADD PRIMARY KEY (`idresultadosuelo`),
  ADD KEY `resultadosuelo_FKIndex1` (`sueloestandar_idsueloestandar`),
  ADD KEY `resultadosuelo_FKIndex2` (`medicionsuelo_idmedicion`);

--
-- Indices de la tabla `sueloestandar`
--
ALTER TABLE `sueloestandar`
  ADD PRIMARY KEY (`idsueloestandar`);

--
-- Indices de la tabla `tratamiento`
--
ALTER TABLE `tratamiento`
  ADD PRIMARY KEY (`idtratamiento`,`enfermedades_idenfermedades`,`plaga_idplaga`),
  ADD KEY `tratamiento_FKIndex1` (`plaga_idplaga`),
  ADD KEY `tratamiento_FKIndex2` (`enfermedades_idenfermedades`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `crecimiento`
--
ALTER TABLE `crecimiento`
  MODIFY `idcrecimiento` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cultivo`
--
ALTER TABLE `cultivo`
  MODIFY `idcultivo` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cultivoinvernadero`
--
ALTER TABLE `cultivoinvernadero`
  MODIFY `idcultivoinver` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `dano_plaen`
--
ALTER TABLE `dano_plaen`
  MODIFY `iddano_plaenf` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `enfermedades`
--
ALTER TABLE `enfermedades`
  MODIFY `idenfermedades` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estado`
--
ALTER TABLE `estado`
  MODIFY `idestado` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estado_cosecha`
--
ALTER TABLE `estado_cosecha`
  MODIFY `idestado_cosecha` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estado_humedad`
--
ALTER TABLE `estado_humedad`
  MODIFY `id_humedad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `estado_tanque`
--
ALTER TABLE `estado_tanque`
  MODIFY `id_tanque` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `estado_temperatura`
--
ALTER TABLE `estado_temperatura`
  MODIFY `id_temperatura` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `fotos`
--
ALTER TABLE `fotos`
  MODIFY `idfotos` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `invernadero`
--
ALTER TABLE `invernadero`
  MODIFY `idinvernadero` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `medicion`
--
ALTER TABLE `medicion`
  MODIFY `idMediciones` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `medicionsuelo`
--
ALTER TABLE `medicionsuelo`
  MODIFY `idmedicion` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mercado`
--
ALTER TABLE `mercado`
  MODIFY `id_mercado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `plaga`
--
ALTER TABLE `plaga`
  MODIFY `idplaga` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `planta`
--
ALTER TABLE `planta`
  MODIFY `idplanta` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `quimico`
--
ALTER TABLE `quimico`
  MODIFY `idquimico` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `quimico_has_tratamiento`
--
ALTER TABLE `quimico_has_tratamiento`
  MODIFY `idquimico_has_tratamiento` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `registro`
--
ALTER TABLE `registro`
  MODIFY `idregistro` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `registro_riego`
--
ALTER TABLE `registro_riego`
  MODIFY `id_registro_riego` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `resultadosuelo`
--
ALTER TABLE `resultadosuelo`
  MODIFY `idresultadosuelo` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sueloestandar`
--
ALTER TABLE `sueloestandar`
  MODIFY `idsueloestandar` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tratamiento`
--
ALTER TABLE `tratamiento`
  MODIFY `idtratamiento` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `crecimiento`
--
ALTER TABLE `crecimiento`
  ADD CONSTRAINT `crecimiento_ibfk_1` FOREIGN KEY (`planta_idplanta`) REFERENCES `planta` (`idplanta`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `cultivo`
--
ALTER TABLE `cultivo`
  ADD CONSTRAINT `cultivo_ibfk_1` FOREIGN KEY (`cultivoinvernadero_idcultivoinver`) REFERENCES `cultivoinvernadero` (`idcultivoinver`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `cultivo_ibfk_2` FOREIGN KEY (`invernadero_idinvernadero`) REFERENCES `invernadero` (`idinvernadero`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `cultivo_ibfk_3` FOREIGN KEY (`estado_idestado`) REFERENCES `estado` (`idestado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `cultivo_ibfk_4` FOREIGN KEY (`enfermedades_idenfermedades`) REFERENCES `enfermedades` (`idenfermedades`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `cultivo_ibfk_5` FOREIGN KEY (`plaga_idplaga`) REFERENCES `plaga` (`idplaga`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `dano_plaen_has_enfermedades`
--
ALTER TABLE `dano_plaen_has_enfermedades`
  ADD CONSTRAINT `dano_plaen_has_enfermedades_ibfk_1` FOREIGN KEY (`dano_plaen_iddano_plaenf`) REFERENCES `dano_plaen` (`iddano_plaenf`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `dano_plaen_has_enfermedades_ibfk_2` FOREIGN KEY (`enfermedades_idenfermedades`) REFERENCES `enfermedades` (`idenfermedades`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `dano_plaen_has_plaga`
--
ALTER TABLE `dano_plaen_has_plaga`
  ADD CONSTRAINT `dano_plaen_has_plaga_ibfk_1` FOREIGN KEY (`dano_plaen_iddano_plaenf`) REFERENCES `dano_plaen` (`iddano_plaenf`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `dano_plaen_has_plaga_ibfk_2` FOREIGN KEY (`plaga_idplaga`) REFERENCES `plaga` (`idplaga`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `enfermedades`
--
ALTER TABLE `enfermedades`
  ADD CONSTRAINT `enfermedades_ibfk_1` FOREIGN KEY (`crecimiento_idcrecimiento`) REFERENCES `crecimiento` (`idcrecimiento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `enfermedades_ibfk_2` FOREIGN KEY (`estado_idestado`) REFERENCES `estado` (`idestado`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `estado`
--
ALTER TABLE `estado`
  ADD CONSTRAINT `estado_ibfk_1` FOREIGN KEY (`planta_idplanta`) REFERENCES `planta` (`idplanta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `estado_ibfk_2` FOREIGN KEY (`cultivoinvernadero_idcultivoinver`) REFERENCES `cultivoinvernadero` (`idcultivoinver`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `estado_cosecha`
--
ALTER TABLE `estado_cosecha`
  ADD CONSTRAINT `estado_cosecha_ibfk_1` FOREIGN KEY (`cultivoinvernadero_idcultivoinver`) REFERENCES `cultivoinvernadero` (`idcultivoinver`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `estado_cosecha_ibfk_2` FOREIGN KEY (`planta_idplanta`) REFERENCES `planta` (`idplanta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `estado_cosecha_ibfk_3` FOREIGN KEY (`plaga_idplaga`) REFERENCES `plaga` (`idplaga`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `estado_cosecha_ibfk_4` FOREIGN KEY (`enfermedades_idenfermedades`) REFERENCES `enfermedades` (`idenfermedades`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tiene` FOREIGN KEY (`mercado_idmercado`) REFERENCES `mercado` (`id_mercado`);

--
-- Filtros para la tabla `fotos`
--
ALTER TABLE `fotos`
  ADD CONSTRAINT `fotos_ibfk_1` FOREIGN KEY (`enfermedades_idenfermedades`) REFERENCES `enfermedades` (`idenfermedades`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `invernadero_has_cultivoinvernadero`
--
ALTER TABLE `invernadero_has_cultivoinvernadero`
  ADD CONSTRAINT `invernadero_has_cultivoinvernadero_ibfk_1` FOREIGN KEY (`invernadero_idinvernadero`) REFERENCES `invernadero` (`idinvernadero`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `invernadero_has_cultivoinvernadero_ibfk_2` FOREIGN KEY (`cultivoinvernadero_idcultivoinver`) REFERENCES `cultivoinvernadero` (`idcultivoinver`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `medicion`
--
ALTER TABLE `medicion`
  ADD CONSTRAINT `medicion_ibfk_1` FOREIGN KEY (`cultivoinvernadero_idcultivoinver`) REFERENCES `cultivoinvernadero` (`idcultivoinver`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `medicion_ibfk_2` FOREIGN KEY (`invernadero_idinvernadero`) REFERENCES `invernadero` (`idinvernadero`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `quimico_has_tratamiento`
--
ALTER TABLE `quimico_has_tratamiento`
  ADD CONSTRAINT `quimico_has_tratamiento_ibfk_1` FOREIGN KEY (`quimico_idquimico`) REFERENCES `quimico` (`idquimico`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `quimico_has_tratamiento_ibfk_2` FOREIGN KEY (`tratamiento_idtratamiento`,`tratamiento_enfermedades_idenfermedades`,`tratamiento_plaga_idplaga`) REFERENCES `tratamiento` (`idtratamiento`, `enfermedades_idenfermedades`, `plaga_idplaga`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `registro`
--
ALTER TABLE `registro`
  ADD CONSTRAINT `registro_ibfk_1` FOREIGN KEY (`estado_cosecha_idestado_cosecha`,`estado_cosecha_planta_idplanta`,`estado_cosecha_enfermedades_idenfermedades`,`estado_cosecha_plaga_idplaga`,`estado_cosecha_cultivoinvernadero_idcultivoinver`) REFERENCES `estado_cosecha` (`idestado_cosecha`, `planta_idplanta`, `enfermedades_idenfermedades`, `plaga_idplaga`, `cultivoinvernadero_idcultivoinver`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `registro_riego`
--
ALTER TABLE `registro_riego`
  ADD CONSTRAINT `TI` FOREIGN KEY (`id_tanque`) REFERENCES `estado_tanque` (`id_tanque`),
  ADD CONSTRAINT `TIE` FOREIGN KEY (`id_temperatura`) REFERENCES `estado_temperatura` (`id_temperatura`),
  ADD CONSTRAINT `pos` FOREIGN KEY (`id_humedad`) REFERENCES `estado_humedad` (`id_humedad`);

--
-- Filtros para la tabla `resultadosuelo`
--
ALTER TABLE `resultadosuelo`
  ADD CONSTRAINT `resultadosuelo_ibfk_1` FOREIGN KEY (`sueloestandar_idsueloestandar`) REFERENCES `sueloestandar` (`idsueloestandar`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `resultadosuelo_ibfk_2` FOREIGN KEY (`medicionsuelo_idmedicion`) REFERENCES `medicionsuelo` (`idmedicion`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tratamiento`
--
ALTER TABLE `tratamiento`
  ADD CONSTRAINT `tratamiento_ibfk_1` FOREIGN KEY (`plaga_idplaga`) REFERENCES `plaga` (`idplaga`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tratamiento_ibfk_2` FOREIGN KEY (`enfermedades_idenfermedades`) REFERENCES `enfermedades` (`idenfermedades`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
