-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 24, 2021 at 04:22 PM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `email_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `emails`
--

CREATE TABLE `emails` (
  `id` int(255) NOT NULL,
  `fromUser` varchar(255) NOT NULL,
  `toUser` varchar(255) NOT NULL,
  `cc` varchar(255) DEFAULT NULL,
  `bcc` varchar(255) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `body` varchar(255) NOT NULL,
  `mailBy` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `emails`
--

INSERT INTO `emails` (`id`, `fromUser`, `toUser`, `cc`, `bcc`, `subject`, `body`, `mailBy`) VALUES
(8, 'hassaan.sagheer5@gmail.com', 'ismailamjad98@yahoo.com', NULL, NULL, 'Sixth Test Subject', 'Sixth Test Body', 29),
(9, 'hassaan.sagheer5@gmail.com', 'ismailamjad98@yahoo.com', NULL, NULL, 'Seventh Test Subject', 'seventh Test Body', 29),
(10, 'hassaan.sagheer5@gmail.com', 'ismailamjad98@yahoo.com', 'yaseenboss49@gmail.com', 'yaseenboss@gmail.com', 'Seventh Test Subject', 'seventh Test Body', 29);

-- --------------------------------------------------------

--
-- Table structure for table `packages`
--

CREATE TABLE `packages` (
  `id` int(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` int(255) NOT NULL,
  `emails` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `packages`
--

INSERT INTO `packages` (`id`, `name`, `price`, `emails`) VALUES
(1, 'Free', 0, 20),
(2, 'Basic', 10, 50),
(3, 'Premium', 30, 100);

-- --------------------------------------------------------

--
-- Table structure for table `secondary_users`
--

CREATE TABLE `secondary_users` (
  `id` int(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `merchant_id` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `secondary_users`
--

INSERT INTO `secondary_users` (`id`, `name`, `email`, `password`, `merchant_id`) VALUES
(11, 'user', 'user@gmail.com', '$2y$10$I4DO1zSeEtT5EV3khdoXvuZqzRDd.U2rVNdrGkja63SuBmxsZT7UW', 29),
(12, 'Ismail', 'ismail@gmail.com', '$2y$10$S.9lnj8li16dJa2xg5zXT.Zg6DYIZGSDHqgTAkL5.V./dqZbohKzO', 29),
(13, 'user', 'user@gmail.com', '$2y$10$qTSvBS21lklyljlJYKHDQeHyVRCg7WHCPyQoVJu0g7S.CpU5wHqW6', 29);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(5) NOT NULL,
  `name` varchar(60) NOT NULL,
  `email` varchar(60) NOT NULL,
  `password` varchar(60) NOT NULL,
  `role` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `remaining_emails` varchar(255) NOT NULL,
  `pkg_id` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `image`, `remaining_emails`, `pkg_id`) VALUES
(4, 'Ali', 'ali@gmail.com', '$2y$10$AeiIKXDBbHvDcG.aL8pLB.4k1r8HBtfv4U.ZHp45qC/wK2IYAmI4C', '', '', '', 0),
(5, 'Ahmad', 'ahmad@gmail.com', '$2y$10$1k/7q2FQ5TcSH7GAX2aHROdhRVyULS3g/JoNuKnQH18BIzpyVP3CO', '', '', '', 0),
(6, 'mudasir', 'musdasir@gmail.com', '$2y$10$mauzpHPNoyTP6k.lCGh8fe7JBHgBzZJn/jXND.N9/8Dg4BoC4smxq', '', '', '', 0),
(8, 'Zubair', 'zubair@gmail.com', '123', '', '', '', 0),
(29, 'Hassaan', 'hassaan.sagheer5@gmail.com', 'hassaanpp12', 'Merchant', '1635017168675.jpg', '20', 1),
(30, 'Yaseen', 'yaseenboss48@gmail.com', '$2y$10$tQCU2o7R0xeqGBD9qHtD4uZmrJA37CkBjg0WvfLugqnwEX1iSUS5y', 'Merchant', '1635017487281.jpg', '20', 1),
(31, 'admin', 'hassaan@gmail.com', 'hassaanpp12', 'Admin', '', '', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `emails`
--
ALTER TABLE `emails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `packages`
--
ALTER TABLE `packages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `secondary_users`
--
ALTER TABLE `secondary_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `emails`
--
ALTER TABLE `emails`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `packages`
--
ALTER TABLE `packages`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `secondary_users`
--
ALTER TABLE `secondary_users`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
