-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: c5_qlybanhang
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
-- Table structure for table `cthd`
--

DROP TABLE IF EXISTS `cthd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cthd` (
  `SoHD` int DEFAULT NULL,
  `MaSP` char(4) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `SoLuong` int DEFAULT NULL,
  KEY `fk_masp_idx` (`MaSP`),
  KEY `fk_sohd` (`SoHD`),
  CONSTRAINT `fk_masp` FOREIGN KEY (`MaSP`) REFERENCES `sanpham` (`MaSP`),
  CONSTRAINT `fk_sohd` FOREIGN KEY (`SoHD`) REFERENCES `hoadon` (`SoHoaDon`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cthd`
--

LOCK TABLES `cthd` WRITE;
/*!40000 ALTER TABLE `cthd` DISABLE KEYS */;
INSERT INTO `cthd` VALUES (1001,'TV02',10),(1001,'TV02',10),(1001,'ST01',5),(1001,'BC01',5),(1001,'BC02',10),(1001,'ST08',10),(1002,'BC04',20),(1002,'BB01',20),(1002,'BB02',20),(1003,'BB03',10),(1004,'TV01',20),(1004,'TV02',10),(1004,'TV03',10),(1004,'TV04',10),(1005,'TV05',50),(1005,'TV06',50),(1006,'TV07',50),(1006,'ST01',30),(1006,'ST02',10),(1007,'ST03',10),(1008,'ST04',8),(1009,'ST05',10),(1010,'TV07',50),(1010,'ST07',50),(1010,'ST08',100),(1010,'ST04',50),(1010,'TV03',100),(1011,'ST06',50),(1012,'ST07',3),(1013,'ST08',5),(1014,'BC02',80),(1014,'BC02',100),(1014,'BC04',60),(1014,'BB01',50),(1015,'BB02',30),(1015,'BB03',7),(1016,'TV01',5),(1017,'TV02',1),(1017,'TV03',1),(1017,'TV04',5),(1018,'ST04',6),(1019,'ST05',1),(1019,'ST06',2),(1020,'ST07',10),(1021,'ST08',5),(1021,'TV01',7),(1021,'TV02',10),(1022,'ST07',1);
/*!40000 ALTER TABLE `cthd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hoadon`
--

DROP TABLE IF EXISTS `hoadon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hoadon` (
  `SoHoaDon` int NOT NULL,
  `NgayMuaHang` datetime DEFAULT NULL,
  `MaKH` char(4) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `MaNV` char(4) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `TriGia` decimal(12,0) DEFAULT NULL,
  PRIMARY KEY (`SoHoaDon`),
  KEY `fk_makh_idx` (`MaKH`),
  KEY `fk_manv_idx` (`MaNV`),
  CONSTRAINT `fk_makh` FOREIGN KEY (`MaKH`) REFERENCES `khachhang` (`MaKH`),
  CONSTRAINT `fk_manv` FOREIGN KEY (`MaNV`) REFERENCES `nhanvien` (`MaNV`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hoadon`
--

LOCK TABLES `hoadon` WRITE;
/*!40000 ALTER TABLE `hoadon` DISABLE KEYS */;
INSERT INTO `hoadon` VALUES (1001,'2006-07-23 00:00:00','KH01','NV01',320000),(1002,'2006-12-08 00:00:00','KH01','NV02',840000),(1003,'2006-08-23 00:00:00','KH02','NV01',100000),(1004,'2006-09-01 00:00:00','KH02','NV01',180000),(1005,'2006-10-20 00:00:00','KH01','NV02',3800000),(1006,'2006-10-16 00:00:00','KH01','NV03',2430000),(1007,'2006-10-28 00:00:00','KH03','NV03',510000),(1008,'2006-10-28 00:00:00','KH01','NV03',440000),(1009,'2006-10-28 00:00:00','KH03','NV04',20000),(1010,'2006-11-01 00:00:00','KH01','NV01',5200000),(1011,'2006-11-04 00:00:00','KH04','NV03',250000),(1012,'2006-11-30 00:00:00','KH05','NV03',21000),(1013,'2006-12-12 00:00:00','KH06','NV01',5000),(1014,'2006-12-31 00:00:00','KH03','NV02',3150000),(1015,'2007-01-01 00:00:00','KH06','NV01',910000),(1016,'2007-01-01 00:00:00','KH07','NV02',12500),(1017,'2007-01-02 00:00:00','KH08','NV03',35000),(1018,'2007-01-13 00:00:00','KH08','NV03',33000),(1019,'2007-01-13 00:00:00','KH01','NV03',30000),(1020,'2007-01-14 00:00:00','KH09','NV04',70000),(1021,'2007-01-16 00:00:00','KH10','NV03',67500),(1022,'2007-01-16 00:00:00',NULL,'NV03',7000);
/*!40000 ALTER TABLE `hoadon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `khachhang`
--

DROP TABLE IF EXISTS `khachhang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `khachhang` (
  `MaKH` char(4) COLLATE utf8mb3_unicode_ci NOT NULL,
  `HoTen` varchar(45) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `DiaChi` varchar(50) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `SoDienThoai` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `NgaySinh` datetime DEFAULT NULL,
  `NgayDangKi` datetime DEFAULT NULL,
  `DoanhSo` decimal(12,0) DEFAULT NULL,
  PRIMARY KEY (`MaKH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khachhang`
--

LOCK TABLES `khachhang` WRITE;
/*!40000 ALTER TABLE `khachhang` DISABLE KEYS */;
INSERT INTO `khachhang` VALUES ('KH01','Nguyen Van A','731 Tran Hung Dao, Q5, TP HCM','08823451','1960-10-22 00:00:00','2006-04-13 00:00:00',13060000),('KH02','Tran Ngoc Han','23/5 Nguyen Trai, Q5, HCM','0908256478','1974-04-03 00:00:00','2006-07-30 00:00:00',280000),('KH03','Tran Ngoc Linh','45 Nguyen Canh Chan, Q1, HCM','0938776266','1980-06-12 00:00:00','2006-08-05 00:00:00',3860000),('KH04','Tran Minh Long','50/34 Le Dai Hanh, Q10, HCM','0917325476','1965-03-09 00:00:00','2006-10-02 00:00:00',250000),('KH05','Le Nhat Minh','34 Truong Dinh, Q3, TP HCM','08246108','1950-03-10 00:00:00','2006-10-28 00:00:00',21000),('KH06','Le Hoai Thuong','227 Nguyen Van Cu, Q5, TP HCM','08631738','1981-12-31 00:00:00','2006-11-24 00:00:00',915000),('KH07','Nguyen Van Tam','32/3 Tran Binh Trong Q5, HCM','0916783565','1971-04-06 00:00:00','2006-12-01 00:00:00',12500),('KH08','Phan Thi Thanh','45/2 An Duong Vuong, Q5, HCM','0938435756','1971-01-10 00:00:00','2006-12-13 00:00:00',365000),('KH09','Le Ha Vinh','873 Le Hong Phong, Q5, HCM','08654763','1979-09-03 00:00:00','2007-01-14 00:00:00',70000),('KH10','Ha Duy Lap','34/34B Nguyen Trai Q1, HCM','08768904','1983-05-02 00:00:00','2007-01-16 00:00:00',67500);
/*!40000 ALTER TABLE `khachhang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nhanvien`
--

DROP TABLE IF EXISTS `nhanvien`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nhanvien` (
  `MaNV` char(4) COLLATE utf8mb3_unicode_ci NOT NULL,
  `HoTen` varchar(45) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `SDT` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `NgayVaoLam` datetime DEFAULT NULL,
  PRIMARY KEY (`MaNV`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nhanvien`
--

LOCK TABLES `nhanvien` WRITE;
/*!40000 ALTER TABLE `nhanvien` DISABLE KEYS */;
INSERT INTO `nhanvien` VALUES ('NV01','Nguyen Nhu Nhut','0927345678','2006-04-13 00:00:00'),('NV02','Le Thi Phi Yen','0987567390','2008-04-15 00:00:00'),('NV03','Nguyen Van B','0997047382','2006-04-27 00:00:00'),('NV04','Ngo Thanh Tuan','0913758498','2006-06-24 00:00:00'),('NV05','Nguyen Thi Truc Thanh','0918590387','2006-07-20 00:00:00');
/*!40000 ALTER TABLE `nhanvien` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sanpham`
--

DROP TABLE IF EXISTS `sanpham`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sanpham` (
  `MaSP` char(4) COLLATE utf8mb3_unicode_ci NOT NULL,
  `TenSP` varchar(40) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `DVT` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `NuocSX` varchar(40) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `Gia` decimal(12,0) DEFAULT NULL,
  PRIMARY KEY (`MaSP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sanpham`
--

LOCK TABLES `sanpham` WRITE;
/*!40000 ALTER TABLE `sanpham` DISABLE KEYS */;
INSERT INTO `sanpham` VALUES ('BB01','But bi','cay','Viet Nam',5000),('BB02','But bi','cay','Trung Quoc',7000),('BB03','But bi','hop','Thai Lan',100000),('BC01','ButChi','cay','Trung Quoc',3000),('BC02','ButChi','cay','Thai Lan',5000),('BC03','ButChi','cay','Viet Nam',3500),('BC04','ButChi','hop','Viet Nam',30000),('ST01','So tay 500 trang','quyen','Trung Quoc',40000),('ST02','So tay loai 1','quyen','Viet Nam',55000),('ST03','So tay loai 2','quyen','Viet Nam',51000),('ST04','So tay','quyen','Thai Lan',55000),('ST05','So tay mong','quyen','Thai Lan',20000),('ST06','Phan viet bang','hop','Viet Nam',5000),('ST07','Phan khong bui','hop','Viet Nam',7000),('ST08','Bong bang','cai','Viet Nam',1000),('ST09','But long','cay','Viet Nam',5000),('ST10','But long','cay','Viet Nam',7000),('TV01','Tap 100 giay mong','quyen','Trung Quoc',2500),('TV02','Tap 200 giay mong','quyen','Trung Quoc',4500),('TV03','Tap 100 giay tot','quyen','Viet Nam',3000),('TV04','Tap 200 giay tot','cay','Viet Nam',5500),('TV05','Tap 100 trang','chuc','Viet Nam',23000),('TV06','Tap 200 trang','chuc','Viet Nam',53000),('TV07','Tap 100 trang','chuc','Trung Quoc',34000);
/*!40000 ALTER TABLE `sanpham` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-08-26 10:19:58