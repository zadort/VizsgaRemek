-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 12, 2025 at 09:40 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vizsga3`
--
CREATE DATABASE IF NOT EXISTS `vizsga3` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `vizsga3`;

-- --------------------------------------------------------

--
-- Table structure for table `kartyak`
--

CREATE TABLE `kartyak` (
  `id` int(255) NOT NULL,
  `nev` varchar(255) DEFAULT NULL,
  `ar` int(255) DEFAULT NULL,
  `leiras` varchar(255) DEFAULT NULL,
  `kep_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kartyak`
--

INSERT INTO `kartyak` (`id`, `nev`, `ar`, `leiras`, `kep_url`) VALUES
(1, 'Dell XPS 13', 500000, 'Prémium ultrabook, 13 hüvelykes kijelzővel, Intel Core i7 processzorral és 16GB RAM-mal.', 'https://p1.akcdn.net/full/998179977.dell-xps-13-plus-9320-9320fi7wb1.jpg'),
(2, 'Apple MacBook Air M2', 450000, 'Vékony és könnyű laptop, Apple M2 chip, 13,6 hüvelykes Retina kijelző, és 18 órás üzemidő.', 'https://p1.akcdn.net/full/1081640598.apple-macbook-air-m2-z15s000re.jpg'),
(3, 'Lenovo ThinkPad X1 Carbon', 600000, 'Üzleti laptop, 14 hüvelykes kijelző, Intel Core i7, 16GB RAM és 1TB SSD.', 'https://p1.akcdn.net/full/1284532306.lenovo-thinkpad-x1-carbon-gen-12-21kc0056hv.jpg'),
(4, 'HP Spectre x360', 550000, '2 az 1-ben laptop, érintőképernyős 13,3 hüvelykes kijelző, Intel Core i7 és toll támogatás.', 'https://p1.akcdn.net/full/629150685.hp-spectre-x360-13-aw0001nh-8bs71ea.jpg'),
(5, 'Asus ROG Zephyrus G14', 650000, 'Nagy teljesítményű gamer laptop, AMD Ryzen 9, 14 hüvelykes kijelző és NVIDIA RTX 3060.', 'https://p1.akcdn.net/full/1369513813.asus-rog-zephyrus-g14-ga403uv-qs022w.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kartyak`
--
ALTER TABLE `kartyak`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
