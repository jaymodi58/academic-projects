-- phpMyAdmin SQL Dump
-- version 4.5.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 23, 2016 at 02:37 AM
-- Server version: 5.7.11
-- PHP Version: 5.6.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `team9final`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer_detail`
--

CREATE TABLE `customer_detail` (
  `customer_id` varchar(20) NOT NULL,
  `name` varchar(20) NOT NULL,
  `remaining_limit` double NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer_detail`
--

INSERT INTO `customer_detail` (`customer_id`, `name`, `remaining_limit`) VALUES
('1234', 'jay', 70.34),
('5678', 'ruchit', 100.12),
('9876', 'apurv', 400.24),
('123456789', 'jaymodi', 900),
('1221', 'ABC', 201),
('234', 'mjs', 1000),
('54321', 'bond', 1000),
('215', 'modi', 1000),
('6986', 'jack', 1000);

-- --------------------------------------------------------

--
-- Table structure for table `item_description`
--

CREATE TABLE `item_description` (
  `item_id` varchar(20) NOT NULL,
  `item_name` varchar(20) NOT NULL,
  `item_price` double NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `item_description`
--

INSERT INTO `item_description` (`item_id`, `item_name`, `item_price`) VALUES
('1', 'iPhone', 799),
('2', 'Gold bar', 100),
('3', 'Gold coin', 50),
('4', 'Nexus7', 400),
('5', 'Note4', 450),
('6', 'iWatch', 200);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
