-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 01, 2025 at 09:13 PM
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
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `category` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `category`) VALUES
(1, 'Notebook'),
(2, 'Okostelefon'),
(3, 'Fülhallgató'),
(4, 'Okosóra'),
(5, 'Tablet'),
(6, 'VR Szemüveg');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` int(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `specs` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `description`, `image`, `specs`, `category`) VALUES
(1, 'Dell XPS 13', 500000, 'A Dell XPS 13 a prémium kategóriás, ultrakompakt laptop, amely a legújabb technológiát és stílust ötvözi. Kiváló teljesítménye és lenyűgöző kijelzője ideálissá teszi mindennapi feladatokhoz, kreatív munkához és üzleti használatra.\r\n\r\nFőbb jellemzők:\r\n\r\n  ', 'https://p1.akcdn.net/full/998179977.dell-xps-13-plus-9320-9320fi7wb1.jpg', 'Műszaki adatok:\r\n\r\n    Képernyő mérete: 13,4\" InfinityEdge FHD+ / 4K UHD+ érintőképernyő\r\n    Processzor: Intel Core i5 vagy i7, 10. generáció\r\n    RAM: 8 GB / 16 GB LPDDR4x\r\n    Tárhely: 256 GB / 512 GB / 1 TB SSD\r\n    Operációs rendszer: Windows 11 Home', 'Notebook'),
(2, 'Apple MacBook Air M2', 450000, 'A MacBook Air M2 egy elegáns, könnyű és nagy teljesítményű laptop, amely az Apple új M2 chipjével érkezik, így gyorsabb és energiahatékonyabb, mint valaha. Ideális választás mindennapi feladatokhoz, kreatív munkához, üzleti használatra és szórakozásra egy', 'https://p1.akcdn.net/full/1081640598.apple-macbook-air-m2-z15s000re.jpg', 'Műszaki adatok:\r\n\r\n    Képernyő mérete: 13,6\" Retina kijelző, 2560x1664 pixel felbontás\r\n    Processzor: Apple M2 chip (8 magos CPU, 10 magos GPU)\r\n    RAM: 8 GB / 16 GB Unified Memory\r\n    Tárhely: 256 GB / 512 GB / 1 TB / 2 TB SSD\r\n    Operációs rendsze', 'Notebook'),
(3, 'Lenovo ThinkPad X1 Carbon', 600000, 'A Lenovo ThinkPad X1 Carbon egy prémium kategóriás ultrakönnyű laptop, amely a legújabb technológiát és robusztus dizájnt ötvözi. Kiváló választás üzletembereknek, kreatív szakembereknek és mindenkinek, aki magas szintű teljesítményt és mobilitást igényel', 'https://p1.akcdn.net/full/1284532306.lenovo-thinkpad-x1-carbon-gen-12-21kc0056hv.jpg', 'Műszaki adatok:\r\n\r\n    Képernyő mérete: 14\" WQHD+ (2560x1600) / 4K UHD (3840x2160) IPS, érintőképernyő opcióval\r\n    Processzor: Intel Core i5 / i7 (12. generáció)\r\n    RAM: 16 GB / 32 GB LPDDR5\r\n    Tárhely: 512 GB / 1 TB SSD\r\n    Operációs rendszer: Win', 'Notebook'),
(4, 'HP Spectre x360', 550000, 'A HP Spectre x360 egy prémium 2 az 1-ben laptop, amely kiemelkedő teljesítményt és elegáns dizájnt kínál. A forgatható kijelző és a nagy teljesítmény ideálissá teszi kreatív feladatokhoz, üzleti használatra, és mindennapi feladatokhoz is.\r\n\r\nFőbb jellemző', 'https://p1.akcdn.net/full/629150685.hp-spectre-x360-13-aw0001nh-8bs71ea.jpg', '\r\nMűszaki adatok:\r\n\r\n    Képernyő mérete: 13,5\" / 14\" 3K (3000x2000) / 4K UHD (3840x2160) OLED, érintőképernyő\r\n    Processzor: Intel Core i5 / i7 (12. generáció)\r\n    RAM: 8 GB / 16 GB LPDDR4x\r\n    Tárhely: 512 GB / 1 TB SSD\r\n    Operációs rendszer: Wind', 'Notebook'),
(5, 'Asus ROG Zephyrus G14', 650000, 'Az Asus ROG Zephyrus G14 a prémium kategóriás gaming laptopok királya, amely erőteljes teljesítményt és lenyűgöző dizájnt kínál a játékosok és kreatív szakemberek számára. Kompakt és könnyű kialakítása miatt tökéletes mobilitást biztosít, miközben a legúj', 'https://p1.akcdn.net/full/1369513813.asus-rog-zephyrus-g14-ga403uv-qs022w.jpg', 'Műszaki adatok:\r\n\r\n    Képernyő mérete: 14\" QHD (2560x1600) / 4K UHD, 120Hz / 144Hz, IPS, érintőképernyő\r\n    Processzor: AMD Ryzen 9 7940HS / Ryzen 7 7840HS (7000 sorozat)\r\n    Grafikus kártya: NVIDIA GeForce RTX 4050 / RTX 4060 / RTX 4070\r\n    RAM: 16 G', 'Notebook'),
(6, 'ASUS TUF Gaming A15 FA507NUR-LP005', 350000, 'Az ASUS TUF Gaming A15 FA507NUR-LP005 egy erőteljes és strapabíró gaming laptop, amely ideális választás azok számára, akik kiemelkedő teljesítményre és hosszú távú megbízhatóságra vágynak. A TUF sorozat a tartósságáról és a katonai szabványú tesztelésről', 'https://p1.akcdn.net/full/1328151121.asus-tuf-gaming-a15-fa507nur-lp005.jpg', 'Műszaki adatok:\r\n\r\n    Képernyő mérete: 15,6\" FHD (1920x1080), 144Hz IPS\r\n    Processzor: AMD Ryzen 7 7735HS (8 mag, 16 szál, 3.2GHz alap, 4.8GHz boost)\r\n    Grafikus kártya: NVIDIA GeForce RTX 4060\r\n    RAM: 16 GB DDR5\r\n    Tárhely: 512 GB PCIe Gen 4 SSD', 'Notebook'),
(7, 'Apple MacBook Air 13.3 M1 MGN63MG/A', 385000, 'Az Apple MacBook Air 13.3 M1 MGN63MG/A a legújabb Apple M1 chip-pel felszerelt, prémium ultrakompakt laptop, amely kiemelkedő teljesítményt, lenyűgöző akkumulátor-élettartamot és egyedi dizájnt kínál. Az Apple híres a minőségéről és az egyszerű, de elegán', 'https://p1.akcdn.net/full/1206282703.apple-macbook-air-13-3-m1-mgn63mg-a.jpg', 'Műszaki adatok:\r\n\r\n    Képernyő mérete: 13,3\" Retina kijelző (2560 x 1600 felbontás), True Tone technológia\r\n    Processzor: Apple M1 chip, 8 magos CPU, 7 magos GPU\r\n    RAM: 8 GB Unified RAM\r\n    Tárhely: 256 GB SSD\r\n    Operációs rendszer: macOS Montere', 'Notebook'),
(8, 'ASUS Vivobook X1504VA-BQ772', 190000, 'Az ASUS Vivobook X1504VA-BQ772 egy kiváló ár-érték arányú laptop, amely ideális mindennapi használatra, iskolai feladatokhoz és irodai munkákhoz. A Vivobook sorozatot az egyszerű, mégis megbízható teljesítmény jellemzi, és az X1504VA-BQ772 is ezt a filozó', 'https://p1.akcdn.net/full/1254648817.asus-vivobook-x1504va-bq772.jpg', NULL, 'Notebook'),
(9, 'Lenovo IdeaPad 1 82V700FBHV', 140000, 'A Lenovo IdeaPad 1 82V700FBHV egy költséghatékony és praktikus laptop, amely ideális alapvető feladatokhoz, például internetezéshez, dokumentumok szerkesztéséhez és online tanuláshoz. A könnyű és kompakt kialakításnak köszönhetően könnyedén hordozható, mi', 'https://p1.akcdn.net/full/1244205769.lenovo-ideapad-1-82v700fbhv.jpg', NULL, 'Notebook'),
(10, 'Apple MacBook Air 13 M3 MRXN3MG/A', 455000, 'Az Apple MacBook Air 13 M3 MRXN3MG/A a legújabb generációs MacBook Air, amely az új M3 chip-el érkezik, biztosítva ezzel a még jobb teljesítményt és energiahatékonyságot. A prémium dizájn és az Apple ökoszisztéma zökkenőmentes integrációja tovább növeli a', 'https://p1.akcdn.net/full/1261068961.apple-macbook-air-13-m3-mrxn3mg-a.jpg', NULL, 'Notebook'),
(11, 'Acer Swift Go 14 AI SFG14-01-X2C3 NX.KYXEU.007', 300000, 'Az Acer Swift Go 14 AI SFG14-01-X2C3 egy prémium ultrakönnyű és vékony laptop, amely az Intel Core i5 vagy i7 processzorral és a legújabb generációs technológiákkal érkezik. Az Acer Swift Go ideális választás a mindennapi feladatokhoz, kreatív munkához és', 'https://p1.akcdn.net/full/1375613428.acer-swift-go-14-ai-sfg14-01-x2c3-nx-kyxeu-007.jpg', NULL, 'Notebook'),
(12, 'ASUS Vivobook Go E1504FA-NJ648', 170000, 'Az ASUS Vivobook Go E1504FA-NJ648 egy belépő szintű laptop, amely alapvető feladatokra lett tervezve. Könnyű, de tartós kialakítása, valamint a jó ár-érték aránya miatt ideális választás mindennapi használatra, iskolai munkához vagy irodai alkalmazásokhoz', 'https://p1.akcdn.net/full/1193052613.asus-vivobook-go-e1504fa-nj648.jpg', NULL, 'Notebook'),
(13, 'ASUS TUF Gaming FA506NCR-HN108', 455000, 'Az ASUS TUF Gaming FA506NCR-HN108 egy erőteljes gaming laptop, amely a legújabb hardverekkel és robusztus kialakítással biztosítja a zökkenőmentes és élvezetes gaming élményt. Az AMD Ryzen processzor és a NVIDIA GeForce RTX videokártya lehetővé teszi, hog', 'https://p1.akcdn.net/full/1335152110.asus-tuf-gaming-fa506ncr-hn108.jpg', NULL, 'Notebook'),
(14, 'Apple MacBook Air 13 M2 MLXY3MG/A', 525000, 'MacBook Air M2 chip-hAz Apple MacBook Air 13 M2 egy vékony és könnyű, prémium kategóriás laptop, amely az Apple M2 chip erejére épít, így gyorsabb és hatékonyabb teljesítményt kínál, mint elődje. A 13 hüvelykes Retina kijelző, a hosszú akkumulátor-élettar', 'https://p1.akcdn.net/full/982927995.apple-macbook-air-13-m2-mlxy3mg-a.jpg', NULL, 'Notebook'),
(15, 'Apple MacBook Air 13 M3 MRXV3MG/A', 540000, 'Az Apple MacBook Air 13 M3 a legújabb generációs MacBook Air modell, amely az Apple M3 chip erejére épít, így még gyorsabb és energiatakarékosabb teljesítményt kínál, mint valaha. Az új 13,6\"-os Liquid Retina kijelző, az akár 20 órás akkumulátor-élettarta', 'https://p1.akcdn.net/full/1261068322.apple-macbook-air-13-m3-mrxv3mg-a.jpg', NULL, 'Notebook'),
(16, 'Samsung Galaxy S24 Ultra 5G 256GB 12GB RAM Dual (SM-S928B)', 500000, 'A Samsung Galaxy S24 Ultra 5G a legújabb prémium okostelefon a Samsung Galaxy sorozatában, amely a legújabb technológiai újításokat és a csúcskategóriás teljesítményt ötvözi. Az S24 Ultra 5G a lenyűgöző 200 MP-es főkamerájával, a gyors 5G hálózati támogat', 'https://p1.akcdn.net/full/1240638061.samsung-galaxy-s24-ultra-5g-256gb-12gb-ram-dual-sm-s928b.jpg', NULL, 'Okostelefon'),
(17, 'Xiaomi Poco X7 Pro 5G 512GB 12GB RAM Dual', 450000, 'Erőteljes 5G telefon 512 GB tárolóval és 12 GB RAM-mal.', 'https://p1.akcdn.net/full/1390398406.xiaomi-poco-x7-pro-5g-512gb-12gb-ram-dual.jpg', NULL, 'Okostelefon'),
(18, 'Samsung Galaxy A55 5G 128GB 8GB RAM Dual (SM-A556)', 220000, 'Kiváló középkategóriás okostelefon 8 GB RAM-mal és 128 GB tárolóval.', 'https://p1.akcdn.net/full/1262383174.samsung-galaxy-a55-5g-128gb-8gb-ram-dual-sm-a556.jpg', NULL, 'Okostelefon'),
(19, 'Apple iPhone 16 128GB', 600000, 'Az új iPhone 16, 128 GB tárolóval, fejlett kamerával és teljesítménnyel.', 'https://p1.akcdn.net/full/1337109469.apple-iphone-16-128gb.jpg', NULL, 'Okostelefon'),
(20, 'Apple iPhone 15 128GB', 550000, 'Apple iPhone 15, 128 GB tárolóval és gyors A15 chip-pel.', 'https://p1.akcdn.net/full/1191449686.apple-iphone-15-128gb.jpg', NULL, 'Okostelefon'),
(21, 'Xiaomi Redmi Note 14 Pro 5G 256GB 8GB RAM Dual', 300000, 'Erőteljes Redmi telefon 8 GB RAM-mal és 256 GB tárolóval.', 'https://p1.akcdn.net/full/1389911983.xiaomi-redmi-note-14-pro-5g-256gb-8gb-ram-dual.jpg', NULL, 'Okostelefon'),
(22, 'Apple iPhone 16 Pro 128GB', 650000, 'Az új iPhone 16 Pro, 128 GB tárolóval és Pro kamera rendszerrel.', 'https://p1.akcdn.net/full/1337110597.apple-iphone-16-pro-128gb.jpg', NULL, 'Okostelefon'),
(23, 'Apple iPhone 13 128GB', 500000, 'Apple iPhone 13, 128 GB tárolóval, A15 Bionic chip-pel.', 'https://p1.akcdn.net/full/859255335.apple-iphone-13-128gb.jpg', NULL, 'Okostelefon'),
(24, 'Samsung Galaxy S24 5G 128GB 8GB RAM Dual (SM-S921B)', 450000, 'Samsung Galaxy S24, 8 GB RAM-mal és 128 GB tárolóval.', 'https://p1.akcdn.net/full/1240638142.samsung-galaxy-s24-5g-128gb-8gb-ram-dual-sm-s921b.jpg', NULL, 'Okostelefon'),
(25, 'Xiaomi Redmi Note 13 Pro 5G 256GB 8GB RAM Dual', 290000, 'Xiaomi Redmi Note 13 Pro 5G, 8 GB RAM-mal és 256 GB tárolóval.', 'https://p1.akcdn.net/full/1239096694.xiaomi-redmi-note-13-pro-5g-256gb-8gb-ram-dual.jpg', NULL, 'Okostelefon'),
(26, 'Samsung Galaxy Buds3 Pro (SM-R630NZ)', 95000, 'Prémium fülhallgató kiváló hangminőséggel és aktív zajszűréssel.', 'https://p1.akcdn.net/full/1318706245.samsung-galaxy-buds3-pro-sm-r630nz.jpg', NULL, 'Fülhallgató'),
(27, 'Apple AirPods Pro 2 (MTJV3ZM/A/MTJV3TY/A)', 120000, 'Új generációs AirPods Pro, aktív zajszűrés és térbeli hangélmény.', 'https://p1.akcdn.net/full/1193325349.apple-airpods-pro-2-mtjv3zm-a-mtjv3ty-a.jpg', NULL, 'Fülhallgató'),
(28, 'Apple AirPods 4 gen. ANC (MXP93ZM/A)', 105000, 'AirPods 4, aktív zajszűréssel és rendkívül kényelmes viselettel.', 'https://p1.akcdn.net/full/1339403914.apple-airpods-4-gen-anc-mxp93zm-a.jpg', NULL, 'Fülhallgató'),
(29, 'Xiaomi Redmi Buds 5 Pro (BHR7660/62GL)', 40000, 'Jó ár-érték arányú fülhallgató, kiváló hangzással és hosszú üzemidővel.', 'https://p1.akcdn.net/full/1239749854.xiaomi-redmi-buds-5-pro-bhr7660-62gl.jpg', NULL, 'Fülhallgató'),
(30, 'Apple AirPods 4 gen. (MXP63ZM/A)', 95000, 'AirPods 4, kiemelkedő hangminőség és könnyű csatlakozás Apple eszközökhöz.', 'https://p1.akcdn.net/full/1339403959.apple-airpods-4-gen-mxp63zm-a.jpg', NULL, 'Fülhallgató'),
(31, 'Samsung Galaxy Buds3 (SM-R530)', 75000, 'Kiváló minőségű hangzás és kényelmes viselet a mindennapokra.', 'https://p1.akcdn.net/full/1310516590.samsung-galaxy-buds3-sm-r530.jpg', NULL, 'Fülhallgató'),
(32, 'Samsung Galaxy Buds FE (SM-R400)', 65000, 'Kiváló ár-érték arányú fülhallgató, kényelmes használat és jó hangzás.', 'https://p1.akcdn.net/full/1202072440.samsung-galaxy-buds-fe-sm-r400.jpg', NULL, 'Fülhallgató'),
(33, 'Apple AirPods 2 (MV7N2TY/MV7N2RU/A / MV7N2ZM)', 60000, 'Kiváló minőségű AirPods 2, könnyű használat és remek hangzás.', 'https://p1.akcdn.net/full/787785633.apple-airpods-2-mv7n2ty-mv7n2ru-a-mv7n2zm.jpg', NULL, 'Fülhallgató'),
(34, 'Xiaomi Redmi Buds 6 Play (BHR8776GL)', 35000, 'Jó ár-érték arányú vezeték nélküli fülhallgató.', 'https://p1.akcdn.net/full/1337979472.xiaomi-redmi-buds-6-play-bhr8776gl.jpg', NULL, 'Fülhallgató'),
(35, 'Xiaomi Redmi Buds 6 Active (BHR839GL)', 38000, 'Kényelmes, vízálló és sportoláshoz is ideális fülhallgató.', 'https://p1.akcdn.net/full/1326418861.xiaomi-redmi-buds-6-active-bhr839gl.jpg', NULL, 'Fülhallgató'),
(36, 'Samsung Galaxy Watch Ultra LTE 47mm (L705)', 300000, 'Kiváló okosóra LTE támogatással és prémium megjelenéssel.', 'https://p1.akcdn.net/full/1315312654.samsung-galaxy-watch-ultra-lte-47mm-l705.jpg', NULL, 'Okosóra'),
(37, 'Huawei Watch D2', 150000, 'Elegáns és funkcionális okosóra, ideális mindennapi használatra.', 'https://p1.akcdn.net/full/1345013809.huawei-watch-d2.jpg', NULL, 'Okosóra'),
(38, 'Xiaomi Redmi Watch 5 Active', 25000, 'Könnyű és sportos okosóra, hosszú akkumulátor élettartammal.', 'https://p1.akcdn.net/full/1345014970.xiaomi-redmi-watch-5-active.jpg', NULL, 'Okosóra'),
(39, 'Apple Watch Ultra 2 GPS + Cellular 49mm', 600000, 'Prémium Apple Watch Ultra 2, GPS + Cellular támogatással.', 'https://p1.akcdn.net/full/1191863290.apple-watch-ultra-2-gps-cellular-49mm.jpg', NULL, 'Okosóra'),
(40, 'Xiaomi Redmi Watch 5', 35000, 'Okosóra okos funkciókkal, ideális ár-érték arányú választás.', 'https://p1.akcdn.net/full/1393228738.xiaomi-redmi-watch-5.jpg', NULL, 'Okosóra'),
(41, 'Xiaomi Smart Band 9', 15000, 'Sportos és kényelmes okoskarkötő, ideális fitnesz követéshez.', 'https://p1.akcdn.net/full/1331218648.xiaomi-smart-band-9.jpg', NULL, 'Okosóra'),
(42, 'Samsung Galaxy Watch 7 44mm (L310)', 350000, 'Samsung prémium okosórája, szép kijelzővel és okos funkciókkal.', 'https://p1.akcdn.net/full/1315312141.samsung-galaxy-watch-7-44mm-l310.jpg', NULL, 'Okosóra'),
(43, 'Xiaomi Watch S3', 60000, 'Stílusos és hosszú üzemidővel rendelkező okosóra a mindennapi használathoz.', 'https://p1.akcdn.net/full/1239778183.xiaomi-watch-s3.jpg', NULL, 'Okosóra'),
(44, 'Samsung Galaxy Watch6 40mm Bluetooth (SM-R930)', 250000, 'Samsung Galaxy Watch 6, 40mm-es Bluetooth változat, elegáns és funkcionalitással.', 'https://p1.akcdn.net/full/1175866380.samsung-galaxy-watch6-40mm-bluetooth-sm-r930.jpg', NULL, 'Okosóra'),
(45, 'Apple Watch Series 10 GPS 46mm', 500000, 'Apple Watch Series 10, 46mm-es GPS változat, prémium megjelenés és funkciók.', 'https://p1.akcdn.net/full/1340662093.apple-watch-series-10-gps-46mm.jpg', NULL, 'Okosóra'),
(46, 'Samsung Galaxy Tab A9+ X210 128GB', 120000, 'Kiváló minőségű táblagép, nagy teljesítmény és nagy kijelző.', 'https://p1.akcdn.net/full/1229535301.samsung-galaxy-tab-a9-x210-128gb.jpg', NULL, 'Tablet'),
(47, 'Xiaomi Redmi Pad Pro 6GB+128GB', 95000, 'Erőteljes táblagép, nagyszerű ár-érték arány.', 'https://p1.akcdn.net/full/1297413103.xiaomi-redmi-pad-pro-6gb-128gb.jpg', NULL, 'Tablet'),
(48, 'Apple iPad 10.9 2022 64GB MPQ23/MCM94', 190000, 'Apple iPad 10.9 64GB, könnyű és erőteljes készülék.', 'https://p1.akcdn.net/full/1047905520.apple-ipad-10-9-2022-64gb-mpq23-mcm94.jpg', NULL, 'Tablet'),
(49, 'Samsung Galaxy Tab S9 FE X510 128GB', 150000, 'Samsung prémium táblagép, nagy kijelző és hosszú üzemidő.', 'https://p1.akcdn.net/full/1201519633.samsung-galaxy-tab-s9-fe-x510-128gb.jpg', NULL, 'Tablet'),
(50, 'Samsung Galaxy Tab A9 X110N 64GB', 90000, 'Kiváló választás mindennapi használatra, nagy teljesítménnyel.', 'https://p1.akcdn.net/full/1224859981.samsung-galaxy-tab-a9-x110n-64gb.jpg', NULL, 'Tablet'),
(51, 'Xiaomi Redmi Pad SE 11 4GB+128GB', 75000, 'Sportos és könnyen kezelhető táblagép, ideális szórakozáshoz és munkához.', 'https://p1.akcdn.net/full/1188909229.xiaomi-redmi-pad-se-11-4gb-128gb.jpg', NULL, 'Tablet'),
(52, 'Samsung Galaxy Tab A9+ X210N 64GB', 105000, 'Kiváló teljesítmény és kiváló kijelző kombinációja.', 'https://p1.akcdn.net/full/1226174050.samsung-galaxy-tab-a9-x210n-64gb.jpg', NULL, 'Tablet'),
(53, 'Apple iPad Air 6 2024 11 128GB MUWD3', 320000, 'Kiváló teljesítmény és dizájn, prémium Apple táblagép.', 'https://p1.akcdn.net/full/1284906358.apple-ipad-air-6-2024-11-128gb-muwd3.jpg', NULL, 'Tablet'),
(54, 'Xiaomi Pad 6 6GB+128GB', 110000, 'Erőteljes Xiaomi táblagép, tökéletes a mindennapi használathoz.', 'https://p1.akcdn.net/full/1167369939.xiaomi-pad-6-6gb-128gb.jpg', NULL, 'Tablet'),
(55, 'Apple iPad 10.9 2022 64GB MPQ13/MCM84', 200000, 'Apple iPad 10.9 2022, erős teljesítmény és magas minőség.', 'https://p1.akcdn.net/full/1376043541.apple-ipad-10-9-2022-64gb-mpq13-mcm84.jpg', NULL, 'Tablet'),
(56, 'Meta Quest 3 128 GB (899-00582-01)', 250000, 'Meta Quest 3, 128 GB tároló, prémium VR élmény.', 'https://p1.akcdn.net/full/1213770922.meta-quest-3-128-gb-899-00582-01.jpg', NULL, 'VR Szemüveg'),
(57, 'Sony PlayStation VR2 (PS719453994)', 350000, 'Sony PlayStation VR2, csúcsminőségű VR élmény PlayStation 5-höz.', 'https://p1.akcdn.net/full/1110727089.sony-playstation-vr2-ps719453994.jpg', NULL, 'VR Szemüveg'),
(58, 'Meta Quest 3S 128 GB (1000206-01)', 280000, 'Meta Quest 3S, 128 GB, a legújabb VR technológia.', 'https://p1.akcdn.net/full/1357325752.meta-quest-3s-128-gb-1000206-01.jpg', NULL, 'VR Szemüveg'),
(59, 'Meta Quest 3 512GB (899-00583-01/899-00586-01)', 350000, 'Meta Quest 3, 512 GB tároló, nagyszerű VR élmény és teljesítmény.', 'https://p1.akcdn.net/full/1243525054.meta-quest-3-512gb-899-00583-01-899-00586-01.jpg', NULL, 'VR Szemüveg'),
(60, 'Meta Quest 2 Elite (899-00208-01)', 200000, 'Meta Quest 2 Elite, kiváló VR eszköz, kényelmes és erőteljes.', 'https://p1.akcdn.net/full/1311948094.meta-quest-2-elite-899-00208-01.jpg', NULL, 'VR Szemüveg'),
(61, 'XREAL Air 2 Pro AR (X1003)', 120000, 'XREAL Air 2 Pro AR, fejlett AR technológia, hordozható és könnyű.', 'https://p1.akcdn.net/full/1333739581.xreal-air-2-pro-ar-x1003.jpg', NULL, 'VR Szemüveg'),
(62, 'Meta Oculus Quest Pro 256GB (899-00412-01/899-00416-01)', 500000, 'Meta Oculus Quest Pro, 256 GB tároló, prémium VR élmény és fejlettebb hardver.', 'https://p1.akcdn.net/full/1111212099.meta-oculus-quest-pro-256gb-899-00412-01-899-00416-01.jpg', NULL, 'VR Szemüveg'),
(63, 'Meta Quest 3S 256 GB (1000212-01)', 320000, 'Meta Quest 3S, 256 GB tároló, rendkívül fejlett VR technológia.', 'https://p1.akcdn.net/full/1390399681.meta-quest-3s-256-gb-1000212-01.jpg', NULL, 'VR Szemüveg'),
(64, 'Sony PlayStation VR2 + Horizon Call of the Mountain (PS711000036282)', 400000, 'Sony PlayStation VR2 + Horizon Call of the Mountain, teljes VR csomag.', 'https://p1.akcdn.net/full/1110726951.sony-playstation-vr2-horizon-call-of-the-mountain-ps711000036282.jpg', NULL, 'VR Szemüveg'),
(65, 'HTC VIVE Pro 2 Full Kit (99HASZ003-00)', 800000, 'HTC VIVE Pro 2, professzionális VR élmény, teljes kit.', 'https://p1.akcdn.net/full/903076941.htc-vive-pro-2-full-kit-99hasz003-00.jpg', NULL, 'VR Szemüveg');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(255) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`) VALUES
(1, 'admin', 'admin', 'admin@gmail.com'),
(2, 'tspore1', '$2a$04$MiEfeKRoA.EBODXV4agF1u4.lt7zqN74Lx8Bv2KMlWopJOCdslLJ.', 'zbursell1@homestead.com'),
(3, 'efreezor2', '$2a$04$/obz10JvtTHLMBKOl9rAZ.T6aPc/ztYRPDs/cvUpZ1orn5izr0XxK', 'vjobke2@usatoday.com'),
(4, 'skolak3', '$2a$04$N0k.hQUUPMrSNlDs9jLfSO/tSaGECuklNYRtTJ9.kPW1abvmo7N3m', 'ubellefonte3@google.co.uk'),
(5, 'smacconnulty4', '$2a$04$k0Vku6vIg5FvWurCXxGYOuwV4id/ywxg4MDdMMbp0rbJEcCAzjt32', 'adrowsfield4@mapquest.com'),
(6, 'msterman5', '$2a$04$RIqRbQlVpf8iWbpQQ7RMqOcNMTJSRAMLWHxE06UpMrQIZLoC5Id4u', 'dosgorby5@uol.com.br'),
(7, 'vwansbury6', '$2a$04$QJyXIga9.ht8I4PKIfC7J.z7hIOejfxlw2lXxS2HUrTvxRlT4eIIC', 'lbelderson6@ameblo.jp'),
(8, 'pwaylen7', '$2a$04$sNYlEIbd1pz9RlTKFSlyEeFLVI3l8O7EQqxAUHhz9pQHzSGTq8JYS', 'jkenelin7@merriam-webster.com'),
(9, 'ameletti8', '$2a$04$JeAPeoCLGtE4M4PxRNaf6OmT0a0cYvdFx9XK2CGX9/IwpIn0bYJl6', 'rleftley8@skyrock.com'),
(10, 'emcaneny9', '$2a$04$BDe7HsLDZe56DU5i7tlx2.2EXg1UrKodkhHA4cIvitBkvSG1s9ndW', 'rsivil9@vimeo.com'),
(11, 'blabbaa', '$2a$04$vLlgJBAOJyc5LVr/HxETc.6hzIOb2FTarACA/BqtoXQlLWHUGTUCq', 'gmcdonagha@storify.com'),
(12, 'pmatzkaitisb', '$2a$04$afZSikeNum86ZpRVAlKd6.3raWL6acdY3YmnLuZawJXkCga1sWiPG', 'shannigerb@netscape.com'),
(13, 'stutchellc', '$2a$04$SYkd4pEfPtRaDBLwZGX.Fe4MTNHBjvO2eio2gobtBOOgrxil9Nefa', 'dtreacyc@lulu.com'),
(14, 'spinillad', '$2a$04$p790luiiaNGS70Ec0k09BO9YyE.jsKAebLltTsS1OUIBVak7WfXSW', 'sstringmand@amazon.co.uk'),
(15, 'fsoutherane', '$2a$04$M0zTy47/zYSCOu2AbLFACedYkmQq57sZbfJ5uPcwRFRzGXt/YKlTq', 'rwollrauche@wikia.com'),
(16, 'tharrellf', '$2a$04$/tYeYRI781CiaJJlg52Im.cSjEX1o389tsfhP6yJPfawNFVA57Mda', 'abolsoverf@who.int'),
(17, 'udicheg', '$2a$04$lZNWHQPL4L.InVLGvdJL2ucbtd/WusPINRDLk3GAiAMov3gQUfgoW', 'chilling@nhs.uk'),
(18, 'rpautoth', '$2a$04$Feqm4wPQuompiVMFObaAj.FGu5U7sMid4ZFTHsGZKHz6esEBWvh.S', 'zrockhillh@phoca.cz'),
(19, 'ptauntoni', '$2a$04$3LLSOGj/QEeJ/q2jk985q.bkuzLJgcoNKm2kqSOxhh9bf2embRxY.', 'jgrzelaki@hatena.ne.jp'),
(20, 'lpolj', '$2a$04$huUdI621Z2fkq0CVLXwtbOM6ogTKgjkgGTvpyyaTXnC9ZyqxMQkhS', 'mlamberthj@sciencedirect.com'),
(21, 'nsolank', '$2a$04$P3/VGBXennRQJ/xg8fQgIeLAv9L.hZsVIJ.CniCkiEO9Ye2A8BmWq', 'cmaccrackenk@europa.eu'),
(22, 'sdemangell', '$2a$04$/lp1HZM6ZJa8BfRA06QuLOTGKZMSgiz5DsgZt1K42p7q1F8qhhHJq', 'bormrodl@scientificamerican.com'),
(23, 'sbleuem', '$2a$04$TY5E.nog4u8VP9JvcNZFiusN6P8Tle4/aZm0ycsW2.R.hLb6QaGZC', 'jmcallanm@mediafire.com'),
(24, 'plimeburnern', '$2a$04$2S99iJY1iB.UBaIFhOV1r.6yCuvniZDMYDkYVeVvMrCnVZh3eqk9O', 'dnaismithn@xinhuanet.com'),
(25, 'mcarlowo', '$2a$04$s5TkAnwhsjv.Vvg2rlv7zu.hwswJqS0Rn5YSifp6.DCNvuexXF0bq', 'cblankmano@europa.eu'),
(26, 'gmeadowcraftp', '$2a$04$r3aTxKpDffUecHbLieTJ6.47/DmRP9QBKgNqjjgtT6NvCsFY6.wQy', 'nhalmkinp@loc.gov'),
(27, 'cdighthamq', '$2a$04$/WLJThlhbJIqd3J7c58dEuqHtgRoU6i5dwelFnakpMWRaLhDbfEIG', 'jdinckeq@usatoday.com'),
(28, 'jstonuaryr', '$2a$04$nuvk4rnMzQBvQFJMq989c.ex06Wc.qXc.7GoI7UHK4aGUnzBWjSw2', 'npaner@is.gd'),
(29, 'hfountaines', '$2a$04$.Tsfc7zCjUKTloTSu7gbfuHmrzK1TK5Z372mRtayto4Kxsb95p5cO', 'cmeardons@elegantthemes.com'),
(30, 'kfergusont', '$2a$04$YYlf2lZugQvG9u/JTzeH7.dhdMorXgF6/qR79dM1pF64Gc7hIQ2yi', 'jbrookhouset@wired.com'),
(31, 'agauntlettu', '$2a$04$5K9nYRAZIOd36OzqHJj4cOm/BhfsLYCix8tjZiMu/BxcpMWMUf21C', 'kriseboroughu@epa.gov'),
(32, 'fnavarrev', '$2a$04$bzlsNmLfbC6gTkbmil5s0OrgtPVIbGPLUgYc38tME7KDu8yOwbsTy', 'pbinfordv@plala.or.jp'),
(33, 'pgavenw', '$2a$04$vzK20Oh6z8wCgKDwuko3Hu3dSEqxBU/p4tgQW1fK5zfyTGcxT00We', 'amedlerw@cyberchimps.com'),
(34, 'hstemsonx', '$2a$04$B/I3tDkDL6LbrdognHZJw.0cwlmTlNIMTnEUEqlhleOpofniMshFe', 'smulheronx@auda.org.au'),
(35, 'reckeryy', '$2a$04$JAHCbCbQASb/SYKcoDtH9u0cQIPKvBg9Y13owoT3TV0XkbLerNSuq', 'jlassetery@goo.ne.jp'),
(36, 'smaccumeskeyz', '$2a$04$MVUl2foL5yD9ZVgabRPZH.PAVfybzJ/fBs1fmTKUlsSAuVsL1RiWW', 'mrauz@ning.com'),
(37, 'wworsnop10', '$2a$04$5lyB.4Ia53tdk.z97hQBuuRSJ4HxGT2UlteW4GCum//5my60tKliS', 'hbente10@goo.ne.jp'),
(38, 'ifareweather11', '$2a$04$86/lLfOWaUpJ1AV9yhLKTeKjAFY7l62aKSDHjg5Nji4vDHhyyJIV.', 'ctatlock11@china.com.cn'),
(39, 'mlorincz12', '$2a$04$W.4z1CPMqzejt0XGvvTUFuA1ZihY/Ex3tiBoFo9yBout7hklCGLHW', 'mbusen12@indiatimes.com'),
(40, 'nwoollett13', '$2a$04$5Pc34Yu.ZeUrM/sLVQ1u6OJjCP.b6vpGZldYYj5l8NUYjp8.POES2', 'bkerins13@blogs.com'),
(41, 'jvautrey14', '$2a$04$n8Uf3oL1/hpUAiwD574VuO5V3peAC8tR9zXCIYWFfFkm5nPCdaC82', 'lbeake14@jigsy.com'),
(42, 'cpainten15', '$2a$04$Nk4gwn21asZ6h7TkNA3U3O41YblJzq8xTu23fxMmT.0AF3Mtp8KWO', 'lahrend15@unc.edu'),
(43, 'jmacmeeking16', '$2a$04$V8JQo1bssrcnWdDNOK4.te0uR8tDupiUqeoNM4SUz1Jmcu4lNwG7u', 'gjulien16@guardian.co.uk'),
(44, 'dascrofte17', '$2a$04$IIpZ/L/ha5hoc4pxMVwG1e0itfUwP3TE8RVNunlSWQkSPxcZ4dq4K', 'kschechter17@fema.gov'),
(45, 'mchavey18', '$2a$04$.jhoHaa3yFRP6YyeNnPH3ew2KnYtjP/vQDzCaQOWND.1qmzUblXZ6', 'shurich18@jiathis.com'),
(46, 'mtammadge19', '$2a$04$afZXf6kj8Z58/t5NsGqFAu1nICYLE5HWrU9Dt6m0D0pecSJjw1qZS', 'wdorr19@ustream.tv'),
(47, 'odewan1a', '$2a$04$sOKYp3VRnvcBChCYsWFLBu1e.ewM/oQFpcn9UHemeeT4S3U2XoJQO', 'cbreslauer1a@studiopress.com'),
(48, 'sgorst1b', '$2a$04$gxvzK1255lkfEX.6PufDyOguTriytVM5yHpvPbi7yh/dSK/emhiwK', 'fmariet1b@bbb.org'),
(49, 'finsole1c', '$2a$04$5qeeyM79LJ8X1wQZ4CIGsO40mJF48h.CE2EWUD7kccM2H77yNWQhq', 'kcatton1c@1und1.de'),
(50, 'seagers1d', '$2a$04$FGMB5e1YMoFtBIWZlw67N.RCeYRs5q9uS1GE5T3TpLlO2roy63ZVq', 'mleyborne1d@usnews.com'),
(51, 'nbeston1e', '$2a$04$pIcTjlZwkmdHv7azdbnyGOkafIcRnQXeFTQPvHesYd...01tjtRaa', 'sbednall1e@vkontakte.ru'),
(52, 'nleyburn1f', '$2a$04$Mu0.6f85zF.aGkb06sK42OghZYZ/4wG8QEetPplk0a0vhFHsOQ3ey', 'psalvage1f@amazon.com'),
(53, 'iarrell1g', '$2a$04$a/BVyKHZdQEhd92lCfOxieqJemHXXwiC8ZbHh8DMZeq.Rx855m/fG', 'smcsherry1g@sina.com.cn'),
(54, 'gharrowing1h', '$2a$04$.BFBjE6d/ailgPbQy8wqHuUOkXPo8ZuaAiO7Lzc5xr5NQNiRHfDRm', 'cagius1h@utexas.edu'),
(55, 'rdutteridge1i', '$2a$04$eHiCyZ7Iv1luEyqtEdE.jefEFtM223aj7tcQOu0g8duUwqRNfMRTG', 'dmcmanus1i@ning.com'),
(56, 'cclearie1j', '$2a$04$RMSiBlUaFUkz3j8Qkl9wL.H.Sn/LTjY9OxEoLdtZ6b0yiL0OTKAH6', 'cjiggen1j@vistaprint.com'),
(57, 'dsilvers1k', '$2a$04$4UxZ8/EhsZ0nU09LwQfSr.s6fJ3b/yhEtHJWi4U4hwbKPAiYFpStK', 'htume1k@columbia.edu'),
(58, 'amuslim1l', '$2a$04$2sI3xQ823yz7/qxRUhcIneeJ8fjO6zDLzpg8KcuW3fvTJR7Aj4nmK', 'dtrevains1l@soundcloud.com'),
(59, 'bbrocklebank1m', '$2a$04$Lm5lZ99uzEQzQ2GWu07Cde9lT1zkuuq/yrT3TEq70nRuudpzwbm0e', 'jcleverly1m@tinyurl.com'),
(60, 'ehawkin1n', '$2a$04$OkUAasscWyxcdRpb.TR6suwXHOSkBc6TkvxLxFt.oyruvpZeU5Mf.', 'ccheesworth1n@cyberchimps.com'),
(61, 'lcodrington1o', '$2a$04$UBojILoDBRw9hpSTisF/O.NdFsADJZeBZWZObaHLRZFipeQCQk0T2', 'trenish1o@blogtalkradio.com'),
(62, 'csomerville1p', '$2a$04$g9WYMkFx34X6D2ARz8xiC.mDaJ7uma6B/uwtxXlVxhkjcv7Eqzik6', 'eburtwhistle1p@jimdo.com'),
(63, 'jroe1q', '$2a$04$D4jONnQMWzIn5iKD3NXyLOUKTb8goF/0cwIWTKHzxLT8CAO4Frw..', 'rgrouen1q@answers.com'),
(64, 'ecreggan1r', '$2a$04$2S7RTvQEkwJcet49wBDmaOEw.gylrSyrHcoD.BimM79sNou8QXFzW', 'civel1r@usnews.com'),
(65, 'camaya1s', '$2a$04$QNqcNKYSe3pUoMIwFCRYu.tjdMiTDo1FsauB2T7WNOuwq/Yxr1apC', 'lklempke1s@twitter.com'),
(66, 'dgoacher1t', '$2a$04$UWRT0eCEZmYp1lUpCQgH0OEDQ7IquWviUJZzffVVT8sqxXiMugsv6', 'mskones1t@cbsnews.com'),
(67, 'wmillott1u', '$2a$04$1lnWLAAlHrYsT6Wq7HEYIeEZV.tDoPnvdB89RGTv6cG47CxM39Bgq', 'vgarret1u@businessweek.com'),
(68, 'bgealle1v', '$2a$04$NAswWIRXSyz8MeTNioppa.E6voWIkSzNuHBtXmjOUMpk1lGrx1t26', 'odellcasa1v@ted.com'),
(69, 'scleyburn1w', '$2a$04$FeHEZBboYhzc2RBGpJGLiOlZr.TqbdGGXO6X/gtb2vvdkExLnC7Cy', 'fhallock1w@netvibes.com'),
(70, 'wwyldbore1x', '$2a$04$mi9/NRUYfGLf2iAnkV1AvubX0/siSNLtLdwzyUudIMZS91MNvHOKW', 'shegges1x@umich.edu'),
(71, 'vbulbrook1y', '$2a$04$p63.7pA.Iq/8QOsrDpmcoe9RH/CgiF444HdT4Aq7L8w/HsdCkKPi.', 'sigounet1y@blog.com'),
(72, 'mselwyn1z', '$2a$04$IVEunFEzS44olTDWZraaIuv8nIXHc0zQV4z87Gkz7nytvdDEjbmH.', 'adiviny1z@lycos.com'),
(73, 'bfreschi20', '$2a$04$NIBYWHK2j6XyzUB6lCTgce9K1MBrkltWItUJouKa9jhevpBB6cOka', 'aravens20@nydailynews.com'),
(74, 'thuband21', '$2a$04$z29dq3Qdy7/Vv2jeR729x.sBko7uaNc4Y5Yon/5W4bnGyCmXVL6Z2', 'jdeviney21@nhs.uk'),
(75, 'bmcilwrath22', '$2a$04$TInAjSQM6wUNs6zfW6/2.u1zFx10HWjFIiv4Igx4W8r5f2xds4ce2', 'abrittoner22@photobucket.com'),
(76, 'veverly23', '$2a$04$CC2ZBsKAIiVQcglF2qnvCe.C4de42PrWroLXfjbAIF1XC2EfulcC2', 'nansley23@tuttocitta.it'),
(77, 'acruddas24', '$2a$04$nfguL80Yjeb6KRbzYhZNHuZ4qFNY8PbG9HtSrcjraihq8U1bTv38K', 'bhilbourne24@sun.com'),
(78, 'hertelt25', '$2a$04$GcbZgwrStmhZZ4qN43FPq.uoVZC6.yQ2g3jRL.jmRrdvC18A2snZ6', 'jmandel25@cbslocal.com'),
(79, 'jvalero26', '$2a$04$iAwjIiOx9y9cGMI2L.47JeT4H1Bj.LDmZ6tSe3vHGeF18cCIKl6qi', 'llaste26@wired.com'),
(80, 'esager27', '$2a$04$JxEnCq9/Kq0/RvDq2mbpWO1JEamLAVP4HIrbOiDXsYKGAJNAE2ZKK', 'tgrubbe27@yale.edu'),
(81, 'hflanner28', '$2a$04$gG9RGaLJ/.4a7ijQJKtx7OmDrcqGreLVeRxYfbjMkTRa35hxjX8Qq', 'rplank28@live.com'),
(82, 'kgarrity29', '$2a$04$eHLLqON8VxZ301vIFcfrK.ouscIFvE5xpuQ/SQsUGuzTm8vaWJbyq', 'cspehr29@digg.com'),
(83, 'squarton2a', '$2a$04$ktKf9NSFrqexgwlv2dNteeb7zCwO1sXKLElUDwlotLp7yaoSYnr26', 'cdillon2a@cbsnews.com'),
(84, 'kfife2b', '$2a$04$4wio1WTAT0.DLFmbtBsm9OY1ABs/q5eKL4Icp8TrA5MHANGTegrLq', 'rfendt2b@bloglovin.com'),
(85, 'hgrowy2c', '$2a$04$VoFLYU11EgGDmmPL8HpKTexVWk29ZHyuKNY0oF.47Jbf9LHQlshhm', 'jlodemann2c@berkeley.edu'),
(86, 'cmcilmorie2d', '$2a$04$sEYZFvCYX2ZjakQDTX8Ja.VdTfRqS3ri0NE.iGkRhq1Ey5uaJh7UO', 'dfrandsen2d@twitter.com'),
(87, 'alesieur2e', '$2a$04$mJwp.xHoorSsBAkuGamHe.pvMvftZFdJ0RSjbQN9yBNk8CUm7LXh.', 'agolsworthy2e@tamu.edu'),
(88, 'aquirke2f', '$2a$04$edVK74XPPfV7krP.6D93wO986ZHp4XIYuNo0fGYxtmo6ANZnqWRS.', 'ploverock2f@google.it'),
(89, 'gnursey2g', '$2a$04$FzrK1b31Ldf0ADaLBP7BVOC5L2jUvmtS/71S8gH2rl0iYFxkz1RcC', 'hjex2g@gmpg.org'),
(90, 'strevan2h', '$2a$04$WOOh3QGl9x8SaRzeRUY74OxSZ2K1IU6KHw0INdwFrlTUFXrKzBPnC', 'wormrod2h@house.gov'),
(91, 'wdowney2i', '$2a$04$GjJ/kr5hy/n6Ppe1CIIwO.m.okh2vN1AytvjrYV2D1FkEbf73eR4K', 'bcolebrook2i@theglobeandmail.com'),
(92, 'mnemchinov2j', '$2a$04$YcBABazcdyiVnJRdBR7Y.uPOWqRpCOjYa5ftb.GX9BvEIh.m6ahjK', 'grayman2j@taobao.com'),
(93, 'rfensome2k', '$2a$04$229Y2In80cPEOoHrHeZ0/OcWY2Q51ep8zHVX.RSSSPVZMHrsUFpCa', 'ljepson2k@bloglines.com'),
(94, 'dsmalecombe2l', '$2a$04$axwZWNUyvTKXxkhvgB33suuqjt21vJbv7NPER/DKIuLo/k7/Rx7rG', 'esheer2l@army.mil'),
(95, 'ktrowsdall2m', '$2a$04$P5ocOXi/ZSTD0GWZYpd4/OsVC3KMjODf3yqx5YTmgzS5adt47w17y', 'lpimblotte2m@cdbaby.com'),
(96, 'mreidie2n', '$2a$04$vajKc/H97R3tBOVsCCmxy.CxwmTk.L3UTNP3X9doce.GSVO3J02Jm', 'bambrogioli2n@cmu.edu'),
(97, 'ekarolczyk2o', '$2a$04$kR5FFIu1AXYdjITNdXOIiOl9b92zunpP5S562VJ/8kydzYFENkdYa', 'mbrandolini2o@tiny.cc'),
(98, 'bebhardt2p', '$2a$04$8bnLC8Th4Mb5rJvE7dAv8.5nl42hgL8s/uGNvN9oAwdeCzmB9dzQO', 'tthurborn2p@xing.com'),
(99, 'bbockin2q', '$2a$04$IsA3Pzv.4Lt09b6aH34U0eia3e6MY8HBnU4/OhHEwkcoEQKmx/cE.', 'lfinnigan2q@symantec.com'),
(100, 'kcraisford2r', '$2a$04$OulPbcqOmnoqEAqrb2OGfeJAu1WPyrY8cbMevuLJqfldWq3mefsp6', 'abertomier2r@nifty.com');

-- --------------------------------------------------------

--
-- Table structure for table `__efmigrationshistory`
--

CREATE TABLE `__efmigrationshistory` (
  `MigrationId` varchar(150) NOT NULL,
  `ProductVersion` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `__efmigrationshistory`
--
ALTER TABLE `__efmigrationshistory`
  ADD PRIMARY KEY (`MigrationId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
