-- phpMyAdmin SQL Dump
-- version 4.9.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 28, 2020 at 02:25 AM
-- Server version: 10.3.22-MariaDB-cll-lve
-- PHP Version: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kbtr4delinks_kbtraders`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_account`
--

CREATE TABLE `tbl_account` (
  `Acc_SlNo` int(11) NOT NULL,
  `branch_id` int(11) NOT NULL,
  `Acc_Code` varchar(50) NOT NULL,
  `Acc_Tr_Type` varchar(25) DEFAULT NULL,
  `Acc_Name` varchar(200) NOT NULL,
  `Acc_Type` varchar(50) NOT NULL,
  `Acc_Description` varchar(255) NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'a',
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_account`
--

INSERT INTO `tbl_account` (`Acc_SlNo`, `branch_id`, `Acc_Code`, `Acc_Tr_Type`, `Acc_Name`, `Acc_Type`, `Acc_Description`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`) VALUES
(1, 1, 'A0001', '', 'Business Cash Amount', '', '', 'a', 'Admin', '2020-04-13 08:15:49', 'Admin', '2020-04-13 08:16:16'),
(2, 1, 'A0002', '', 'Business Products Amount	', '', '', 'a', 'Admin', '2020-04-13 08:15:55', NULL, NULL),
(3, 1, 'A0003', '', 'Food', '', '', 'a', 'Admin', '2020-04-13 17:50:17', NULL, NULL),
(4, 1, 'A0004', '', 'Bill', '', '', 'a', 'Admin', '2020-04-13 17:50:22', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_assets`
--

CREATE TABLE `tbl_assets` (
  `as_id` int(11) NOT NULL,
  `as_date` date DEFAULT NULL,
  `as_name` varchar(50) DEFAULT NULL,
  `as_qty` int(11) DEFAULT NULL,
  `as_rate` decimal(10,2) DEFAULT NULL,
  `as_amount` decimal(10,2) DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `branchid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_assets`
--

INSERT INTO `tbl_assets` (`as_id`, `as_date`, `as_name`, `as_qty`, `as_rate`, `as_amount`, `status`, `AddBy`, `AddTime`, `branchid`) VALUES
(1, '2020-04-12', 'Brand কাজললতা', 78, 760.00, 59280.00, 'd', 'Admin', '2020-04-12 21:57:53', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_bank_accounts`
--

CREATE TABLE `tbl_bank_accounts` (
  `account_id` int(11) NOT NULL,
  `account_name` varchar(500) NOT NULL,
  `account_number` varchar(250) NOT NULL,
  `account_type` varchar(200) NOT NULL,
  `bank_name` varchar(250) NOT NULL,
  `branch_name` varchar(250) DEFAULT NULL,
  `initial_balance` float NOT NULL,
  `description` varchar(2000) NOT NULL,
  `saved_by` int(11) NOT NULL,
  `saved_datetime` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_datetime` datetime DEFAULT NULL,
  `branch_id` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_bank_accounts`
--

INSERT INTO `tbl_bank_accounts` (`account_id`, `account_name`, `account_number`, `account_type`, `bank_name`, `branch_name`, `initial_balance`, `description`, `saved_by`, `saved_datetime`, `updated_by`, `updated_datetime`, `branch_id`, `status`) VALUES
(1, 'KB Traders & Agro Food', '21515214854', 'CC Loan', 'Rupali Bank (CC)', 'Shailkupa', 700000, '', 1, '2020-04-14 21:50:43', 1, '2020-04-14 22:02:59', 1, 1),
(2, 'KB Traders & Agro Food	', '45645645645', 'Current', 'Rupali Bank	', 'Shailkupa	', 12500, '', 1, '2020-04-14 21:51:28', NULL, NULL, 1, 1),
(3, 'Bidhan Kumar Saha', '454564564', 'Savings', 'Dutch Bangla Bank', 'Shailkupa	', 257575, '', 1, '2020-04-14 21:53:19', 1, '2020-04-14 21:55:09', 1, 1),
(4, 'Bimol Kumar Saha', '54645645645', 'Savings	', 'Dutch Bangla Bank	', 'Shailkupa', 7500, '', 1, '2020-04-14 21:54:21', 1, '2020-04-14 21:54:56', 1, 1),
(5, 'KB Traders & Agro Food	', '54964564454', 'Current', 'Janata Bank', 'Shailkupa', 4500, '', 1, '2020-04-14 21:55:53', NULL, NULL, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_bank_transactions`
--

CREATE TABLE `tbl_bank_transactions` (
  `transaction_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `transaction_date` date NOT NULL,
  `transaction_type` varchar(10) NOT NULL,
  `amount` float NOT NULL,
  `note` varchar(500) DEFAULT NULL,
  `saved_by` int(11) NOT NULL,
  `saved_datetime` datetime NOT NULL,
  `branch_id` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_brand`
--

CREATE TABLE `tbl_brand` (
  `brand_SiNo` int(11) NOT NULL,
  `ProductCategory_SlNo` int(11) NOT NULL,
  `brand_name` varchar(100) NOT NULL,
  `status` char(2) NOT NULL,
  `brand_branchid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_brunch`
--

CREATE TABLE `tbl_brunch` (
  `brunch_id` int(11) NOT NULL,
  `Brunch_name` varchar(250) CHARACTER SET utf8 NOT NULL,
  `Brunch_title` varchar(250) CHARACTER SET utf8 NOT NULL,
  `Brunch_address` text CHARACTER SET utf8 NOT NULL,
  `Brunch_sales` varchar(1) NOT NULL COMMENT 'Wholesales = 1, Retail = 2',
  `add_date` date NOT NULL,
  `add_time` datetime NOT NULL,
  `add_by` char(50) NOT NULL,
  `update_by` char(50) NOT NULL,
  `status` char(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_brunch`
--

INSERT INTO `tbl_brunch` (`brunch_id`, `Brunch_name`, `Brunch_title`, `Brunch_address`, `Brunch_sales`, `add_date`, `add_time`, `add_by`, `update_by`, `status`) VALUES
(1, 'KB Showroom', 'Main Warehouse', 'Degree Collage Road,Shailkupa,Jhenaidah', '2', '2019-08-07', '2019-08-07 23:09:25', '', 'Admin', 'a'),
(7, 'Warehouse 2', 'Own Warehouse', 'High School Warehouse Road', '2', '0000-00-00', '2020-03-19 19:52:49', 'Admin', '', 'a'),
(8, 'Warehouse 3', 'Rent Warehouse', 'High School Warehouse Road', '2', '0000-00-00', '2020-03-19 19:53:03', 'Admin', '', 'a');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_cashregister`
--

CREATE TABLE `tbl_cashregister` (
  `Transaction_ID` int(11) NOT NULL,
  `Transaction_Date` varchar(20) NOT NULL,
  `IdentityNo` varchar(50) DEFAULT NULL,
  `Narration` varchar(100) NOT NULL,
  `InAmount` decimal(18,2) NOT NULL,
  `OutAmount` decimal(18,2) NOT NULL,
  `Description` longtext NOT NULL,
  `Status` char(1) DEFAULT NULL,
  `Saved_By` varchar(50) DEFAULT NULL,
  `Saved_Time` datetime DEFAULT NULL,
  `Edited_By` varchar(50) DEFAULT NULL,
  `Edited_Time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_cashtransaction`
--

CREATE TABLE `tbl_cashtransaction` (
  `Tr_SlNo` int(11) NOT NULL,
  `Tr_Id` varchar(50) NOT NULL,
  `Tr_date` date NOT NULL,
  `Tr_Type` varchar(20) NOT NULL,
  `Tr_account_Type` varchar(50) NOT NULL,
  `Acc_SlID` int(11) NOT NULL,
  `Tr_Description` varchar(255) NOT NULL,
  `In_Amount` decimal(18,2) NOT NULL,
  `Out_Amount` decimal(18,2) NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'a',
  `AddBy` varchar(100) NOT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `Tr_branchid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_cashtransaction`
--

INSERT INTO `tbl_cashtransaction` (`Tr_SlNo`, `Tr_Id`, `Tr_date`, `Tr_Type`, `Tr_account_Type`, `Acc_SlID`, `Tr_Description`, `In_Amount`, `Out_Amount`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`, `Tr_branchid`) VALUES
(1, 'TR00001', '2020-04-13', 'In Cash', '', 2, 'Stock Products Amount', 866008.00, 0.00, 'a', 'Admin', '2020-04-13 08:16:45', 'Admin', '2020-04-14 22:12:26', 1),
(2, 'TR00002', '2020-04-13', 'Out Cash', '', 4, 'Wifi', 0.00, 1600.00, 'd', 'Admin', '2020-04-13 17:50:43', NULL, NULL, 1),
(3, 'TR00003', '2020-04-13', 'In Cash', '', 1, '13/04/2020 Update', 390010.00, 0.00, 'a', 'Admin', '2020-04-14 22:11:55', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_checks`
--

CREATE TABLE `tbl_checks` (
  `id` int(20) UNSIGNED NOT NULL,
  `cus_id` int(20) DEFAULT NULL,
  `SM_id` int(20) UNSIGNED DEFAULT NULL,
  `bank_name` varchar(250) DEFAULT NULL,
  `branch_name` varchar(250) DEFAULT NULL,
  `check_no` varchar(250) DEFAULT NULL,
  `check_amount` decimal(18,2) DEFAULT NULL,
  `date` timestamp NULL DEFAULT NULL,
  `check_date` timestamp NULL DEFAULT NULL,
  `remid_date` timestamp NULL DEFAULT NULL,
  `sub_date` timestamp NULL DEFAULT NULL,
  `note` varchar(250) DEFAULT NULL,
  `check_status` char(5) DEFAULT 'Pe' COMMENT 'Pe =Pending, Pa = Paid',
  `status` char(5) NOT NULL DEFAULT 'a',
  `created_by` varchar(250) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `branch_id` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_color`
--

CREATE TABLE `tbl_color` (
  `color_SiNo` int(11) NOT NULL,
  `color_name` varchar(100) NOT NULL,
  `status` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_company`
--

CREATE TABLE `tbl_company` (
  `Company_SlNo` int(11) NOT NULL,
  `Company_Name` varchar(150) NOT NULL,
  `Repot_Heading` text NOT NULL,
  `Company_Logo_org` varchar(250) NOT NULL,
  `Company_Logo_thum` varchar(250) NOT NULL,
  `Invoice_Type` int(11) NOT NULL,
  `Currency_Name` varchar(50) DEFAULT NULL,
  `Currency_Symbol` varchar(10) DEFAULT NULL,
  `SubCurrency_Name` varchar(50) DEFAULT NULL,
  `print_type` int(11) NOT NULL,
  `company_BrunchId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_company`
--

INSERT INTO `tbl_company` (`Company_SlNo`, `Company_Name`, `Repot_Heading`, `Company_Logo_org`, `Company_Logo_thum`, `Invoice_Type`, `Currency_Name`, `Currency_Symbol`, `SubCurrency_Name`, `print_type`, `company_BrunchId`) VALUES
(1, 'কে বি ট্রেডার্স এন্ড এগ্রো ফুড', 'প্রোঃ বিমল কুমার সাহা / পরিচালনায়ঃ বিধান কুমার সাহা\r\nচাউল ও যাবতীয় মালের ব্যবসায়ী ও কমিশন এজেন্ট\r\nডিগ্রী কলেজ রোড, শৈলকূপা ঝিনাইদাহ-৭৩২০ \r\nবিধান সাহাঃ ০১৭৫৯-০১১৫৬৭\r\nবিমল সাহাঃ ০১৯১৫১৫৭২৭৭\r\nঅফিসঃ ০১৯০৮২১২৯৮০\r\nEmail: kbgroup1965@gmail.com\r\nWebsite: www.kbtradelinks.com', '2.png', '2.png', 1, NULL, NULL, NULL, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_country`
--

CREATE TABLE `tbl_country` (
  `Country_SlNo` int(11) NOT NULL,
  `CountryName` varchar(50) NOT NULL,
  `Status` char(1) NOT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_currentinventory`
--

CREATE TABLE `tbl_currentinventory` (
  `inventory_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `purchase_quantity` float NOT NULL,
  `purchase_return_quantity` float NOT NULL,
  `sales_quantity` float NOT NULL,
  `sales_return_quantity` float NOT NULL,
  `damage_quantity` float NOT NULL,
  `transfer_from_quantity` float NOT NULL,
  `transfer_to_quantity` float NOT NULL,
  `branch_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_currentinventory`
--

INSERT INTO `tbl_currentinventory` (`inventory_id`, `product_id`, `cat_id`, `purchase_quantity`, `purchase_return_quantity`, `sales_quantity`, `sales_return_quantity`, `damage_quantity`, `transfer_from_quantity`, `transfer_to_quantity`, `branch_id`) VALUES
(1, 1, 1, 0, 0, 0, 0, 0, 500, 0, 1),
(2, 1, 1, 0, 0, 0, 0, 0, 0, 500, 7),
(3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 1),
(4, 2, 1, 0, 0, 0, 0, 0, 0, 10, 7),
(5, 2, 0, 0, 0, 0, 0, 0, 0, 0, 8),
(6, 3, 1, 0, 0, 0, 0, 0, 0, 0, 1),
(7, 4, 1, 0, 0, -3, 0, 0, 0, 0, 1),
(8, 5, 1, -10, 0, -2, 0, 0, 0, 0, 1),
(9, 6, 1, 0, 0, 0, 0, 0, 0, 0, 1),
(10, 7, 1, 0, 0, 0, 0, 0, 0, 0, 1),
(11, 8, 1, 0, 0, 0, 0, 0, 0, 0, 1),
(12, 9, 1, 0, 0, 0, 0, 0, 0, 0, 1),
(13, 8, 1, 0, 0, 0, 0, 0, 0, 0, 8),
(14, 5, 1, 0, 0, 0, 0, 0, 0, 0, 8),
(15, 4, 1, 0, 0, 3, 0, 0, 0, 0, 7),
(16, 10, 1, 0, 0, -5, 0, 0, 0, 0, 1),
(17, 11, 1, 0, 0, 0, 0, 0, 0, 0, 1),
(18, 10, 1, 0, 0, 5, 0, 0, 0, 0, 8),
(19, 12, 1, -10, 0, -8, 0, 0, 0, 0, 1),
(20, 12, 1, 10, 0, 8, 0, 0, 0, 0, 7),
(21, 5, 1, 10, 0, 2, 0, 0, 0, 0, 7),
(22, 13, 1, 0, 0, 0, 0, 0, 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_customer`
--

CREATE TABLE `tbl_customer` (
  `Customer_SlNo` int(11) NOT NULL,
  `Customer_Code` varchar(50) NOT NULL,
  `Customer_Name` varchar(150) NOT NULL,
  `Customer_Type` varchar(50) NOT NULL,
  `Customer_Phone` varchar(50) NOT NULL,
  `Customer_Mobile` varchar(15) NOT NULL,
  `Customer_Email` varchar(50) NOT NULL,
  `Customer_OfficePhone` varchar(50) NOT NULL,
  `Customer_Address` varchar(300) NOT NULL,
  `owner_name` varchar(250) DEFAULT NULL,
  `Country_SlNo` int(11) NOT NULL,
  `area_ID` int(11) NOT NULL,
  `Customer_Web` varchar(50) NOT NULL,
  `Customer_Credit_Limit` decimal(18,2) NOT NULL,
  `previous_due` decimal(18,2) NOT NULL,
  `image_name` varchar(1000) DEFAULT NULL,
  `status` char(1) NOT NULL DEFAULT 'a',
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `Customer_brunchid` int(11) NOT NULL,
  `page_number` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_customer`
--

INSERT INTO `tbl_customer` (`Customer_SlNo`, `Customer_Code`, `Customer_Name`, `Customer_Type`, `Customer_Phone`, `Customer_Mobile`, `Customer_Email`, `Customer_OfficePhone`, `Customer_Address`, `owner_name`, `Country_SlNo`, `area_ID`, `Customer_Web`, `Customer_Credit_Limit`, `previous_due`, `image_name`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`, `Customer_brunchid`, `page_number`) VALUES
(1, 'C00001', 'আলিফ ট্রেডার্স', 'wholesale', '', '01745123165', '', '', 'রয়ড়া বাজার', 'মন্নু ', 0, 1, '', 300000.00, 267198.00, NULL, 'd', 'Admin', '2020-04-12 17:12:49', 'Admin', '2020-04-12 19:44:05', 1, '227'),
(2, 'C00002', 'আব্দুল রাজ্জাক স্টোর', 'wholesale', '', '০১৯২০২৬৪৭৫৫', '', '', 'সাধুহাটি', 'আব্দুল রাজ্জাক', 0, 1, '', 100000.00, 59920.00, NULL, 'd', 'Admin', '2020-04-12 19:20:39', NULL, NULL, 1, ''),
(3, 'C00003', 'আব্দুল্লাহ স্টোর', 'wholesale', '', 'NO Have', '', '', 'টবাজার', 'আব্দুল্লাহ', 0, 1, '', 100000.00, 11800.00, NULL, 'a', 'Admin', '2020-04-12 19:21:59', NULL, NULL, 1, ''),
(4, 'C00004', 'আমজাদ স্টোর', 'wholesale', '', '০১৯২৬৯০৭৪৮২', '', '', 'খুলুমবাড়ি বাজার', 'আমজাদ', 0, 1, '', 100000.00, 2680.00, NULL, 'a', 'Admin', '2020-04-12 19:23:20', NULL, NULL, 1, ''),
(5, 'C00005', 'আলামিন স্টোর', 'wholesale', '', '০১৯২৩১৮২৬১৭', '', '', 'চামটিপাড়ার মোড়', 'আলামিন', 0, 1, '', 50000.00, 7475.00, NULL, 'd', 'Admin', '2020-04-12 19:24:56', NULL, NULL, 1, ''),
(6, 'C00006', 'আশরাফুল', 'wholesale', '', '০১৯৫৬২৩৩৯১৭', '', '', 'বড়িয়া বাজার', 'আশরাফুল', 0, 1, '', 100000.00, 40795.00, NULL, 'a', 'Admin', '2020-04-12 19:26:30', NULL, NULL, 1, ''),
(7, 'C00007', 'উজ্জল স্টোর', 'wholesale', '', '০১৭১৮২৩৩৬৫৯', '', '', 'ধাওড়া বাজার', 'উজ্জল', 0, 1, '', 300000.00, 229190.00, NULL, 'a', 'Admin', '2020-04-12 19:32:22', NULL, NULL, 1, ''),
(8, 'C00008', 'এনামুল ট্রেডার্স', 'wholesale', '', '০১৯১০০০৪৬৫১', '', '', 'ধাওড়া বাজার', 'এনামুল হক', 0, 1, '', 50000.00, 17815.00, NULL, 'a', 'Admin', '2020-04-12 19:35:29', 'Admin', '2020-04-26 11:06:28', 1, ''),
(9, 'C00009', 'এনামুল হক স্টোর', 'wholesale', '', '০১৯৮৫১৬৬৫৪৬', '', '', 'মালিপাড়া', 'এনামুল হক', 0, 1, '', 50000.00, 9660.00, NULL, 'a', 'Admin', '2020-04-12 19:36:32', NULL, NULL, 1, ''),
(10, 'C00010', 'কুদ্দুস স্টোর', 'wholesale', '', '০১৭৭০১২৫১০৫', '', '', 'বানুগঞ্জ বাজার', 'কুদ্দুস', 0, 1, '', 50000.00, 7814.00, NULL, 'a', 'Admin', '2020-04-12 19:39:00', NULL, NULL, 1, ''),
(11, 'C00011', 'কাজল স্টোর', 'wholesale', '', '০১৯০০৩৬৪৯৬২', '', '', 'কবিরপুর', 'কাজল', 0, 1, '', 50000.00, 8360.00, NULL, 'a', 'Admin', '2020-04-12 19:39:41', NULL, NULL, 1, ''),
(12, 'C00012', 'কামাল স্টোর', 'wholesale', '', '০১৭১৭০৯৬৩৩৪', '', '', 'বড়িয়া বাজার', 'কামাল হোসেন', 0, 1, '', 200000.00, 130385.00, NULL, 'a', 'Admin', '2020-04-12 19:42:42', NULL, NULL, 1, ''),
(13, 'C00013', 'কোকিল স্টোর', 'wholesale', '', '০১৭৬০৩১৩৯৪৫', '', '', 'টবাজার', 'কোকিল', 0, 1, '', 50000.00, 15930.00, NULL, 'a', 'Admin', '2020-04-12 19:43:56', NULL, NULL, 1, ''),
(14, 'C00014', 'খসরু স্টোর', 'wholesale', '', '০১৯২৬২৮০৬৩৩', '', '', 'দিগনগর', 'খসরু', 0, 1, '', 50000.00, 10050.00, NULL, 'a', 'Admin', '2020-04-12 19:44:58', NULL, NULL, 1, ''),
(15, 'C00015', 'ছোয়াদ স্টোর', 'wholesale', '', '০১৭৪২৫৬৩৭২৬', '', '', 'বানুগঞ্জ', 'ছোয়াদ', 0, 1, '', 200000.00, 125980.00, NULL, 'a', 'Admin', '2020-04-12 19:46:18', 'Admin', '2020-04-12 19:47:55', 1, ''),
(16, 'C00016', 'জামির স্টোর', 'wholesale', '', '০১৭৮৬৪৩৪৭৫৮', '', '', 'শিতেলী', 'জামির হুজুর', 0, 1, '', 100000.00, 39880.00, NULL, 'a', 'Admin', '2020-04-12 19:47:31', NULL, NULL, 1, ''),
(17, 'C00017', 'জামিরুল স্টোর', 'wholesale', '', '০১৭৮৫৮৬৭০৬৩', '', '', 'ছোট ধল্লা', 'জামিরুল', 0, 1, '', 100000.00, 46955.00, NULL, 'a', 'Admin', '2020-04-12 19:49:21', NULL, NULL, 1, ''),
(18, 'C00018', 'টিক্কা স্টোর', 'wholesale', '', '০১৯২৭৫১৫৯৯২', '', '', 'টবাজার', 'মীর অহিদ রেজা', 0, 1, '', 200000.00, 117812.00, NULL, 'a', 'Admin', '2020-04-12 19:50:45', NULL, NULL, 1, ''),
(19, 'C00019', 'তোবারেক স্টোর', 'wholesale', '', '০১৭২৪৫২০৮৫৪', '', '', 'বকশিপুর', 'তোবারেক', 0, 1, '', 50000.00, 4960.00, NULL, 'a', 'Admin', '2020-04-12 19:53:16', NULL, NULL, 1, ''),
(20, 'C00020', 'নয়ন স্টোর', 'wholesale', '', '০১৮৯৩২১৭১৫৫', '', '', 'চড়পাড়া বাজার', 'নয়ন', 0, 1, '', 50000.00, 29060.00, NULL, 'a', 'Admin', '2020-04-12 19:55:07', NULL, NULL, 1, ''),
(21, 'C00021', 'নুর ইসলাম স্টোর', 'wholesale', '', '০১৯২০০৬৩৩৪৮', '', '', 'কবিরপুর', 'নুর ইসলাম মন্ডল', 0, 1, '', 50000.00, 5345.00, NULL, 'd', 'Admin', '2020-04-12 19:56:01', NULL, NULL, 1, ''),
(22, 'C00022', 'নাজির স্টোর', 'wholesale', '', '০১৭৪৬৬৪১১৮২', '', '', 'সাধুহাটি', 'নাজির', 0, 1, '', 50000.00, 17130.00, NULL, 'a', 'Admin', '2020-04-12 19:57:27', NULL, NULL, 1, ''),
(23, 'C00023', 'পরি স্টোর', 'wholesale', '', '০১৭২৫৫৫৬২৪৯', '', '', 'খুদেরমোড়', 'পরি ', 0, 1, '', 50000.00, 20565.00, NULL, 'a', 'Admin', '2020-04-12 19:59:03', NULL, NULL, 1, ''),
(24, 'C00024', 'বিমল সাহা', 'wholesale', '', '০১৯১৫৬৫৭৭৭২', '', '', 'টবাজার', 'বিমল সাহা', 0, 1, '', 50000.00, 17085.00, NULL, 'a', 'Admin', '2020-04-12 20:01:02', NULL, NULL, 1, ''),
(25, 'C00025', 'মজিবর স্টোর', 'wholesale', '', 'NO Have 2', '', '', 'নওয়াপাড়া', 'মজিবর', 0, 1, '', 50000.00, 30085.00, NULL, 'a', 'Admin', '2020-04-12 20:02:24', NULL, NULL, 1, ''),
(26, 'C00026', 'মধু', 'wholesale', '', '০১৯৪১৯৪৭৬৭১', '', '', 'টবাজার', 'মধু', 0, 1, '', 10000.00, 7310.00, NULL, 'd', 'Admin', '2020-04-12 20:03:10', NULL, NULL, 1, ''),
(27, 'C00027', 'মাসুদ ট্রেডার্স', 'wholesale', '', '০১৭০৮৯৮১২৮৩', '', '', 'খুলুমবাড়ি বাজার', 'মাসুদ', 0, 1, '', 250000.00, 138121.00, NULL, 'a', 'Admin', '2020-04-12 20:05:13', 'Admin', '2020-04-26 11:04:03', 1, '419'),
(28, 'C00028', 'মোলাম ট্রেডার্স', 'wholesale', '', '01738757552', '', '', 'বানুগঞ্জ বাজার', 'মোলাম', 0, 1, '', 350000.00, 322450.00, NULL, 'a', 'Admin', '2020-04-12 20:06:02', 'Admin', '2020-04-26 11:03:25', 1, '53'),
(29, 'C00029', '', 'G', '', '', '', '', '', NULL, 0, 0, '', 0.00, 0.00, NULL, 'a', 'Admin', '2020-04-13 17:49:24', NULL, NULL, 1, NULL),
(30, 'C00030', 'রবিউল ট্রেডার্স', 'wholesale', '', '০১৭৫৫১৬৩১৯২', '', '', 'বানুগঞ্জ বাজার', 'রবিউল ইসলাম', 0, 1, '', 150000.00, 98335.00, NULL, 'a', 'Admin', '2020-04-13 22:06:48', 'Admin', '2020-04-26 11:03:02', 1, '431'),
(31, 'C00031', '', 'G', '', '', '', '', '', NULL, 0, 0, '', 0.00, 0.00, NULL, 'a', 'Admin', '2020-04-13 22:15:05', NULL, NULL, 1, NULL),
(32, 'C00032', '', 'G', '', '', '', '', '', NULL, 0, 0, '', 0.00, 0.00, NULL, 'a', 'Admin', '2020-04-13 22:15:48', NULL, NULL, 1, NULL),
(33, 'C00033', '', 'G', '', '', '', '', '', NULL, 0, 0, '', 0.00, 0.00, NULL, 'a', 'Admin', '2020-04-13 22:17:30', NULL, NULL, 1, NULL),
(34, 'C00034', 'General', 'retail', '', 'NO ', '', '', '', '', 0, 1, '', 0.00, 0.00, NULL, 'a', 'Admin', '2020-04-13 22:23:14', NULL, NULL, 1, ''),
(35, 'C00035', 'রশিদ স্টোর', 'wholesale', '', 'NO Have 4', '', '', 'রয়ড়া বাজার	', 'রশিদ', 0, 1, '', 50000.00, 16400.00, NULL, 'd', 'Admin', '2020-04-13 22:40:13', NULL, NULL, 1, ''),
(36, 'C00036', 'hhh', 'G', '', '', '', '', '', NULL, 0, 0, '', 0.00, 0.00, NULL, 'a', 'Admin', '2020-04-25 01:48:00', NULL, NULL, 1, NULL),
(37, 'C00037', 'MOzammel Enterprise', 'retail', '', '01911978897', '', '', 'Dhaka', 'MOzammel Hossain', 0, 1, '', 300000.00, 2000.00, NULL, 'd', 'Admin', '2020-04-25 01:51:46', NULL, NULL, 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_customer_payment`
--

CREATE TABLE `tbl_customer_payment` (
  `CPayment_id` int(11) NOT NULL,
  `CPayment_date` date DEFAULT NULL,
  `CPayment_invoice` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `CPayment_customerID` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `CPayment_TransactionType` varchar(20) DEFAULT NULL,
  `CPayment_amount` decimal(18,2) DEFAULT NULL,
  `out_amount` float NOT NULL DEFAULT 0,
  `CPayment_Paymentby` varchar(50) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `CPayment_notes` varchar(225) CHARACTER SET latin1 DEFAULT NULL,
  `CPayment_brunchid` int(11) DEFAULT NULL,
  `CPayment_previous_due` float NOT NULL DEFAULT 0,
  `CPayment_Addby` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `CPayment_AddDAte` date DEFAULT NULL,
  `CPayment_status` varchar(1) DEFAULT NULL,
  `update_by` int(11) DEFAULT NULL,
  `CPayment_UpdateDAte` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_customer_payment`
--

INSERT INTO `tbl_customer_payment` (`CPayment_id`, `CPayment_date`, `CPayment_invoice`, `CPayment_customerID`, `CPayment_TransactionType`, `CPayment_amount`, `out_amount`, `CPayment_Paymentby`, `account_id`, `CPayment_notes`, `CPayment_brunchid`, `CPayment_previous_due`, `CPayment_Addby`, `CPayment_AddDAte`, `CPayment_status`, `update_by`, `CPayment_UpdateDAte`) VALUES
(1, '2020-04-13', 'TR00001', '1', 'CR', 20000.00, 0, 'cash', NULL, '', 1, 267198, 'Admin', '2020-04-13', 'd', NULL, NULL),
(2, '2020-04-13', 'TR00002', '35', 'CR', 15000.00, 0, 'cash', NULL, 'Cash', 1, 16400, 'Admin', '2020-04-13', 'd', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_damage`
--

CREATE TABLE `tbl_damage` (
  `Damage_SlNo` int(11) NOT NULL,
  `Damage_InvoiceNo` varchar(50) NOT NULL,
  `Damage_Date` date NOT NULL,
  `Damage_Description` varchar(300) NOT NULL,
  `status` char(1) NOT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `Damage_brunchid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_damage`
--

INSERT INTO `tbl_damage` (`Damage_SlNo`, `Damage_InvoiceNo`, `Damage_Date`, `Damage_Description`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`, `Damage_brunchid`) VALUES
(1, 'D0001', '2020-04-13', 'Nil', 'd', 'Admin', '2020-04-13 17:48:48', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_damagedetails`
--

CREATE TABLE `tbl_damagedetails` (
  `DamageDetails_SlNo` int(11) NOT NULL,
  `Damage_SlNo` int(11) NOT NULL,
  `Product_SlNo` int(11) NOT NULL,
  `DamageDetails_DamageQuantity` int(11) NOT NULL,
  `damage_amount` float NOT NULL,
  `status` char(1) NOT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `branch_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `Product_Purchase_Rate` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_damagedetails`
--

INSERT INTO `tbl_damagedetails` (`DamageDetails_SlNo`, `Damage_SlNo`, `Product_SlNo`, `DamageDetails_DamageQuantity`, `damage_amount`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`, `branch_id`, `cat_id`, `Product_Purchase_Rate`) VALUES
(1, 1, 2, 10, 10000, 'd', 'Admin', '2020-04-13 17:48:48', NULL, NULL, 1, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_department`
--

CREATE TABLE `tbl_department` (
  `Department_SlNo` int(11) NOT NULL,
  `Department_Name` varchar(50) NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'a',
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_department`
--

INSERT INTO `tbl_department` (`Department_SlNo`, `Department_Name`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`) VALUES
(1, 'Office', 'a', 'Admin', '2020-04-12 22:03:02', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_designation`
--

CREATE TABLE `tbl_designation` (
  `Designation_SlNo` int(11) NOT NULL,
  `Designation_Name` varchar(50) NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'a',
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_designation`
--

INSERT INTO `tbl_designation` (`Designation_SlNo`, `Designation_Name`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`) VALUES
(1, 'Director', 'a', 'Admin', '2020-04-12 22:02:55', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_district`
--

CREATE TABLE `tbl_district` (
  `District_SlNo` int(11) NOT NULL,
  `District_Name` varchar(50) NOT NULL,
  `status` char(10) NOT NULL DEFAULT 'a',
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_district`
--

INSERT INTO `tbl_district` (`District_SlNo`, `District_Name`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`) VALUES
(1, 'Shailkupa', 'a', 'Admin', '2020-04-13 22:05:32', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_employee`
--

CREATE TABLE `tbl_employee` (
  `Employee_SlNo` int(11) NOT NULL,
  `Designation_ID` int(11) NOT NULL,
  `Department_ID` int(11) NOT NULL,
  `Employee_ID` varchar(50) NOT NULL,
  `Employee_Name` varchar(150) NOT NULL,
  `Employee_JoinDate` date NOT NULL,
  `Employee_Gender` varchar(20) NOT NULL,
  `Employee_BirthDate` date NOT NULL,
  `Employee_NID` varchar(50) NOT NULL,
  `Employee_ContactNo` varchar(20) NOT NULL,
  `Employee_Email` varchar(50) NOT NULL,
  `Employee_MaritalStatus` varchar(50) NOT NULL,
  `Employee_FatherName` varchar(150) NOT NULL,
  `Employee_MotherName` varchar(150) NOT NULL,
  `Employee_PrasentAddress` text NOT NULL,
  `Employee_PermanentAddress` text NOT NULL,
  `Employee_Pic_org` varchar(250) NOT NULL,
  `Employee_Pic_thum` varchar(250) NOT NULL,
  `salary_range` int(11) NOT NULL,
  `status` char(10) NOT NULL DEFAULT 'a',
  `AddBy` varchar(50) NOT NULL,
  `AddTime` varchar(50) NOT NULL,
  `UpdateBy` varchar(50) NOT NULL,
  `UpdateTime` varchar(50) NOT NULL,
  `Employee_brinchid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_employee`
--

INSERT INTO `tbl_employee` (`Employee_SlNo`, `Designation_ID`, `Department_ID`, `Employee_ID`, `Employee_Name`, `Employee_JoinDate`, `Employee_Gender`, `Employee_BirthDate`, `Employee_NID`, `Employee_ContactNo`, `Employee_Email`, `Employee_MaritalStatus`, `Employee_FatherName`, `Employee_MotherName`, `Employee_PrasentAddress`, `Employee_PermanentAddress`, `Employee_Pic_org`, `Employee_Pic_thum`, `salary_range`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`, `Employee_brinchid`) VALUES
(1, 1, 1, 'E1001', 'Bidhan Kumar Saha', '2020-04-12', 'Male', '1993-12-31', '', '01759011567', '', 'unmarried', 'Bimol Kumar Saha', 'Arpona Rani', 'NAGAR PARA', '', '', '', 15000, 'a', 'Admin', '2020-04-12 22:04:11', '', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_employee_payment`
--

CREATE TABLE `tbl_employee_payment` (
  `employee_payment_id` int(11) NOT NULL,
  `Employee_SlNo` int(11) NOT NULL,
  `payment_date` date DEFAULT NULL,
  `month_id` int(11) NOT NULL,
  `payment_amount` decimal(18,2) NOT NULL,
  `deduction_amount` decimal(18,2) NOT NULL,
  `status` varchar(1) DEFAULT NULL,
  `save_by` char(30) NOT NULL,
  `save_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_by` int(11) DEFAULT NULL,
  `update_date` varchar(12) NOT NULL,
  `paymentBranch_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_expense_head`
--

CREATE TABLE `tbl_expense_head` (
  `id` int(11) NOT NULL,
  `head_name` varchar(100) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `status` enum('a','d') DEFAULT 'a',
  `saved_by` int(11) DEFAULT NULL,
  `saved_datetime` datetime DEFAULT NULL,
  `update_by` int(11) DEFAULT NULL,
  `update_datetime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_last_update_software`
--

CREATE TABLE `tbl_last_update_software` (
  `last_update_soft_id` int(11) NOT NULL,
  `last_update_soft_date` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_last_update_software`
--

INSERT INTO `tbl_last_update_software` (`last_update_soft_id`, `last_update_soft_date`) VALUES
(1, '2020-04-27');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_month`
--

CREATE TABLE `tbl_month` (
  `month_id` int(11) NOT NULL,
  `month_name` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_product`
--

CREATE TABLE `tbl_product` (
  `Product_SlNo` int(11) NOT NULL,
  `Product_Code` varchar(50) NOT NULL,
  `Product_Name` varchar(150) NOT NULL,
  `ProductCategory_ID` int(11) NOT NULL,
  `color` int(11) NOT NULL,
  `brand` int(11) NOT NULL,
  `size` varchar(11) NOT NULL DEFAULT 'na',
  `vat` float NOT NULL,
  `Product_ReOrederLevel` int(11) NOT NULL,
  `Product_Purchase_Rate` decimal(18,2) NOT NULL,
  `Product_SellingPrice` decimal(18,2) NOT NULL,
  `Product_MinimumSellingPrice` decimal(18,2) NOT NULL,
  `Product_WholesaleRate` decimal(18,2) NOT NULL,
  `one_cartun_equal` varchar(20) NOT NULL,
  `is_service` varchar(10) NOT NULL DEFAULT 'false',
  `Unit_ID` int(11) NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'a',
  `AddBy` varchar(100) NOT NULL,
  `AddTime` varchar(30) NOT NULL,
  `UpdateBy` varchar(50) NOT NULL,
  `UpdateTime` varchar(30) NOT NULL,
  `Product_branchid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_product`
--

INSERT INTO `tbl_product` (`Product_SlNo`, `Product_Code`, `Product_Name`, `ProductCategory_ID`, `color`, `brand`, `size`, `vat`, `Product_ReOrederLevel`, `Product_Purchase_Rate`, `Product_SellingPrice`, `Product_MinimumSellingPrice`, `Product_WholesaleRate`, `one_cartun_equal`, `is_service`, `Unit_ID`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`, `Product_branchid`) VALUES
(1, 'P00001', 'Brand জিরাশাইল', 1, 0, 0, 'na', 0, 0, 883.00, 1000.00, 0.00, 1000.00, '', 'true', 1, 'd', 'Admin', '2020-04-12 21:55:50', 'Admin', '2020-04-12 22:14:03', 1),
(2, 'P00002', 'mac', 1, 0, 0, 'na', 0, 0, 1000.00, 1200.00, 0.00, 0.00, '', 'false', 1, 'd', 'Admin', '2020-04-13 12:40:07', '', '', 1),
(3, 'P00003', 'মিনিকেট ২৫ কেজি', 1, 0, 0, 'na', 0, 0, 1100.00, 1250.00, 0.00, 0.00, '', 'false', 1, 'd', 'Admin', '2020-04-13 19:25:14', '', '', 1),
(4, 'P00004', 'বিধান জিরাশাইল (২৫ কেজি)', 1, 0, 0, 'na', 0, 0, 910.00, 1000.00, 0.00, 0.00, '', 'false', 1, 'a', 'Admin', '2020-04-13 21:13:14', 'Admin', '2020-04-13 21:28:58', 1),
(5, 'P00005', 'বিধান কাজললতা (২৫ কেজি)	', 1, 0, 0, 'na', 0, 0, 810.00, 1025.00, 0.00, 0.00, '', 'false', 1, 'a', 'Admin', '2020-04-13 21:13:14', 'Admin', '2020-04-13 21:28:51', 1),
(6, 'P00006', 'বাছায় স্বর্ণা (১০০ লট) ৫০ কেজি ', 1, 0, 0, 'na', 0, 0, 1735.00, 1850.00, 0.00, 0.00, '', 'false', 1, 'a', 'Admin', '2020-04-13 21:13:14', 'Admin', '2020-04-13 21:28:43', 1),
(7, 'P00007', 'বাছায় স্বর্ণা (২০০ লট) ২৫ কেজি', 1, 0, 0, 'na', 0, 0, 890.00, 950.00, 0.00, 0.00, '', 'false', 1, 'a', 'Admin', '2020-04-13 21:13:14', 'Admin', '2020-04-13 21:28:35', 1),
(8, 'P00008', 'অটো সুপার গুটি স্বর্ণা (১০০ লট) ৫০ কেজি', 1, 0, 0, 'na', 0, 0, 1855.00, 1900.00, 0.00, 0.00, '', 'false', 1, 'a', 'Admin', '2020-04-13 21:13:14', 'Admin', '2020-04-13 21:26:01', 1),
(9, 'P00009', 'বাছায় ২৮ (৪১ লট) ৫০ কেজি', 1, 0, 0, 'na', 0, 0, 1595.00, 1900.00, 0.00, 0.00, '', 'false', 1, 'a', 'Admin', '2020-04-13 21:13:14', 'Admin', '2020-04-13 21:28:19', 1),
(10, 'P00010', 'আঠাশ (২০ লট)', 1, 0, 0, 'na', 0, 0, 1500.00, 2000.00, 0.00, 0.00, '', 'false', 1, 'a', 'Admin', '2020-04-22 13:26:45', '', '', 1),
(11, 'P00011', '২৮(১০লট)', 1, 0, 0, 'na', 0, 0, 1600.00, 1900.00, 0.00, 0.00, '', 'false', 1, 'a', 'Admin', '2020-04-22 13:33:26', '', '', 1),
(12, 'P00012', 'স্বর্ণা (৩০)', 1, 0, 0, 'na', 0, 0, 1200.00, 1400.00, 0.00, 0.00, '', 'false', 1, 'a', 'Admin', '2020-04-22 13:47:30', '', '', 1),
(13, 'P00013', 'লোকাল স্বর্ণা (২০)', 1, 0, 0, 'na', 0, 0, 1600.00, 0.00, 0.00, 0.00, '', 'false', 1, 'a', 'Admin', '2020-04-25 09:07:59', '', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_productcategory`
--

CREATE TABLE `tbl_productcategory` (
  `ProductCategory_SlNo` int(11) NOT NULL,
  `ProductCategory_Name` varchar(150) NOT NULL,
  `ProductCategory_Description` varchar(300) NOT NULL,
  `status` char(1) NOT NULL,
  `AddBy` varchar(50) NOT NULL,
  `AddTime` varchar(30) NOT NULL,
  `UpdateBy` varchar(50) NOT NULL,
  `UpdateTime` varchar(30) NOT NULL,
  `category_branchid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_productcategory`
--

INSERT INTO `tbl_productcategory` (`ProductCategory_SlNo`, `ProductCategory_Name`, `ProductCategory_Description`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`, `category_branchid`) VALUES
(1, 'চাউল', '', 'a', 'Admin', '2020-04-12 21:54:47', '', '', 1),
(2, 'খুদ', '', 'a', 'Admin', '2020-04-13 22:37:37', '', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_purchasedetails`
--

CREATE TABLE `tbl_purchasedetails` (
  `PurchaseDetails_SlNo` int(11) NOT NULL,
  `PurchaseMaster_IDNo` int(11) NOT NULL,
  `Product_IDNo` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `PurchaseDetails_TotalQuantity` float NOT NULL,
  `PurchaseDetails_Rate` decimal(18,2) NOT NULL,
  `purchase_cost` decimal(18,2) NOT NULL,
  `PurchaseDetails_Discount` decimal(18,2) NOT NULL,
  `PurchaseDetails_TotalAmount` decimal(18,2) NOT NULL,
  `Status` char(1) NOT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `PurchaseDetails_branchID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_purchasedetails`
--

INSERT INTO `tbl_purchasedetails` (`PurchaseDetails_SlNo`, `PurchaseMaster_IDNo`, `Product_IDNo`, `cat_id`, `PurchaseDetails_TotalQuantity`, `PurchaseDetails_Rate`, `purchase_cost`, `PurchaseDetails_Discount`, `PurchaseDetails_TotalAmount`, `Status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`, `PurchaseDetails_branchID`) VALUES
(1, 1, 1, 1, 513, 883.00, 0.00, 0.00, 452979.00, 'd', 'Admin', '2020-04-12 21:56:57', NULL, NULL, 1),
(2, 2, 1, 1, 513, 883.00, 0.00, 0.00, 452979.00, 'd', 'Admin', '2020-04-13 08:17:49', NULL, NULL, 1),
(3, 3, 1, 1, 10, 883.00, 0.00, 0.00, 8830.00, 'd', 'Admin', '2020-04-13 10:19:40', NULL, NULL, 1),
(4, 4, 2, 1, 100, 1000.00, 0.00, 0.00, 100000.00, 'd', 'Admin', '2020-04-13 12:40:27', NULL, NULL, 1),
(5, 5, 3, 1, 10, 1100.00, 0.00, 0.00, 11000.00, 'd', 'Admin', '2020-04-13 19:25:14', NULL, NULL, 1),
(24, 6, 4, 1, 513, 883.00, 0.00, 0.00, 452979.00, 'd', NULL, NULL, 'Admin', '2020-04-13 22:33:07', 1),
(25, 6, 5, 1, 78, 760.00, 0.00, 0.00, 59280.00, 'd', NULL, NULL, 'Admin', '2020-04-13 22:33:07', 1),
(26, 6, 6, 1, 43, 1735.00, 0.00, 0.00, 74605.00, 'd', NULL, NULL, 'Admin', '2020-04-13 22:33:07', 1),
(27, 6, 7, 1, 124, 890.00, 0.00, 0.00, 110360.00, 'd', NULL, NULL, 'Admin', '2020-04-13 22:33:07', 1),
(28, 6, 8, 1, 98, 1855.00, 0.00, 0.00, 181790.00, 'd', NULL, NULL, 'Admin', '2020-04-13 22:33:07', 1),
(29, 6, 9, 1, 4, 1595.00, 0.00, 0.00, 6380.00, 'd', NULL, NULL, 'Admin', '2020-04-13 22:33:07', 1),
(32, 7, 5, 1, 50, 760.00, 0.00, 0.00, 38000.00, 'd', NULL, NULL, 'Admin', '2020-04-15 19:41:14', 1),
(34, 8, 5, 1, 50, 760.00, 0.00, 0.00, 38000.00, 'd', NULL, NULL, 'Admin', '2020-04-15 19:46:14', 1),
(36, 9, 4, 1, 50, 883.00, 0.00, 0.00, 44150.00, 'd', NULL, NULL, 'Admin', '2020-04-17 21:34:08', 1),
(37, 10, 10, 1, 20, 1550.00, 0.00, 0.00, 30000.00, 'd', 'Admin', '2020-04-22 13:26:45', NULL, NULL, 1),
(38, 11, 11, 1, 10, 1650.00, 0.00, 0.00, 16000.00, 'd', 'Admin', '2020-04-22 13:33:26', NULL, NULL, 1),
(39, 12, 12, 1, 30, 1200.00, 0.00, 0.00, 36000.00, 'd', 'Admin', '2020-04-22 13:47:30', NULL, NULL, 1),
(40, 13, 12, 1, 10, 1220.00, 0.00, 0.00, 12000.00, 'd', 'Admin', '2020-04-23 17:47:45', NULL, NULL, 7),
(41, 14, 4, 1, 100, 884.82, 0.00, 0.00, 88300.00, 'd', 'Admin', '2020-04-23 17:50:26', NULL, NULL, 1),
(42, 14, 5, 1, 10, 761.82, 0.00, 0.00, 7600.00, 'd', 'Admin', '2020-04-23 17:50:26', NULL, NULL, 1),
(43, 15, 4, 1, 10, 900.00, 0.00, 0.00, 9000.00, 'd', 'Admin', '2020-04-25 01:50:02', NULL, NULL, 1),
(44, 15, 5, 1, 10, 800.00, 0.00, 0.00, 8000.00, 'd', 'Admin', '2020-04-25 01:50:02', NULL, NULL, 7),
(46, 16, 13, 1, 20, 1570.00, 0.00, 0.00, 31400.00, 'd', NULL, NULL, 'Admin', '2020-04-25 09:09:02', 1),
(47, 17, 4, 1, 10, 910.00, 0.00, 0.00, 9100.00, 'd', 'Admin', '2020-04-26 17:26:07', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_purchasemaster`
--

CREATE TABLE `tbl_purchasemaster` (
  `PurchaseMaster_SlNo` int(11) NOT NULL,
  `Supplier_SlNo` int(11) NOT NULL,
  `Employee_SlNo` int(11) NOT NULL,
  `PurchaseMaster_InvoiceNo` varchar(50) NOT NULL,
  `PurchaseMaster_OrderDate` date NOT NULL,
  `PurchaseMaster_PurchaseFor` varchar(50) NOT NULL,
  `PurchaseMaster_Description` longtext NOT NULL,
  `PurchaseMaster_TotalAmount` decimal(18,2) NOT NULL,
  `PurchaseMaster_DiscountAmount` decimal(18,2) NOT NULL,
  `PurchaseMaster_Tax` decimal(18,2) NOT NULL,
  `PurchaseMaster_Freight` decimal(18,2) NOT NULL,
  `PurchaseMaster_SubTotalAmount` decimal(18,2) NOT NULL,
  `PurchaseMaster_PaidAmount` decimal(18,2) NOT NULL,
  `PurchaseMaster_DueAmount` decimal(18,2) NOT NULL,
  `previous_due` float DEFAULT NULL,
  `status` char(1) NOT NULL DEFAULT 'a',
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `PurchaseMaster_BranchID` int(11) NOT NULL,
  `own_freight` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_purchasemaster`
--

INSERT INTO `tbl_purchasemaster` (`PurchaseMaster_SlNo`, `Supplier_SlNo`, `Employee_SlNo`, `PurchaseMaster_InvoiceNo`, `PurchaseMaster_OrderDate`, `PurchaseMaster_PurchaseFor`, `PurchaseMaster_Description`, `PurchaseMaster_TotalAmount`, `PurchaseMaster_DiscountAmount`, `PurchaseMaster_Tax`, `PurchaseMaster_Freight`, `PurchaseMaster_SubTotalAmount`, `PurchaseMaster_PaidAmount`, `PurchaseMaster_DueAmount`, `previous_due`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`, `PurchaseMaster_BranchID`, `own_freight`) VALUES
(1, 1, 0, '2020000001', '2020-04-12', '1', '', 452979.00, 0.00, 0.00, 0.00, 452979.00, 452979.00, 0.00, 0, 'd', 'Admin', '2020-04-12 21:56:57', NULL, NULL, 1, 0),
(2, 2, 0, '2020000002', '2020-04-13', '1', '', 452979.00, 0.00, 0.00, 0.00, 452979.00, 452979.00, 0.00, 0, 'd', 'Admin', '2020-04-13 08:17:49', NULL, NULL, 1, 0),
(3, 3, 0, '2020000003', '2020-04-13', '1', '', 8830.00, 0.00, 0.00, 0.00, 8830.00, 8830.00, 0.00, 0, 'd', 'Admin', '2020-04-13 10:19:40', NULL, NULL, 1, 0),
(4, 4, 0, '2020000004', '2020-04-13', '1', '', 100000.00, 0.00, 0.00, 0.00, 100000.00, 100000.00, 0.00, 0, 'd', 'Admin', '2020-04-13 12:40:27', NULL, NULL, 1, 0),
(5, 5, 0, '2020000005', '2020-04-13', '1', '', 11000.00, 0.00, 0.00, 0.00, 11000.00, 3000.00, 8000.00, 100000, 'd', 'Admin', '2020-04-13 19:25:14', NULL, NULL, 1, 500),
(6, 6, 0, '2020000006', '2020-04-12', '0', '', 885394.00, 0.00, 0.00, 0.00, 885394.00, 885394.00, 0.00, 0, 'd', 'Admin', '2020-04-13 21:13:14', 'Admin', '2020-04-13 22:33:07', 1, 0),
(7, 5, 0, '2020000007', '2020-04-15', '0', '', 38000.00, 0.00, 0.00, 0.00, 38000.00, 20000.00, 18000.00, 715530, 'd', 'Admin', '2020-04-15 19:29:49', 'Admin', '2020-04-15 19:41:14', 1, 500),
(8, 5, 0, '2020000008', '2020-04-15', '0', '', 38500.00, 0.00, 0.00, 500.00, 38000.00, 10000.00, 28500.00, 715530, 'd', 'Admin', '2020-04-15 19:44:38', 'Admin', '2020-04-15 19:46:14', 1, 0),
(9, 5, 0, '2020000009', '2020-04-17', '0', '', 44150.00, 0.00, 0.00, 0.00, 44150.00, 12000.00, 32150.00, 744030, 'd', 'Admin', '2020-04-17 20:58:41', 'Admin', '2020-04-17 21:34:08', 1, 500),
(10, 11, 0, '2020-04-22-0009', '2020-04-22', '1', '', 30000.00, 0.00, 0.00, 0.00, 30000.00, 95.00, 29905.00, 95, 'd', 'Admin', '2020-04-22 13:26:45', NULL, NULL, 1, 1000),
(11, 11, 0, '2020-04-22-00010', '2020-04-22', '1', '', 16000.00, 0.00, 0.00, 0.00, 16000.00, 10000.00, 6000.00, 30000, 'd', 'Admin', '2020-04-22 13:33:26', NULL, NULL, 1, 500),
(12, 8, 0, '2020-04-22-00011', '2020-04-22', '1', '', 36300.00, 0.00, 0.00, 300.00, 36000.00, 300.00, 36000.00, 76000, 'd', 'Admin', '2020-04-22 13:47:30', NULL, NULL, 1, 0),
(13, 12, 0, '2020-04-23-00012', '2020-04-23', '7', '', 12000.00, 0.00, 0.00, 0.00, 12000.00, 0.00, 12000.00, 0, 'd', 'Admin', '2020-04-23 17:47:45', NULL, NULL, 1, 200),
(14, 11, 0, '2020-04-23-00013', '2020-04-23', '1', '', 95900.00, 0.00, 0.00, 0.00, 95900.00, 0.00, 95900.00, 36000, 'd', 'Admin', '2020-04-23 17:50:26', NULL, NULL, 1, 200),
(15, 11, 0, '2020-04-250001', '2020-04-25', '7', '', 17000.00, 0.00, 0.00, 0.00, 17000.00, 10000.00, 7000.00, 131900, 'd', 'Admin', '2020-04-25 01:50:02', NULL, NULL, 1, 200),
(16, 11, 0, '2020-04-250001', '2020-04-25', '0', '', 32000.00, 0.00, 0.00, 600.00, 31400.00, 9400.00, 22600.00, 138900, 'd', 'Admin', '2020-04-25 09:07:59', 'Admin', '2020-04-25 09:09:02', 1, 0),
(17, 11, 0, '2020-04-260001', '2020-04-26', '1', '', 9100.00, 0.00, 0.00, 0.00, 9100.00, 0.00, 9100.00, 0, 'd', 'Admin', '2020-04-26 17:26:07', NULL, NULL, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_purchasereturn`
--

CREATE TABLE `tbl_purchasereturn` (
  `PurchaseReturn_SlNo` int(11) NOT NULL,
  `PurchaseMaster_InvoiceNo` varchar(50) NOT NULL,
  `Supplier_IDdNo` int(11) NOT NULL,
  `PurchaseReturn_ReturnDate` date NOT NULL,
  `PurchaseReturn_ReturnAmount` decimal(18,2) NOT NULL,
  `PurchaseReturn_Description` varchar(300) NOT NULL,
  `Status` char(1) NOT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `PurchaseReturn_brunchID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_purchasereturndetails`
--

CREATE TABLE `tbl_purchasereturndetails` (
  `PurchaseReturnDetails_SlNo` int(11) NOT NULL,
  `PurchaseReturn_SlNo` int(11) NOT NULL,
  `PurchaseReturnDetailsProduct_SlNo` int(11) NOT NULL,
  `PurchaseReturnDetails_ReturnQuantity` int(11) NOT NULL,
  `PurchaseReturnDetails_ReturnAmount` decimal(18,2) NOT NULL,
  `Status` char(1) NOT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `PurchaseReturnDetails_brachid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_quotaion_customer`
--

CREATE TABLE `tbl_quotaion_customer` (
  `quotation_customer_id` int(11) NOT NULL,
  `customer_name` char(50) NOT NULL,
  `contact_number` varchar(35) NOT NULL,
  `customer_address` text NOT NULL,
  `quation_customer_branchid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_quotation_details`
--

CREATE TABLE `tbl_quotation_details` (
  `SaleDetails_SlNo` int(11) NOT NULL,
  `SaleMaster_IDNo` int(11) NOT NULL,
  `Product_IDNo` int(11) NOT NULL,
  `SaleDetails_TotalQuantity` int(11) NOT NULL,
  `SaleDetails_Rate` decimal(18,2) NOT NULL,
  `SaleDetails_Discount` decimal(18,2) NOT NULL,
  `SaleDetails_Tax` decimal(18,2) NOT NULL,
  `SaleDetails_Freight` decimal(18,2) NOT NULL,
  `SaleDetails_TotalAmount` decimal(18,2) NOT NULL,
  `Status` char(1) NOT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `SaleDetails_BranchId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_quotation_master`
--

CREATE TABLE `tbl_quotation_master` (
  `SaleMaster_SlNo` int(11) NOT NULL,
  `SaleMaster_InvoiceNo` varchar(50) NOT NULL,
  `SaleMaster_customer_name` varchar(500) NOT NULL,
  `SaleMaster_customer_mobile` varchar(50) NOT NULL,
  `SaleMaster_customer_address` varchar(1000) NOT NULL,
  `SaleMaster_SaleDate` date NOT NULL,
  `SaleMaster_Description` longtext DEFAULT NULL,
  `SaleMaster_TotalSaleAmount` decimal(18,2) NOT NULL,
  `SaleMaster_TotalDiscountAmount` decimal(18,2) NOT NULL,
  `SaleMaster_TaxAmount` decimal(18,2) NOT NULL,
  `SaleMaster_Freight` decimal(18,2) NOT NULL,
  `SaleMaster_SubTotalAmount` decimal(18,2) NOT NULL,
  `Status` char(1) NOT NULL DEFAULT 'a',
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `SaleMaster_branchid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_saledetails`
--

CREATE TABLE `tbl_saledetails` (
  `SaleDetails_SlNo` int(11) NOT NULL,
  `SaleMaster_IDNo` int(11) NOT NULL,
  `Product_IDNo` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `SaleDetails_TotalQuantity` float NOT NULL,
  `Purchase_Rate` decimal(18,2) DEFAULT NULL,
  `SaleDetails_Rate` decimal(18,2) NOT NULL,
  `SaleDetails_Discount` decimal(18,2) NOT NULL,
  `Discount_amount` decimal(18,2) DEFAULT NULL,
  `SaleDetails_Tax` decimal(18,2) NOT NULL,
  `SaleDetails_TotalAmount` decimal(18,2) NOT NULL,
  `Status` char(1) NOT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `SaleDetails_BranchId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_saledetails`
--

INSERT INTO `tbl_saledetails` (`SaleDetails_SlNo`, `SaleMaster_IDNo`, `Product_IDNo`, `cat_id`, `SaleDetails_TotalQuantity`, `Purchase_Rate`, `SaleDetails_Rate`, `SaleDetails_Discount`, `Discount_amount`, `SaleDetails_Tax`, `SaleDetails_TotalAmount`, `Status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`, `SaleDetails_BranchId`) VALUES
(1, 1, 2, 1, 90, 1000.00, 1200.00, 0.00, NULL, 0.00, 108000.00, 'd', 'Admin', '2020-04-13 16:48:22', NULL, NULL, 1),
(2, 2, 2, 1, 10, 1000.00, 1200.00, 0.00, NULL, 0.00, 12000.00, 'd', 'Admin', '2020-04-13 17:49:24', NULL, NULL, 1),
(3, 3, 2, 1, 5, 1000.00, 1200.00, 0.00, NULL, 0.00, 6000.00, 'd', 'Admin', '2020-04-13 18:33:19', NULL, NULL, 1),
(8, 4, 8, 1, 2, 1855.00, 1900.00, 0.00, NULL, 0.00, 3800.00, 'd', 'Admin', '2020-04-13 21:27:09', NULL, NULL, 1),
(9, 5, 4, 1, 6, 883.00, 1010.00, 0.00, NULL, 0.00, 6060.00, 'd', 'Admin', '2020-04-13 21:31:08', NULL, NULL, 1),
(10, 5, 8, 1, 2, 1855.00, 1900.00, 0.00, NULL, 0.00, 3800.00, 'd', 'Admin', '2020-04-13 21:31:08', NULL, NULL, 1),
(11, 5, 6, 1, 2, 1735.00, 1850.00, 0.00, NULL, 0.00, 3700.00, 'd', 'Admin', '2020-04-13 21:31:08', NULL, NULL, 1),
(12, 5, 9, 1, 3, 1595.00, 1900.00, 0.00, NULL, 0.00, 5700.00, 'd', 'Admin', '2020-04-13 21:31:08', NULL, NULL, 1),
(13, 6, 4, 1, 6, 883.00, 1010.00, 0.00, NULL, 0.00, 6060.00, 'd', 'Admin', '2020-04-13 21:41:17', NULL, NULL, 1),
(14, 6, 8, 1, 2, 1855.00, 1900.00, 0.00, NULL, 0.00, 3800.00, 'd', 'Admin', '2020-04-13 21:41:17', NULL, NULL, 1),
(15, 6, 6, 1, 2, 1735.00, 1850.00, 0.00, NULL, 0.00, 3700.00, 'd', 'Admin', '2020-04-13 21:41:17', NULL, NULL, 1),
(16, 6, 9, 1, 3, 1595.00, 1900.00, 0.00, NULL, 0.00, 5700.00, 'd', 'Admin', '2020-04-13 21:41:17', NULL, NULL, 1),
(17, 7, 4, 1, 40, 883.00, 1010.00, 0.00, NULL, 0.00, 40400.00, 'd', 'Admin', '2020-04-13 21:49:03', NULL, NULL, 1),
(18, 8, 4, 1, 40, 883.00, 1010.00, 0.00, NULL, 0.00, 40400.00, 'd', 'Admin', '2020-04-13 21:51:04', NULL, NULL, 1),
(19, 9, 4, 1, 10, 883.00, 1015.00, 0.00, NULL, 0.00, 10150.00, 'd', 'Admin', '2020-04-13 22:07:52', NULL, NULL, 1),
(20, 9, 5, 1, 6, 760.00, 1025.00, 0.00, NULL, 0.00, 6150.00, 'd', 'Admin', '2020-04-13 22:07:52', NULL, NULL, 1),
(21, 9, 8, 1, 4, 1855.00, 1900.00, 0.00, NULL, 0.00, 7600.00, 'd', 'Admin', '2020-04-13 22:07:52', NULL, NULL, 1),
(22, 10, 7, 1, 6, 890.00, 950.00, 0.00, NULL, 0.00, 5700.00, 'd', 'Admin', '2020-04-13 22:09:19', NULL, NULL, 1),
(23, 10, 4, 1, 4, 883.00, 1050.00, 0.00, NULL, 0.00, 4200.00, 'd', 'Admin', '2020-04-13 22:09:19', NULL, NULL, 1),
(24, 11, 4, 1, 10, 883.00, 1025.00, 0.00, NULL, 0.00, 10250.00, 'd', 'Admin', '2020-04-13 22:10:39', NULL, NULL, 1),
(25, 11, 5, 1, 10, 760.00, 1020.00, 0.00, NULL, 0.00, 10200.00, 'd', 'Admin', '2020-04-13 22:10:39', NULL, NULL, 1),
(26, 12, 4, 1, 10, 883.00, 990.00, 0.00, NULL, 0.00, 9900.00, 'd', 'Admin', '2020-04-13 22:10:58', NULL, NULL, 1),
(27, 13, 5, 1, 10, 760.00, 1020.00, 0.00, NULL, 0.00, 10200.00, 'd', 'Admin', '2020-04-13 22:14:01', NULL, NULL, 1),
(28, 13, 4, 1, 10, 883.00, 1025.00, 0.00, NULL, 0.00, 10250.00, 'd', 'Admin', '2020-04-13 22:14:01', NULL, NULL, 1),
(29, 14, 8, 1, 1, 1855.00, 2000.00, 0.00, NULL, 0.00, 2000.00, 'd', 'Admin', '2020-04-13 22:15:05', NULL, NULL, 1),
(30, 14, 4, 1, 1, 883.00, 1050.00, 0.00, NULL, 0.00, 1050.00, 'd', 'Admin', '2020-04-13 22:15:05', NULL, NULL, 1),
(31, 15, 8, 1, 2, 1855.00, 1970.00, 0.00, NULL, 0.00, 3940.00, 'd', 'Admin', '2020-04-13 22:15:48', NULL, NULL, 1),
(32, 15, 5, 1, 3, 760.00, 1075.00, 0.00, NULL, 0.00, 3225.00, 'd', 'Admin', '2020-04-13 22:15:48', NULL, NULL, 1),
(33, 16, 6, 1, 4, 1735.00, 1850.00, 0.00, NULL, 0.00, 7400.00, 'd', 'Admin', '2020-04-13 22:16:34', NULL, NULL, 1),
(34, 16, 4, 1, 12, 883.00, 1010.00, 0.00, NULL, 0.00, 12120.00, 'd', 'Admin', '2020-04-13 22:16:34', NULL, NULL, 1),
(35, 17, 4, 1, 2, 883.00, 1150.00, 0.00, NULL, 0.00, 2300.00, 'd', 'Admin', '2020-04-13 22:17:30', NULL, NULL, 1),
(36, 17, 6, 1, 8, 1735.00, 1875.00, 0.00, NULL, 0.00, 15000.00, 'd', 'Admin', '2020-04-13 22:17:30', NULL, NULL, 1),
(37, 17, 7, 1, 20, 890.00, 925.00, 0.00, NULL, 0.00, 18500.00, 'd', 'Admin', '2020-04-13 22:17:30', NULL, NULL, 1),
(38, 18, 5, 1, 30, 760.00, 1025.00, 0.00, NULL, 0.00, 30750.00, 'd', 'Admin', '2020-04-15 19:33:35', NULL, NULL, 1),
(39, 19, 5, 1, 10, 760.00, 1025.00, 0.00, NULL, 0.00, 10250.00, 'd', 'Admin', '2020-04-15 21:06:27', NULL, NULL, 1),
(40, 20, 5, 1, 5, 760.00, 1025.00, 0.00, NULL, 0.00, 5125.00, 'd', 'Admin', '2020-04-15 21:13:15', NULL, NULL, 1),
(41, 21, 4, 1, 5, 883.00, 1000.00, 0.00, NULL, 0.00, 5000.00, 'd', 'Admin', '2020-04-17 21:08:47', NULL, NULL, 1),
(42, 22, 4, 1, 2, 883.00, 1000.00, 0.00, NULL, 0.00, 2000.00, 'd', 'Admin', '2020-04-19 19:20:30', NULL, NULL, 7),
(43, 23, 4, 1, 1, 883.00, 1000.00, 0.00, NULL, 0.00, 1000.00, 'd', 'Admin', '2020-04-22 13:19:06', NULL, NULL, 7),
(44, 23, 5, 1, 1, 760.00, 1025.00, 0.00, NULL, 0.00, 1025.00, 'd', 'Admin', '2020-04-22 13:19:06', NULL, NULL, 1),
(45, 24, 5, 1, 2, 760.00, 1025.00, 0.00, NULL, 0.00, 2050.00, 'd', 'Admin', '2020-04-22 13:37:47', NULL, NULL, 1),
(46, 25, 12, 1, 5, 1200.00, 1400.00, 0.00, NULL, 0.00, 7000.00, 'd', 'Admin', '2020-04-25 01:48:00', NULL, NULL, 7),
(47, 25, 4, 1, 2, 883.00, 1000.00, 0.00, NULL, 0.00, 2000.00, 'd', 'Admin', '2020-04-25 01:48:00', NULL, NULL, 1),
(48, 26, 5, 1, 2, 810.00, 1025.00, 0.00, NULL, 0.00, 2050.00, 'd', 'Admin', '2020-04-25 01:53:05', NULL, NULL, 7),
(49, 26, 4, 1, 20, 910.00, 1000.00, 0.00, NULL, 0.00, 20000.00, 'd', 'Admin', '2020-04-25 01:53:05', NULL, NULL, 1),
(50, 27, 12, 1, 3, 1200.00, 1400.00, 0.00, NULL, 0.00, 4200.00, 'd', 'Admin', '2020-04-25 08:37:14', NULL, NULL, 7),
(51, 27, 4, 1, 10, 910.00, 1000.00, 0.00, NULL, 0.00, 10000.00, 'd', 'Admin', '2020-04-25 08:37:14', NULL, NULL, 1),
(52, 28, 4, 1, 10, 910.00, 1000.00, 0.00, NULL, 0.00, 10000.00, 'd', 'Admin', '2020-04-25 16:40:48', NULL, NULL, 1),
(53, 29, 10, 1, 5, 1500.00, 2000.00, 0.00, NULL, 0.00, 10000.00, 'd', 'Admin', '2020-04-25 16:46:58', NULL, NULL, 8);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_salereturn`
--

CREATE TABLE `tbl_salereturn` (
  `SaleReturn_SlNo` int(11) NOT NULL,
  `SaleMaster_InvoiceNo` varchar(50) NOT NULL,
  `SaleReturn_ReturnDate` date NOT NULL,
  `SaleReturn_ReturnAmount` decimal(18,2) NOT NULL,
  `SaleReturn_Description` varchar(300) NOT NULL,
  `Status` char(1) NOT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `SaleReturn_brunchId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_salereturndetails`
--

CREATE TABLE `tbl_salereturndetails` (
  `SaleReturnDetails_SlNo` int(11) NOT NULL,
  `SaleReturn_IdNo` int(11) NOT NULL,
  `SaleReturnDetailsProduct_SlNo` int(11) NOT NULL,
  `SaleReturnDetails_ReturnQuantity` int(11) NOT NULL,
  `SaleReturnDetails_ReturnAmount` decimal(18,2) NOT NULL,
  `Status` char(1) NOT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `SaleReturnDetails_brunchID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_salesmaster`
--

CREATE TABLE `tbl_salesmaster` (
  `SaleMaster_SlNo` int(11) NOT NULL,
  `SaleMaster_InvoiceNo` varchar(50) NOT NULL,
  `SalseCustomer_IDNo` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `SaleMaster_SaleDate` date NOT NULL,
  `SaleMaster_Description` longtext DEFAULT NULL,
  `SaleMaster_SaleType` varchar(50) DEFAULT NULL,
  `payment_type` varchar(50) DEFAULT 'Cash',
  `SaleMaster_TotalSaleAmount` decimal(18,2) NOT NULL,
  `SaleMaster_TotalDiscountAmount` decimal(18,2) NOT NULL,
  `SaleMaster_TaxAmount` decimal(18,2) NOT NULL,
  `SaleMaster_Freight` decimal(18,2) DEFAULT 0.00,
  `SaleMaster_SubTotalAmount` decimal(18,2) NOT NULL,
  `SaleMaster_PaidAmount` decimal(18,2) NOT NULL,
  `SaleMaster_DueAmount` decimal(18,2) NOT NULL,
  `SaleMaster_Previous_Due` double(18,2) DEFAULT NULL,
  `Status` char(1) NOT NULL DEFAULT 'a',
  `is_service` varchar(10) NOT NULL DEFAULT 'false',
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `SaleMaster_branchid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_salesmaster`
--

INSERT INTO `tbl_salesmaster` (`SaleMaster_SlNo`, `SaleMaster_InvoiceNo`, `SalseCustomer_IDNo`, `employee_id`, `SaleMaster_SaleDate`, `SaleMaster_Description`, `SaleMaster_SaleType`, `payment_type`, `SaleMaster_TotalSaleAmount`, `SaleMaster_TotalDiscountAmount`, `SaleMaster_TaxAmount`, `SaleMaster_Freight`, `SaleMaster_SubTotalAmount`, `SaleMaster_PaidAmount`, `SaleMaster_DueAmount`, `SaleMaster_Previous_Due`, `Status`, `is_service`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`, `SaleMaster_branchid`) VALUES
(1, '2020000001', 1, NULL, '2020-04-13', '', 'wholesale', 'Cash', 108000.00, 0.00, 0.00, 0.00, 108000.00, 80000.00, 28000.00, 267198.00, 'd', 'false', 'Admin', '2020-04-13 16:48:22', NULL, NULL, 1),
(2, '2020000002', 29, NULL, '2020-04-13', '', 'retail', 'Cash', 12000.00, 0.00, 0.00, 0.00, 12000.00, 12000.00, 0.00, 0.00, 'd', 'false', 'Admin', '2020-04-13 17:49:24', NULL, NULL, 1),
(3, '2020000003', 28, NULL, '2020-04-13', '', 'wholesale', 'Cash', 6000.00, 0.00, 0.00, 0.00, 6000.00, 2000.00, 4000.00, 306840.00, 'd', 'false', 'Admin', '2020-04-13 18:33:19', NULL, NULL, 1),
(4, '2020000004', 28, NULL, '2020-04-13', '', 'wholesale', 'Cash', 19260.00, 0.00, 0.00, 0.00, 19260.00, 5000.00, 14260.00, 306840.00, 'd', 'false', 'Admin', '2020-04-13 21:24:21', 'Admin', '2020-04-13 21:27:09', 1),
(5, '2020000005', 28, NULL, '2020-04-13', '', 'wholesale', 'Cash', 19260.00, 0.00, 0.00, 0.00, 19260.00, 5000.00, 14260.00, 321100.00, 'd', 'false', 'Admin', '2020-04-13 21:31:08', NULL, NULL, 1),
(6, '2020000006', 28, NULL, '2020-04-13', '', 'wholesale', 'Cash', 19260.00, 0.00, 0.00, 0.00, 19260.00, 5000.00, 14260.00, 306840.00, 'd', 'false', 'Admin', '2020-04-13 21:41:17', NULL, NULL, 1),
(7, '2020000007', 27, NULL, '2020-04-13', '', 'wholesale', 'Cash', 40400.00, 0.00, 0.00, 0.00, 40400.00, 200000.00, -159600.00, 185280.00, 'd', 'false', 'Admin', '2020-04-13 21:49:03', NULL, NULL, 1),
(8, '2020000008', 27, NULL, '2020-04-13', '', 'wholesale', 'Cash', 40400.00, 0.00, 0.00, 0.00, 40400.00, 25000.00, 15400.00, 185280.00, 'd', 'false', 'Admin', '2020-04-13 21:51:04', NULL, NULL, 1),
(9, '2020000009', 30, NULL, '2020-04-13', '', 'wholesale', 'Cash', 23900.00, 0.00, 0.00, 0.00, 23900.00, 9500.00, 14400.00, 98335.00, 'd', 'false', 'Admin', '2020-04-13 22:07:52', NULL, NULL, 1),
(10, '2020000010', 2, NULL, '2020-04-13', '', 'wholesale', 'Cash', 9900.00, 0.00, 0.00, 0.00, 9900.00, 8000.00, 1900.00, 59920.00, 'd', 'false', 'Admin', '2020-04-13 22:09:19', NULL, NULL, 1),
(11, '2020000011', 1, NULL, '2020-04-13', '', 'wholesale', 'Cash', 20450.00, 0.00, 0.00, 0.00, 20450.00, 25000.00, -4550.00, 267198.00, 'd', 'false', 'Admin', '2020-04-13 22:10:39', NULL, NULL, 1),
(12, '2020000012', 1, NULL, '2020-04-13', '', 'wholesale', 'Cash', 9900.00, 0.00, 0.00, 0.00, 9900.00, 0.00, 9900.00, 262648.00, 'd', 'false', 'Admin', '2020-04-13 22:10:58', NULL, NULL, 1),
(13, '2020000013', 1, NULL, '2020-04-13', '', 'wholesale', 'Cash', 20450.00, 0.00, 0.00, 0.00, 20450.00, 20000.00, 450.00, 277098.00, 'd', 'false', 'Admin', '2020-04-13 22:14:01', NULL, NULL, 1),
(14, '2020000014', 31, NULL, '2020-04-13', '', 'retail', 'Cash', 3050.00, 0.00, 0.00, 0.00, 3050.00, 3050.00, 0.00, 0.00, 'd', 'false', 'Admin', '2020-04-13 22:15:05', NULL, NULL, 1),
(15, '2020000015', 32, NULL, '2020-04-13', '', 'retail', 'Cash', 7165.00, 0.00, 0.00, 0.00, 7165.00, 7165.00, 0.00, 0.00, 'd', 'false', 'Admin', '2020-04-13 22:15:48', NULL, NULL, 1),
(16, '2020000016', 27, NULL, '2020-04-13', '', 'wholesale', 'Cash', 19520.00, 0.00, 0.00, 0.00, 19520.00, 6000.00, 13520.00, 200680.00, 'd', 'false', 'Admin', '2020-04-13 22:16:34', NULL, NULL, 1),
(17, '2020000017', 33, NULL, '2020-04-13', '', 'retail', 'Cash', 35800.00, 0.00, 0.00, 0.00, 35800.00, 35800.00, 0.00, 0.00, 'd', 'false', 'Admin', '2020-04-13 22:17:30', NULL, NULL, 1),
(18, '2020000018', 1, NULL, '2020-04-15', '', 'wholesale', 'Cash', 30750.00, 0.00, 0.00, 0.00, 30750.00, 10000.00, 20750.00, 267198.00, 'd', 'false', 'Admin', '2020-04-15 19:33:35', NULL, NULL, 1),
(19, '2020000019', 1, NULL, '2020-04-15', '', 'wholesale', 'Cash', 10250.00, 0.00, 0.00, 0.00, 10250.00, 5000.00, 5250.00, 267198.00, 'd', 'false', 'Admin', '2020-04-15 21:06:27', NULL, NULL, 1),
(20, '2020000020', 35, NULL, '2020-04-15', '', 'wholesale', 'Cash', 5125.00, 0.00, 0.00, 0.00, 5125.00, 2000.00, 3125.00, 16400.00, 'd', 'false', 'Admin', '2020-04-15 21:13:15', NULL, NULL, 1),
(21, '2020000021', 1, NULL, '2020-04-17', '', 'wholesale', 'Cash', 5000.00, 0.00, 0.00, 0.00, 5000.00, 2000.00, 3000.00, 267198.00, 'd', 'false', 'Admin', '2020-04-17 21:08:47', NULL, NULL, 1),
(22, '2020000022', 34, NULL, '2020-04-19', '', 'retail', 'Cash', 2000.00, 0.00, 0.00, 0.00, 2000.00, 2000.00, 0.00, 0.00, 'd', 'false', 'Admin', '2020-04-19 19:20:30', NULL, NULL, 1),
(23, '2020-04-22-00022', 34, NULL, '2020-04-22', '', 'retail', 'Cash', 2025.00, 0.00, 0.00, 0.00, 2025.00, 2025.00, 0.00, 0.00, 'd', 'false', 'Admin', '2020-04-22 13:19:06', NULL, NULL, 1),
(24, '2020-04-22-00023', 34, NULL, '2020-04-22', '', 'retail', 'Cash', 2050.00, 0.00, 0.00, 0.00, 2050.00, 2050.00, 0.00, 0.00, 'd', 'false', 'Admin', '2020-04-22 13:37:47', NULL, NULL, 1),
(25, '2020-04-250001', 36, NULL, '2020-04-25', '', 'retail', 'Cash', 9000.00, 0.00, 0.00, 0.00, 9000.00, 0.00, 9000.00, 0.00, 'd', 'false', 'Admin', '2020-04-25 01:48:00', NULL, NULL, 1),
(26, '2020-04-250001', 37, 1, '2020-04-25', '', 'retail', 'Cash', 22050.00, 0.00, 0.00, 0.00, 22050.00, 2050.00, 20000.00, 2000.00, 'd', 'false', 'Admin', '2020-04-25 01:53:05', NULL, NULL, 1),
(27, '2020-04-250002', 2, NULL, '2020-04-25', '', 'wholesale', 'Cash', 14200.00, 0.00, 0.00, 0.00, 14200.00, 0.00, 14200.00, 59920.00, 'd', 'false', 'Admin', '2020-04-25 08:37:14', NULL, NULL, 1),
(28, '2020-04-250003', 1, NULL, '2020-04-25', '', 'wholesale', 'Cash', 10000.00, 0.00, 0.00, 0.00, 10000.00, 5000.00, 5000.00, 270198.00, 'd', 'false', 'Admin', '2020-04-25 16:40:48', NULL, NULL, 1),
(29, '2020-04-250004', 1, NULL, '2020-04-25', '', 'wholesale', 'Cash', 10000.00, 0.00, 0.00, 0.00, 10000.00, 2000.00, 8000.00, 275198.00, 'd', 'false', 'Admin', '2020-04-25 16:46:58', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_sms`
--

CREATE TABLE `tbl_sms` (
  `row_id` int(11) NOT NULL,
  `number` varchar(30) NOT NULL,
  `sms_text` varchar(500) NOT NULL,
  `sent_by` int(11) NOT NULL,
  `sent_datetime` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_sms_settings`
--

CREATE TABLE `tbl_sms_settings` (
  `sms_enabled` varchar(10) NOT NULL DEFAULT 'false',
  `api_key` varchar(500) NOT NULL,
  `url` varchar(1000) NOT NULL,
  `bulk_url` varchar(1000) NOT NULL,
  `sms_type` varchar(50) NOT NULL,
  `sender_id` varchar(200) NOT NULL,
  `sender_name` varchar(200) NOT NULL,
  `sender_phone` varchar(50) NOT NULL,
  `saved_by` int(11) DEFAULT NULL,
  `saved_datetime` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_supplier`
--

CREATE TABLE `tbl_supplier` (
  `Supplier_SlNo` int(11) NOT NULL,
  `Supplier_Code` varchar(50) NOT NULL,
  `Supplier_Name` varchar(150) NOT NULL,
  `Supplier_Type` varchar(50) NOT NULL,
  `Supplier_Phone` varchar(50) NOT NULL,
  `Supplier_Mobile` varchar(15) NOT NULL,
  `Supplier_Email` varchar(50) NOT NULL,
  `Supplier_OfficePhone` varchar(50) NOT NULL,
  `Supplier_Address` varchar(300) NOT NULL,
  `contact_person` varchar(250) DEFAULT NULL,
  `District_SlNo` int(11) NOT NULL,
  `Country_SlNo` int(11) NOT NULL,
  `Supplier_Web` varchar(150) NOT NULL,
  `previous_due` decimal(18,2) NOT NULL,
  `image_name` varchar(1000) DEFAULT NULL,
  `Status` char(1) NOT NULL DEFAULT 'a',
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `Supplier_brinchid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_supplier`
--

INSERT INTO `tbl_supplier` (`Supplier_SlNo`, `Supplier_Code`, `Supplier_Name`, `Supplier_Type`, `Supplier_Phone`, `Supplier_Mobile`, `Supplier_Email`, `Supplier_OfficePhone`, `Supplier_Address`, `contact_person`, `District_SlNo`, `Country_SlNo`, `Supplier_Web`, `previous_due`, `image_name`, `Status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`, `Supplier_brinchid`) VALUES
(1, 'S00001', '', 'G', '', '', '', '', '', NULL, 0, 0, '', 0.00, NULL, 'a', 'Admin', '2020-04-12 21:56:57', NULL, NULL, 1),
(2, 'S00002', '', 'G', '', '', '', '', '', NULL, 0, 0, '', 0.00, NULL, 'a', 'Admin', '2020-04-13 08:17:49', NULL, NULL, 1),
(3, 'S00003', '', 'G', '', '', '', '', '', NULL, 0, 0, '', 0.00, NULL, 'a', 'Admin', '2020-04-13 10:19:40', NULL, NULL, 1),
(4, 'S00004', '', 'G', '', '', '', '', '', NULL, 0, 0, '', 0.00, NULL, 'a', 'Admin', '2020-04-13 12:40:27', NULL, NULL, 1),
(5, 'S00005', 'ফোর স্টার অটো রাইচ মিল', '', '', '0158612', '', '', 'কুষ্টিয়া ', 'নজরুল ইসলাম', 0, 0, '', 0.00, NULL, 'a', 'Admin', '2020-04-13 17:55:00', 'Admin', '2020-04-25 17:28:55', 1),
(6, 'S00006', '', 'G', '', '', '', '', '', NULL, 0, 0, '', 0.00, NULL, 'a', 'Admin', '2020-04-13 21:13:14', 'Admin', '2020-04-13 22:33:07', 1),
(7, 'S00007', 'মহিদুল এন্টারপ্রাইজ', '', '', '0424524', '', '', 'খাজানগর', 'মহিদুল', 0, 0, '', 0.00, NULL, 'a', 'Admin', '2020-04-14 22:18:15', 'Admin', '2020-04-25 17:28:50', 1),
(8, 'S00008', 'বারিক রাইচ মিল', '', '', '013574255', '', '', 'হাটগোপালপুর', 'আলী মামা ', 0, 0, '', 76000.00, NULL, 'a', 'Admin', '2020-04-14 22:19:15', NULL, NULL, 1),
(9, 'S00009', 'আল-আমিন বাছায় মিল', '', '', '0141552115565', '', '', 'ডাক বাংলা ', 'আল-আমিন', 0, 0, '', 0.00, NULL, 'a', 'Admin', '2020-04-14 22:20:12', 'Admin', '2020-04-25 17:28:40', 1),
(10, 'S00010', 'ইফাদ অটো রাইচ মিল', '', '', '01414514154', '', '', 'কবুরহাট', 'ইউনুচ ব্যপারি', 0, 0, '', 0.00, NULL, 'a', 'Admin', '2020-04-14 22:21:13', 'Admin', '2020-04-25 17:28:34', 1),
(11, 'S00011', 'বেরেস্টার এন্টারপ্রাইজ', '', '', '01257455852', '', '', 'মালিপাড়া', 'বেরেস্টার', 0, 0, '', 0.00, NULL, 'a', 'Admin', '2020-04-14 22:21:45', 'Admin', '2020-04-25 17:28:27', 1),
(12, 'S00012', '', 'G', '', '', '', '', '', NULL, 0, 0, '', 0.00, NULL, 'a', 'Admin', '2020-04-23 17:47:45', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_supplier_payment`
--

CREATE TABLE `tbl_supplier_payment` (
  `SPayment_id` int(11) NOT NULL,
  `SPayment_date` date DEFAULT NULL,
  `SPayment_invoice` varchar(20) DEFAULT NULL,
  `SPayment_customerID` varchar(20) DEFAULT NULL,
  `SPayment_TransactionType` varchar(25) DEFAULT NULL,
  `SPayment_amount` decimal(18,2) DEFAULT NULL,
  `SPayment_Paymentby` varchar(20) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `SPayment_notes` varchar(225) DEFAULT NULL,
  `SPayment_brunchid` int(11) DEFAULT NULL,
  `SPayment_status` varchar(2) DEFAULT NULL,
  `SPayment_Addby` varchar(100) DEFAULT NULL,
  `SPayment_AddDAte` date DEFAULT NULL,
  `update_by` int(11) DEFAULT NULL,
  `SPayment_UpdateDAte` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_transferdetails`
--

CREATE TABLE `tbl_transferdetails` (
  `transferdetails_id` int(11) NOT NULL,
  `transfer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` float NOT NULL,
  `cat_id` int(11) NOT NULL,
  `branch_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_transfermaster`
--

CREATE TABLE `tbl_transfermaster` (
  `transfer_id` int(11) NOT NULL,
  `transfer_date` date NOT NULL,
  `transfer_by` int(11) NOT NULL,
  `transfer_from` int(11) NOT NULL,
  `transfer_to` int(11) NOT NULL,
  `note` varchar(500) DEFAULT NULL,
  `added_by` int(11) NOT NULL,
  `added_datetime` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_datetime` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_unit`
--

CREATE TABLE `tbl_unit` (
  `Unit_SlNo` int(11) NOT NULL,
  `Unit_Name` varchar(150) NOT NULL,
  `status` char(1) NOT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_unit`
--

INSERT INTO `tbl_unit` (`Unit_SlNo`, `Unit_Name`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`) VALUES
(1, 'বস্তা', 'a', 'Admin', '2020-04-12 21:54:59', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

CREATE TABLE `tbl_user` (
  `User_SlNo` int(11) NOT NULL,
  `User_ID` varchar(50) NOT NULL,
  `FullName` varchar(150) NOT NULL,
  `User_Name` varchar(150) NOT NULL,
  `UserEmail` varchar(200) NOT NULL,
  `userBrunch_id` int(11) NOT NULL,
  `User_Password` varchar(50) NOT NULL,
  `UserType` varchar(50) NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'a',
  `verifycode` int(11) NOT NULL,
  `image_name` varchar(1000) DEFAULT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `Brunch_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_user`
--

INSERT INTO `tbl_user` (`User_SlNo`, `User_ID`, `FullName`, `User_Name`, `UserEmail`, `userBrunch_id`, `User_Password`, `UserType`, `status`, `verifycode`, `image_name`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`, `Brunch_ID`) VALUES
(1, '1', 'Admin', 'Admin', '', 1, 'dc9a3069aaafde96bffb0e039505bbb7', 'm', 'a', 0, '1.png', NULL, NULL, NULL, NULL, 1),
(2, '', 'Bidhan Saha', 'Director', 'kbgroup1965@gmail.com', 1, 'c81e728d9d4c2f636f067f89cc14862c', 'm', 'a', 0, NULL, NULL, '2020-03-24 01:11:37', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user_access`
--

CREATE TABLE `tbl_user_access` (
  `access_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `access` text NOT NULL,
  `saved_by` int(11) NOT NULL,
  `saved_datetime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_user_access`
--

INSERT INTO `tbl_user_access` (`access_id`, `user_id`, `access`, `saved_by`, `saved_datetime`) VALUES
(1, 2, '[\"sales\\/product\",\"sales\\/service\",\"salesReturn\",\"customer\",\"customerPaymentPage\",\"currentStock\",\"quotation\",\"salesrecord\",\"cashTransaction\",\"bank_transactions\",\"supplierPayment\",\"cash_view\",\"account\",\"bank_accounts\",\"check\\/entry\",\"check\\/list\",\"check\\/reminder\\/list\",\"check\\/pending\\/list\",\"check\\/dis\\/list\",\"check\\/paid\\/list\",\"salesinvoice\",\"returnList\",\"customerDue\",\"customerPaymentReport\",\"customer_payment_history\",\"customerlist\",\"price_list\",\"quotation_invoice_report\",\"quotation_record\",\"TransactionReport\",\"bank_transaction_report\",\"cashStatment\",\"BalanceSheet\",\"profitLoss\",\"day_book\",\"purchase\",\"purchaseReturns\",\"purchaseRecord\",\"AssetsEntry\",\"salarypayment\",\"employee\",\"emplists\",\"designation\",\"depertment\",\"month\",\"employeesalaryreport\",\"purchaseInvoice\",\"supplierDue\",\"supplierPaymentReport\",\"supplierList\",\"returnsList\",\"reorder_list\",\"sms\",\"product\",\"productlist\",\"product_ledger\",\"damageEntry\",\"damageList\",\"product_transfer\",\"transfer_list\",\"received_list\",\"supplier\",\"brunch\",\"category\",\"unit\",\"area\",\"companyProfile\",\"user\"]', 1, '2020-04-12 16:00:30'),
(2, 1, '[\"sales\\/product\",\"sales\\/service\",\"salesReturn\",\"salesrecord\",\"currentStock\",\"quotation\",\"cashTransaction\",\"bank_transactions\",\"customerPaymentPage\",\"supplierPayment\",\"cash_view\",\"account\",\"bank_accounts\",\"check\\/entry\",\"check\\/list\",\"check\\/reminder\\/list\",\"check\\/pending\\/list\",\"check\\/dis\\/list\",\"check\\/paid\\/list\",\"salesinvoice\",\"returnList\",\"customerDue\",\"customerPaymentReport\",\"customer_payment_history\",\"customerlist\",\"price_list\",\"quotation_invoice_report\",\"quotation_record\",\"TransactionReport\",\"bank_transaction_report\",\"cashStatment\",\"BalanceSheet\",\"profitLoss\",\"day_book\",\"purchase\",\"purchaseReturns\",\"purchaseRecord\",\"AssetsEntry\",\"salarypayment\",\"employee\",\"emplists\",\"designation\",\"depertment\",\"month\",\"employeesalaryreport\",\"purchaseInvoice\",\"supplierDue\",\"supplierPaymentReport\",\"supplierList\",\"returnsList\",\"reorder_list\",\"sms\",\"product\",\"productlist\",\"product_ledger\",\"damageEntry\",\"damageList\",\"product_transfer\",\"transfer_list\",\"received_list\",\"customer\",\"supplier\",\"brunch\",\"category\",\"unit\",\"area\",\"companyProfile\",\"user\"]', 1, '2020-04-12 16:00:39');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_account`
--
ALTER TABLE `tbl_account`
  ADD PRIMARY KEY (`Acc_SlNo`);

--
-- Indexes for table `tbl_assets`
--
ALTER TABLE `tbl_assets`
  ADD PRIMARY KEY (`as_id`);

--
-- Indexes for table `tbl_bank_accounts`
--
ALTER TABLE `tbl_bank_accounts`
  ADD PRIMARY KEY (`account_id`);

--
-- Indexes for table `tbl_bank_transactions`
--
ALTER TABLE `tbl_bank_transactions`
  ADD PRIMARY KEY (`transaction_id`);

--
-- Indexes for table `tbl_brand`
--
ALTER TABLE `tbl_brand`
  ADD PRIMARY KEY (`brand_SiNo`);

--
-- Indexes for table `tbl_brunch`
--
ALTER TABLE `tbl_brunch`
  ADD PRIMARY KEY (`brunch_id`);

--
-- Indexes for table `tbl_cashregister`
--
ALTER TABLE `tbl_cashregister`
  ADD PRIMARY KEY (`Transaction_ID`);

--
-- Indexes for table `tbl_cashtransaction`
--
ALTER TABLE `tbl_cashtransaction`
  ADD PRIMARY KEY (`Tr_SlNo`);

--
-- Indexes for table `tbl_checks`
--
ALTER TABLE `tbl_checks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `id_2` (`id`);

--
-- Indexes for table `tbl_color`
--
ALTER TABLE `tbl_color`
  ADD PRIMARY KEY (`color_SiNo`);

--
-- Indexes for table `tbl_company`
--
ALTER TABLE `tbl_company`
  ADD PRIMARY KEY (`Company_SlNo`);

--
-- Indexes for table `tbl_country`
--
ALTER TABLE `tbl_country`
  ADD PRIMARY KEY (`Country_SlNo`);

--
-- Indexes for table `tbl_currentinventory`
--
ALTER TABLE `tbl_currentinventory`
  ADD PRIMARY KEY (`inventory_id`);

--
-- Indexes for table `tbl_customer`
--
ALTER TABLE `tbl_customer`
  ADD PRIMARY KEY (`Customer_SlNo`);

--
-- Indexes for table `tbl_customer_payment`
--
ALTER TABLE `tbl_customer_payment`
  ADD PRIMARY KEY (`CPayment_id`);

--
-- Indexes for table `tbl_damage`
--
ALTER TABLE `tbl_damage`
  ADD PRIMARY KEY (`Damage_SlNo`);

--
-- Indexes for table `tbl_damagedetails`
--
ALTER TABLE `tbl_damagedetails`
  ADD PRIMARY KEY (`DamageDetails_SlNo`);

--
-- Indexes for table `tbl_department`
--
ALTER TABLE `tbl_department`
  ADD PRIMARY KEY (`Department_SlNo`);

--
-- Indexes for table `tbl_designation`
--
ALTER TABLE `tbl_designation`
  ADD PRIMARY KEY (`Designation_SlNo`);

--
-- Indexes for table `tbl_district`
--
ALTER TABLE `tbl_district`
  ADD PRIMARY KEY (`District_SlNo`);

--
-- Indexes for table `tbl_employee`
--
ALTER TABLE `tbl_employee`
  ADD PRIMARY KEY (`Employee_SlNo`);

--
-- Indexes for table `tbl_employee_payment`
--
ALTER TABLE `tbl_employee_payment`
  ADD PRIMARY KEY (`employee_payment_id`);

--
-- Indexes for table `tbl_expense_head`
--
ALTER TABLE `tbl_expense_head`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_last_update_software`
--
ALTER TABLE `tbl_last_update_software`
  ADD PRIMARY KEY (`last_update_soft_id`);

--
-- Indexes for table `tbl_month`
--
ALTER TABLE `tbl_month`
  ADD PRIMARY KEY (`month_id`);

--
-- Indexes for table `tbl_product`
--
ALTER TABLE `tbl_product`
  ADD PRIMARY KEY (`Product_SlNo`),
  ADD UNIQUE KEY `Product_Code` (`Product_Code`);

--
-- Indexes for table `tbl_productcategory`
--
ALTER TABLE `tbl_productcategory`
  ADD PRIMARY KEY (`ProductCategory_SlNo`);

--
-- Indexes for table `tbl_purchasedetails`
--
ALTER TABLE `tbl_purchasedetails`
  ADD PRIMARY KEY (`PurchaseDetails_SlNo`);

--
-- Indexes for table `tbl_purchasemaster`
--
ALTER TABLE `tbl_purchasemaster`
  ADD PRIMARY KEY (`PurchaseMaster_SlNo`);

--
-- Indexes for table `tbl_purchasereturn`
--
ALTER TABLE `tbl_purchasereturn`
  ADD PRIMARY KEY (`PurchaseReturn_SlNo`);

--
-- Indexes for table `tbl_purchasereturndetails`
--
ALTER TABLE `tbl_purchasereturndetails`
  ADD PRIMARY KEY (`PurchaseReturnDetails_SlNo`);

--
-- Indexes for table `tbl_quotaion_customer`
--
ALTER TABLE `tbl_quotaion_customer`
  ADD PRIMARY KEY (`quotation_customer_id`);

--
-- Indexes for table `tbl_quotation_details`
--
ALTER TABLE `tbl_quotation_details`
  ADD PRIMARY KEY (`SaleDetails_SlNo`);

--
-- Indexes for table `tbl_quotation_master`
--
ALTER TABLE `tbl_quotation_master`
  ADD PRIMARY KEY (`SaleMaster_SlNo`);

--
-- Indexes for table `tbl_saledetails`
--
ALTER TABLE `tbl_saledetails`
  ADD PRIMARY KEY (`SaleDetails_SlNo`);

--
-- Indexes for table `tbl_salereturn`
--
ALTER TABLE `tbl_salereturn`
  ADD PRIMARY KEY (`SaleReturn_SlNo`);

--
-- Indexes for table `tbl_salereturndetails`
--
ALTER TABLE `tbl_salereturndetails`
  ADD PRIMARY KEY (`SaleReturnDetails_SlNo`);

--
-- Indexes for table `tbl_salesmaster`
--
ALTER TABLE `tbl_salesmaster`
  ADD PRIMARY KEY (`SaleMaster_SlNo`);

--
-- Indexes for table `tbl_sms`
--
ALTER TABLE `tbl_sms`
  ADD PRIMARY KEY (`row_id`);

--
-- Indexes for table `tbl_supplier`
--
ALTER TABLE `tbl_supplier`
  ADD PRIMARY KEY (`Supplier_SlNo`);

--
-- Indexes for table `tbl_supplier_payment`
--
ALTER TABLE `tbl_supplier_payment`
  ADD PRIMARY KEY (`SPayment_id`);

--
-- Indexes for table `tbl_transferdetails`
--
ALTER TABLE `tbl_transferdetails`
  ADD PRIMARY KEY (`transferdetails_id`);

--
-- Indexes for table `tbl_transfermaster`
--
ALTER TABLE `tbl_transfermaster`
  ADD PRIMARY KEY (`transfer_id`);

--
-- Indexes for table `tbl_unit`
--
ALTER TABLE `tbl_unit`
  ADD PRIMARY KEY (`Unit_SlNo`);

--
-- Indexes for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`User_SlNo`);

--
-- Indexes for table `tbl_user_access`
--
ALTER TABLE `tbl_user_access`
  ADD PRIMARY KEY (`access_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_account`
--
ALTER TABLE `tbl_account`
  MODIFY `Acc_SlNo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_assets`
--
ALTER TABLE `tbl_assets`
  MODIFY `as_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_bank_accounts`
--
ALTER TABLE `tbl_bank_accounts`
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tbl_bank_transactions`
--
ALTER TABLE `tbl_bank_transactions`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_brand`
--
ALTER TABLE `tbl_brand`
  MODIFY `brand_SiNo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_brunch`
--
ALTER TABLE `tbl_brunch`
  MODIFY `brunch_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tbl_cashregister`
--
ALTER TABLE `tbl_cashregister`
  MODIFY `Transaction_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_cashtransaction`
--
ALTER TABLE `tbl_cashtransaction`
  MODIFY `Tr_SlNo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_checks`
--
ALTER TABLE `tbl_checks`
  MODIFY `id` int(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_color`
--
ALTER TABLE `tbl_color`
  MODIFY `color_SiNo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_company`
--
ALTER TABLE `tbl_company`
  MODIFY `Company_SlNo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_country`
--
ALTER TABLE `tbl_country`
  MODIFY `Country_SlNo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_currentinventory`
--
ALTER TABLE `tbl_currentinventory`
  MODIFY `inventory_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `tbl_customer`
--
ALTER TABLE `tbl_customer`
  MODIFY `Customer_SlNo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `tbl_customer_payment`
--
ALTER TABLE `tbl_customer_payment`
  MODIFY `CPayment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_damage`
--
ALTER TABLE `tbl_damage`
  MODIFY `Damage_SlNo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_damagedetails`
--
ALTER TABLE `tbl_damagedetails`
  MODIFY `DamageDetails_SlNo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_department`
--
ALTER TABLE `tbl_department`
  MODIFY `Department_SlNo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_designation`
--
ALTER TABLE `tbl_designation`
  MODIFY `Designation_SlNo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_district`
--
ALTER TABLE `tbl_district`
  MODIFY `District_SlNo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_employee`
--
ALTER TABLE `tbl_employee`
  MODIFY `Employee_SlNo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_employee_payment`
--
ALTER TABLE `tbl_employee_payment`
  MODIFY `employee_payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_expense_head`
--
ALTER TABLE `tbl_expense_head`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_last_update_software`
--
ALTER TABLE `tbl_last_update_software`
  MODIFY `last_update_soft_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_month`
--
ALTER TABLE `tbl_month`
  MODIFY `month_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_product`
--
ALTER TABLE `tbl_product`
  MODIFY `Product_SlNo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `tbl_productcategory`
--
ALTER TABLE `tbl_productcategory`
  MODIFY `ProductCategory_SlNo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_purchasedetails`
--
ALTER TABLE `tbl_purchasedetails`
  MODIFY `PurchaseDetails_SlNo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `tbl_purchasemaster`
--
ALTER TABLE `tbl_purchasemaster`
  MODIFY `PurchaseMaster_SlNo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `tbl_purchasereturn`
--
ALTER TABLE `tbl_purchasereturn`
  MODIFY `PurchaseReturn_SlNo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_purchasereturndetails`
--
ALTER TABLE `tbl_purchasereturndetails`
  MODIFY `PurchaseReturnDetails_SlNo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_quotaion_customer`
--
ALTER TABLE `tbl_quotaion_customer`
  MODIFY `quotation_customer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_quotation_details`
--
ALTER TABLE `tbl_quotation_details`
  MODIFY `SaleDetails_SlNo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_quotation_master`
--
ALTER TABLE `tbl_quotation_master`
  MODIFY `SaleMaster_SlNo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_saledetails`
--
ALTER TABLE `tbl_saledetails`
  MODIFY `SaleDetails_SlNo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `tbl_salereturn`
--
ALTER TABLE `tbl_salereturn`
  MODIFY `SaleReturn_SlNo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_salereturndetails`
--
ALTER TABLE `tbl_salereturndetails`
  MODIFY `SaleReturnDetails_SlNo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_salesmaster`
--
ALTER TABLE `tbl_salesmaster`
  MODIFY `SaleMaster_SlNo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `tbl_sms`
--
ALTER TABLE `tbl_sms`
  MODIFY `row_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_supplier`
--
ALTER TABLE `tbl_supplier`
  MODIFY `Supplier_SlNo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `tbl_supplier_payment`
--
ALTER TABLE `tbl_supplier_payment`
  MODIFY `SPayment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_transferdetails`
--
ALTER TABLE `tbl_transferdetails`
  MODIFY `transferdetails_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `tbl_transfermaster`
--
ALTER TABLE `tbl_transfermaster`
  MODIFY `transfer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tbl_unit`
--
ALTER TABLE `tbl_unit`
  MODIFY `Unit_SlNo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `User_SlNo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_user_access`
--
ALTER TABLE `tbl_user_access`
  MODIFY `access_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
