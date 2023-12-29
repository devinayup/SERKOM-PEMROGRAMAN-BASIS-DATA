-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 28, 2023 at 12:52 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lapor_kejahatan`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getLaporan` ()   BEGIN
    SELECT code_laporan, location, description, date FROM laporan;
  END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `countLaporan` () RETURNS INT(11)  BEGIN
  DECLARE count INT;
  SELECT COUNT(*) INTO count FROM laporan;
  RETURN count;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `laporan`
--

CREATE TABLE `laporan` (
  `id` int(11) NOT NULL,
  `code_laporan` char(7) NOT NULL,
  `location` varchar(30) NOT NULL,
  `description` text NOT NULL,
  `date` date NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `laporan`
--

INSERT INTO `laporan` (`id`, `code_laporan`, `location`, `description`, `date`, `user_id`) VALUES
(4, 'KR3Bseb', 'rt 1 rw 3 desa karangpucung', 'terjadi perampokan di rumah bapak ahmad, barang yang di rampok 1 unit sepeda motor', '2023-12-25', 1),
(5, 'd6Ys4Vc', 'jalan dr angka nomer 17', 'terjadi begal motor sekitar jam 2 dini hari, korban dilarikan ke rumah sakit', '2023-12-25', 3),
(6, '87Bo3iU', 'purwokerto', 'kemalingan motor', '2023-12-26', 3),
(7, 'NrbCStl', 'yogyakarta', 'kehilangan motor', '2023-12-26', 1),
(8, 'IdB4ydu', 'klaten', 'pencurian', '2023-12-26', 1),
(9, 'T57CXJ6', 'jakarta', 'pencurian', '2023-12-26', 1),
(10, '7wpnxDE', 'purwokerto selatan', 'terjadi kemalingan mobil dimalam hari sekitar jam 3 pagi dini hari', '2023-12-27', 2);

--
-- Triggers `laporan`
--
DELIMITER $$
CREATE TRIGGER `laporan_insert_trigger` AFTER INSERT ON `laporan` FOR EACH ROW BEGIN
  INSERT INTO logs (message, date, time, user_id)
  VALUES ('create Laporan',CURDATE(), CURTIME(), NEW.user_id);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `message` varchar(20) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `logs`
--

INSERT INTO `logs` (`id`, `message`, `date`, `time`, `user_id`, `created_at`) VALUES
(2, 'create Laporan', '2023-12-25', '08:39:59', 1, '2023-12-25 01:39:59'),
(3, 'create Laporan', '2023-12-25', '08:57:16', 3, '2023-12-25 01:57:16'),
(4, 'create Laporan', '2023-12-26', '13:15:21', 3, '2023-12-26 06:15:21'),
(5, 'create Laporan', '2023-12-26', '18:45:15', 1, '2023-12-26 11:45:15'),
(6, 'create Laporan', '2023-12-26', '20:22:38', 1, '2023-12-26 13:22:38'),
(7, 'create Laporan', '2023-12-26', '20:31:29', 1, '2023-12-26 13:31:29'),
(8, 'create Laporan', '2023-12-27', '11:10:15', 2, '2023-12-27 04:10:15');

-- --------------------------------------------------------

--
-- Table structure for table `tindakan`
--

CREATE TABLE `tindakan` (
  `id` int(11) NOT NULL,
  `status` char(10) NOT NULL,
  `keterangan` text NOT NULL,
  `date` date NOT NULL,
  `laporan_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `handphone` varchar(20) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role` enum('admin','pelapor') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `handphone`, `username`, `password`, `role`, `created_at`, `updated_at`) VALUES
(1, 'budi', '08123456789', 'budi', 'budi1234', 'pelapor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 'joko', '091289658832', 'lati', 'lati02', 'pelapor', '2023-12-26 13:25:59', '2023-12-26 13:25:59'),
(3, 'Rizky', '0897654231', 'rizky', 'rizky1234', 'pelapor', '2023-12-25 01:19:26', '2023-12-25 01:19:26');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `laporan`
--
ALTER TABLE `laporan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tindakan`
--
ALTER TABLE `tindakan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `laporan_id` (`laporan_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_name_user` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `laporan`
--
ALTER TABLE `laporan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tindakan`
--
ALTER TABLE `tindakan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7657;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `laporan`
--
ALTER TABLE `laporan`
  ADD CONSTRAINT `laporan_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `logs`
--
ALTER TABLE `logs`
  ADD CONSTRAINT `logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `tindakan`
--
ALTER TABLE `tindakan`
  ADD CONSTRAINT `tindakan_ibfk_1` FOREIGN KEY (`laporan_id`) REFERENCES `laporan` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
