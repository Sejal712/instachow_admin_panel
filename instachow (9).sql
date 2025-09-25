-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 11, 2025 at 02:39 PM
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
-- Database: `instachow`
--

-- --------------------------------------------------------

--
-- Table structure for table `addons`
--

CREATE TABLE `addons` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `selection_type` enum('single','multiple') NOT NULL,
  `min_select` int(11) DEFAULT 0,
  `max_select` int(11) DEFAULT 0,
  `is_required` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `addons`
--

INSERT INTO `addons` (`id`, `product_id`, `name`, `selection_type`, `min_select`, `max_select`, `is_required`) VALUES
(1, 7, 'toopings', 'multiple', 0, 3, 0),
(2, 26, 'fe', 'multiple', 2, 3, 0),
(3, 27, 'dwc', 'multiple', 3, 4, 0),
(4, 28, 'sdv', 'multiple', 2, 4, 0),
(5, 29, 'dD', 'multiple', 2, 9, 0),
(6, 30, 'hjjh', 'multiple', 7, 9, 1),
(7, 31, 'sd', 'multiple', 3, 34, 1),
(8, 32, 'm', 'multiple', 7, 9, 0),
(9, 34, 'vdf', 'multiple', 4, 5, 0),
(12, 49, '', 'single', 0, 1, 0),
(13, 53, '', 'multiple', 0, 0, 0),
(15, 69, 'size', 'single', 0, 1, 1),
(16, 69, '', 'single', 0, 1, 0),
(17, 73, 'size', 'single', 0, 1, 1),
(18, 74, 'sad', 'multiple', 324, 13244444, 1),
(19, 75, 'fvs', 'multiple', 0, 1, 1),
(20, 83, 'ds', 'single', 0, 1, 1),
(21, 85, 'qd', 'multiple', 0, 1, 1),
(22, 86, 'jaahvrition', 'multiple', 0, 1, 1),
(23, 87, 'dddd', 'single', 0, 1, 1),
(25, 90, 'd', 'multiple', 34, 5, 1),
(26, 91, 'tooopings', 'multiple', 2, 4, 1),
(28, 89, 'knlsc', 'single', 0, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `addon_options`
--

CREATE TABLE `addon_options` (
  `id` int(11) NOT NULL,
  `addon_id` int(11) NOT NULL,
  `option_name` varchar(255) NOT NULL,
  `price` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `addon_options`
--

INSERT INTO `addon_options` (`id`, `addon_id`, `option_name`, `price`) VALUES
(1, 1, 'cheese', 10.00),
(2, 1, 'olivs', 10.00),
(3, 2, 'da', 5.00),
(4, 3, 'sd', 3.00),
(5, 5, 'HJJ', 45.00),
(6, 6, 'uy', 8.00),
(7, 12, '', 0.00),
(9, 15, 'bk,', 5.00),
(10, 17, 'qwdw', 23.00),
(11, 19, 'sdc', 2.00),
(12, 20, 'dsf', 3.00),
(13, 21, 'as', 3.00),
(14, 22, 'jashoption', 0.00),
(15, 23, 'd1', 3.00),
(16, 23, 'd2', 3.00),
(19, 25, 'edc', 3.00),
(20, 26, 'cheese', 12.00),
(22, 28, 'cki', 2.00),
(23, 28, 'fv', 3.00);

-- --------------------------------------------------------

--
-- Table structure for table `admin_logs`
--

CREATE TABLE `admin_logs` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `action` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_logs`
--

INSERT INTO `admin_logs` (`id`, `admin_id`, `action`, `created_at`) VALUES
(1, 18, 'Added new grocery coupon: HHH (Code: GROCERY628395)', '2025-09-02 10:50:47'),
(2, 22, 'Updated grocery coupon: HHH (ID: 2)', '2025-09-02 10:51:04'),
(4, 18, 'Added new grocery coupon: dfed (Code: GROCERY507985)', '2025-09-02 10:52:24'),
(5, 22, 'Updated grocery coupon: ssss (ID: 3)', '2025-09-02 10:52:54'),
(7, 18, 'Added new grocery coupon: ED (Code: GROCERY869318)', '2025-09-02 10:58:12'),
(9, 18, 'Added new grocery coupon: sd (Code: GROCERY81413)', '2025-09-02 11:05:04'),
(11, 18, 'Added new grocery coupon: gcch (Code: GROCERY04545)', '2025-09-02 11:07:03'),
(12, 22, 'Updated grocery coupon: gcch (ID: 6)', '2025-09-02 11:07:51'),
(14, 18, 'Added new grocery coupon: dd (Code: GROCERY53778)', '2025-09-02 11:15:50'),
(15, 18, 'Added new grocery coupon: FGGV (Code: GROCERY15696) - Min Purchase: 2', '2025-09-02 11:22:31'),
(18, 18, 'Added new grocery coupon: bb (Code: GROCERY85773) - Min Purchase: 22', '2025-09-02 11:25:13'),
(19, 22, 'Updated grocery coupon: bb (ID: 9)', '2025-09-02 11:25:27'),
(20, 22, 'Updated grocery coupon: bb (ID: 9)', '2025-09-02 11:26:25');

-- --------------------------------------------------------

--
-- Table structure for table `allergen_master`
--

CREATE TABLE `allergen_master` (
  `allergen_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `allergen_master`
--

INSERT INTO `allergen_master` (`allergen_id`, `name`, `created_at`) VALUES
(1, 'a', '2025-08-22 19:22:36'),
(2, 'b', '2025-08-22 19:22:38'),
(3, 'c', '2025-08-22 19:22:41');

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `cart_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`cart_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2025-08-20 10:32:08', '2025-08-20 10:32:08'),
(13, 19, '2025-08-27 11:41:50', '2025-08-27 11:41:50'),
(18, 20, '2025-08-27 23:17:02', '2025-08-27 23:17:02'),
(19, 13, '2025-08-28 18:07:31', '2025-08-28 18:07:31');

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `cart_item_id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `price` decimal(10,2) NOT NULL,
  `addons` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`addons`)),
  `total_price` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart_items`
--

INSERT INTO `cart_items` (`cart_item_id`, `cart_id`, `product_id`, `quantity`, `price`, `addons`, `total_price`) VALUES
(46, 1, 38, 1, 78.00, NULL, 78.00),
(47, 1, 30, 1, 41.00, '[{\"addon_id\":6,\"option_id\":6,\"option_name\":\"uy\",\"price\":8.0}]', 41.00),
(60, 13, 58, 1, 435.00, NULL, 435.00),
(78, 13, 57, 1, 435.00, NULL, 435.00),
(87, 19, 76, 1, 45.00, NULL, 45.00),
(88, 19, 45, 1, 23.00, NULL, 23.00),
(91, 19, 73, 1, 324.00, NULL, 324.00),
(93, 18, 72, 1, 21.00, NULL, 21.00);

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `coupon_id` int(11) NOT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `store_type` enum('food','grocery') DEFAULT 'food',
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `code` varchar(50) NOT NULL,
  `coupon_type` enum('default','percentage','amount') DEFAULT 'default',
  `discount_type` enum('amount','percentage') DEFAULT 'amount',
  `discount_value` decimal(10,2) NOT NULL,
  `max_discount` decimal(10,2) DEFAULT 0.00,
  `min_trip_amount` decimal(10,2) DEFAULT 0.00,
  `limit_per_user` int(11) DEFAULT 0,
  `usage_count` int(11) DEFAULT 0,
  `max_usage` int(11) DEFAULT 0,
  `start_date` date NOT NULL,
  `expire_date` date NOT NULL,
  `status` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupon_usages`
--

CREATE TABLE `coupon_usages` (
  `id` int(11) NOT NULL,
  `coupon_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `used_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `delivery_partners`
--

CREATE TABLE `delivery_partners` (
  `deliveryguy_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `vehicle_number` varchar(50) DEFAULT NULL,
  `vehicle_type` varchar(50) DEFAULT NULL,
  `current_latitude` double DEFAULT NULL,
  `current_longitude` double DEFAULT NULL,
  `is_busy` tinyint(1) DEFAULT 0,
  `total_earnings` decimal(10,2) DEFAULT 0.00,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `earnings`
--

CREATE TABLE `earnings` (
  `id` int(11) NOT NULL,
  `delivery_partner_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `food_products`
--

CREATE TABLE `food_products` (
  `product_id` int(11) NOT NULL,
  `is_halal` enum('yes','no') DEFAULT NULL,
  `food_type` enum('veg','non_veg','both') DEFAULT NULL,
  `addons` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `food_products`
--

INSERT INTO `food_products` (`product_id`, `is_halal`, `food_type`, `addons`) VALUES
(6, 'yes', 'veg', '[{\"name\":\"hello\",\"price\":12.0}]'),
(7, 'yes', 'non_veg', NULL),
(25, 'no', 'non_veg', NULL),
(26, 'no', 'non_veg', NULL),
(27, 'no', 'non_veg', NULL),
(28, 'no', 'non_veg', NULL),
(29, 'yes', 'non_veg', NULL),
(30, 'no', 'non_veg', NULL),
(31, 'no', 'non_veg', NULL),
(45, 'no', 'non_veg', NULL),
(53, 'no', 'non_veg', NULL),
(54, 'no', 'veg', NULL),
(55, 'yes', 'veg', NULL),
(56, 'no', 'both', NULL),
(57, 'no', 'non_veg', NULL),
(58, 'no', 'non_veg', NULL),
(59, 'no', 'non_veg', NULL),
(60, 'yes', 'veg', NULL),
(63, 'no', 'both', NULL),
(64, '', '', NULL),
(70, 'no', 'veg', NULL),
(71, '', '', NULL),
(76, 'no', 'non_veg', NULL),
(82, 'no', 'non_veg', NULL),
(89, 'no', 'non_veg', NULL),
(90, 'no', 'both', NULL),
(91, 'no', 'non_veg', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `grocery_products`
--

CREATE TABLE `grocery_products` (
  `product_id` int(11) NOT NULL,
  `is_halal` enum('yes','no') DEFAULT 'no',
  `is_organic` enum('yes','no') DEFAULT 'no',
  `unit` varchar(10) NOT NULL,
  `is_indian_product` enum('yes','no') NOT NULL DEFAULT 'no'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `grocery_products`
--

INSERT INTO `grocery_products` (`product_id`, `is_halal`, `is_organic`, `unit`, `is_indian_product`) VALUES
(49, 'yes', 'yes', 'kg', 'no'),
(51, 'yes', 'yes', 'kg', 'no'),
(52, 'yes', 'yes', 'kg', 'no'),
(61, 'yes', 'yes', 'kg', 'no'),
(62, 'yes', 'yes', 'kg', 'no'),
(65, 'yes', 'yes', 'kg', 'no'),
(66, 'yes', 'no', 'kg', 'no'),
(68, 'yes', 'yes', '', 'yes'),
(69, 'yes', 'yes', '', 'yes'),
(72, 'yes', 'no', 'g', 'yes'),
(73, 'yes', 'yes', 'g', 'yes'),
(74, 'yes', 'yes', 'kg', 'yes'),
(75, 'no', 'yes', 'g', 'no'),
(78, 'yes', 'yes', 'kg', 'yes'),
(83, 'yes', 'yes', 'kg', 'yes'),
(84, 'yes', 'yes', 'kg', 'yes'),
(85, 'yes', 'yes', 'kg', 'yes'),
(86, 'yes', 'yes', 'kg', 'yes'),
(87, 'yes', 'yes', 'kg', 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `master_categories`
--

CREATE TABLE `master_categories` (
  `maste_cat_food_id` int(11) UNSIGNED NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `icon_url` text DEFAULT NULL,
  `module` varchar(50) DEFAULT 'Food',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `master_categories`
--

INSERT INTO `master_categories` (`maste_cat_food_id`, `name`, `icon_url`, `module`, `created_at`) VALUES
(1, 'food', 'master_cat_food_img/burger.png', 'Food', '2025-07-07 20:46:58'),
(5, 'kh', 'master_cat_food_img/cat_688e5d4f51d879.30313834.png', 'Food', '2025-08-03 00:17:43'),
(6, 'kgk', 'master_cat_food_img/cat_688e6087a21052.89857791.png', 'Food', '2025-08-03 00:31:27'),
(7, 'bkm', 'master_cat_food_img/cat_688e60943d6b39.29392914.png', 'Food', '2025-08-03 00:31:40'),
(8, 'kde', 'master_cat_food_img/cat_688e626a050b46.76443487.png', 'Grocery', '2025-08-03 00:39:30'),
(9, 'wrr', 'master_cat_food_img/cat_688eca6b8a21b9.53790222.png', 'Grocery', '2025-08-03 08:03:15'),
(10, 'fwef', 'master_cat_food_img/cat_688eca797f9e58.00032958.png', 'Food', '2025-08-03 08:03:29'),
(11, 'pizza', '', 'Grocery', '2025-08-03 09:12:14'),
(12, 'food pizaa', 'master_cat_food_img/cat_688edaa7b29971.03645779.png', 'Food', '2025-08-03 09:12:31'),
(13, '22', 'master_cat_food_img/cat_688edd1c244428.30987054.png', 'Food', '2025-08-03 09:23:00'),
(14, '22222', 'master_cat_food_img/cat_688edd2a8a5191.80869516.png', 'Grocery', '2025-08-03 09:23:14'),
(15, 'drinks', 'master_cat_food_img/cat_688ef0545fcaa9.60405912.png', 'Food', '2025-08-03 10:45:00');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nutrition_master`
--

CREATE TABLE `nutrition_master` (
  `nutrition_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nutrition_master`
--

INSERT INTO `nutrition_master` (`nutrition_id`, `name`, `created_at`) VALUES
(1, 'fat', '2025-08-03 12:31:56');

-- --------------------------------------------------------

--
-- Table structure for table `offers`
--

CREATE TABLE `offers` (
  `offer_id` int(11) NOT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `image_url` text DEFAULT NULL,
  `discount_percentage` int(11) DEFAULT NULL CHECK (`discount_percentage` between 1 and 100),
  `is_approved` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `offer_type` enum('food','grocery') DEFAULT 'food'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `offers`
--

INSERT INTO `offers` (`offer_id`, `vendor_id`, `product_id`, `image_url`, `discount_percentage`, `is_approved`, `created_at`, `offer_type`) VALUES
(1, 1, 1, 'offer_banner/offer1.webp', 20, 1, '2025-07-07 20:50:08', 'food'),
(2, 1, 1, 'offer_banner/offer1.webp', 30, 1, '2025-07-08 05:59:46', 'food'),
(3, 1, 1, 'offer_banner/offer1.webp', 30, 1, '2025-07-09 08:26:34', 'grocery'),
(4, NULL, NULL, NULL, 20, 1, '2025-07-09 08:26:34', 'grocery');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `delivery_partner_id` int(11) DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `status` enum('pending','accepted','assigned','picked','delivered','cancelled') DEFAULT 'pending',
  `payment_method` enum('cash','online','payfast') DEFAULT NULL,
  `payment_status` enum('pending','completed','failed') DEFAULT 'pending',
  `payment_reference` varchar(255) DEFAULT NULL,
  `payment_gateway` enum('cash','payfast','other') DEFAULT 'cash',
  `payment_date` datetime DEFAULT NULL,
  `currency` varchar(10) DEFAULT 'ZAR',
  `gateway_transaction_id` varchar(255) DEFAULT NULL,
  `delivery_address` text DEFAULT NULL,
  `delivery_latitude` double DEFAULT NULL,
  `delivery_longitude` double DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `coupon_id` int(11) DEFAULT NULL,
  `discount_amount` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `customer_id`, `vendor_id`, `delivery_partner_id`, `total_amount`, `status`, `payment_method`, `payment_status`, `payment_reference`, `payment_gateway`, `payment_date`, `currency`, `gateway_transaction_id`, `delivery_address`, `delivery_latitude`, `delivery_longitude`, `created_at`, `updated_at`, `coupon_id`, `discount_amount`) VALUES
(1, 19, 1, NULL, 9.00, 'pending', '', 'pending', NULL, 'cash', NULL, 'ZAR', NULL, 'f, t, i, j - 123456', 28.6139, 77.209, '2025-08-25 22:19:40', '2025-08-25 22:19:40', NULL, 0.00),
(2, 19, 1, NULL, 43.00, 'pending', '', 'pending', NULL, 'cash', NULL, 'ZAR', NULL, 'j, h, t, t - 123445', 28.6139, 77.209, '2025-08-25 22:26:02', '2025-08-25 22:26:02', NULL, 0.00),
(3, 19, 1, NULL, 23.76, 'pending', '', 'pending', NULL, 'cash', NULL, 'ZAR', NULL, 'SDFF, RG, G, TRG - 748596', 28.6139, 77.209, '2025-08-26 16:32:34', '2025-08-26 16:32:34', NULL, 0.00),
(4, 19, 11, NULL, 31.36, 'pending', '', 'pending', NULL, 'cash', NULL, 'ZAR', NULL, 'tgrrgr, g, dg, dg - 123123', 28.6139, 77.209, '2025-08-26 17:30:21', '2025-08-26 17:30:21', NULL, 0.00),
(5, 19, 1, NULL, 401.00, 'pending', '', 'pending', NULL, 'cash', NULL, 'ZAR', NULL, 'ug, yugu, yg, uh - 748596', 28.6139, 77.209, '2025-08-26 19:32:10', '2025-08-26 19:32:10', NULL, 0.00),
(6, 19, 1, NULL, 401.00, 'pending', '', 'pending', NULL, 'cash', NULL, 'ZAR', NULL, 'ed, , cd, dc - 123123', 28.6139, 77.209, '2025-08-26 19:33:32', '2025-08-26 19:33:32', NULL, 0.00),
(7, 19, 1, NULL, 401.00, 'pending', '', 'pending', NULL, 'cash', NULL, 'ZAR', NULL, 'FE, FSD, FS, GDG - 132122', 28.6139, 77.209, '2025-08-27 11:41:28', '2025-08-27 11:41:28', NULL, 0.00),
(8, 20, 1, NULL, 802.00, 'pending', '', 'pending', NULL, 'cash', NULL, 'ZAR', NULL, 'JR29+HFX, , Anand, Gujarat - 388421', 22.6016889, 72.8175354, '2025-08-27 14:11:39', '2025-08-27 14:11:39', NULL, 0.00),
(9, 20, 11, NULL, 44.16, 'pending', '', 'pending', NULL, 'cash', NULL, 'ZAR', NULL, 'JR29+HFX, , Anand, Gujarat - 388421', 22.6016887, 72.8175565, '2025-08-27 15:24:36', '2025-08-27 15:24:36', NULL, 0.00),
(10, 20, 1, NULL, 401.00, 'pending', '', 'pending', NULL, 'cash', NULL, 'ZAR', NULL, 'JR29+HFX, , Anand, Gujarat - 388421', 22.6016892, 72.8175546, '2025-08-27 15:50:32', '2025-08-27 15:50:32', NULL, 0.00),
(22, 19, 1, NULL, 50.00, 'pending', 'payfast', 'completed', 'TEST_PAYFAST_1756292880', 'payfast', '2025-08-27 13:08:00', 'ZAR', 'TEST_PAYFAST_1756292880', 'Test PayFast Order - Test Customer', NULL, NULL, '2025-08-27 16:38:00', '2025-08-27 16:38:00', NULL, 0.00),
(23, 19, 1, NULL, 50.00, 'pending', 'payfast', 'completed', 'TEST_PAYFAST_1756293140', 'payfast', '2025-08-27 13:12:20', 'ZAR', 'TEST_PAYFAST_1756293140', 'Test PayFast Order - Test Customer', NULL, NULL, '2025-08-27 16:42:20', '2025-08-27 16:42:20', NULL, 0.00),
(25, 14, 1, NULL, 150.00, 'pending', 'payfast', 'completed', 'PAYFAST_1756295407', 'payfast', '2025-08-27 13:50:07', 'ZAR', 'PAYFAST_1756295407', 'PayFast Order - dhvanii', NULL, NULL, '2025-08-27 17:20:07', '2025-08-27 17:20:07', NULL, 0.00),
(26, 14, 1, NULL, 150.00, 'pending', 'payfast', 'completed', 'PAYFAST_1756295442', 'payfast', '2025-08-27 13:50:42', 'ZAR', 'PAYFAST_1756295442', 'PayFast Order - dhvanii', NULL, NULL, '2025-08-27 17:20:42', '2025-08-27 17:20:42', NULL, 0.00),
(27, 1, 1, NULL, 0.00, 'pending', 'payfast', 'pending', NULL, 'cash', NULL, 'ZAR', NULL, 'PayFast Online Payment', 0, 0, '2025-08-27 22:37:54', '2025-08-27 22:37:54', NULL, 0.00),
(28, 20, 1, NULL, 330.00, 'pending', 'payfast', 'completed', 'PAYFAST_1756315989344', 'payfast', '2025-08-27 23:03:09', 'ZAR', 'PAYFAST_1756315989344', 'PayFast Order - fg', NULL, NULL, '2025-08-27 23:03:10', '2025-08-27 23:03:10', NULL, 0.00),
(29, 20, 1, NULL, 330.00, 'pending', '', 'pending', NULL, 'cash', NULL, 'ZAR', NULL, 'JR29+HFX, , Anand, Gujarat - 388421', 22.6016943, 72.8175136, '2025-08-27 23:05:31', '2025-08-27 23:05:31', NULL, 0.00),
(30, 20, 1, NULL, 172.00, 'pending', 'payfast', 'completed', 'PAYFAST_1756317829341', 'payfast', '2025-08-27 23:33:49', 'ZAR', 'PAYFAST_1756317829341', 'PayFast Order - fg', NULL, NULL, '2025-08-27 23:33:49', '2025-08-27 23:33:49', NULL, 0.00),
(31, 20, 11, NULL, 94.08, 'pending', 'payfast', 'completed', 'PAYFAST_1756319174942', 'payfast', '2025-08-27 23:56:14', 'ZAR', 'PAYFAST_1756319174942', 'PayFast Order - fg', NULL, NULL, '2025-08-27 23:56:14', '2025-08-27 23:56:14', NULL, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_items_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_items_id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
(1, 1, 25, 1, 9.00),
(2, 2, 76, 1, 43.00),
(3, 3, 31, 2, 11.88),
(4, 4, 68, 1, 31.36),
(5, 5, 58, 1, 401.00),
(6, 6, 58, 1, 401.00),
(7, 7, 57, 1, 401.00),
(8, 8, 57, 2, 401.00),
(9, 9, 84, 3, 14.72),
(10, 10, 57, 1, 401.00),
(11, 10, 54, 1, 0.00),
(23, 22, 25, 1, 50.00),
(24, 23, 25, 1, 50.00),
(26, 25, 1, 2, 75.00),
(27, 26, 1, 2, 75.00),
(28, 28, 1, 3, 110.00),
(29, 29, 1, 3, 110.00),
(30, 30, 76, 4, 43.00),
(31, 31, 68, 3, 31.36);

-- --------------------------------------------------------

--
-- Table structure for table `payfast_payments`
--

CREATE TABLE `payfast_payments` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `m_payment_id` varchar(255) NOT NULL,
  `pf_payment_id` varchar(255) DEFAULT NULL,
  `payment_status` enum('pending','complete','cancelled','failed') DEFAULT 'pending',
  `amount_gross` decimal(10,2) DEFAULT NULL,
  `customer_email` varchar(255) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `item_name` varchar(255) DEFAULT NULL,
  `custom_str1` varchar(255) DEFAULT NULL,
  `payment_date` datetime DEFAULT current_timestamp(),
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payfast_payments`
--

INSERT INTO `payfast_payments` (`id`, `order_id`, `m_payment_id`, `pf_payment_id`, `payment_status`, `amount_gross`, `customer_email`, `customer_name`, `item_name`, `custom_str1`, `payment_date`, `created_at`, `updated_at`) VALUES
(1, NULL, '', '', '', 0.00, '', NULL, '', '', '2025-08-27 16:20:17', '2025-08-27 16:20:17', '2025-08-30 22:42:59'),
(2, 22, 'TEST_PAYFAST_1756292880', NULL, 'complete', 50.00, 'dhvanikotak006@gmail.com', 'Test Customer', 'Test Product', '22', '2025-08-27 13:08:00', '2025-08-27 16:38:00', '2025-08-27 16:38:00'),
(3, 23, 'TEST_PAYFAST_1756293140', NULL, 'complete', 50.00, 'dhvanikotak006@gmail.com', 'Test Customer', 'Test Product', '23', '2025-08-27 13:12:20', '2025-08-27 16:42:20', '2025-08-27 16:42:20'),
(4, 25, 'PAYFAST_1756295407', NULL, 'complete', 150.00, 'dhvani@gmail.com', 'dhvanii', 'Test Product', '25', '2025-08-27 13:50:07', '2025-08-27 17:20:07', '2025-08-27 17:20:07'),
(5, 26, 'PAYFAST_1756295442', NULL, 'complete', 150.00, 'dhvani@gmail.com', 'dhvanii', 'Test Product', '26', '2025-08-27 13:50:42', '2025-08-27 17:20:42', '2025-08-27 17:20:42'),
(6, NULL, 'FALLBACK_1756312142', 'PAYFAST_FALLBACK_1756312142', 'complete', 43.00, 'customer@example.com', NULL, NULL, 'FALLBACK_1756312142', '2025-08-27 21:59:02', '2025-08-27 21:59:02', '2025-08-27 21:59:02'),
(7, 27, 'FALLBACK_1756314474', 'PAYFAST_FALLBACK_1756314474', 'complete', 0.00, 'customer@example.com', NULL, NULL, 'FALLBACK_1756314474', '2025-08-27 22:37:54', '2025-08-27 22:37:54', '2025-08-27 22:37:54'),
(8, 28, 'PAYFAST_1756315989344', NULL, 'complete', 330.00, 'fg@gmail.com', 'fg', 'veg chiz burger', '28', '2025-08-27 23:03:09', '2025-08-27 23:03:10', '2025-08-27 23:03:10'),
(9, 30, 'PAYFAST_1756317829341', NULL, 'complete', 172.00, 'fg@gmail.com', 'fg', 'junk', '30', '2025-08-27 23:33:49', '2025-08-27 23:33:49', '2025-08-27 23:33:49'),
(10, 31, 'PAYFAST_1756319174942', NULL, 'complete', 94.08, 'fg@gmail.com', 'fg', 'fffffff', '31', '2025-08-27 23:56:14', '2025-08-27 23:56:14', '2025-08-27 23:56:14');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `category_id` int(11) UNSIGNED DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `discount_type` enum('percentage','fixed') DEFAULT NULL,
  `discount_amount` decimal(10,2) DEFAULT NULL,
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`images`)),
  `stock` int(11) DEFAULT NULL,
  `is_available` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `sub_category_id` int(11) DEFAULT NULL,
  `is_recommended` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `vendor_id`, `category_id`, `name`, `description`, `price`, `discount_type`, `discount_amount`, `images`, `stock`, `is_available`, `created_at`, `updated_at`, `sub_category_id`, `is_recommended`) VALUES
(1, 1, 1, 'veg chiz burger', 'xxxxxxxxxxx', 110.00, NULL, NULL, '[]', 17, 1, '2025-07-07 20:48:48', '2025-08-27 23:05:31', NULL, 0),
(2, 1, 15, 'qc', 'cdqa', 3.00, 'percentage', 3.00, '[]', 32, 1, '2025-08-04 20:07:43', '2025-08-04 22:16:33', NULL, 0),
(3, 1, 15, 'csae', 'cs', 32.00, 'percentage', 65.00, '[\"C:\\Users\\dhkot\\OneDrive\\Pictures\\temp\\OIP.jpeg\",\"C:\\Users\\dhkot\\OneDrive\\Pictures\\temp\\rakshabandhan.jpg\"]', 32, 1, '2025-08-04 22:25:00', '2025-08-04 22:25:00', NULL, 0),
(4, 1, 15, 'dxa', 'cas', 32.00, 'percentage', 32.00, '[\"C:\\Users\\dhkot\\OneDrive\\Pictures\\temp\\OIP.webp\"]', 32, 1, '2025-08-04 23:15:30', '2025-08-04 23:15:30', NULL, 0),
(5, 1, 15, 'dhvani', 'ds', 32.00, 'percentage', 0.00, '[\"C:\\Users\\dhkot\\OneDrive\\Pictures\\temp\\happy-diwali-wishes.jpg\"]', 32, 1, '2025-08-05 15:34:57', '2025-08-05 15:34:57', NULL, 0),
(6, 1, 15, 'hello', 'hello', 12.00, 'percentage', 12.00, '[\"C:\\Users\\dhkot\\OneDrive\\Pictures\\temp\\OIP.webp\"]', 12, 1, '2025-08-06 22:33:22', '2025-08-06 22:33:22', NULL, 0),
(7, 1, 15, 'pizza', 'pizza is good for health', 12.00, 'percentage', 121.00, '[\"C:\\Users\\dhkot\\OneDrive\\Pictures\\temp\\rakshabandhan.jpg\"]', 12, 1, '2025-08-06 23:26:20', '2025-08-06 23:26:20', NULL, 0),
(24, 11, 8, 'grain', 'ca', 2.00, 'percentage', 3.00, '[]', 3, 1, '2025-08-07 23:10:55', '2025-08-07 23:10:55', 18, 0),
(25, 1, 15, 'burguere', 'csa', 32.00, 'fixed', 23.00, '[\"C:\\Users\\dhkot\\OneDrive\\Pictures\\temp\\OIP.jpeg\"]', 22, 1, '2025-08-07 23:11:52', '2025-08-25 22:19:40', 17, 0),
(26, 1, 6, 'grde', 'vfd', 4.00, 'percentage', 3.00, '[\"C:\\Users\\dhkot\\OneDrive\\Pictures\\temp\\OIP.jpeg\"]', 3, 1, '2025-08-07 23:58:26', '2025-08-07 23:58:26', 2, 0),
(27, 1, 7, 'grainnnnnn', 'qd', 25.00, '', 0.00, '[\"C:\\Users\\dhkot\\OneDrive\\Pictures\\temp\\OIP.webp\"]', 52, 1, '2025-08-08 00:10:40', '2025-08-08 00:10:40', 4, 0),
(28, 1, 15, 'dhvaniiiiiiiiiiii', 'qdqc', 3.00, 'fixed', 2.00, '[\"C:\\Users\\dhkot\\OneDrive\\Pictures\\temp\\OIP.webp\"]', 33, 1, '2025-08-14 06:10:21', '2025-08-14 06:10:21', 17, 0),
(29, 1, 15, 'sejallllllll', 'dc', 32.00, 'percentage', 3.00, '[\"C:\\Users\\dhkot\\OneDrive\\Pictures\\temp\\OIP.webp\"]', 3, 1, '2025-08-14 06:11:44', '2025-08-14 06:11:44', 17, 0),
(30, 1, 15, 'heloooo', 'fkl', 33.00, 'percentage', 3.00, '[\"C:\\Users\\dhkot\\OneDrive\\Pictures\\temp\\OIP.webp\"]', 3, 1, '2025-08-14 16:49:39', '2025-08-14 16:49:39', 17, 0),
(31, 1, 15, 'yoyo', 'qjdna', 12.00, 'percentage', 1.00, '[\"C:\\Users\\dhkot\\OneDrive\\Pictures\\temp\\OIP.jpeg\"]', 121, 1, '2025-08-18 05:34:46', '2025-08-26 16:32:34', 17, 0),
(32, 11, 8, 'grainnnnnn', 'dvs', 2344.00, 'percentage', 34.00, '[\"..\\/grocery_products\\/grocery_1755505334_0.jpg\"]', 3, 1, '2025-08-18 13:52:14', '2025-08-18 13:52:14', 18, 0),
(34, 11, 8, 'dddddddddddddd', 'f', 3.00, 'percentage', 4.00, '[\"..\\/uploads\\/grocery_products\\/grocery_1755514372_0.jpg\"]', 4, 1, '2025-08-18 16:22:52', '2025-08-18 16:22:52', 18, 0),
(45, 1, 12, 'kotakkkkkkkkkkkkkkkk', 'dc', 23.00, 'fixed', 23.00, '[\"C:\\Users\\dhkot\\OneDrive\\Pictures\\temp\\360_F_428530650_IGTg0ih8fe6NKEwn15aXxORRQAN0GrJP.jpg\"]', 234, 1, '2025-08-19 17:10:55', '2025-08-19 17:10:55', 13, 0),
(49, 11, 11, 'helooooooooooooooo', 'dcbgfh', 231.00, 'percentage', 34.00, '[\"..\\/grocery_products\\/grocery_1755752349_0.jpg\"]', 34, 1, '2025-08-21 10:29:09', '2025-08-21 10:29:09', 14, 0),
(51, 11, 8, 'sejal', 'wcf', 3.00, '', 333333.00, '[\"..\\/grocery_products\\/grocery_1755753285_0.jpg\"]', 3, 1, '2025-08-21 10:44:45', '2025-08-21 10:54:03', 18, 0),
(52, 11, 8, 'charusat', 'fdsg', 32.00, 'fixed', 34.00, '[\"..\\/grocery_products\\/grocery_1755754008_0.jpg\"]', 43, 1, '2025-08-21 10:56:48', '2025-08-21 10:56:48', 18, 0),
(53, 1, 6, 'burgerrrrrrrrr', 'ewf', 435.00, 'fixed', 43.00, '[\"C:\\Users\\dhkot\\OneDrive\\Pictures\\temp\\OIP.webp\"]', 3245, 1, '2025-08-21 10:59:32', '2025-08-21 10:59:32', 2, 0),
(54, 1, 12, 'sadcvf', 'dsvfg', 3.00, 'fixed', 32.00, '[\"C:\\Users\\dhkot\\OneDrive\\Pictures\\temp\\rakshabandhan.jpg\"]', 31, 1, '2025-08-21 11:03:52', '2025-08-27 15:50:32', 12, 0),
(55, 1, 15, 'Aaaa', 'ewfvt', 32.00, 'fixed', 32.00, '[\"food_products\\/rakshabandhan.jpg\"]', 23, 1, '2025-08-21 11:06:29', '2025-08-21 11:06:29', 17, 0),
(56, 1, 15, 'ewdcfvgb', 'fcc', 21.00, 'fixed', 21.00, '[\"happy-diwali-wishes.jpg\"]', 12, 1, '2025-08-21 11:10:18', '2025-08-21 11:10:18', 17, 0),
(57, 1, 12, 'dssv', 'svd', 435.00, 'fixed', 34.00, '[]', 3448, 1, '2025-08-21 17:14:39', '2025-08-27 15:50:32', 13, 0),
(58, 1, 12, 'dssv', 'svd', 435.00, 'fixed', 34.00, '[]', 3450, 1, '2025-08-21 17:14:45', '2025-08-26 19:33:32', 13, 0),
(59, 1, 12, 'dssv', 'svd', 435.00, 'fixed', 34.00, '[\"1755776743_rakshabandhan.jpg\",\"1755776743_happy-diwali-wishes.jpg\"]', 3452, 1, '2025-08-21 17:15:43', '2025-08-21 17:15:43', 13, 0),
(60, 1, 15, 'yashvi gor', 'ef', 32.00, 'fixed', 32.00, '[\"1755776852_Du1vGD_UwAAR7NH.jpg\",\"1755776852_8642bbef02f1ef0c4c7a7dd9a89d8636.jpg\"]', 32, 1, '2025-08-21 17:17:32', '2025-08-21 17:17:32', 17, 0),
(61, 11, 8, 'devanshiii', 'dvvz', 2572.00, 'percentage', 22.00, '[\"..\\/grocery_products\\/grocery_1755778051_0.jpg\",\"..\\/grocery_products\\/grocery_1755778051_1.jpg\"]', 43, 1, '2025-08-21 17:37:31', '2025-08-21 17:37:31', 18, 0),
(62, 11, 11, 'arpita', 'dfv', 42.00, 'fixed', 43.00, '[\"..\\/grocery_products\\/grocery_1755779120_0.jpg\"]', 5, 1, '2025-08-21 17:55:20', '2025-08-21 17:55:20', 14, 0),
(63, 1, 15, 'hellooooooooo', 'ds', 6726.00, 'fixed', 43.00, '[\"1755780923_Screenshot_2025-05-02_154241.png\",\"1755780923_Screenshot_2025-05-02_160328.png\"]', 32, 1, '2025-08-21 18:25:23', '2025-08-21 18:25:23', 17, 0),
(64, 1, 15, 'dhvaniiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii', 'dcbkbnda,', 15.00, 'fixed', 5.00, '[\"1755781006_Screenshot_2025-05-02_160328.png\"]', 3, 1, '2025-08-21 18:26:46', '2025-08-21 18:26:46', 17, 0),
(65, 11, 11, 'shrutiiiiiiiiiiiiiiiiiiiiiiiiiii', 'kkkkkkkkkkkkkk', 2356.00, '', 0.00, '[]', 77, 1, '2025-08-21 18:30:36', '2025-08-21 18:30:36', 15, 0),
(66, 11, 11, 'godhani', 'khbhbh', 51656.00, 'percentage', 7.00, '[\"..\\/grocery_products\\/grocery_1755781301_0.jpg\"]', 5, 0, '2025-08-21 18:31:41', '2025-08-22 05:48:20', 14, 0),
(68, 11, 11, 'fffffff', 'qd', 32.00, 'percentage', 2.00, '[\"..\\/grocery_products\\/grocery_1755824209_0.jpg\"]', 31, 1, '2025-08-22 06:26:49', '2025-08-26 17:30:21', 14, 0),
(69, 11, 11, 'ggggggggggggg', 'daq', 3.00, 'percentage', 5.00, '[\"..\\/grocery_products\\/grocery_1755824539_0.jpg\"]', 3, 1, '2025-08-22 06:32:19', '2025-08-22 06:32:19', 14, 0),
(70, 1, 15, 'kotakkkk', 'as', 42.00, 'fixed', 32.00, '[\"1755824658_Screenshot_2025-05-07_120919.png\"]', 342, 1, '2025-08-22 06:34:18', '2025-08-22 06:34:18', 17, 0),
(71, 1, 12, 'kookoko', 'dcs', 3.00, '', 0.00, '[\"1755825122_admin_panel.jpg\"]', 32, 1, '2025-08-22 06:42:02', '2025-08-22 06:42:02', 12, 0),
(72, 11, 8, 'tanvi', 'acs', 21.00, 'percentage', 3.00, '[]', 21, 1, '2025-08-22 18:08:30', '2025-08-22 18:08:30', 18, 0),
(73, 11, 8, 'chasma', 'chashma description', 324.00, 'percentage', 123.00, '[\"..\\/grocery_products\\/grocery_1755866429_0.jpg\",\"..\\/grocery_products\\/grocery_1755866429_1.jpg\"]', 123, 1, '2025-08-22 18:10:29', '2025-08-22 18:10:29', 18, 0),
(74, 11, 11, 'laptop', 'laptop desctio', 123123.00, 'percentage', 123.00, '[\"..\\/grocery_products\\/grocery_1755868317_0.jpg\"]', 123, 1, '2025-08-22 18:41:57', '2025-08-22 18:41:57', 14, 0),
(75, 11, 8, 'info', 'asc', 21.00, 'percentage', 23.00, '[\"..\\/grocery_products\\/grocery_1755897602_0.jpg\"]', 32, 0, '2025-08-23 02:50:02', '2025-08-23 04:24:03', 18, 0),
(76, 1, 12, 'junk', 'da', 45.00, 'fixed', 2.00, '[\"1755899461_Screenshot_2025-05-04_001228.png\"]', 65, 1, '2025-08-23 03:21:01', '2025-08-25 22:26:02', 12, 0),
(78, 16, 11, 'hmm', 'dce', 3.00, '', 0.00, '[\"..\\/grocery_products\\/grocery_1755900297_0.jpg\"]', 3, 1, '2025-08-23 03:34:57', '2025-08-23 03:34:57', 15, 0),
(82, 16, 15, 'njii', 'njk', 21.00, 'percentage', 6.00, '[\"1755902111_Screenshot_2025-05-04_001228.png\"]', 5, 0, '2025-08-23 04:05:11', '2025-08-23 16:57:31', 17, 1),
(83, 11, 11, 'uuuuuuu', 'cd', 32.00, 'percentage', 3.00, '[\"..\\/grocery_products\\/grocery_1755903510_0.jpg\",\"..\\/grocery_products\\/grocery_1755903510_1.jpg\"]', 3, 1, '2025-08-23 04:28:30', '2025-08-23 04:28:30', 14, 0),
(84, 11, 8, 'ewjkfnjdrb', 'dsa', 32.00, 'percentage', 54.00, '[\"..\\/grocery_products\\/grocery_1755906535_0.jpg\"]', 0, 1, '2025-08-23 05:18:55', '2025-08-27 15:24:36', 11, 0),
(85, 11, 11, 'basic', 'v', 4.00, 'percentage', 43.00, '[\"..\\/grocery_products\\/grocery_1755906818_0.jpg\",\"..\\/grocery_products\\/grocery_1755906818_1.jpg\"]', 4, 0, '2025-08-23 05:23:38', '2025-08-24 12:12:07', 14, 1),
(86, 11, 11, 'jash', 'ew', 321.00, 'percentage', 2.00, '[\"..\\/grocery_products\\/grocery_1755907820_0.jpg\",\"..\\/grocery_products\\/grocery_1755907820_1.jpg\"]', 2, 1, '2025-08-23 05:40:20', '2025-08-26 17:23:26', 15, 0),
(87, 11, 11, 'dhruvi', 'dkjm', 10.00, 'percentage', 43.00, '[\"..\\/grocery_products\\/grocery_1755935209_0.jpg\"]', 32, 0, '2025-08-23 13:16:49', '2025-08-24 12:12:20', 14, 1),
(89, 10, 15, 'palak prajapati', 'nkdwshbwj', 13.00, '', 12.00, '[\"1755950578_Screenshot_2025-05-23_151403.png\"]', 132, 1, '2025-08-23 17:32:58', '2025-08-24 09:41:28', 17, 0),
(90, 10, 15, 'hhkhkh', 'fs', 3.00, 'fixed', 32.00, '[\"1755956962_Screenshot_2025-05-18_162219.png\"]', 32, 1, '2025-08-23 19:19:22', '2025-08-23 19:19:22', 17, 0),
(91, 10, 15, 'noodles', 'das', 123.00, 'fixed', 123.00, '[\"1755959690_Screenshot_2025-05-23_164934.png\"]', 123, 1, '2025-08-23 20:04:50', '2025-08-23 20:04:50', 17, 0);

-- --------------------------------------------------------

--
-- Table structure for table `product_allergens`
--

CREATE TABLE `product_allergens` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `allergen_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_allergens`
--

INSERT INTO `product_allergens` (`id`, `product_id`, `allergen_id`) VALUES
(1, 75, 2),
(2, 76, 1),
(3, 83, 1),
(4, 85, 1),
(5, 86, 3),
(6, 87, 1),
(7, 87, 2),
(10, 90, 2),
(11, 91, 1),
(13, 89, 2);

-- --------------------------------------------------------

--
-- Table structure for table `product_nutritions`
--

CREATE TABLE `product_nutritions` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `nutrition_id` int(11) NOT NULL,
  `value` varchar(50) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_nutritions`
--

INSERT INTO `product_nutritions` (`id`, `product_id`, `nutrition_id`, `value`, `created_at`) VALUES
(1, 2, 1, '3', '2025-08-04 20:07:44'),
(2, 3, 1, '423', '2025-08-04 22:25:00'),
(3, 4, 1, '3', '2025-08-04 23:15:30'),
(4, 6, 1, '12', '2025-08-06 22:33:22'),
(5, 25, 1, 'ew', '2025-08-07 23:11:52'),
(6, 28, 1, '22', '2025-08-14 06:10:21'),
(7, 29, 1, '1', '2025-08-14 06:11:44'),
(8, 31, 1, '23', '2025-08-18 05:34:46'),
(11, 45, 1, '43', '2025-08-19 17:10:55'),
(15, 51, 1, '32', '2025-08-21 10:44:45'),
(16, 53, 1, '4', '2025-08-21 10:59:32'),
(17, 54, 1, '7', '2025-08-21 11:03:52'),
(18, 55, 1, '23', '2025-08-21 11:06:29'),
(19, 56, 1, '21', '2025-08-21 11:10:18'),
(20, 56, 1, '5', '2025-08-21 11:10:18'),
(21, 57, 1, '5', '2025-08-21 17:14:39'),
(22, 58, 1, '5', '2025-08-21 17:14:45'),
(23, 59, 1, '5', '2025-08-21 17:15:43'),
(24, 60, 1, '5', '2025-08-21 17:17:32'),
(25, 61, 1, '302', '2025-08-21 17:37:31'),
(26, 62, 1, '65', '2025-08-21 17:55:20'),
(27, 64, 1, '3', '2025-08-21 18:26:46'),
(28, 75, 1, '2', '2025-08-23 02:50:02'),
(29, 76, 1, '13', '2025-08-23 03:21:01'),
(30, 82, 1, '3', '2025-08-23 04:05:11'),
(31, 83, 1, '3', '2025-08-23 04:28:30'),
(32, 85, 1, '324', '2025-08-23 05:23:38'),
(33, 85, 1, '54', '2025-08-23 05:23:38'),
(34, 86, 1, '2', '2025-08-23 05:40:20'),
(35, 87, 1, '32', '2025-08-23 13:16:49'),
(38, 90, 1, '3', '2025-08-23 19:19:22'),
(39, 91, 1, '123', '2025-08-23 20:04:50'),
(41, 89, 1, '54', '2025-08-24 09:41:28');

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `review` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sub_categories`
--

CREATE TABLE `sub_categories` (
  `categories_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `master_cat_food_id` int(11) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sub_categories`
--

INSERT INTO `sub_categories` (`categories_id`, `name`, `description`, `created_at`, `master_cat_food_id`) VALUES
(1, 'burgereeeefff', 'get offeeee', '2025-07-07 20:48:19', 5),
(2, 'ddd', 'csgeg', '2025-08-03 08:18:29', 6),
(4, 'www', 'www', '2025-08-03 08:19:39', 7),
(10, 'eeeewwww', 'eeeewwwwwwwwwwe2e', '2025-08-03 09:05:28', 1),
(11, 'ed3r', 'wee', '2025-08-03 09:06:24', 8),
(12, 'qweqqq', 'qqqqqq', '2025-08-03 09:12:54', 12),
(13, 'qqq', 'aaa', '2025-08-03 09:13:49', 12),
(14, '222', '222', '2025-08-03 09:17:20', 11),
(15, 'qq', 'qqqq', '2025-08-03 09:22:09', 11),
(16, 'qwe22', 'qqq22', '2025-08-03 09:22:36', 6),
(17, 'soft drink', 'cock', '2025-08-03 11:06:52', 15),
(18, 'dhvani', 'svd', '2025-08-07 21:57:25', 8);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `dob` date DEFAULT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `address` text DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `role` enum('customer','vendor','admin','delivery_partner') NOT NULL,
  `profile_image` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `longitude` decimal(11,8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `email`, `phone`, `password`, `dob`, `gender`, `address`, `latitude`, `role`, `profile_image`, `created_at`, `updated_at`, `longitude`) VALUES
(1, 'sejal', 'sejallathigara1008@gmail.com', '9925183935', '', '2015-07-01', 'female', 'jetpur', NULL, 'vendor', 'vendor_images/brand2.png', '2025-07-07 17:25:56', '2025-07-07 18:25:56', NULL),
(2, 'sejal', 'sejal123@gmail.com', '123', '', '2007-08-09', 'female', NULL, NULL, 'vendor', NULL, '2025-08-04 17:17:33', '2025-08-04 17:17:33', NULL),
(3, 'senahl', 'snehal123@gmail.com', '31', '', '2007-08-09', 'female', NULL, NULL, 'vendor', NULL, '2025-08-04 23:14:35', '2025-08-04 23:14:35', NULL),
(4, 'nihir', 'nihir123@gmail.com', '165165', '$2y$10$ac/kbCMf.7cUKxlmlLlCa.ftUZMNiUabTU/67yysbkNb85PsFbn96', '2007-08-10', 'male', NULL, NULL, 'vendor', NULL, '2025-08-05 16:32:22', '2025-08-05 16:32:22', NULL),
(5, 'nidhi', 'nidhi123@gmail.com', '3e', '$2y$10$FCmUKXn6F2M5BGBx9ntUAOdCeoDfwjFYyIKlCeVoscW5sqEYwnnNe', '2007-08-10', 'female', NULL, NULL, 'vendor', NULL, '2025-08-05 17:08:08', '2025-08-05 17:08:08', NULL),
(6, 'nidhi', 'nidhi1234@gmail.com', '324', '$2y$10$l1/R/ctJKGCjuS45b9K2RuASPEnEjErEohCvhdTkgHMrvv/isIJQa', '2007-08-10', 'female', NULL, 22.60171267, 'vendor', NULL, '2025-08-05 17:27:17', '2025-08-05 17:27:17', 72.81760908),
(7, 'nidhi', 'nidhi12345@gmail.com', '213', '$2y$10$jEx4h7JqOaQSCnZj3K9ZqOI30sFZ2gS3hx2RKJ.7IfIQBFfX5J2XS', '2007-08-10', 'female', NULL, NULL, 'vendor', NULL, '2025-08-05 17:34:50', '2025-08-05 17:34:50', NULL),
(8, 'nidhi', 'nidhi123456@gmail.com', '1324', '$2y$10$8Na3RQBsVkIO7FU7cGBTpe7YOJryKEMtGAZnfhSaRMMkDIMcjwS4a', '2007-08-10', 'female', NULL, NULL, 'vendor', NULL, '2025-08-05 17:42:27', '2025-08-05 17:42:27', NULL),
(9, 'nidhi', 'nidhi1234567@gmail.com', '12354678', '$2y$10$vlFZ9vPL3cbNMuhjuVR7jODfnzz6HnvRJB2xzZ753fNOmRCnANaBO', '2007-08-10', 'female', NULL, NULL, 'vendor', NULL, '2025-08-05 17:47:15', '2025-08-05 17:47:15', NULL),
(10, 'hetal', 'hetal123@gmail.com', '8634', '$2y$10$cZDLtk168qaEtRylHE6c4uG4ApoQdl7V/TgxP2YE0CsviFooOYvEe', '2007-08-11', 'female', NULL, NULL, 'vendor', NULL, '2025-08-06 22:30:06', '2025-08-06 22:30:06', NULL),
(11, 'hitesh', 'hitesh123@gmail.com', '321', '$2y$10$aEU21pMTqy/UfbdTphqwdOrPDU5GremHRyi/ptO5x9nxoAK3dTMf6', '2007-08-11', 'male', NULL, NULL, 'vendor', NULL, '2025-08-06 23:48:03', '2025-08-06 23:48:03', NULL),
(12, 'niraj', 'niraj123@gmail.com', '432', '$2y$10$LFiCYthbw4XsulzUt7zSiui0eZ0VJ7zFuFjp40U.qu7sa7UsUxof6', '2007-08-11', 'male', NULL, NULL, 'vendor', NULL, '2025-08-06 23:49:08', '2025-08-06 23:49:08', NULL),
(13, 'sejal', 'sejal1234@gmail.com', '123123', '$2y$10$y8p.MFTS/a9mihx/QaqDFuOT/7mnZ4kaA6cPdsUBTvMn0WEnXtxTG', '2007-08-24', 'female', NULL, NULL, 'vendor', NULL, '2025-08-19 17:50:29', '2025-08-19 17:50:29', NULL),
(14, 'dhvanii', 'dhvani@gmail.com', '+2712375989', '$2y$10$jRnCF1d5.IC/oN3qcZW5B.7TDyeKYb7BPQKfmGDDVzFOixVM/h.x6', '2007-08-25', 'female', 'JR29+HFX, Anand, Gujarat, India', 22.60168860, 'customer', 'uploads/profile_images/profile_68a5452bab843.jpg', '2025-08-20 09:16:52', '2025-08-20 09:17:11', 72.81756120),
(15, 'test', 'test123@gmail.com', '314', '$2y$10$BDlS6Q.WIP6C94f4AvF1SOaJ.RlAcJlp3sFHkaJxJV7FlozddJPiy', '2007-08-26', 'female', NULL, NULL, 'vendor', NULL, '2025-08-21 18:39:05', '2025-08-21 18:39:05', NULL),
(16, 'niraj', 'nirajj123@gmail.com', '123123123123', '$2y$10$1SJn.ibgsQclvZEsKFgFieWALx1MpKnhZlBO9K12E2XtKlWXX81jW', '2007-08-28', 'female', NULL, NULL, 'vendor', NULL, '2025-08-23 03:14:35', '2025-08-23 03:14:35', NULL),
(17, 'nidhi', 'nidhii123@gmail.com', '123164168', '$2y$10$zO8dJkYyOfCMUaq/26Q9/eDPi4vh8AMyICPsQ3/R/2DSwJf.rRGLm', '2007-08-28', 'female', NULL, NULL, 'vendor', NULL, '2025-08-23 03:18:56', '2025-08-23 03:18:56', NULL),
(18, 'yanshi', 'yanshi123@gmail.com', '132', '$2y$10$fXkX9WYCpTouA4A880qsKejLVG.aBUyQ0HMVPyrCUw29GBSYSFBhm', '2007-08-28', 'female', NULL, NULL, 'vendor', NULL, '2025-08-23 04:11:04', '2025-08-23 04:11:04', NULL),
(19, 'dhvani', 'dhvanikotak006@gmail.com', '+2723432', '$2y$10$agox1gVST4xFYYtEM.opye9K6rIBO2dol0M1fyR006/SClU3.l5R.', '2007-08-29', 'female', 'ds', NULL, 'customer', NULL, '2025-08-24 11:21:42', '2025-08-24 11:21:58', NULL),
(20, 'fg', 'fg@gmail.com', '+275999', '$2y$10$WNs88YTD/K52v3qg7CAI0uFBQ8p3.GQQ0503trv.aKWFwlkb8oSU6', '2007-09-01', 'female', 'JR29+HFX, Anand, Gujarat, India', 22.60168800, 'customer', 'uploads/profile_images/profile_68aec42bed325.jpg', '2025-08-27 14:09:08', '2025-08-27 14:09:31', 72.81756040),
(21, 'fxgx', 'ssss@gmail.com', '+27099', '$2y$10$Sajbtvkjvnctf8Y4Qk9JgeNVWBRAITCqz79kJ1LkPHb2NxDddExh6', '2007-09-01', 'female', 'JR29+HFX, Anand, Gujarat, India', 22.60168930, 'customer', NULL, '2025-08-27 15:21:29', '2025-08-27 15:21:51', 72.81755290),
(22, 'see', 'see@gmail.com', '7894561230', '$2y$10$QTwTJDgAI.popIH5L4slIeoFLt0zNQywKrZL4OtAmqmvTelIRqjL2', '2007-09-07', 'female', NULL, NULL, 'vendor', NULL, '2025-09-02 09:40:59', '2025-09-02 09:40:59', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_otp`
--

CREATE TABLE `user_otp` (
  `otp_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `otp_code` varchar(6) NOT NULL,
  `is_verified` tinyint(1) DEFAULT 0,
  `expires_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `store_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `store_name` varchar(100) NOT NULL,
  `store_type` enum('restaurant','grocery','pharmacy') NOT NULL,
  `store_address` text DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `is_approved` tinyint(1) DEFAULT 0,
  `logo_img` text DEFAULT NULL,
  `open_time` time DEFAULT NULL,
  `close_time` time DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`store_id`, `user_id`, `store_name`, `store_type`, `store_address`, `latitude`, `longitude`, `is_approved`, `logo_img`, `open_time`, `close_time`, `created_at`, `updated_at`) VALUES
(1, 1, 'sejal da dhaba', 'restaurant', 'jetpur', 10, 10.2, 1, 'vendors_logo/brand1.png', '18:30:33', '18:30:35', '2025-07-07 18:30:24', '2025-07-07 18:30:41'),
(2, 2, 'navjivan', 'restaurant', 'sxGFVTUKM', NULL, NULL, 1, NULL, NULL, NULL, '2025-08-04 17:17:33', '2025-08-04 17:18:40'),
(3, 3, 'fd', 'restaurant', 'sdev', NULL, NULL, 1, NULL, NULL, NULL, '2025-08-04 23:14:35', '2025-08-04 23:47:06'),
(4, 4, 'dwq', 'restaurant', 'wcw', NULL, NULL, 0, NULL, NULL, NULL, '2025-08-05 16:32:22', '2025-08-05 16:32:22'),
(5, 5, 'efw', 'restaurant', 'wcf', NULL, NULL, 0, NULL, NULL, NULL, '2025-08-05 17:08:08', '2025-08-05 17:08:08'),
(6, 6, 'df', 'restaurant', 'dvzfesthyju', NULL, NULL, 0, NULL, NULL, NULL, '2025-08-05 17:27:18', '2025-08-05 17:27:18'),
(7, 7, 'sdv', 'restaurant', 'svd', 22.601712666666664, 72.81760908333332, 0, NULL, NULL, NULL, '2025-08-05 17:34:50', '2025-08-05 17:34:50'),
(8, 8, 'qd', 'restaurant', 'dddddddd', 22.601712666666664, 72.81760908333332, 0, 'uploads/logos/6891f52bb361c_1754395947.jpg', NULL, NULL, '2025-08-05 17:42:27', '2025-08-05 17:42:27'),
(9, 9, 'wd', 'restaurant', 'wfcw', 22.601712666666664, 72.81760908333332, 0, 'logos/6891f64b2ea11_1754396235.jpeg', NULL, NULL, '2025-08-05 17:47:15', '2025-08-05 17:47:15'),
(10, 10, 'dcs', 'restaurant', 'sd', 22.601672474761255, 72.81767195770806, 1, 'logos/68938a15cbaeb_1754499605.jpeg', NULL, NULL, '2025-08-06 22:30:06', '2025-08-06 23:51:53'),
(11, 11, 'qdsa', 'grocery', 'ac', 22.601455011186903, 72.81822483901774, 1, '', NULL, NULL, '2025-08-06 23:48:03', '2025-08-06 23:51:32'),
(12, 12, 'wdf', 'pharmacy', 'wf', 22.601455011186903, 72.81822483901774, 1, 'logos/68939c9c93a69_1754504348.jpg', NULL, NULL, '2025-08-06 23:49:08', '2025-08-06 23:51:44'),
(13, 13, 'wf', 'restaurant', 'dwf', 32, 23, 0, 'logos/68a46c0d379ea_1755606029.jpg', NULL, NULL, '2025-08-19 17:50:29', '2025-08-19 17:50:29'),
(14, 15, 'wfe', 'restaurant', 'werf', 423, 6789, 0, 'logos/68a71a7131543_1755781745.png', NULL, NULL, '2025-08-21 18:39:05', '2025-08-21 18:39:05'),
(15, 16, 'dsc', 'grocery', 'qea', 5, 3, 1, 'logos/68a8e4c330ed9_1755899075.png', NULL, NULL, '2025-08-23 03:14:35', '2025-08-23 03:16:42'),
(16, 17, 'wkn', 'restaurant', 'few', 5255, 326, 1, 'logos/68a8e5c8a7174_1755899336.png', NULL, NULL, '2025-08-23 03:18:56', '2025-08-23 03:19:26'),
(17, 18, '12323', 'pharmacy', 'ew', 132, 32, 0, 'logos/68a8f1ffe907f_1755902463.png', NULL, NULL, '2025-08-23 04:11:04', '2025-08-23 04:11:04'),
(18, 22, 'ajna', 'grocery', 'sjbx', 545, 12, 1, '', NULL, NULL, '2025-09-02 09:40:59', '2025-09-02 09:41:39');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addons`
--
ALTER TABLE `addons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `addon_options`
--
ALTER TABLE `addon_options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `addon_id` (`addon_id`);

--
-- Indexes for table `admin_logs`
--
ALTER TABLE `admin_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `allergen_master`
--
ALTER TABLE `allergen_master`
  ADD PRIMARY KEY (`allergen_id`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`cart_item_id`),
  ADD KEY `cart_id` (`cart_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`coupon_id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `idx_vendor_type` (`vendor_id`,`store_type`),
  ADD KEY `idx_status_dates` (`status`,`start_date`,`expire_date`);

--
-- Indexes for table `coupon_usages`
--
ALTER TABLE `coupon_usages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `coupon_id` (`coupon_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `delivery_partners`
--
ALTER TABLE `delivery_partners`
  ADD PRIMARY KEY (`deliveryguy_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `earnings`
--
ALTER TABLE `earnings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `delivery_partner_id` (`delivery_partner_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `food_products`
--
ALTER TABLE `food_products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `grocery_products`
--
ALTER TABLE `grocery_products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `master_categories`
--
ALTER TABLE `master_categories`
  ADD PRIMARY KEY (`maste_cat_food_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `nutrition_master`
--
ALTER TABLE `nutrition_master`
  ADD PRIMARY KEY (`nutrition_id`);

--
-- Indexes for table `offers`
--
ALTER TABLE `offers`
  ADD PRIMARY KEY (`offer_id`),
  ADD KEY `vendor_id` (`vendor_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `vendor_id` (`vendor_id`),
  ADD KEY `delivery_partner_id` (`delivery_partner_id`),
  ADD KEY `fk_orders_coupon` (`coupon_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_items_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `payfast_payments`
--
ALTER TABLE `payfast_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `m_payment_id` (`m_payment_id`),
  ADD KEY `pf_payment_id` (`pf_payment_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `vendor_id` (`vendor_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `fk_products_sub_category` (`sub_category_id`);

--
-- Indexes for table `product_allergens`
--
ALTER TABLE `product_allergens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `allergen_id` (`allergen_id`);

--
-- Indexes for table `product_nutritions`
--
ALTER TABLE `product_nutritions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `nutrition_id` (`nutrition_id`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `vendor_id` (`vendor_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD PRIMARY KEY (`categories_id`),
  ADD KEY `master_cat_food_id` (`master_cat_food_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Indexes for table `user_otp`
--
ALTER TABLE `user_otp`
  ADD PRIMARY KEY (`otp_id`),
  ADD KEY `fk_user` (`user_id`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`store_id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addons`
--
ALTER TABLE `addons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `addon_options`
--
ALTER TABLE `addon_options`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `admin_logs`
--
ALTER TABLE `admin_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `allergen_master`
--
ALTER TABLE `allergen_master`
  MODIFY `allergen_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `cart_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `coupon_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `coupon_usages`
--
ALTER TABLE `coupon_usages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `delivery_partners`
--
ALTER TABLE `delivery_partners`
  MODIFY `deliveryguy_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `earnings`
--
ALTER TABLE `earnings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_categories`
--
ALTER TABLE `master_categories`
  MODIFY `maste_cat_food_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nutrition_master`
--
ALTER TABLE `nutrition_master`
  MODIFY `nutrition_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `offers`
--
ALTER TABLE `offers`
  MODIFY `offer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_items_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `payfast_payments`
--
ALTER TABLE `payfast_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT for table `product_allergens`
--
ALTER TABLE `product_allergens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `product_nutritions`
--
ALTER TABLE `product_nutritions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sub_categories`
--
ALTER TABLE `sub_categories`
  MODIFY `categories_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `user_otp`
--
ALTER TABLE `user_otp`
  MODIFY `otp_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `store_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addons`
--
ALTER TABLE `addons`
  ADD CONSTRAINT `addons_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `addon_options`
--
ALTER TABLE `addon_options`
  ADD CONSTRAINT `addon_options_ibfk_1` FOREIGN KEY (`addon_id`) REFERENCES `addons` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `admin_logs`
--
ALTER TABLE `admin_logs`
  ADD CONSTRAINT `admin_logs_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `coupons`
--
ALTER TABLE `coupons`
  ADD CONSTRAINT `fk_coupons_vendor` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`store_id`) ON DELETE CASCADE;

--
-- Constraints for table `coupon_usages`
--
ALTER TABLE `coupon_usages`
  ADD CONSTRAINT `coupon_usages_ibfk_1` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`coupon_id`),
  ADD CONSTRAINT `coupon_usages_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `coupon_usages_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `delivery_partners`
--
ALTER TABLE `delivery_partners`
  ADD CONSTRAINT `delivery_partners_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `earnings`
--
ALTER TABLE `earnings`
  ADD CONSTRAINT `earnings_ibfk_1` FOREIGN KEY (`delivery_partner_id`) REFERENCES `delivery_partners` (`deliveryguy_id`),
  ADD CONSTRAINT `earnings_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `food_products`
--
ALTER TABLE `food_products`
  ADD CONSTRAINT `food_products_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `grocery_products`
--
ALTER TABLE `grocery_products`
  ADD CONSTRAINT `grocery_products_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `offers`
--
ALTER TABLE `offers`
  ADD CONSTRAINT `offers_ibfk_1` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`store_id`),
  ADD CONSTRAINT `offers_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_coupon` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`coupon_id`),
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`store_id`),
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`delivery_partner_id`) REFERENCES `delivery_partners` (`deliveryguy_id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `payfast_payments`
--
ALTER TABLE `payfast_payments`
  ADD CONSTRAINT `payfast_payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE SET NULL;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_products_category` FOREIGN KEY (`category_id`) REFERENCES `master_categories` (`maste_cat_food_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_products_sub_category` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`categories_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`store_id`) ON DELETE CASCADE;

--
-- Constraints for table `product_allergens`
--
ALTER TABLE `product_allergens`
  ADD CONSTRAINT `product_allergens_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_allergens_ibfk_2` FOREIGN KEY (`allergen_id`) REFERENCES `allergen_master` (`allergen_id`) ON DELETE CASCADE;

--
-- Constraints for table `product_nutritions`
--
ALTER TABLE `product_nutritions`
  ADD CONSTRAINT `product_nutritions_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_nutritions_ibfk_2` FOREIGN KEY (`nutrition_id`) REFERENCES `nutrition_master` (`nutrition_id`) ON DELETE CASCADE;

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`store_id`),
  ADD CONSTRAINT `ratings_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD CONSTRAINT `sub_categories_ibfk_2` FOREIGN KEY (`master_cat_food_id`) REFERENCES `master_categories` (`maste_cat_food_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `user_otp`
--
ALTER TABLE `user_otp`
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `vendors`
--
ALTER TABLE `vendors`
  ADD CONSTRAINT `vendors_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
