-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Feb 11. 12:55
-- Kiszolgáló verziója: 10.4.20-MariaDB
-- PHP verzió: 7.3.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `vizsga3`
--
CREATE DATABASE IF NOT EXISTS `vizsga3` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `vizsga3`;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `felhasznalok`
--

CREATE TABLE `felhasznalok` (
  `Id` int(11) NOT NULL,
  `Felhasznalonev` varchar(100) NOT NULL,
  `Jelszo` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- A tábla adatainak kiíratása `felhasznalok`
--

INSERT INTO `felhasznalok` (`Id`, `Felhasznalonev`, `Jelszo`) VALUES
(1, 'user', 'user'),
(2, 'user2', 'user2');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kartyak`
--

CREATE TABLE `kartyak` (
  `id` int(11) NOT NULL,
  `nev` varchar(255) DEFAULT NULL,
  `ar` int(255) DEFAULT NULL,
  `leiras` varchar(255) DEFAULT NULL,
  `kep_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- A tábla adatainak kiíratása `kartyak`
--

INSERT INTO `kartyak` (`id`, `nev`, `ar`, `leiras`, `kep_url`) VALUES
(1, 'Dell XPS 13', 500000, 'Prémium ultrabook, 13 hüvelykes kijelzővel, Intel Core i7 processzorral és 16GB RAM-mal.', 'https://p1.akcdn.net/full/998179977.dell-xps-13-plus-9320-9320fi7wb1.jpg'),
(2, 'Apple MacBook Air M2', 450000, 'Vékony és könnyű laptop, Apple M2 chip, 13,6 hüvelykes Retina kijelző, és 18 órás üzemidő.', 'https://p1.akcdn.net/full/1081640598.apple-macbook-air-m2-z15s000re.jpg'),
(3, 'Lenovo ThinkPad X1 Carbon', 600000, 'Üzleti laptop, 14 hüvelykes kijelző, Intel Core i7, 16GB RAM és 1TB SSD.', 'https://p1.akcdn.net/full/1284532306.lenovo-thinkpad-x1-carbon-gen-12-21kc0056hv.jpg'),
(4, 'HP Spectre x360', 550000, '2 az 1-ben laptop, érintőképernyős 13,3 hüvelykes kijelző, Intel Core i7 és toll támogatás.', 'https://p1.akcdn.net/full/629150685.hp-spectre-x360-13-aw0001nh-8bs71ea.jpg'),
(5, 'Asus ROG Zephyrus G14', 650000, 'Nagy teljesítményű gamer laptop, AMD Ryzen 9, 14 hüvelykes kijelző és NVIDIA RTX 3060.', 'https://p1.akcdn.net/full/1369513813.asus-rog-zephyrus-g14-ga403uv-qs022w.jpg'),
(6, 'ASUS TUF Gaming A15 FA507NUR-LP005', 350000, 'Egy nagy teljesítményű gamer laptop, erős hűtőrendszerrel és strapabíró kialakítással.', 'https://p1.akcdn.net/full/1328151121.asus-tuf-gaming-a15-fa507nur-lp005.jpg'),
(7, 'Apple MacBook Air 13.3 M1 MGN63MG/A', 385000, 'Könnyű és erőteljes laptop, amelyet az Apple M1 chip hajt.', 'https://p1.akcdn.net/full/1206282703.apple-macbook-air-13-3-m1-mgn63mg-a.jpg'),
(8, 'ASUS Vivobook X1504VA-BQ772', 190000, 'Kedvező árú laptop, amely ideális napi feladatokhoz.', 'https://p1.akcdn.net/full/1254648817.asus-vivobook-x1504va-bq772.jpg'),
(9, 'Lenovo IdeaPad 1 82V700FBHV', 140000, 'Hozzáférhető árú laptop alapvető feladatokhoz.', 'https://p1.akcdn.net/full/1244205769.lenovo-ideapad-1-82v700fbhv.jpg'),
(10, 'Apple MacBook Air 13 M3 MRXN3MG/A', 455000, 'Új generációs MacBook Air, fejlett M3 chip-hel.', 'https://p1.akcdn.net/full/1261068961.apple-macbook-air-13-m3-mrxn3mg-a.jpg'),
(11, 'Acer Swift Go 14 AI SFG14-01-X2C3 NX.KYXEU.007', 300000, 'Acer Swift Go egy könnyű és gyors laptop, ideális utazásra.', 'https://p1.akcdn.net/full/1375613428.acer-swift-go-14-ai-sfg14-01-x2c3-nx-kyxeu-007.jpg'),
(12, 'ASUS Vivobook Go E1504FA-NJ648', 170000, 'Az ASUS Vivobook Go egy belépő szintű laptop, ideális mindennapi használatra.', 'https://p1.akcdn.net/full/1193052613.asus-vivobook-go-e1504fa-nj648.jpg'),
(13, 'ASUS TUF Gaming FA506NCR-HN108', 455000, 'Erősebb gaming laptop az ASUS TUF sorozatából, tartós és gyors.', 'https://p1.akcdn.net/full/1335152110.asus-tuf-gaming-fa506ncr-hn108.jpg'),
(14, 'Apple MacBook Air 13 M2 MLXY3MG/A', 525000, 'MacBook Air M2 chip-hel, új és fejlettebb technológiával.', 'https://p1.akcdn.net/full/982927995.apple-macbook-air-13-m2-mlxy3mg-a.jpg'),
(15, 'Apple MacBook Air 13 M3 MRXV3MG/A', 540000, 'A legújabb MacBook Air M3 chip-hel, nagy teljesítménnyel.', 'https://p1.akcdn.net/full/1261068322.apple-macbook-air-13-m3-mrxv3mg-a.jpg'),
(16, 'Samsung Galaxy S24 Ultra 5G 256GB 12GB RAM Dual (SM-S928B)', 500000, 'Prémium okostelefon 12 GB RAM-mal és 256 GB tárolóval.', 'https://p1.akcdn.net/full/1240638061.samsung-galaxy-s24-ultra-5g-256gb-12gb-ram-dual-sm-s928b.jpg'),
(17, 'Xiaomi Poco X7 Pro 5G 512GB 12GB RAM Dual', 450000, 'Erőteljes 5G telefon 512 GB tárolóval és 12 GB RAM-mal.', 'https://p1.akcdn.net/full/1390398406.xiaomi-poco-x7-pro-5g-512gb-12gb-ram-dual.jpg'),
(18, 'Samsung Galaxy A55 5G 128GB 8GB RAM Dual (SM-A556)', 220000, 'Kiváló középkategóriás okostelefon 8 GB RAM-mal és 128 GB tárolóval.', 'https://p1.akcdn.net/full/1262383174.samsung-galaxy-a55-5g-128gb-8gb-ram-dual-sm-a556.jpg'),
(19, 'Apple iPhone 16 128GB', 600000, 'Az új iPhone 16, 128 GB tárolóval, fejlett kamerával és teljesítménnyel.', 'https://p1.akcdn.net/full/1337109469.apple-iphone-16-128gb.jpg'),
(20, 'Apple iPhone 15 128GB', 550000, 'Apple iPhone 15, 128 GB tárolóval és gyors A15 chip-pel.', 'https://p1.akcdn.net/full/1191449686.apple-iphone-15-128gb.jpg'),
(21, 'Xiaomi Redmi Note 14 Pro 5G 256GB 8GB RAM Dual', 300000, 'Erőteljes Redmi telefon 8 GB RAM-mal és 256 GB tárolóval.', 'https://p1.akcdn.net/full/1389911983.xiaomi-redmi-note-14-pro-5g-256gb-8gb-ram-dual.jpg'),
(22, 'Apple iPhone 16 Pro 128GB', 650000, 'Az új iPhone 16 Pro, 128 GB tárolóval és Pro kamera rendszerrel.', 'https://p1.akcdn.net/full/1337110597.apple-iphone-16-pro-128gb.jpg'),
(23, 'Apple iPhone 13 128GB', 500000, 'Apple iPhone 13, 128 GB tárolóval, A15 Bionic chip-pel.', 'https://p1.akcdn.net/full/859255335.apple-iphone-13-128gb.jpg'),
(24, 'Samsung Galaxy S24 5G 128GB 8GB RAM Dual (SM-S921B)', 450000, 'Samsung Galaxy S24, 8 GB RAM-mal és 128 GB tárolóval.', 'https://p1.akcdn.net/full/1240638142.samsung-galaxy-s24-5g-128gb-8gb-ram-dual-sm-s921b.jpg'),
(25, 'Xiaomi Redmi Note 13 Pro 5G 256GB 8GB RAM Dual', 290000, 'Xiaomi Redmi Note 13 Pro 5G, 8 GB RAM-mal és 256 GB tárolóval.', 'https://p1.akcdn.net/full/1239096694.xiaomi-redmi-note-13-pro-5g-256gb-8gb-ram-dual.jpg'),
(26, 'Samsung Galaxy Buds3 Pro (SM-R630NZ)', 95000, 'Prémium fülhallgató kiváló hangminőséggel és aktív zajszűréssel.', 'https://p1.akcdn.net/full/1318706245.samsung-galaxy-buds3-pro-sm-r630nz.jpg'),
(27, 'Apple AirPods Pro 2 (MTJV3ZM/A/MTJV3TY/A)', 120000, 'Új generációs AirPods Pro, aktív zajszűrés és térbeli hangélmény.', 'https://p1.akcdn.net/full/1193325349.apple-airpods-pro-2-mtjv3zm-a-mtjv3ty-a.jpg'),
(28, 'Apple AirPods 4 gen. ANC (MXP93ZM/A)', 105000, 'AirPods 4, aktív zajszűréssel és rendkívül kényelmes viselettel.', 'https://p1.akcdn.net/full/1339403914.apple-airpods-4-gen-anc-mxp93zm-a.jpg'),
(29, 'Xiaomi Redmi Buds 5 Pro (BHR7660/62GL)', 40000, 'Jó ár-érték arányú fülhallgató, kiváló hangzással és hosszú üzemidővel.', 'https://p1.akcdn.net/full/1239749854.xiaomi-redmi-buds-5-pro-bhr7660-62gl.jpg'),
(30, 'Apple AirPods 4 gen. (MXP63ZM/A)', 95000, 'AirPods 4, kiemelkedő hangminőség és könnyű csatlakozás Apple eszközökhöz.', 'https://p1.akcdn.net/full/1339403959.apple-airpods-4-gen-mxp63zm-a.jpg'),
(31, 'Samsung Galaxy Buds3 (SM-R530)', 75000, 'Kiváló minőségű hangzás és kényelmes viselet a mindennapokra.', 'https://p1.akcdn.net/full/1310516590.samsung-galaxy-buds3-sm-r530.jpg'),
(32, 'Samsung Galaxy Buds FE (SM-R400)', 65000, 'Kiváló ár-érték arányú fülhallgató, kényelmes használat és jó hangzás.', 'https://p1.akcdn.net/full/1202072440.samsung-galaxy-buds-fe-sm-r400.jpg'),
(33, 'Apple AirPods 2 (MV7N2TY/MV7N2RU/A / MV7N2ZM)', 60000, 'Kiváló minőségű AirPods 2, könnyű használat és remek hangzás.', 'https://p1.akcdn.net/full/787785633.apple-airpods-2-mv7n2ty-mv7n2ru-a-mv7n2zm.jpg'),
(34, 'Xiaomi Redmi Buds 6 Play (BHR8776GL)', 35000, 'Jó ár-érték arányú vezeték nélküli fülhallgató.', 'https://p1.akcdn.net/full/1337979472.xiaomi-redmi-buds-6-play-bhr8776gl.jpg'),
(35, 'Xiaomi Redmi Buds 6 Active (BHR839GL)', 38000, 'Kényelmes, vízálló és sportoláshoz is ideális fülhallgató.', 'https://p1.akcdn.net/full/1326418861.xiaomi-redmi-buds-6-active-bhr839gl.jpg'),
(36, 'Samsung Galaxy Watch Ultra LTE 47mm (L705)', 300000, 'Kiváló okosóra LTE támogatással és prémium megjelenéssel.', 'https://p1.akcdn.net/full/1315312654.samsung-galaxy-watch-ultra-lte-47mm-l705.jpg'),
(37, 'Huawei Watch D2', 150000, 'Elegáns és funkcionális okosóra, ideális mindennapi használatra.', 'https://p1.akcdn.net/full/1345013809.huawei-watch-d2.jpg'),
(38, 'Xiaomi Redmi Watch 5 Active', 25000, 'Könnyű és sportos okosóra, hosszú akkumulátor élettartammal.', 'https://p1.akcdn.net/full/1345014970.xiaomi-redmi-watch-5-active.jpg'),
(39, 'Apple Watch Ultra 2 GPS + Cellular 49mm', 600000, 'Prémium Apple Watch Ultra 2, GPS + Cellular támogatással.', 'https://p1.akcdn.net/full/1191863290.apple-watch-ultra-2-gps-cellular-49mm.jpg'),
(40, 'Xiaomi Redmi Watch 5', 35000, 'Okosóra okos funkciókkal, ideális ár-érték arányú választás.', 'https://p1.akcdn.net/full/1393228738.xiaomi-redmi-watch-5.jpg'),
(41, 'Xiaomi Smart Band 9', 15000, 'Sportos és kényelmes okoskarkötő, ideális fitnesz követéshez.', 'https://p1.akcdn.net/full/1331218648.xiaomi-smart-band-9.jpg'),
(42, 'Samsung Galaxy Watch 7 44mm (L310)', 350000, 'Samsung prémium okosórája, szép kijelzővel és okos funkciókkal.', 'https://p1.akcdn.net/full/1315312141.samsung-galaxy-watch-7-44mm-l310.jpg'),
(43, 'Xiaomi Watch S3', 60000, 'Stílusos és hosszú üzemidővel rendelkező okosóra a mindennapi használathoz.', 'https://p1.akcdn.net/full/1239778183.xiaomi-watch-s3.jpg'),
(44, 'Samsung Galaxy Watch6 40mm Bluetooth (SM-R930)', 250000, 'Samsung Galaxy Watch 6, 40mm-es Bluetooth változat, elegáns és funkcionalitással.', 'https://p1.akcdn.net/full/1175866380.samsung-galaxy-watch6-40mm-bluetooth-sm-r930.jpg'),
(45, 'Apple Watch Series 10 GPS 46mm', 500000, 'Apple Watch Series 10, 46mm-es GPS változat, prémium megjelenés és funkciók.', 'https://p1.akcdn.net/full/1340662093.apple-watch-series-10-gps-46mm.jpg'),
(46, 'Samsung Galaxy Tab A9+ X210 128GB', 120000, 'Kiváló minőségű táblagép, nagy teljesítmény és nagy kijelző.', 'https://p1.akcdn.net/full/1229535301.samsung-galaxy-tab-a9-x210-128gb.jpg'),
(47, 'Xiaomi Redmi Pad Pro 6GB+128GB', 95000, 'Erőteljes táblagép, nagyszerű ár-érték arány.', 'https://p1.akcdn.net/full/1297413103.xiaomi-redmi-pad-pro-6gb-128gb.jpg'),
(48, 'Apple iPad 10.9 2022 64GB MPQ23/MCM94', 190000, 'Apple iPad 10.9 64GB, könnyű és erőteljes készülék.', 'https://p1.akcdn.net/full/1047905520.apple-ipad-10-9-2022-64gb-mpq23-mcm94.jpg'),
(49, 'Samsung Galaxy Tab S9 FE X510 128GB', 150000, 'Samsung prémium táblagép, nagy kijelző és hosszú üzemidő.', 'https://p1.akcdn.net/full/1201519633.samsung-galaxy-tab-s9-fe-x510-128gb.jpg'),
(50, 'Samsung Galaxy Tab A9 X110N 64GB', 90000, 'Kiváló választás mindennapi használatra, nagy teljesítménnyel.', 'https://p1.akcdn.net/full/1224859981.samsung-galaxy-tab-a9-x110n-64gb.jpg'),
(51, 'Xiaomi Redmi Pad SE 11 4GB+128GB', 75000, 'Sportos és könnyen kezelhető táblagép, ideális szórakozáshoz és munkához.', 'https://p1.akcdn.net/full/1188909229.xiaomi-redmi-pad-se-11-4gb-128gb.jpg'),
(52, 'Samsung Galaxy Tab A9+ X210N 64GB', 105000, 'Kiváló teljesítmény és kiváló kijelző kombinációja.', 'https://p1.akcdn.net/full/1226174050.samsung-galaxy-tab-a9-x210n-64gb.jpg'),
(53, 'Apple iPad Air 6 2024 11 128GB MUWD3', 320000, 'Kiváló teljesítmény és dizájn, prémium Apple táblagép.', 'https://p1.akcdn.net/full/1284906358.apple-ipad-air-6-2024-11-128gb-muwd3.jpg'),
(54, 'Xiaomi Pad 6 6GB+128GB', 110000, 'Erőteljes Xiaomi táblagép, tökéletes a mindennapi használathoz.', 'https://p1.akcdn.net/full/1167369939.xiaomi-pad-6-6gb-128gb.jpg'),
(55, 'Apple iPad 10.9 2022 64GB MPQ13/MCM84', 200000, 'Apple iPad 10.9 2022, erős teljesítmény és magas minőség.', 'https://p1.akcdn.net/full/1376043541.apple-ipad-10-9-2022-64gb-mpq13-mcm84.jpg'),
(56, 'Meta Quest 3 128 GB (899-00582-01)', 250000, 'Meta Quest 3, 128 GB tároló, prémium VR élmény.', 'https://p1.akcdn.net/full/1213770922.meta-quest-3-128-gb-899-00582-01.jpg'),
(57, 'Sony PlayStation VR2 (PS719453994)', 350000, 'Sony PlayStation VR2, csúcsminőségű VR élmény PlayStation 5-höz.', 'https://p1.akcdn.net/full/1110727089.sony-playstation-vr2-ps719453994.jpg'),
(58, 'Meta Quest 3S 128 GB (1000206-01)', 280000, 'Meta Quest 3S, 128 GB, a legújabb VR technológia.', 'https://p1.akcdn.net/full/1357325752.meta-quest-3s-128-gb-1000206-01.jpg'),
(59, 'Meta Quest 3 512GB (899-00583-01/899-00586-01)', 350000, 'Meta Quest 3, 512 GB tároló, nagyszerű VR élmény és teljesítmény.', 'https://p1.akcdn.net/full/1243525054.meta-quest-3-512gb-899-00583-01-899-00586-01.jpg'),
(60, 'Meta Quest 2 Elite (899-00208-01)', 200000, 'Meta Quest 2 Elite, kiváló VR eszköz, kényelmes és erőteljes.', 'https://p1.akcdn.net/full/1311948094.meta-quest-2-elite-899-00208-01.jpg'),
(61, 'XREAL Air 2 Pro AR (X1003)', 120000, 'XREAL Air 2 Pro AR, fejlett AR technológia, hordozható és könnyű.', 'https://p1.akcdn.net/full/1333739581.xreal-air-2-pro-ar-x1003.jpg'),
(62, 'Meta Oculus Quest Pro 256GB (899-00412-01/899-00416-01)', 500000, 'Meta Oculus Quest Pro, 256 GB tároló, prémium VR élmény és fejlettebb hardver.', 'https://p1.akcdn.net/full/1111212099.meta-oculus-quest-pro-256gb-899-00412-01-899-00416-01.jpg'),
(63, 'Meta Quest 3S 256 GB (1000212-01)', 320000, 'Meta Quest 3S, 256 GB tároló, rendkívül fejlett VR technológia.', 'https://p1.akcdn.net/full/1390399681.meta-quest-3s-256-gb-1000212-01.jpg'),
(64, 'Sony PlayStation VR2 + Horizon Call of the Mountain (PS711000036282)', 400000, 'Sony PlayStation VR2 + Horizon Call of the Mountain, teljes VR csomag.', 'https://p1.akcdn.net/full/1110726951.sony-playstation-vr2-horizon-call-of-the-mountain-ps711000036282.jpg'),
(65, 'HTC VIVE Pro 2 Full Kit (99HASZ003-00)', 800000, 'HTC VIVE Pro 2, professzionális VR élmény, teljes kit.', 'https://p1.akcdn.net/full/903076941.htc-vive-pro-2-full-kit-99hasz003-00.jpg');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `felhasznalok`
--
ALTER TABLE `felhasznalok`
  ADD PRIMARY KEY (`Id`);

--
-- A tábla indexei `kartyak`
--
ALTER TABLE `kartyak`
  ADD PRIMARY KEY (`id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `felhasznalok`
--
ALTER TABLE `felhasznalok`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `kartyak`
--
ALTER TABLE `kartyak`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
