-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 17, 2025 at 02:18 PM
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
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` varchar(255) NOT NULL,
  `order_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` int(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `specs` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `description`, `specs`, `image`, `category`) VALUES
(1, 'Dell XPS 13', 500000, 'A Dell XPS 13 a prémium kategóriás, ultrakompakt laptop, amely a legújabb technológiát és stílust ötvözi. Kiváló teljesítménye és lenyűgöző kijelzője ideálissá teszi mindennapi feladatokhoz, kreatív munkához és üzleti használatra.\r\n\r\nFőbb jellemzők:\r\n\r\n  ', 'Műszaki adatok:\r\n\r\n    Képernyő mérete: 13,4\" InfinityEdge FHD+ / 4K UHD+ érintőképernyő\r\n    Processzor: Intel Core i5 vagy i7, 10. generáció\r\n    RAM: 8 GB / 16 GB LPDDR4x\r\n    Tárhely: 256 GB / 512 GB / 1 TB SSD\r\n    Operációs rendszer: Windows 11 Home', 'https://p1.akcdn.net/full/998179977.dell-xps-13-plus-9320-9320fi7wb1.jpg', 'Notebook'),
(2, 'Apple MacBook Air M2', 450000, 'A MacBook Air M2 egy elegáns, könnyű és nagy teljesítményű laptop, amely az Apple új M2 chipjével érkezik, így gyorsabb és energiahatékonyabb, mint valaha. Ideális választás mindennapi feladatokhoz, kreatív munkához, üzleti használatra és szórakozásra egy', 'Műszaki adatok:\r\n\r\n    Képernyő mérete: 13,6\" Retina kijelző, 2560x1664 pixel felbontás\r\n    Processzor: Apple M2 chip (8 magos CPU, 10 magos GPU)\r\n    RAM: 8 GB / 16 GB Unified Memory\r\n    Tárhely: 256 GB / 512 GB / 1 TB / 2 TB SSD\r\n    Operációs rendsze', 'https://p1.akcdn.net/full/1081640598.apple-macbook-air-m2-z15s000re.jpg', 'Notebook'),
(3, 'Lenovo ThinkPad X1 Carbon', 600000, 'A Lenovo ThinkPad X1 Carbon egy prémium kategóriás ultrakönnyű laptop, amely a legújabb technológiát és robusztus dizájnt ötvözi. Kiváló választás üzletembereknek, kreatív szakembereknek és mindenkinek, aki magas szintű teljesítményt és mobilitást igényel', 'Műszaki adatok:\r\n\r\n    Képernyő mérete: 14\" WQHD+ (2560x1600) / 4K UHD (3840x2160) IPS, érintőképernyő opcióval\r\n    Processzor: Intel Core i5 / i7 (12. generáció)\r\n    RAM: 16 GB / 32 GB LPDDR5\r\n    Tárhely: 512 GB / 1 TB SSD\r\n    Operációs rendszer: Win', 'https://p1.akcdn.net/full/1284532306.lenovo-thinkpad-x1-carbon-gen-12-21kc0056hv.jpg', 'Notebook'),
(4, 'HP Spectre x360', 550000, 'A HP Spectre x360 egy prémium 2 az 1-ben laptop, amely kiemelkedő teljesítményt és elegáns dizájnt kínál. A forgatható kijelző és a nagy teljesítmény ideálissá teszi kreatív feladatokhoz, üzleti használatra, és mindennapi feladatokhoz is.\r\n\r\nFőbb jellemző', '\r\nMűszaki adatok:\r\n\r\n    Képernyő mérete: 13,5\" / 14\" 3K (3000x2000) / 4K UHD (3840x2160) OLED, érintőképernyő\r\n    Processzor: Intel Core i5 / i7 (12. generáció)\r\n    RAM: 8 GB / 16 GB LPDDR4x\r\n    Tárhely: 512 GB / 1 TB SSD\r\n    Operációs rendszer: Wind', 'https://p1.akcdn.net/full/629150685.hp-spectre-x360-13-aw0001nh-8bs71ea.jpg', 'Notebook'),
(5, 'Asus ROG Zephyrus G14', 650000, 'Az Asus ROG Zephyrus G14 a prémium kategóriás gaming laptopok királya, amely erőteljes teljesítményt és lenyűgöző dizájnt kínál a játékosok és kreatív szakemberek számára. Kompakt és könnyű kialakítása miatt tökéletes mobilitást biztosít, miközben a legúj', 'Műszaki adatok:\r\n\r\n    Képernyő mérete: 14\" QHD (2560x1600) / 4K UHD, 120Hz / 144Hz, IPS, érintőképernyő\r\n    Processzor: AMD Ryzen 9 7940HS / Ryzen 7 7840HS (7000 sorozat)\r\n    Grafikus kártya: NVIDIA GeForce RTX 4050 / RTX 4060 / RTX 4070\r\n    RAM: 16 G', 'https://p1.akcdn.net/full/1369513813.asus-rog-zephyrus-g14-ga403uv-qs022w.jpg', 'Notebook'),
(6, 'ASUS TUF Gaming A15 FA507NUR-LP005', 350000, 'Az ASUS TUF Gaming A15 FA507NUR-LP005 egy erőteljes és strapabíró gaming laptop, amely ideális választás azok számára, akik kiemelkedő teljesítményre és hosszú távú megbízhatóságra vágynak. A TUF sorozat a tartósságáról és a katonai szabványú tesztelésről', 'Műszaki adatok:\r\n\r\n    Képernyő mérete: 15,6\" FHD (1920x1080), 144Hz IPS\r\n    Processzor: AMD Ryzen 7 7735HS (8 mag, 16 szál, 3.2GHz alap, 4.8GHz boost)\r\n    Grafikus kártya: NVIDIA GeForce RTX 4060\r\n    RAM: 16 GB DDR5\r\n    Tárhely: 512 GB PCIe Gen 4 SSD', 'https://p1.akcdn.net/full/1328151121.asus-tuf-gaming-a15-fa507nur-lp005.jpg', 'Notebook'),
(7, 'Apple MacBook Air 13.3 M1 MGN63MG/A', 385000, 'Az Apple MacBook Air 13.3 M1 MGN63MG/A a legújabb Apple M1 chip-pel felszerelt, prémium ultrakompakt laptop, amely kiemelkedő teljesítményt, lenyűgöző akkumulátor-élettartamot és egyedi dizájnt kínál. Az Apple híres a minőségéről és az egyszerű, de elegán', 'Műszaki adatok:\r\n\r\n    Képernyő mérete: 13,3\" Retina kijelző (2560 x 1600 felbontás), True Tone technológia\r\n    Processzor: Apple M1 chip, 8 magos CPU, 7 magos GPU\r\n    RAM: 8 GB Unified RAM\r\n    Tárhely: 256 GB SSD\r\n    Operációs rendszer: macOS Montere', 'https://p1.akcdn.net/full/1206282703.apple-macbook-air-13-3-m1-mgn63mg-a.jpg', 'Notebook'),
(8, 'ASUS Vivobook X1504VA-BQ772', 190000, 'Az ASUS Vivobook X1504VA-BQ772 egy kiváló ár-érték arányú laptop, amely ideális mindennapi használatra, iskolai feladatokhoz és irodai munkákhoz. A Vivobook sorozatot az egyszerű, mégis megbízható teljesítmény jellemzi, és az X1504VA-BQ772 is ezt a filozó', NULL, 'https://p1.akcdn.net/full/1254648817.asus-vivobook-x1504va-bq772.jpg', 'Notebook'),
(9, 'Lenovo IdeaPad 1 82V700FBHV', 140000, 'A Lenovo IdeaPad 1 82V700FBHV egy költséghatékony és praktikus laptop, amely ideális alapvető feladatokhoz, például internetezéshez, dokumentumok szerkesztéséhez és online tanuláshoz. A könnyű és kompakt kialakításnak köszönhetően könnyedén hordozható, mi', NULL, 'https://p1.akcdn.net/full/1244205769.lenovo-ideapad-1-82v700fbhv.jpg', 'Notebook'),
(10, 'Apple MacBook Air 13 M3 MRXN3MG/A', 455000, 'Az Apple MacBook Air 13 M3 MRXN3MG/A a legújabb generációs MacBook Air, amely az új M3 chip-el érkezik, biztosítva ezzel a még jobb teljesítményt és energiahatékonyságot. A prémium dizájn és az Apple ökoszisztéma zökkenőmentes integrációja tovább növeli a', NULL, 'https://p1.akcdn.net/full/1261068961.apple-macbook-air-13-m3-mrxn3mg-a.jpg', 'Notebook'),
(11, 'Acer Swift Go 14 AI SFG14-01-X2C3 NX.KYXEU.007', 300000, 'Az Acer Swift Go 14 AI SFG14-01-X2C3 egy prémium ultrakönnyű és vékony laptop, amely az Intel Core i5 vagy i7 processzorral és a legújabb generációs technológiákkal érkezik. Az Acer Swift Go ideális választás a mindennapi feladatokhoz, kreatív munkához és', NULL, 'https://p1.akcdn.net/full/1375613428.acer-swift-go-14-ai-sfg14-01-x2c3-nx-kyxeu-007.jpg', 'Notebook'),
(12, 'ASUS Vivobook Go E1504FA-NJ648', 170000, 'Az ASUS Vivobook Go E1504FA-NJ648 egy belépő szintű laptop, amely alapvető feladatokra lett tervezve. Könnyű, de tartós kialakítása, valamint a jó ár-érték aránya miatt ideális választás mindennapi használatra, iskolai munkához vagy irodai alkalmazásokhoz', NULL, 'https://p1.akcdn.net/full/1193052613.asus-vivobook-go-e1504fa-nj648.jpg', 'Notebook'),
(13, 'ASUS TUF Gaming FA506NCR-HN108', 455000, 'Az ASUS TUF Gaming FA506NCR-HN108 egy erőteljes gaming laptop, amely a legújabb hardverekkel és robusztus kialakítással biztosítja a zökkenőmentes és élvezetes gaming élményt. Az AMD Ryzen processzor és a NVIDIA GeForce RTX videokártya lehetővé teszi, hog', NULL, 'https://p1.akcdn.net/full/1335152110.asus-tuf-gaming-fa506ncr-hn108.jpg', 'Notebook'),
(14, 'Apple MacBook Air 13 M2 MLXY3MG/A', 525000, 'MacBook Air M2 chip-hAz Apple MacBook Air 13 M2 egy vékony és könnyű, prémium kategóriás laptop, amely az Apple M2 chip erejére épít, így gyorsabb és hatékonyabb teljesítményt kínál, mint elődje. A 13 hüvelykes Retina kijelző, a hosszú akkumulátor-élettar', NULL, 'https://p1.akcdn.net/full/982927995.apple-macbook-air-13-m2-mlxy3mg-a.jpg', 'Notebook'),
(15, 'Apple MacBook Air 13 M3 MRXV3MG/A', 540000, 'Az Apple MacBook Air 13 M3 a legújabb generációs MacBook Air modell, amely az Apple M3 chip erejére épít, így még gyorsabb és energiatakarékosabb teljesítményt kínál, mint valaha. Az új 13,6\"-os Liquid Retina kijelző, az akár 20 órás akkumulátor-élettarta', NULL, 'https://p1.akcdn.net/full/1261068322.apple-macbook-air-13-m3-mrxv3mg-a.jpg', 'Notebook'),
(16, 'Samsung Galaxy S24 Ultra 5G 256GB 12GB RAM Dual (SM-S928B)', 500000, 'A Samsung Galaxy S24 Ultra 5G a legújabb prémium okostelefon a Samsung Galaxy sorozatában, amely a legújabb technológiai újításokat és a csúcskategóriás teljesítményt ötvözi. Az S24 Ultra 5G a lenyűgöző 200 MP-es főkamerájával, a gyors 5G hálózati támogat', NULL, 'https://p1.akcdn.net/full/1240638061.samsung-galaxy-s24-ultra-5g-256gb-12gb-ram-dual-sm-s928b.jpg', 'Okostelefon'),
(17, 'Xiaomi Poco X7 Pro 5G 512GB 12GB RAM Dual', 450000, 'Erőteljes 5G telefon 512 GB tárolóval és 12 GB RAM-mal.', NULL, 'https://p1.akcdn.net/full/1390398406.xiaomi-poco-x7-pro-5g-512gb-12gb-ram-dual.jpg', 'Okostelefon'),
(18, 'Samsung Galaxy A55 5G 128GB 8GB RAM Dual (SM-A556)', 220000, 'Kiváló középkategóriás okostelefon 8 GB RAM-mal és 128 GB tárolóval.', NULL, 'https://p1.akcdn.net/full/1262383174.samsung-galaxy-a55-5g-128gb-8gb-ram-dual-sm-a556.jpg', 'Okostelefon'),
(19, 'Apple iPhone 16 128GB', 600000, 'Az új iPhone 16, 128 GB tárolóval, fejlett kamerával és teljesítménnyel.', NULL, 'https://p1.akcdn.net/full/1337109469.apple-iphone-16-128gb.jpg', 'Okostelefon'),
(20, 'Apple iPhone 15 128GB', 550000, 'Apple iPhone 15, 128 GB tárolóval és gyors A15 chip-pel.', NULL, 'https://p1.akcdn.net/full/1191449686.apple-iphone-15-128gb.jpg', 'Okostelefon'),
(21, 'Xiaomi Redmi Note 14 Pro 5G 256GB 8GB RAM Dual', 300000, 'Erőteljes Redmi telefon 8 GB RAM-mal és 256 GB tárolóval.', NULL, 'https://p1.akcdn.net/full/1389911983.xiaomi-redmi-note-14-pro-5g-256gb-8gb-ram-dual.jpg', 'Okostelefon'),
(22, 'Apple iPhone 16 Pro 128GB', 650000, 'Az új iPhone 16 Pro, 128 GB tárolóval és Pro kamera rendszerrel.', NULL, 'https://p1.akcdn.net/full/1337110597.apple-iphone-16-pro-128gb.jpg', 'Okostelefon'),
(23, 'Apple iPhone 13 128GB', 500000, 'Apple iPhone 13, 128 GB tárolóval, A15 Bionic chip-pel.', NULL, 'https://p1.akcdn.net/full/859255335.apple-iphone-13-128gb.jpg', 'Okostelefon'),
(24, 'Samsung Galaxy S24 5G 128GB 8GB RAM Dual (SM-S921B)', 450000, 'Samsung Galaxy S24, 8 GB RAM-mal és 128 GB tárolóval.', NULL, 'https://p1.akcdn.net/full/1240638142.samsung-galaxy-s24-5g-128gb-8gb-ram-dual-sm-s921b.jpg', 'Okostelefon'),
(25, 'Xiaomi Redmi Note 13 Pro 5G 256GB 8GB RAM Dual', 290000, 'Xiaomi Redmi Note 13 Pro 5G, 8 GB RAM-mal és 256 GB tárolóval.', NULL, 'https://p1.akcdn.net/full/1239096694.xiaomi-redmi-note-13-pro-5g-256gb-8gb-ram-dual.jpg', 'Okostelefon'),
(26, 'Samsung Galaxy Buds3 Pro (SM-R630NZ)', 95000, 'Prémium fülhallgató kiváló hangminőséggel és aktív zajszűréssel.', NULL, 'https://p1.akcdn.net/full/1318706245.samsung-galaxy-buds3-pro-sm-r630nz.jpg', 'Fülhallgató'),
(27, 'Apple AirPods Pro 2 (MTJV3ZM/A/MTJV3TY/A)', 120000, 'Új generációs AirPods Pro, aktív zajszűrés és térbeli hangélmény.', NULL, 'https://p1.akcdn.net/full/1193325349.apple-airpods-pro-2-mtjv3zm-a-mtjv3ty-a.jpg', 'Fülhallgató'),
(28, 'Apple AirPods 4 gen. ANC (MXP93ZM/A)', 105000, 'AirPods 4, aktív zajszűréssel és rendkívül kényelmes viselettel.', NULL, 'https://p1.akcdn.net/full/1339403914.apple-airpods-4-gen-anc-mxp93zm-a.jpg', 'Fülhallgató'),
(29, 'Xiaomi Redmi Buds 5 Pro (BHR7660/62GL)', 40000, 'Jó ár-érték arányú fülhallgató, kiváló hangzással és hosszú üzemidővel.', NULL, 'https://p1.akcdn.net/full/1239749854.xiaomi-redmi-buds-5-pro-bhr7660-62gl.jpg', 'Fülhallgató'),
(30, 'Apple AirPods 4 gen. (MXP63ZM/A)', 95000, 'AirPods 4, kiemelkedő hangminőség és könnyű csatlakozás Apple eszközökhöz.', NULL, 'https://p1.akcdn.net/full/1339403959.apple-airpods-4-gen-mxp63zm-a.jpg', 'Fülhallgató'),
(31, 'Samsung Galaxy Buds3 (SM-R530)', 75000, 'Kiváló minőségű hangzás és kényelmes viselet a mindennapokra.', NULL, 'https://p1.akcdn.net/full/1310516590.samsung-galaxy-buds3-sm-r530.jpg', 'Fülhallgató'),
(32, 'Samsung Galaxy Buds FE (SM-R400)', 65000, 'Kiváló ár-érték arányú fülhallgató, kényelmes használat és jó hangzás.', NULL, 'https://p1.akcdn.net/full/1202072440.samsung-galaxy-buds-fe-sm-r400.jpg', 'Fülhallgató'),
(33, 'Apple AirPods 2 (MV7N2TY/MV7N2RU/A / MV7N2ZM)', 60000, 'Kiváló minőségű AirPods 2, könnyű használat és remek hangzás.', NULL, 'https://p1.akcdn.net/full/787785633.apple-airpods-2-mv7n2ty-mv7n2ru-a-mv7n2zm.jpg', 'Fülhallgató'),
(34, 'Xiaomi Redmi Buds 6 Play (BHR8776GL)', 35000, 'Jó ár-érték arányú vezeték nélküli fülhallgató.', NULL, 'https://p1.akcdn.net/full/1337979472.xiaomi-redmi-buds-6-play-bhr8776gl.jpg', 'Fülhallgató'),
(35, 'Xiaomi Redmi Buds 6 Active (BHR839GL)', 38000, 'Kényelmes, vízálló és sportoláshoz is ideális fülhallgató.', NULL, 'https://p1.akcdn.net/full/1326418861.xiaomi-redmi-buds-6-active-bhr839gl.jpg', 'Fülhallgató'),
(36, 'Samsung Galaxy Watch Ultra LTE 47mm (L705)', 300000, 'Kiváló okosóra LTE támogatással és prémium megjelenéssel.', NULL, 'https://p1.akcdn.net/full/1315312654.samsung-galaxy-watch-ultra-lte-47mm-l705.jpg', 'Okosóra'),
(37, 'Huawei Watch D2', 150000, 'Elegáns és funkcionális okosóra, ideális mindennapi használatra.', NULL, 'https://p1.akcdn.net/full/1345013809.huawei-watch-d2.jpg', 'Okosóra'),
(38, 'Xiaomi Redmi Watch 5 Active', 25000, 'Könnyű és sportos okosóra, hosszú akkumulátor élettartammal.', NULL, 'https://p1.akcdn.net/full/1345014970.xiaomi-redmi-watch-5-active.jpg', 'Okosóra'),
(39, 'Apple Watch Ultra 2 GPS + Cellular 49mm', 600000, 'Prémium Apple Watch Ultra 2, GPS + Cellular támogatással.', NULL, 'https://p1.akcdn.net/full/1191863290.apple-watch-ultra-2-gps-cellular-49mm.jpg', 'Okosóra'),
(40, 'Xiaomi Redmi Watch 5', 35000, 'Okosóra okos funkciókkal, ideális ár-érték arányú választás.', NULL, 'https://p1.akcdn.net/full/1393228738.xiaomi-redmi-watch-5.jpg', 'Okosóra'),
(41, 'Xiaomi Smart Band 9', 15000, 'Sportos és kényelmes okoskarkötő, ideális fitnesz követéshez.', NULL, 'https://p1.akcdn.net/full/1331218648.xiaomi-smart-band-9.jpg', 'Okosóra'),
(42, 'Samsung Galaxy Watch 7 44mm (L310)', 350000, 'Samsung prémium okosórája, szép kijelzővel és okos funkciókkal.', NULL, 'https://p1.akcdn.net/full/1315312141.samsung-galaxy-watch-7-44mm-l310.jpg', 'Okosóra'),
(43, 'Xiaomi Watch S3', 60000, 'Stílusos és hosszú üzemidővel rendelkező okosóra a mindennapi használathoz.', NULL, 'https://p1.akcdn.net/full/1239778183.xiaomi-watch-s3.jpg', 'Okosóra'),
(44, 'Samsung Galaxy Watch6 40mm Bluetooth (SM-R930)', 250000, 'Samsung Galaxy Watch 6, 40mm-es Bluetooth változat, elegáns és funkcionalitással.', NULL, 'https://p1.akcdn.net/full/1175866380.samsung-galaxy-watch6-40mm-bluetooth-sm-r930.jpg', 'Okosóra'),
(45, 'Apple Watch Series 10 GPS 46mm', 500000, 'Apple Watch Series 10, 46mm-es GPS változat, prémium megjelenés és funkciók.', NULL, 'https://p1.akcdn.net/full/1340662093.apple-watch-series-10-gps-46mm.jpg', 'Okosóra'),
(46, 'Samsung Galaxy Tab A9+ X210 128GB', 120000, 'Kiváló minőségű táblagép, nagy teljesítmény és nagy kijelző.', NULL, 'https://p1.akcdn.net/full/1229535301.samsung-galaxy-tab-a9-x210-128gb.jpg', 'Tablet'),
(47, 'Xiaomi Redmi Pad Pro 6GB+128GB', 95000, 'Erőteljes táblagép, nagyszerű ár-érték arány.', NULL, 'https://p1.akcdn.net/full/1297413103.xiaomi-redmi-pad-pro-6gb-128gb.jpg', 'Tablet'),
(48, 'Apple iPad 10.9 2022 64GB MPQ23/MCM94', 190000, 'Apple iPad 10.9 64GB, könnyű és erőteljes készülék.', NULL, 'https://p1.akcdn.net/full/1047905520.apple-ipad-10-9-2022-64gb-mpq23-mcm94.jpg', 'Tablet'),
(49, 'Samsung Galaxy Tab S9 FE X510 128GB', 150000, 'Samsung prémium táblagép, nagy kijelző és hosszú üzemidő.', NULL, 'https://p1.akcdn.net/full/1201519633.samsung-galaxy-tab-s9-fe-x510-128gb.jpg', 'Tablet'),
(50, 'Samsung Galaxy Tab A9 X110N 64GB', 90000, 'Kiváló választás mindennapi használatra, nagy teljesítménnyel.', NULL, 'https://p1.akcdn.net/full/1224859981.samsung-galaxy-tab-a9-x110n-64gb.jpg', 'Tablet'),
(51, 'Xiaomi Redmi Pad SE 11 4GB+128GB', 75000, 'Sportos és könnyen kezelhető táblagép, ideális szórakozáshoz és munkához.', NULL, 'https://p1.akcdn.net/full/1188909229.xiaomi-redmi-pad-se-11-4gb-128gb.jpg', 'Tablet'),
(52, 'Samsung Galaxy Tab A9+ X210N 64GB', 105000, 'Kiváló teljesítmény és kiváló kijelző kombinációja.', NULL, 'https://p1.akcdn.net/full/1226174050.samsung-galaxy-tab-a9-x210n-64gb.jpg', 'Tablet'),
(53, 'Apple iPad Air 6 2024 11 128GB MUWD3', 320000, 'Kiváló teljesítmény és dizájn, prémium Apple táblagép.', NULL, 'https://p1.akcdn.net/full/1284906358.apple-ipad-air-6-2024-11-128gb-muwd3.jpg', 'Tablet'),
(54, 'Xiaomi Pad 6 6GB+128GB', 110000, 'Erőteljes Xiaomi táblagép, tökéletes a mindennapi használathoz.', NULL, 'https://p1.akcdn.net/full/1167369939.xiaomi-pad-6-6gb-128gb.jpg', 'Tablet'),
(55, 'Apple iPad 10.9 2022 64GB MPQ13/MCM84', 200000, 'Apple iPad 10.9 2022, erős teljesítmény és magas minőség.', NULL, 'https://p1.akcdn.net/full/1376043541.apple-ipad-10-9-2022-64gb-mpq13-mcm84.jpg', 'Tablet'),
(56, 'Meta Quest 3 128 GB (899-00582-01)', 250000, 'Meta Quest 3, 128 GB tároló, prémium VR élmény.', NULL, 'https://p1.akcdn.net/full/1213770922.meta-quest-3-128-gb-899-00582-01.jpg', 'VR Szemüveg'),
(57, 'Sony PlayStation VR2 (PS719453994)', 350000, 'Sony PlayStation VR2, csúcsminőségű VR élmény PlayStation 5-höz.', NULL, 'https://p1.akcdn.net/full/1110727089.sony-playstation-vr2-ps719453994.jpg', 'VR Szemüveg'),
(58, 'Meta Quest 3S 128 GB (1000206-01)', 280000, 'Meta Quest 3S, 128 GB, a legújabb VR technológia.', NULL, 'https://p1.akcdn.net/full/1357325752.meta-quest-3s-128-gb-1000206-01.jpg', 'VR Szemüveg'),
(59, 'Meta Quest 3 512GB (899-00583-01/899-00586-01)', 350000, 'Meta Quest 3, 512 GB tároló, nagyszerű VR élmény és teljesítmény.', NULL, 'https://p1.akcdn.net/full/1243525054.meta-quest-3-512gb-899-00583-01-899-00586-01.jpg', 'VR Szemüveg'),
(60, 'Meta Quest 2 Elite (899-00208-01)', 200000, 'Meta Quest 2 Elite, kiváló VR eszköz, kényelmes és erőteljes.', NULL, 'https://p1.akcdn.net/full/1311948094.meta-quest-2-elite-899-00208-01.jpg', 'VR Szemüveg'),
(61, 'XREAL Air 2 Pro AR (X1003)', 120000, 'XREAL Air 2 Pro AR, fejlett AR technológia, hordozható és könnyű.', NULL, 'https://p1.akcdn.net/full/1333739581.xreal-air-2-pro-ar-x1003.jpg', 'VR Szemüveg'),
(62, 'Meta Oculus Quest Pro 256GB (899-00412-01/899-00416-01)', 500000, 'Meta Oculus Quest Pro, 256 GB tároló, prémium VR élmény és fejlettebb hardver.', NULL, 'https://p1.akcdn.net/full/1111212099.meta-oculus-quest-pro-256gb-899-00412-01-899-00416-01.jpg', 'VR Szemüveg'),
(63, 'Meta Quest 3S 256 GB (1000212-01)', 320000, 'Meta Quest 3S, 256 GB tároló, rendkívül fejlett VR technológia.', NULL, 'https://p1.akcdn.net/full/1390399681.meta-quest-3s-256-gb-1000212-01.jpg', 'VR Szemüveg'),
(64, 'Sony PlayStation VR2 + Horizon Call of the Mountain (PS711000036282)', 400000, 'Sony PlayStation VR2 + Horizon Call of the Mountain, teljes VR csomag.', NULL, 'https://p1.akcdn.net/full/1110726951.sony-playstation-vr2-horizon-call-of-the-mountain-ps711000036282.jpg', 'VR Szemüveg'),
(65, 'HTC VIVE Pro 2 Full Kit (99HASZ003-00)', 800000, 'HTC VIVE Pro 2, professzionális VR élmény, teljes kit.', NULL, 'https://p1.akcdn.net/full/903076941.htc-vive-pro-2-full-kit-99hasz003-00.jpg', 'VR Szemüveg');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(255) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`) VALUES
(1, 'admin', 'admin@gmail.com', 'admin'),
(2, 'tspore1', 'zbursell1@homestead.com', '$2a$04$MiEfeKRoA.EBODXV4agF1u4.lt7zqN74Lx8Bv2KMlWopJOCdslLJ.'),
(3, 'efreezor2', 'vjobke2@usatoday.com', '$2a$04$/obz10JvtTHLMBKOl9rAZ.T6aPc/ztYRPDs/cvUpZ1orn5izr0XxK'),
(4, 'skolak3', 'ubellefonte3@google.co.uk', '$2a$04$N0k.hQUUPMrSNlDs9jLfSO/tSaGECuklNYRtTJ9.kPW1abvmo7N3m'),
(5, 'smacconnulty4', 'adrowsfield4@mapquest.com', '$2a$04$k0Vku6vIg5FvWurCXxGYOuwV4id/ywxg4MDdMMbp0rbJEcCAzjt32'),
(6, 'msterman5', 'dosgorby5@uol.com.br', '$2a$04$RIqRbQlVpf8iWbpQQ7RMqOcNMTJSRAMLWHxE06UpMrQIZLoC5Id4u'),
(7, 'vwansbury6', 'lbelderson6@ameblo.jp', '$2a$04$QJyXIga9.ht8I4PKIfC7J.z7hIOejfxlw2lXxS2HUrTvxRlT4eIIC'),
(8, 'pwaylen7', 'jkenelin7@merriam-webster.com', '$2a$04$sNYlEIbd1pz9RlTKFSlyEeFLVI3l8O7EQqxAUHhz9pQHzSGTq8JYS'),
(9, 'ameletti8', 'rleftley8@skyrock.com', '$2a$04$JeAPeoCLGtE4M4PxRNaf6OmT0a0cYvdFx9XK2CGX9/IwpIn0bYJl6'),
(10, 'emcaneny9', 'rsivil9@vimeo.com', '$2a$04$BDe7HsLDZe56DU5i7tlx2.2EXg1UrKodkhHA4cIvitBkvSG1s9ndW'),
(11, 'blabbaa', 'gmcdonagha@storify.com', '$2a$04$vLlgJBAOJyc5LVr/HxETc.6hzIOb2FTarACA/BqtoXQlLWHUGTUCq'),
(12, 'pmatzkaitisb', 'shannigerb@netscape.com', '$2a$04$afZSikeNum86ZpRVAlKd6.3raWL6acdY3YmnLuZawJXkCga1sWiPG'),
(13, 'stutchellc', 'dtreacyc@lulu.com', '$2a$04$SYkd4pEfPtRaDBLwZGX.Fe4MTNHBjvO2eio2gobtBOOgrxil9Nefa'),
(14, 'spinillad', 'sstringmand@amazon.co.uk', '$2a$04$p790luiiaNGS70Ec0k09BO9YyE.jsKAebLltTsS1OUIBVak7WfXSW'),
(15, 'fsoutherane', 'rwollrauche@wikia.com', '$2a$04$M0zTy47/zYSCOu2AbLFACedYkmQq57sZbfJ5uPcwRFRzGXt/YKlTq'),
(16, 'tharrellf', 'abolsoverf@who.int', '$2a$04$/tYeYRI781CiaJJlg52Im.cSjEX1o389tsfhP6yJPfawNFVA57Mda'),
(17, 'udicheg', 'chilling@nhs.uk', '$2a$04$lZNWHQPL4L.InVLGvdJL2ucbtd/WusPINRDLk3GAiAMov3gQUfgoW'),
(18, 'rpautoth', 'zrockhillh@phoca.cz', '$2a$04$Feqm4wPQuompiVMFObaAj.FGu5U7sMid4ZFTHsGZKHz6esEBWvh.S'),
(19, 'ptauntoni', 'jgrzelaki@hatena.ne.jp', '$2a$04$3LLSOGj/QEeJ/q2jk985q.bkuzLJgcoNKm2kqSOxhh9bf2embRxY.'),
(20, 'lpolj', 'mlamberthj@sciencedirect.com', '$2a$04$huUdI621Z2fkq0CVLXwtbOM6ogTKgjkgGTvpyyaTXnC9ZyqxMQkhS'),
(21, 'nsolank', 'cmaccrackenk@europa.eu', '$2a$04$P3/VGBXennRQJ/xg8fQgIeLAv9L.hZsVIJ.CniCkiEO9Ye2A8BmWq'),
(22, 'sdemangell', 'bormrodl@scientificamerican.com', '$2a$04$/lp1HZM6ZJa8BfRA06QuLOTGKZMSgiz5DsgZt1K42p7q1F8qhhHJq'),
(23, 'sbleuem', 'jmcallanm@mediafire.com', '$2a$04$TY5E.nog4u8VP9JvcNZFiusN6P8Tle4/aZm0ycsW2.R.hLb6QaGZC'),
(24, 'plimeburnern', 'dnaismithn@xinhuanet.com', '$2a$04$2S99iJY1iB.UBaIFhOV1r.6yCuvniZDMYDkYVeVvMrCnVZh3eqk9O'),
(25, 'mcarlowo', 'cblankmano@europa.eu', '$2a$04$s5TkAnwhsjv.Vvg2rlv7zu.hwswJqS0Rn5YSifp6.DCNvuexXF0bq'),
(26, 'gmeadowcraftp', 'nhalmkinp@loc.gov', '$2a$04$r3aTxKpDffUecHbLieTJ6.47/DmRP9QBKgNqjjgtT6NvCsFY6.wQy'),
(27, 'cdighthamq', 'jdinckeq@usatoday.com', '$2a$04$/WLJThlhbJIqd3J7c58dEuqHtgRoU6i5dwelFnakpMWRaLhDbfEIG'),
(28, 'jstonuaryr', 'npaner@is.gd', '$2a$04$nuvk4rnMzQBvQFJMq989c.ex06Wc.qXc.7GoI7UHK4aGUnzBWjSw2'),
(29, 'hfountaines', 'cmeardons@elegantthemes.com', '$2a$04$.Tsfc7zCjUKTloTSu7gbfuHmrzK1TK5Z372mRtayto4Kxsb95p5cO'),
(30, 'kfergusont', 'jbrookhouset@wired.com', '$2a$04$YYlf2lZugQvG9u/JTzeH7.dhdMorXgF6/qR79dM1pF64Gc7hIQ2yi'),
(31, 'agauntlettu', 'kriseboroughu@epa.gov', '$2a$04$5K9nYRAZIOd36OzqHJj4cOm/BhfsLYCix8tjZiMu/BxcpMWMUf21C'),
(32, 'fnavarrev', 'pbinfordv@plala.or.jp', '$2a$04$bzlsNmLfbC6gTkbmil5s0OrgtPVIbGPLUgYc38tME7KDu8yOwbsTy'),
(33, 'pgavenw', 'amedlerw@cyberchimps.com', '$2a$04$vzK20Oh6z8wCgKDwuko3Hu3dSEqxBU/p4tgQW1fK5zfyTGcxT00We'),
(34, 'hstemsonx', 'smulheronx@auda.org.au', '$2a$04$B/I3tDkDL6LbrdognHZJw.0cwlmTlNIMTnEUEqlhleOpofniMshFe'),
(35, 'reckeryy', 'jlassetery@goo.ne.jp', '$2a$04$JAHCbCbQASb/SYKcoDtH9u0cQIPKvBg9Y13owoT3TV0XkbLerNSuq'),
(36, 'smaccumeskeyz', 'mrauz@ning.com', '$2a$04$MVUl2foL5yD9ZVgabRPZH.PAVfybzJ/fBs1fmTKUlsSAuVsL1RiWW'),
(37, 'wworsnop10', 'hbente10@goo.ne.jp', '$2a$04$5lyB.4Ia53tdk.z97hQBuuRSJ4HxGT2UlteW4GCum//5my60tKliS'),
(38, 'ifareweather11', 'ctatlock11@china.com.cn', '$2a$04$86/lLfOWaUpJ1AV9yhLKTeKjAFY7l62aKSDHjg5Nji4vDHhyyJIV.'),
(39, 'mlorincz12', 'mbusen12@indiatimes.com', '$2a$04$W.4z1CPMqzejt0XGvvTUFuA1ZihY/Ex3tiBoFo9yBout7hklCGLHW'),
(40, 'nwoollett13', 'bkerins13@blogs.com', '$2a$04$5Pc34Yu.ZeUrM/sLVQ1u6OJjCP.b6vpGZldYYj5l8NUYjp8.POES2'),
(41, 'jvautrey14', 'lbeake14@jigsy.com', '$2a$04$n8Uf3oL1/hpUAiwD574VuO5V3peAC8tR9zXCIYWFfFkm5nPCdaC82'),
(42, 'cpainten15', 'lahrend15@unc.edu', '$2a$04$Nk4gwn21asZ6h7TkNA3U3O41YblJzq8xTu23fxMmT.0AF3Mtp8KWO'),
(43, 'jmacmeeking16', 'gjulien16@guardian.co.uk', '$2a$04$V8JQo1bssrcnWdDNOK4.te0uR8tDupiUqeoNM4SUz1Jmcu4lNwG7u'),
(44, 'dascrofte17', 'kschechter17@fema.gov', '$2a$04$IIpZ/L/ha5hoc4pxMVwG1e0itfUwP3TE8RVNunlSWQkSPxcZ4dq4K'),
(45, 'mchavey18', 'shurich18@jiathis.com', '$2a$04$.jhoHaa3yFRP6YyeNnPH3ew2KnYtjP/vQDzCaQOWND.1qmzUblXZ6'),
(46, 'mtammadge19', 'wdorr19@ustream.tv', '$2a$04$afZXf6kj8Z58/t5NsGqFAu1nICYLE5HWrU9Dt6m0D0pecSJjw1qZS'),
(47, 'odewan1a', 'cbreslauer1a@studiopress.com', '$2a$04$sOKYp3VRnvcBChCYsWFLBu1e.ewM/oQFpcn9UHemeeT4S3U2XoJQO'),
(48, 'sgorst1b', 'fmariet1b@bbb.org', '$2a$04$gxvzK1255lkfEX.6PufDyOguTriytVM5yHpvPbi7yh/dSK/emhiwK'),
(49, 'finsole1c', 'kcatton1c@1und1.de', '$2a$04$5qeeyM79LJ8X1wQZ4CIGsO40mJF48h.CE2EWUD7kccM2H77yNWQhq'),
(50, 'seagers1d', 'mleyborne1d@usnews.com', '$2a$04$FGMB5e1YMoFtBIWZlw67N.RCeYRs5q9uS1GE5T3TpLlO2roy63ZVq'),
(51, 'nbeston1e', 'sbednall1e@vkontakte.ru', '$2a$04$pIcTjlZwkmdHv7azdbnyGOkafIcRnQXeFTQPvHesYd...01tjtRaa'),
(52, 'nleyburn1f', 'psalvage1f@amazon.com', '$2a$04$Mu0.6f85zF.aGkb06sK42OghZYZ/4wG8QEetPplk0a0vhFHsOQ3ey'),
(53, 'iarrell1g', 'smcsherry1g@sina.com.cn', '$2a$04$a/BVyKHZdQEhd92lCfOxieqJemHXXwiC8ZbHh8DMZeq.Rx855m/fG'),
(54, 'gharrowing1h', 'cagius1h@utexas.edu', '$2a$04$.BFBjE6d/ailgPbQy8wqHuUOkXPo8ZuaAiO7Lzc5xr5NQNiRHfDRm'),
(55, 'rdutteridge1i', 'dmcmanus1i@ning.com', '$2a$04$eHiCyZ7Iv1luEyqtEdE.jefEFtM223aj7tcQOu0g8duUwqRNfMRTG'),
(56, 'cclearie1j', 'cjiggen1j@vistaprint.com', '$2a$04$RMSiBlUaFUkz3j8Qkl9wL.H.Sn/LTjY9OxEoLdtZ6b0yiL0OTKAH6'),
(57, 'dsilvers1k', 'htume1k@columbia.edu', '$2a$04$4UxZ8/EhsZ0nU09LwQfSr.s6fJ3b/yhEtHJWi4U4hwbKPAiYFpStK'),
(58, 'amuslim1l', 'dtrevains1l@soundcloud.com', '$2a$04$2sI3xQ823yz7/qxRUhcIneeJ8fjO6zDLzpg8KcuW3fvTJR7Aj4nmK'),
(59, 'bbrocklebank1m', 'jcleverly1m@tinyurl.com', '$2a$04$Lm5lZ99uzEQzQ2GWu07Cde9lT1zkuuq/yrT3TEq70nRuudpzwbm0e'),
(60, 'ehawkin1n', 'ccheesworth1n@cyberchimps.com', '$2a$04$OkUAasscWyxcdRpb.TR6suwXHOSkBc6TkvxLxFt.oyruvpZeU5Mf.'),
(61, 'lcodrington1o', 'trenish1o@blogtalkradio.com', '$2a$04$UBojILoDBRw9hpSTisF/O.NdFsADJZeBZWZObaHLRZFipeQCQk0T2'),
(62, 'csomerville1p', 'eburtwhistle1p@jimdo.com', '$2a$04$g9WYMkFx34X6D2ARz8xiC.mDaJ7uma6B/uwtxXlVxhkjcv7Eqzik6'),
(63, 'jroe1q', 'rgrouen1q@answers.com', '$2a$04$D4jONnQMWzIn5iKD3NXyLOUKTb8goF/0cwIWTKHzxLT8CAO4Frw..'),
(64, 'ecreggan1r', 'civel1r@usnews.com', '$2a$04$2S7RTvQEkwJcet49wBDmaOEw.gylrSyrHcoD.BimM79sNou8QXFzW'),
(65, 'camaya1s', 'lklempke1s@twitter.com', '$2a$04$QNqcNKYSe3pUoMIwFCRYu.tjdMiTDo1FsauB2T7WNOuwq/Yxr1apC'),
(66, 'dgoacher1t', 'mskones1t@cbsnews.com', '$2a$04$UWRT0eCEZmYp1lUpCQgH0OEDQ7IquWviUJZzffVVT8sqxXiMugsv6'),
(67, 'wmillott1u', 'vgarret1u@businessweek.com', '$2a$04$1lnWLAAlHrYsT6Wq7HEYIeEZV.tDoPnvdB89RGTv6cG47CxM39Bgq'),
(68, 'bgealle1v', 'odellcasa1v@ted.com', '$2a$04$NAswWIRXSyz8MeTNioppa.E6voWIkSzNuHBtXmjOUMpk1lGrx1t26'),
(69, 'scleyburn1w', 'fhallock1w@netvibes.com', '$2a$04$FeHEZBboYhzc2RBGpJGLiOlZr.TqbdGGXO6X/gtb2vvdkExLnC7Cy'),
(70, 'wwyldbore1x', 'shegges1x@umich.edu', '$2a$04$mi9/NRUYfGLf2iAnkV1AvubX0/siSNLtLdwzyUudIMZS91MNvHOKW'),
(71, 'vbulbrook1y', 'sigounet1y@blog.com', '$2a$04$p63.7pA.Iq/8QOsrDpmcoe9RH/CgiF444HdT4Aq7L8w/HsdCkKPi.'),
(72, 'mselwyn1z', 'adiviny1z@lycos.com', '$2a$04$IVEunFEzS44olTDWZraaIuv8nIXHc0zQV4z87Gkz7nytvdDEjbmH.'),
(73, 'bfreschi20', 'aravens20@nydailynews.com', '$2a$04$NIBYWHK2j6XyzUB6lCTgce9K1MBrkltWItUJouKa9jhevpBB6cOka'),
(74, 'thuband21', 'jdeviney21@nhs.uk', '$2a$04$z29dq3Qdy7/Vv2jeR729x.sBko7uaNc4Y5Yon/5W4bnGyCmXVL6Z2'),
(75, 'bmcilwrath22', 'abrittoner22@photobucket.com', '$2a$04$TInAjSQM6wUNs6zfW6/2.u1zFx10HWjFIiv4Igx4W8r5f2xds4ce2'),
(76, 'veverly23', 'nansley23@tuttocitta.it', '$2a$04$CC2ZBsKAIiVQcglF2qnvCe.C4de42PrWroLXfjbAIF1XC2EfulcC2'),
(77, 'acruddas24', 'bhilbourne24@sun.com', '$2a$04$nfguL80Yjeb6KRbzYhZNHuZ4qFNY8PbG9HtSrcjraihq8U1bTv38K'),
(78, 'hertelt25', 'jmandel25@cbslocal.com', '$2a$04$GcbZgwrStmhZZ4qN43FPq.uoVZC6.yQ2g3jRL.jmRrdvC18A2snZ6'),
(79, 'jvalero26', 'llaste26@wired.com', '$2a$04$iAwjIiOx9y9cGMI2L.47JeT4H1Bj.LDmZ6tSe3vHGeF18cCIKl6qi'),
(80, 'esager27', 'tgrubbe27@yale.edu', '$2a$04$JxEnCq9/Kq0/RvDq2mbpWO1JEamLAVP4HIrbOiDXsYKGAJNAE2ZKK'),
(81, 'hflanner28', 'rplank28@live.com', '$2a$04$gG9RGaLJ/.4a7ijQJKtx7OmDrcqGreLVeRxYfbjMkTRa35hxjX8Qq'),
(82, 'kgarrity29', 'cspehr29@digg.com', '$2a$04$eHLLqON8VxZ301vIFcfrK.ouscIFvE5xpuQ/SQsUGuzTm8vaWJbyq'),
(83, 'squarton2a', 'cdillon2a@cbsnews.com', '$2a$04$ktKf9NSFrqexgwlv2dNteeb7zCwO1sXKLElUDwlotLp7yaoSYnr26'),
(84, 'kfife2b', 'rfendt2b@bloglovin.com', '$2a$04$4wio1WTAT0.DLFmbtBsm9OY1ABs/q5eKL4Icp8TrA5MHANGTegrLq'),
(85, 'hgrowy2c', 'jlodemann2c@berkeley.edu', '$2a$04$VoFLYU11EgGDmmPL8HpKTexVWk29ZHyuKNY0oF.47Jbf9LHQlshhm'),
(86, 'cmcilmorie2d', 'dfrandsen2d@twitter.com', '$2a$04$sEYZFvCYX2ZjakQDTX8Ja.VdTfRqS3ri0NE.iGkRhq1Ey5uaJh7UO'),
(87, 'alesieur2e', 'agolsworthy2e@tamu.edu', '$2a$04$mJwp.xHoorSsBAkuGamHe.pvMvftZFdJ0RSjbQN9yBNk8CUm7LXh.'),
(88, 'aquirke2f', 'ploverock2f@google.it', '$2a$04$edVK74XPPfV7krP.6D93wO986ZHp4XIYuNo0fGYxtmo6ANZnqWRS.'),
(89, 'gnursey2g', 'hjex2g@gmpg.org', '$2a$04$FzrK1b31Ldf0ADaLBP7BVOC5L2jUvmtS/71S8gH2rl0iYFxkz1RcC'),
(90, 'strevan2h', 'wormrod2h@house.gov', '$2a$04$WOOh3QGl9x8SaRzeRUY74OxSZ2K1IU6KHw0INdwFrlTUFXrKzBPnC'),
(91, 'wdowney2i', 'bcolebrook2i@theglobeandmail.com', '$2a$04$GjJ/kr5hy/n6Ppe1CIIwO.m.okh2vN1AytvjrYV2D1FkEbf73eR4K'),
(92, 'mnemchinov2j', 'grayman2j@taobao.com', '$2a$04$YcBABazcdyiVnJRdBR7Y.uPOWqRpCOjYa5ftb.GX9BvEIh.m6ahjK'),
(93, 'rfensome2k', 'ljepson2k@bloglines.com', '$2a$04$229Y2In80cPEOoHrHeZ0/OcWY2Q51ep8zHVX.RSSSPVZMHrsUFpCa'),
(94, 'dsmalecombe2l', 'esheer2l@army.mil', '$2a$04$axwZWNUyvTKXxkhvgB33suuqjt21vJbv7NPER/DKIuLo/k7/Rx7rG'),
(95, 'ktrowsdall2m', 'lpimblotte2m@cdbaby.com', '$2a$04$P5ocOXi/ZSTD0GWZYpd4/OsVC3KMjODf3yqx5YTmgzS5adt47w17y'),
(96, 'mreidie2n', 'bambrogioli2n@cmu.edu', '$2a$04$vajKc/H97R3tBOVsCCmxy.CxwmTk.L3UTNP3X9doce.GSVO3J02Jm'),
(97, 'ekarolczyk2o', 'mbrandolini2o@tiny.cc', '$2a$04$kR5FFIu1AXYdjITNdXOIiOl9b92zunpP5S562VJ/8kydzYFENkdYa'),
(98, 'bebhardt2p', 'tthurborn2p@xing.com', '$2a$04$8bnLC8Th4Mb5rJvE7dAv8.5nl42hgL8s/uGNvN9oAwdeCzmB9dzQO'),
(99, 'bbockin2q', 'lfinnigan2q@symantec.com', '$2a$04$IsA3Pzv.4Lt09b6aH34U0eia3e6MY8HBnU4/OhHEwkcoEQKmx/cE.'),
(100, 'kcraisford2r', 'abertomier2r@nifty.com', '$2a$04$OulPbcqOmnoqEAqrb2OGfeJAu1WPyrY8cbMevuLJqfldWq3mefsp6');

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
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

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
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
