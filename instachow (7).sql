-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Sep 25, 2025 at 01:54 PM
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
(37, 105, 'size', 'multiple', 0, 1, 1),
(38, 109, 'quality', 'single', 0, 1, 1);

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
(45, 37, 'full dish', 100.00),
(46, 37, 'half dish', 50.00),
(47, 38, 'good one', 102.00),
(48, 38, 'medium quality', 50.00);

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
(2, 11, 'Added new grocery banner offer - Discount: 10%', '2025-09-16 15:26:58'),
(3, 11, 'Added new grocery banner offer - Discount: 10%', '2025-09-16 15:27:22'),
(4, 10, 'Added new food banner offer - Discount: 10%', '2025-09-16 15:28:22'),
(5, 10, 'Added new food banner offer - Discount: 10%', '2025-09-16 15:28:49');

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
(4, 'Milk', '2025-09-16 14:12:48'),
(5, 'Eggs', '2025-09-16 14:12:54'),
(6, 'Shellfish', '2025-09-16 14:13:00'),
(7, 'Wheat (Gluten)', '2025-09-16 14:13:08'),
(8, 'Lupin (legume, used in flour)', '2025-09-16 14:13:12'),
(9, 'Soybeans', '2025-09-16 14:13:19');

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
(140, 28, '2025-09-17 00:23:50', '2025-09-17 00:23:50'),
(141, 29, '2025-09-17 00:28:27', '2025-09-17 00:28:27'),
(142, 30, '2025-09-17 16:00:25', '2025-09-17 16:00:25');

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
  `total_price` decimal(10,2) DEFAULT 0.00,
  `websocket_added_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart_items`
--

INSERT INTO `cart_items` (`cart_item_id`, `cart_id`, `product_id`, `quantity`, `price`, `addons`, `total_price`, `websocket_added_at`) VALUES
(225, 140, 105, 1, 100.00, '[{\"addon_id\":37,\"option_id\":45,\"option_name\":\"full dish\",\"price\":100.0}]', 200.00, '2025-09-16 18:53:50'),
(226, 140, 109, 2, 122.00, '[{\"addon_id\":38,\"option_id\":48,\"option_name\":\"medium quality\",\"price\":50.0}]', 344.00, '2025-09-16 18:54:23'),
(227, 141, 105, 1, 100.00, '[{\"addon_id\":37,\"option_id\":45,\"option_name\":\"full dish\",\"price\":100.0}]', 200.00, '2025-09-16 18:58:27'),
(228, 141, 109, 2, 122.00, '[{\"addon_id\":38,\"option_id\":47,\"option_name\":\"good one\",\"price\":102.0}]', 448.00, '2025-09-16 18:58:53'),
(230, 142, 107, 3, 100.00, NULL, 300.00, '2025-09-17 10:38:09'),
(231, 142, 109, 1, 122.00, '[{\"addon_id\":38,\"option_id\":48,\"option_name\":\"medium quality\",\"price\":50.0}]', 172.00, '2025-09-17 10:59:13');

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
  `coupon_type` enum('default','special','seasonal','promotional') DEFAULT 'default',
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
  `discount_amount` decimal(10,2) DEFAULT 0.00,
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
(105, 'yes', 'non_veg', NULL),
(106, 'no', 'non_veg', NULL),
(107, 'yes', 'veg', NULL),
(108, 'yes', 'non_veg', NULL);

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
(109, 'yes', 'yes', 'kg', 'yes');

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
(20, 'Biryani & Rice', 'master_cat_food_img/cat_68c91a3bbff994.78506014.jpg', 'Food', '2025-09-16 13:35:15'),
(21, 'Pizza & Pasta', 'master_cat_food_img/cat_68c91a56efa3f9.30895239.png', 'Food', '2025-09-16 13:35:42'),
(22, 'Burgers & Sandwiches', 'master_cat_food_img/cat_68c91a6feed719.16768921.png', 'Food', '2025-09-16 13:36:07'),
(23, 'paneer food', 'master_cat_food_img/cat_68c91a8d3269d9.79647187.jpg', 'Food', '2025-09-16 13:36:37'),
(24, 'italian', 'master_cat_food_img/cat_68c91aa657b176.23689194.png', 'Food', '2025-09-16 13:37:02'),
(25, 'Spices & Condiments', 'master_cat_food_img/cat_68c91cd38aa0f9.92929269.jpg', 'Grocery', '2025-09-16 13:46:19'),
(26, 'Dry Fruits & Snacks', 'master_cat_food_img/cat_68c91d03ef8450.00959362.jpg', 'Grocery', '2025-09-16 13:47:07'),
(27, 'Beverages & Breakfast', 'master_cat_food_img/cat_68c91d24af4b56.77935641.jpg', 'Grocery', '2025-09-16 13:47:40'),
(28, 'Dairy & Bakery', 'master_cat_food_img/cat_68c91d48eeff31.12757554.jpg', 'Grocery', '2025-09-16 13:48:16');

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
(2, 'Energy', '2025-09-16 14:12:11'),
(3, 'Protein', '2025-09-16 14:12:18'),
(4, 'Carbohydrates', '2025-09-16 14:12:25'),
(5, 'Sugars', '2025-09-16 14:12:32'),
(6, 'Dietary Fiber (g)', '2025-09-16 14:12:38');

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
  `offer_type` enum('food','grocery') DEFAULT 'food',
  `title` varchar(255) DEFAULT '',
  `url` text DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `offers`
--

INSERT INTO `offers` (`offer_id`, `vendor_id`, `product_id`, `image_url`, `discount_percentage`, `is_approved`, `created_at`, `offer_type`, `title`, `url`) VALUES
(15, 11, 109, 'offer_banner/banner_1758016618_68c9346a651fc.jpg', 10, 1, '2025-09-16 15:26:58', 'grocery', 'big sale', 'xyz'),
(16, 11, 109, 'offer_banner/banner_1758016642_68c93482c756b.jpg', 10, 1, '2025-09-16 15:27:22', 'grocery', 'super sale', 'xyz'),
(17, 10, 106, 'offer_banner/banner_1758016702_68c934bec3d94.jpg', 10, 1, '2025-09-16 15:28:22', 'food', 'big offer', 'xyz'),
(18, 10, 107, 'offer_banner/banner_1758016729_68c934d96dc91.jpg', 10, 1, '2025-09-16 15:28:49', 'food', 'super sale', 'xyz');

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
  `status` enum('pending','confirmed','cooking','ready_for_delivery','item_on_the_way','delivered','refunded','scheduled','cancled') DEFAULT 'pending',
  `websocket_notified` tinyint(1) DEFAULT 0,
  `websocket_events_count` int(11) DEFAULT 0,
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

INSERT INTO `orders` (`order_id`, `customer_id`, `vendor_id`, `delivery_partner_id`, `total_amount`, `status`, `websocket_notified`, `websocket_events_count`, `payment_method`, `payment_status`, `payment_reference`, `payment_gateway`, `payment_date`, `currency`, `gateway_transaction_id`, `delivery_address`, `delivery_latitude`, `delivery_longitude`, `created_at`, `updated_at`, `coupon_id`, `discount_amount`) VALUES
(1058, 20, 10, NULL, 95.00, 'pending', 0, 0, 'cash', 'pending', NULL, 'cash', NULL, 'ZAR', NULL, 'JR29+HFX, , Anand, Gujarat - 388421', 22.6013468, 72.8181865, '2025-09-16 15:00:35', '2025-09-16 15:00:35', NULL, 0.00),
(1059, 22, 10, NULL, 95.00, 'pending', 0, 0, 'cash', 'pending', NULL, 'cash', NULL, 'ZAR', NULL, 'JR29+HFX, , Anand, Gujarat - 388421', 22.6016212, 72.8175709, '2025-09-16 15:02:03', '2025-09-16 15:02:03', NULL, 0.00),
(1060, 20, 10, NULL, 450.00, 'pending', 0, 0, 'cash', 'pending', NULL, 'cash', NULL, 'ZAR', NULL, 'JR29+HFX, , Anand, Gujarat - 388421', 22.6013909, 72.8181329, '2025-09-16 16:11:47', '2025-09-16 16:11:47', NULL, 0.00),
(1061, 20, 11, NULL, 214.72, 'pending', 0, 0, 'cash', 'pending', NULL, 'cash', NULL, 'ZAR', NULL, 'JR29+JFG, , Petlad, Gujarat - 388421', 22.601934, 72.8180983, '2025-09-16 17:10:55', '2025-09-16 17:10:55', NULL, 0.00),
(1062, 20, 10, NULL, 417.12, 'pending', 0, 0, 'cash', 'pending', NULL, 'cash', NULL, 'ZAR', NULL, 'JR29+JFG, , Petlad, Gujarat - 388421', 22.601934, 72.8180983, '2025-09-16 17:10:56', '2025-09-16 17:10:56', NULL, 0.00),
(1063, 20, 10, NULL, 504.72, 'pending', 0, 0, 'payfast', 'completed', 'PAYFAST_1758047196940', 'payfast', '2025-09-16 23:56:36', 'ZAR', 'PAYFAST_1758047196940', 'JR29+HFX, xyz, Anand, Gujarat - 388421', 22.6016886, 72.8175864, '2025-09-16 23:56:34', '2025-09-16 23:56:34', NULL, 0.00),
(1064, 20, 10, NULL, 190.00, 'confirmed', 0, 0, 'cash', 'pending', NULL, 'cash', NULL, 'ZAR', NULL, 'JR29+HFX, , Anand, Gujarat - 388421', 22.6017043, 72.8175697, '2025-09-16 23:57:27', '2025-09-19 13:57:29', NULL, 0.00),
(1065, 20, 11, NULL, 209.36, 'pending', 0, 0, 'cash', 'pending', NULL, 'cash', NULL, 'ZAR', NULL, 'JR29+HFX, , Anand, Gujarat - 388421', 22.6017043, 72.8175697, '2025-09-16 23:57:27', '2025-09-16 23:57:27', NULL, 0.00),
(1066, 29, 11, NULL, 608.72, 'confirmed', 0, 0, 'payfast', 'completed', 'PAYFAST_1758049193231', 'payfast', '2025-09-17 00:29:53', 'ZAR', 'PAYFAST_1758049193231', 'JR29+HFX, xyz, Anand, Gujarat - 388421', 22.6016859, 72.8175586, '2025-09-17 00:30:06', '2025-09-21 06:20:43', NULL, 0.00),
(1067, 30, 11, NULL, 837.44, 'confirmed', 0, 0, 'payfast', 'completed', 'PAYFAST_1758105095497', 'payfast', '2025-09-17 16:01:35', 'ZAR', 'PAYFAST_1758105095497', 'JR29+HFX, , Anand, Gujarat - 388421', 22.6013922, 72.8177376, '2025-09-17 16:01:34', '2025-09-19 13:55:10', NULL, 0.00);

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
(156, 1058, 107, 1, 95.00),
(157, 1059, 107, 1, 95.00),
(158, 1060, 105, 1, 90.00),
(159, 1060, 106, 4, 90.00),
(160, 1061, 109, 2, 107.36),
(161, 1062, 108, 2, 118.56),
(162, 1062, 106, 1, 90.00),
(163, 1062, 105, 1, 90.00),
(164, 1063, 105, 1, 90.00),
(165, 1063, 109, 2, 107.36),
(166, 1064, 105, 1, 90.00),
(167, 1065, 109, 1, 107.36),
(168, 1066, 109, 2, 107.36),
(169, 1066, 105, 1, 90.00),
(170, 1067, 109, 4, 107.36);

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
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `websocket_notified` tinyint(1) DEFAULT NULL,
  `websocket_events_count` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payfast_payments`
--

INSERT INTO `payfast_payments` (`id`, `order_id`, `m_payment_id`, `pf_payment_id`, `payment_status`, `amount_gross`, `customer_email`, `customer_name`, `item_name`, `custom_str1`, `payment_date`, `created_at`, `updated_at`, `websocket_notified`, `websocket_events_count`) VALUES
(1, NULL, '', '', '', 0.00, '', NULL, '', '', '2025-08-27 16:20:17', '2025-08-27 16:20:17', '2025-08-27 16:20:32', NULL, NULL),
(2, NULL, 'TEST_PAYFAST_1756292880', NULL, 'complete', 50.00, 'dhvanikotak006@gmail.com', 'Test Customer', 'Test Product', '22', '2025-08-27 13:08:00', '2025-08-27 16:38:00', '2025-08-27 16:38:00', NULL, NULL),
(3, NULL, 'TEST_PAYFAST_1756293140', NULL, 'complete', 50.00, 'dhvanikotak006@gmail.com', 'Test Customer', 'Test Product', '23', '2025-08-27 13:12:20', '2025-08-27 16:42:20', '2025-08-27 16:42:20', NULL, NULL),
(4, NULL, 'PAYFAST_1756295407', NULL, 'complete', 150.00, 'dhvani@gmail.com', 'dhvanii', 'Test Product', '25', '2025-08-27 13:50:07', '2025-08-27 17:20:07', '2025-08-27 17:20:07', NULL, NULL),
(5, NULL, 'PAYFAST_1756295442', NULL, 'complete', 150.00, 'dhvani@gmail.com', 'dhvanii', 'Test Product', '26', '2025-08-27 13:50:42', '2025-08-27 17:20:42', '2025-08-27 17:20:42', NULL, NULL),
(6, NULL, 'FALLBACK_1756312142', 'PAYFAST_FALLBACK_1756312142', 'complete', 43.00, 'customer@example.com', NULL, NULL, 'FALLBACK_1756312142', '2025-08-27 21:59:02', '2025-08-27 21:59:02', '2025-08-27 21:59:02', NULL, NULL),
(7, NULL, 'FALLBACK_1756314474', 'PAYFAST_FALLBACK_1756314474', 'complete', 0.00, 'customer@example.com', NULL, NULL, 'FALLBACK_1756314474', '2025-08-27 22:37:54', '2025-08-27 22:37:54', '2025-08-27 22:37:54', NULL, NULL),
(8, NULL, 'PAYFAST_1756315989344', NULL, 'complete', 330.00, 'fg@gmail.com', 'fg', 'veg chiz burger', '28', '2025-08-27 23:03:09', '2025-08-27 23:03:10', '2025-08-27 23:03:10', NULL, NULL),
(9, NULL, 'PAYFAST_1756317829341', NULL, 'complete', 172.00, 'fg@gmail.com', 'fg', 'junk', '30', '2025-08-27 23:33:49', '2025-08-27 23:33:49', '2025-08-27 23:33:49', NULL, NULL),
(10, NULL, 'PAYFAST_1756319174942', NULL, 'complete', 94.08, 'fg@gmail.com', 'fg', 'fffffff', '31', '2025-08-27 23:56:14', '2025-08-27 23:56:14', '2025-08-27 23:56:14', NULL, NULL),
(11, NULL, 'PAYFAST_1756468394559', NULL, 'complete', 3.00, 'fg@gmail.com', 'fg', 'kookoko', '32', '2025-08-29 17:23:14', '2025-08-29 17:23:15', '2025-08-29 17:23:15', NULL, NULL),
(12, NULL, 'PAYFAST_1756469739014', NULL, 'complete', 110.00, 'fg@gmail.com', 'fg', 'veg chiz burger', '33', '2025-08-29 17:45:39', '2025-08-29 17:45:40', '2025-08-29 17:45:40', NULL, NULL),
(13, NULL, 'PAYFAST_1756470092067', NULL, 'complete', 110.00, 'fg@gmail.com', 'fg', 'veg chiz burger', '35', '2025-08-29 17:51:32', '2025-08-29 17:51:33', '2025-08-29 17:51:33', NULL, NULL),
(14, NULL, 'PAYFAST_1756470427641', NULL, 'complete', 110.00, 'fg@gmail.com', 'fg', 'veg chiz burger', '36', '2025-08-29 17:57:07', '2025-08-29 17:57:08', '2025-08-29 17:57:08', NULL, NULL),
(15, NULL, 'PAYFAST_1756470673149', NULL, 'complete', 401.00, 'fg@gmail.com', 'fg', 'dssv', '37', '2025-08-29 18:01:13', '2025-08-29 18:01:14', '2025-08-29 18:01:14', NULL, NULL),
(16, NULL, 'PAYMENT_1757869452701', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '95', '2025-09-14 22:34:12', '2025-09-14 22:34:12', '2025-09-14 22:34:12', NULL, NULL),
(17, NULL, 'PAYMENT_1757870007577', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '96', '2025-09-14 22:43:27', '2025-09-14 22:43:27', '2025-09-14 22:43:27', NULL, NULL),
(18, NULL, 'PAYMENT_1757870870834', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '97', '2025-09-14 22:57:50', '2025-09-14 22:57:50', '2025-09-14 22:57:50', NULL, NULL),
(19, NULL, 'PAYMENT_1757876440224', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '98', '2025-09-15 00:30:40', '2025-09-15 00:30:40', '2025-09-15 00:30:40', NULL, NULL),
(20, NULL, 'PAYMENT_1757878463784', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '99', '2025-09-15 01:04:24', '2025-09-15 01:04:24', '2025-09-15 01:04:24', NULL, NULL),
(21, NULL, 'PAYMENT_1757878780191', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '100', '2025-09-15 01:09:40', '2025-09-15 01:09:40', '2025-09-15 01:09:40', NULL, NULL),
(22, NULL, 'PAYMENT_1757879431297', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '101', '2025-09-15 01:20:31', '2025-09-15 01:20:31', '2025-09-15 01:20:31', NULL, NULL),
(23, NULL, 'PAYMENT_1757880595609', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '1004', '2025-09-15 01:39:55', '2025-09-15 01:39:55', '2025-09-15 01:39:55', NULL, NULL),
(24, NULL, 'PAYMENT_1757881506836', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '1005', '2025-09-15 01:55:07', '2025-09-15 01:55:07', '2025-09-15 01:55:07', NULL, NULL),
(25, NULL, 'PAYMENT_1757882325607', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '1006', '2025-09-15 02:08:45', '2025-09-15 02:08:45', '2025-09-15 02:08:45', NULL, NULL),
(26, NULL, 'PAYMENT_1757882530145', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '1007', '2025-09-15 02:12:10', '2025-09-15 02:12:10', '2025-09-15 02:12:10', NULL, NULL),
(27, NULL, 'PAYMENT_1757882606495', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '1008', '2025-09-15 02:13:26', '2025-09-15 02:13:26', '2025-09-15 02:13:26', NULL, NULL),
(28, NULL, 'PAYMENT_1757883531260', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '1009', '2025-09-15 02:28:51', '2025-09-15 02:28:51', '2025-09-15 02:28:51', NULL, NULL),
(29, NULL, 'PAYMENT_1757883585414', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '1010', '2025-09-15 02:29:45', '2025-09-15 02:29:45', '2025-09-15 02:29:45', NULL, NULL),
(30, NULL, 'PAYMENT_1757883657972', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '1011', '2025-09-15 02:30:58', '2025-09-15 02:30:58', '2025-09-15 02:30:58', NULL, NULL),
(31, NULL, 'PAYMENT_1757884372782', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '1012', '2025-09-15 02:42:53', '2025-09-15 02:42:53', '2025-09-15 02:42:53', NULL, NULL),
(32, NULL, 'PAYMENT_1757885030985', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '1013', '2025-09-15 02:53:51', '2025-09-15 02:53:51', '2025-09-15 02:53:51', NULL, NULL),
(33, NULL, 'PAYMENT_1757886297187', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '1015', '2025-09-15 03:14:57', '2025-09-15 03:14:57', '2025-09-15 03:14:57', NULL, NULL),
(34, NULL, 'PAYMENT_1757886865684', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '1016', '2025-09-15 03:24:25', '2025-09-15 03:24:25', '2025-09-15 03:24:25', NULL, NULL),
(35, NULL, 'PAYMENT_1757886920851', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '1017', '2025-09-15 03:25:21', '2025-09-15 03:25:21', '2025-09-15 03:25:21', NULL, NULL),
(36, NULL, 'PAYMENT_1757887484912', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '1018', '2025-09-15 03:34:45', '2025-09-15 03:34:45', '2025-09-15 03:34:45', NULL, NULL),
(37, NULL, 'PAYMENT_1757887534298', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '1019', '2025-09-15 03:35:34', '2025-09-15 03:35:34', '2025-09-15 03:35:34', NULL, NULL),
(38, NULL, 'PAYMENT_1757887611144', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '1020', '2025-09-15 03:36:51', '2025-09-15 03:36:51', '2025-09-15 03:36:51', NULL, NULL),
(39, NULL, 'PAYMENT_1757888094360', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '1021', '2025-09-15 03:44:54', '2025-09-15 03:44:54', '2025-09-15 03:44:54', NULL, NULL),
(40, NULL, 'PAYMENT_1757888613464', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '1022', '2025-09-15 03:53:33', '2025-09-15 03:53:33', '2025-09-15 03:53:33', NULL, NULL),
(41, NULL, 'PAYMENT_1757888818091', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '1023', '2025-09-15 03:56:58', '2025-09-15 03:56:58', '2025-09-15 03:56:58', NULL, NULL),
(42, NULL, 'PAYMENT_1757888904148', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '1024', '2025-09-15 03:58:24', '2025-09-15 03:58:24', '2025-09-15 03:58:24', NULL, NULL),
(43, NULL, 'PAYMENT_1757888962333', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '1025', '2025-09-15 03:59:22', '2025-09-15 03:59:22', '2025-09-15 03:59:22', NULL, NULL),
(44, NULL, 'PAYMENT_1757889016377', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '1026', '2025-09-15 04:00:16', '2025-09-15 04:00:16', '2025-09-15 04:00:16', NULL, NULL),
(45, NULL, 'PAYMENT_1757889513197', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '1027', '2025-09-15 04:08:33', '2025-09-15 04:08:33', '2025-09-15 04:08:33', NULL, NULL),
(46, NULL, 'PAYMENT_1757889614984', NULL, 'complete', 2.00, 'websocket@instachow.com', 'WebSocket User', 'WebSocket Payment', '1028', '2025-09-15 04:10:15', '2025-09-15 04:10:15', '2025-09-15 04:10:15', NULL, NULL),
(47, 1063, 'PAYFAST_1758047196940', NULL, 'complete', 504.72, 'fg@gmail.com', 'fg', '2 Items', '1063', '2025-09-16 23:56:36', '2025-09-16 23:56:34', '2025-09-16 23:56:34', NULL, NULL),
(48, 1066, 'PAYFAST_1758049193231', NULL, 'complete', 608.72, 'qq@gmail.com', 'qq', '2 Items', '1066', '2025-09-17 00:29:53', '2025-09-17 00:30:06', '2025-09-17 00:30:06', NULL, NULL),
(49, 1067, 'PAYFAST_1758105095497', NULL, 'complete', 837.44, 'mmm@gmail.com', 'mmm', 'turmeric', '1067', '2025-09-17 16:01:35', '2025-09-17 16:01:34', '2025-09-17 16:01:34', NULL, NULL);

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
(105, 10, 20, 'Hyderabadi Chicken Biryani', 'A fragrant rice dish cooked with aromatic spices and tender chicken, Hyderabadi style.', 100.00, 'percentage', 10.00, '[\"1758012291_web_image_1.jpg\"]', 47, 1, '2025-09-16 14:14:51', '2025-09-16 23:57:27', 27, 0),
(106, 10, 20, 'Kolkata Mutton Biryani', 'Classic Kolkata-style biryani with juicy mutton, flavored rice, and potatoes', 100.00, 'percentage', 10.00, '[\"1758012406_web_image_1.jpg\"]', 45, 1, '2025-09-16 14:16:46', '2025-09-16 17:10:56', 28, 0),
(107, 10, 21, 'cheese Margherita Pizza', 'Classic Italian pizza with mozzarella cheese, tomato, and basil.', 100.00, 'fixed', 5.00, '[\"1758012478_web_image_1.jpg\"]', 53, 1, '2025-09-16 14:17:58', '2025-09-16 15:02:03', 31, 0),
(108, 10, 21, 'Chicken BBQ Pizza', 'Smoky chicken chunks, BBQ sauce, and melted cheese on a pizza base.', 152.00, 'percentage', 22.00, '[\"1758012569_web_image_1.jpg\"]', 53, 0, '2025-09-16 14:19:29', '2025-09-19 13:21:38', 32, 1),
(109, 11, 25, 'turmeric', 'helty and yellow and organic', 122.00, 'percentage', 12.00, '[\"..\\/grocery_products\\/grocery_1758013152_0.jpg\"]', 120, 0, '2025-09-16 14:29:12', '2025-09-19 13:14:29', 33, 1);

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
(25, 106, 4),
(26, 106, 8),
(27, 106, 9),
(28, 107, 9);

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
(54, 106, 4, '10', '2025-09-16 14:16:46'),
(55, 106, 6, '4', '2025-09-16 14:16:46'),
(56, 107, 2, '10', '2025-09-16 14:17:58'),
(57, 108, 6, '10', '2025-09-16 14:19:29'),
(58, 109, 4, '12', '2025-09-16 14:29:12');

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
(1, 'burgereeeefff', 'get offeeee', '2025-07-07 20:48:19', NULL),
(2, 'ddd', 'csgeg', '2025-08-03 08:18:29', NULL),
(4, 'www', 'www', '2025-08-03 08:19:39', NULL),
(10, 'eeeewwww', 'eeeewwwwwwwwwwe2e', '2025-08-03 09:05:28', NULL),
(11, 'ed3r', 'wee', '2025-08-03 09:06:24', NULL),
(12, 'qweqqq', 'qqqqqq', '2025-08-03 09:12:54', NULL),
(13, 'qqq', 'aaa', '2025-08-03 09:13:49', NULL),
(14, '222', '222', '2025-08-03 09:17:20', NULL),
(15, 'qq', 'qqqq', '2025-08-03 09:22:09', NULL),
(16, 'qwe22', 'qqq22', '2025-08-03 09:22:36', NULL),
(17, 'soft drink', 'cock', '2025-08-03 11:06:52', NULL),
(18, 'dhvani', 'svd', '2025-08-07 21:57:25', NULL),
(19, 'Citrus Fruits', 'xyz', '2025-09-15 22:45:06', NULL),
(20, 'Tropical Fruits', 'xyz', '2025-09-15 22:45:19', NULL),
(21, 'Milk', 'discription', '2025-09-15 22:45:43', NULL),
(22, 'Curd & Yogurt', 'description', '2025-09-15 22:45:58', NULL),
(23, 'North Indian', 'xyz', '2025-09-15 22:49:41', NULL),
(24, 'South Indian Meals', 'xyz', '2025-09-15 22:49:54', NULL),
(25, 'Soft Drinks', 'xyz', '2025-09-15 22:50:08', NULL),
(26, 'Fresh Juices', 'xyz', '2025-09-15 22:50:19', NULL),
(27, 'Chicken Biryani', 'A fragrant rice dish cooked with aromatic spices and tender chicken, Hyderabadi style.', '2025-09-16 13:37:59', 20),
(28, 'Mutton Biryani', 'Classic Kolkata-style biryani with juicy mutton, flavored rice, and potatoes.', '2025-09-16 13:38:32', 20),
(29, 'Veg Biryani', 'Indo-Chinese fried rice with spicy schezwan sauce and vegetables', '2025-09-16 13:39:02', 20),
(30, 'Veg Pizza', 'Smoky chicken chunks, BBQ sauce, and melted cheese on a pizza base.', '2025-09-16 13:39:48', 21),
(31, 'Margherita Pizza', 'Classic Italian pizza with mozzarella cheese, tomato, and basil.', '2025-09-16 13:40:03', 21),
(32, 'Non-Veg Pizza', 'Soft bread baked with garlic butter and topped with melted cheese.', '2025-09-16 13:40:20', 21),
(33, 'Basic Spices', 'Turmeric, chili powder, coriander, cumin, and other single spices.', '2025-09-16 13:48:54', 25),
(34, 'Blended Masalas', 'Curry masala, garam masala, pav bhaji masala, biryani masala.', '2025-09-16 13:49:09', 25),
(35, 'Pickles & Sauces', 'Mango pickle, tomato ketchup, soy sauce, chili sauce, chutneys.', '2025-09-16 13:49:22', 25),
(36, 'Dry Fruits & Nuts', 'Almonds, cashews, raisins, pistachios, walnuts, dates.', '2025-09-16 13:49:35', 26),
(37, 'Namkeen & Savories', 'Bhujia, sev, farsan, chips, roasted snacks.', '2025-09-16 13:49:51', 26),
(38, 'Biscuits & Cookies', 'Glucose biscuits, cream biscuits, cookies, rusks.', '2025-09-16 13:50:04', 26);

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
(20, 'fg', 'fg@gmail.com', '+275999', '$2y$10$WNs88YTD/K52v3qg7CAI0uFBQ8p3.GQQ0503trv.aKWFwlkb8oSU6', '2007-09-01', 'female', 'JR29+HFX, Anand, Gujarat, India', 22.60168800, 'customer', 'profile_images/profile_20_1758043696.jpg', '2025-08-27 14:09:08', '2025-09-16 22:58:17', 72.81756040),
(21, 'fxgx', 'ssss@gmail.com', '+27099', '$2y$10$Sajbtvkjvnctf8Y4Qk9JgeNVWBRAITCqz79kJ1LkPHb2NxDddExh6', '2007-09-01', 'female', 'JR29+HFX, Anand, Gujarat, India', 22.60168930, 'customer', NULL, '2025-08-27 15:21:29', '2025-08-27 15:21:51', 72.81755290),
(22, 'fg', 'ff@gmail.com', '+27123456', '$2y$10$09sRlqS4YcYREiKR6BhHWuyqoxBXm4tMKaSgUEum.0eLlfIKjpZX6', '2007-09-21', 'female', 'JR29+HFX, Anand, Gujarat, India', 22.60136790, 'customer', 'profile_images/profile_22_1758014736.jpg', '2025-09-16 14:55:36', '2025-09-16 14:55:53', 72.81816030),
(23, 'vgg', 'rrr@gmail.com', '+278401877688', '$2y$10$4KGRAKjBPA59pSu/ts4Ex.3rBuh7fNIbMAT4vSpiVamU8rJ2z2hfO', '2007-09-21', 'female', NULL, NULL, 'customer', 'profile_images/profile_23_1758019463.jpg', '2025-09-16 16:14:22', '2025-09-16 16:14:23', NULL),
(24, 'ed', 'dhvanikotak17@gmail.com', '+278401877686', '$2y$10$vri1qnFt7bg2w7KEhp1ebuvyfu0XVLrrwrhOiIhKNHSlfNY0Cmx8G', '2007-09-21', NULL, 'JR29+HFX, Anand, Gujarat, India', 22.60168690, 'customer', 'profile_images/profile_24_1758042366.jpg', '2025-09-16 22:36:05', '2025-09-16 22:36:27', 72.81756040),
(25, 'xyz', 'xyz@gmail.com', '+279925176856', '$2y$10$9QboWiPq.kMe2vX2BRL9XOHX8Gysd21Z/KOYUmSWc1da/r9O5CE7y', '2007-09-22', NULL, NULL, NULL, 'customer', NULL, '2025-09-17 00:03:48', '2025-09-17 00:03:48', NULL),
(26, 'xyz', 'xyzz@gmail.com', '+278401877683', '$2y$10$v8gHriYSgI/RTh779FmR0uwvX6n7cqjMJ07h/.VMgPVEy7jCQZzsi', '2007-09-22', NULL, NULL, NULL, 'customer', 'profile_images/profile_26_1758048388.jpg', '2025-09-17 00:16:27', '2025-09-17 00:16:28', NULL),
(27, 'gdy', 'sgh@gmail.com', '+271234567891', '$2y$10$NoRx00VdVBIyJpESBJth8eY3v9f2Y6H1mZ41RM8XIDjrstBZ9w5xq', '2007-09-22', NULL, NULL, NULL, 'customer', 'profile_images/profile_27_1758048625.jpg', '2025-09-17 00:20:24', '2025-09-17 00:20:25', NULL),
(28, 'pqr', 'pqr@gmail.com', '+279925147688', '$2y$10$3Vtub.X3QhrXF3KiL6YRIeyDyd/nedSd6g502F8o38T3ripRY93RC', '2007-09-22', NULL, NULL, NULL, 'customer', 'profile_images/profile_28_1758048796.jpg', '2025-09-17 00:23:15', '2025-09-17 00:23:16', NULL),
(29, 'qq', 'qq@gmail.com', '+279925147632', '$2y$10$CqWecnvSW0Gnra0Vd.zwye3V4RsiFosCUZH2kKqeju0FDiJ4L8chW', '2007-09-22', NULL, NULL, NULL, 'customer', 'profile_images/profile_29_1758049054.jpg', '2025-09-17 00:27:32', '2025-09-17 00:27:34', NULL),
(30, 'mmm', 'mmm@gmail.com', '+2728690', '$2y$10$NORDTaswaxYzR4Fn7s0Hi.OPcOIKVM1v67k.2BYXbkkbA5knOYem6', '2007-09-22', 'female', NULL, NULL, 'customer', 'profile_images/profile_30_1758105003.jpg', '2025-09-17 16:00:03', '2025-09-17 16:00:03', NULL);

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

--
-- Dumping data for table `user_otp`
--

INSERT INTO `user_otp` (`otp_id`, `user_id`, `otp_code`, `is_verified`, `expires_at`, `created_at`) VALUES
(2, 23, '843962', 0, '2025-09-16 20:38:40', '2025-09-16 18:23:40');

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
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `store_status` enum('open','close') DEFAULT 'close'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`store_id`, `user_id`, `store_name`, `store_type`, `store_address`, `latitude`, `longitude`, `is_approved`, `logo_img`, `created_at`, `updated_at`, `store_status`) VALUES
(1, 1, 'sejal da dhaba', 'restaurant', 'jetpur', 10, 10.2, 1, 'vendors_logo/brand1.png', '2025-07-07 18:30:24', '2025-07-07 18:30:41', 'close'),
(2, 2, 'navjivan', 'restaurant', 'sxGFVTUKM', NULL, NULL, 1, NULL, '2025-08-04 17:17:33', '2025-08-04 17:18:40', 'close'),
(3, 3, 'fd', 'restaurant', 'sdev', NULL, NULL, 1, NULL, '2025-08-04 23:14:35', '2025-08-04 23:47:06', 'close'),
(4, 4, 'dwq', 'restaurant', 'wcw', NULL, NULL, 0, NULL, '2025-08-05 16:32:22', '2025-08-05 16:32:22', 'close'),
(5, 5, 'efw', 'restaurant', 'wcf', NULL, NULL, 0, NULL, '2025-08-05 17:08:08', '2025-08-05 17:08:08', 'close'),
(6, 6, 'df', 'restaurant', 'dvzfesthyju', NULL, NULL, 0, NULL, '2025-08-05 17:27:18', '2025-08-05 17:27:18', 'close'),
(7, 7, 'sdv', 'restaurant', 'svd', 22.601712666666664, 72.81760908333332, 0, NULL, '2025-08-05 17:34:50', '2025-08-05 17:34:50', 'close'),
(8, 8, 'qd', 'restaurant', 'dddddddd', 22.601712666666664, 72.81760908333332, 0, 'uploads/logos/6891f52bb361c_1754395947.jpg', '2025-08-05 17:42:27', '2025-08-05 17:42:27', 'close'),
(9, 9, 'wd', 'restaurant', 'wfcw', 22.601712666666664, 72.81760908333332, 0, 'logos/6891f64b2ea11_1754396235.jpeg', '2025-08-05 17:47:15', '2025-08-05 17:47:15', 'close'),
(10, 10, 'dcs', 'restaurant', 'sd', 22.601672474761255, 72.81767195770806, 1, 'logos/68938a15cbaeb_1754499605.jpeg', '2025-08-06 22:30:06', '2025-09-15 19:29:54', 'open'),
(11, 11, 'qdsa', 'grocery', 'ac', 22.601455011186903, 72.81822483901774, 1, '', '2025-08-06 23:48:03', '2025-09-15 23:10:51', 'open'),
(12, 12, 'wdf', 'pharmacy', 'wf', 22.601455011186903, 72.81822483901774, 1, 'logos/68939c9c93a69_1754504348.jpg', '2025-08-06 23:49:08', '2025-08-06 23:51:44', 'close'),
(13, 13, 'wf', 'restaurant', 'dwf', 32, 23, 0, 'logos/68a46c0d379ea_1755606029.jpg', '2025-08-19 17:50:29', '2025-08-19 17:50:29', 'close'),
(14, 15, 'wfe', 'restaurant', 'werf', 423, 6789, 0, 'logos/68a71a7131543_1755781745.png', '2025-08-21 18:39:05', '2025-08-21 18:39:05', 'close'),
(15, 16, 'dsc', 'grocery', 'qea', 5, 3, 1, 'logos/68a8e4c330ed9_1755899075.png', '2025-08-23 03:14:35', '2025-08-23 03:16:42', 'close'),
(16, 17, 'wkn', 'restaurant', 'few', 5255, 326, 1, 'logos/68a8e5c8a7174_1755899336.png', '2025-08-23 03:18:56', '2025-08-23 03:19:26', 'close'),
(17, 18, '12323', 'pharmacy', 'ew', 132, 32, 0, 'logos/68a8f1ffe907f_1755902463.png', '2025-08-23 04:11:04', '2025-08-23 04:11:04', 'close');

-- --------------------------------------------------------

--
-- Table structure for table `websocket_connections`
--

CREATE TABLE `websocket_connections` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `ip_address` varchar(45) NOT NULL,
  `user_agent` text DEFAULT NULL,
  `connected_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_activity` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `disconnected_at` timestamp NULL DEFAULT NULL,
  `status` enum('connected','disconnected') DEFAULT 'connected'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `websocket_connections`
--

INSERT INTO `websocket_connections` (`id`, `client_id`, `user_id`, `ip_address`, `user_agent`, `connected_at`, `last_activity`, `disconnected_at`, `status`) VALUES
(1, 1, 11, 'tcp://127.0.0.1:59240', NULL, '2025-09-02 05:52:16', '2025-09-14 21:53:40', '2025-09-14 21:53:40', 'disconnected'),
(2, 2, NULL, 'tcp://127.0.0.1:59877', NULL, '2025-09-02 05:57:33', '2025-09-14 21:53:48', '2025-09-14 21:53:48', 'disconnected'),
(3, 3, NULL, 'tcp://127.0.0.1:59902', NULL, '2025-09-02 05:57:43', '2025-09-14 21:49:19', '2025-09-14 21:49:19', 'disconnected'),
(4, 4, NULL, 'tcp://192.168.137.58:60002', NULL, '2025-09-02 05:58:46', '2025-09-14 21:50:06', '2025-09-14 21:50:06', 'disconnected'),
(5, 5, NULL, 'tcp://192.168.137.58:60072', NULL, '2025-09-02 05:59:17', '2025-09-14 21:52:46', '2025-09-14 21:52:46', 'disconnected'),
(6, 1, 11, 'tcp://172.27.190.186:65081', NULL, '2025-09-11 12:04:38', '2025-09-14 21:53:40', '2025-09-14 21:53:40', 'disconnected'),
(7, 2, NULL, 'tcp://172.27.190.186:49253', NULL, '2025-09-11 12:09:40', '2025-09-14 21:53:48', '2025-09-14 21:53:48', 'disconnected'),
(8, 3, NULL, 'tcp://172.27.190.186:49356', NULL, '2025-09-11 12:09:59', '2025-09-14 21:49:19', '2025-09-14 21:49:19', 'disconnected'),
(9, 4, NULL, 'tcp://172.27.190.186:49677', NULL, '2025-09-11 12:10:55', '2025-09-14 21:50:06', '2025-09-14 21:50:06', 'disconnected'),
(10, 5, NULL, 'tcp://172.27.190.186:49680', NULL, '2025-09-11 12:10:59', '2025-09-14 21:52:46', '2025-09-14 21:52:46', 'disconnected'),
(11, 6, 11, 'tcp://172.27.190.186:51700', NULL, '2025-09-11 12:19:51', '2025-09-14 22:03:54', '2025-09-14 22:03:54', 'disconnected'),
(12, 7, NULL, 'tcp://172.27.190.186:51773', NULL, '2025-09-11 12:20:05', '2025-09-14 22:03:37', '2025-09-14 22:03:37', 'disconnected'),
(13, 8, NULL, 'tcp://172.27.190.186:52822', NULL, '2025-09-11 12:26:39', '2025-09-14 21:20:20', '2025-09-14 21:20:20', 'disconnected'),
(14, 9, 10, 'tcp://172.27.190.186:52910', NULL, '2025-09-11 12:27:06', '2025-09-14 22:13:54', '2025-09-14 22:13:54', 'disconnected'),
(15, 10, 11, 'tcp://172.27.190.186:54153', NULL, '2025-09-11 12:32:12', '2025-09-14 22:22:58', '2025-09-14 22:22:58', 'disconnected'),
(16, 11, 11, 'tcp://172.27.190.186:54360', NULL, '2025-09-11 12:32:57', '2025-09-14 22:26:29', '2025-09-14 22:26:29', 'disconnected'),
(17, 1, 11, 'tcp', 'WebSocket Client', '2025-09-14 20:53:38', '2025-09-14 21:53:40', '2025-09-14 21:53:40', 'disconnected'),
(18, 2, NULL, 'tcp', 'WebSocket Client', '2025-09-14 20:53:52', '2025-09-14 21:53:48', '2025-09-14 21:53:48', 'disconnected'),
(19, 3, NULL, 'tcp', 'WebSocket Client', '2025-09-14 21:07:10', '2025-09-14 21:49:19', '2025-09-14 21:49:19', 'disconnected'),
(20, 4, NULL, 'tcp', 'WebSocket Client', '2025-09-14 21:07:20', '2025-09-14 21:50:06', '2025-09-14 21:50:06', 'disconnected'),
(21, 5, NULL, 'tcp', 'WebSocket Client', '2025-09-14 21:07:30', '2025-09-14 21:52:46', '2025-09-14 21:52:46', 'disconnected'),
(22, 6, 11, 'tcp', 'WebSocket Client', '2025-09-14 21:11:03', '2025-09-14 22:03:54', '2025-09-14 22:03:54', 'disconnected'),
(23, 7, NULL, 'tcp', 'WebSocket Client', '2025-09-14 21:11:21', '2025-09-14 22:03:37', '2025-09-14 22:03:37', 'disconnected'),
(24, 8, NULL, 'tcp', 'WebSocket Client', '2025-09-14 21:20:10', '2025-09-14 21:20:20', '2025-09-14 21:20:20', 'disconnected'),
(25, 1, 11, 'tcp', 'WebSocket Client', '2025-09-14 21:23:33', '2025-09-14 21:53:40', '2025-09-14 21:53:40', 'disconnected'),
(26, 2, NULL, 'tcp', 'WebSocket Client', '2025-09-14 21:26:02', '2025-09-14 21:53:48', '2025-09-14 21:53:48', 'disconnected'),
(27, 1, 11, 'tcp', 'WebSocket Client', '2025-09-14 21:43:31', '2025-09-14 21:53:40', '2025-09-14 21:53:40', 'disconnected'),
(28, 2, NULL, 'tcp', 'WebSocket Client', '2025-09-14 21:44:11', '2025-09-14 21:53:48', '2025-09-14 21:53:48', 'disconnected'),
(29, 3, NULL, 'tcp', 'WebSocket Client', '2025-09-14 21:49:09', '2025-09-14 21:49:19', '2025-09-14 21:49:19', 'disconnected'),
(30, 4, NULL, 'tcp', 'WebSocket Client', '2025-09-14 21:49:56', '2025-09-14 21:50:06', '2025-09-14 21:50:06', 'disconnected'),
(31, 5, NULL, 'tcp', 'WebSocket Client', '2025-09-14 21:52:36', '2025-09-14 21:52:46', '2025-09-14 21:52:46', 'disconnected'),
(32, 6, 11, 'tcp', 'WebSocket Client', '2025-09-14 21:53:46', '2025-09-14 22:03:54', '2025-09-14 22:03:54', 'disconnected'),
(33, 7, NULL, 'tcp', 'WebSocket Client', '2025-09-14 21:53:50', '2025-09-14 22:03:37', '2025-09-14 22:03:37', 'disconnected'),
(34, 8, NULL, 'tcp', 'WebSocket Client', '2025-09-14 22:03:39', '2025-09-14 22:03:39', NULL, 'connected'),
(35, 9, 10, 'tcp', 'WebSocket Client', '2025-09-14 22:04:02', '2025-09-14 22:13:54', '2025-09-14 22:13:54', 'disconnected'),
(36, 10, 11, 'tcp', 'WebSocket Client', '2025-09-14 22:13:57', '2025-09-14 22:22:58', '2025-09-14 22:22:58', 'disconnected'),
(37, 11, 11, 'tcp', 'WebSocket Client', '2025-09-14 22:23:02', '2025-09-14 22:26:29', '2025-09-14 22:26:29', 'disconnected'),
(38, 12, 11, 'tcp', 'WebSocket Client', '2025-09-14 22:26:33', '2025-09-14 22:37:46', '2025-09-14 22:37:46', 'disconnected'),
(39, 13, 11, 'tcp', 'WebSocket Client', '2025-09-14 22:37:50', '2025-09-14 22:37:50', NULL, 'connected');

-- --------------------------------------------------------

--
-- Table structure for table `websocket_events`
--

CREATE TABLE `websocket_events` (
  `id` int(11) NOT NULL,
  `event_type` varchar(50) NOT NULL,
  `event_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`event_data`)),
  `client_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `websocket_events`
--

INSERT INTO `websocket_events` (`id`, `event_type`, `event_data`, `client_id`, `user_id`, `created_at`) VALUES
(1, 'server_initialized', '{\"message\": \"InstaChow WebSocket Server initialized\", \"timestamp\": \"2024-01-15T10:00:00Z\", \"version\": \"1.0.0\"}', 1, NULL, '2025-09-02 05:36:22'),
(2, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-13 16:13:01'),
(3, 'order_placed', '{\"order_id\":\"85\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"ds, ds, fds, sdf - 324343\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-13 16:13:16'),
(4, 'payment_done', '{\"payment_id\":\"PAYMENT_1757779995780\",\"order_id\":\"85\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-13 16:13:16'),
(5, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-13 16:17:29'),
(6, 'order_placed', '{\"order_id\":\"86\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"fd, ds, sd, dsf - 234234\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-13 16:17:43'),
(7, 'payment_done', '{\"payment_id\":\"PAYMENT_1757780263140\",\"order_id\":\"86\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-13 16:17:43'),
(8, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-13 16:26:42'),
(9, 'order_placed', '{\"order_id\":\"87\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"cz, dz, xz, zx - 213434\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-13 16:26:59'),
(10, 'payment_done', '{\"payment_id\":\"PAYMENT_1757780819489\",\"order_id\":\"87\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-13 16:27:00'),
(11, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-13 16:54:27'),
(12, 'order_placed', '{\"order_id\":\"88\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"kj, jk, kj, kj - 999999\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-13 16:54:41'),
(13, 'payment_done', '{\"payment_id\":\"PAYMENT_1757782481591\",\"order_id\":\"88\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-13 16:54:41'),
(14, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-13 17:01:36'),
(15, 'order_placed', '{\"order_id\":\"89\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"ge, dfg, dg, df - 345535\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-13 17:01:58'),
(16, 'payment_done', '{\"payment_id\":\"PAYMENT_1757782918877\",\"order_id\":\"89\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-13 17:01:59'),
(17, 'new_product', '{\"product_id\":\"58\",\"product_name\":\"dssv\",\"price\":435,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"[]\",\"additional_data\":{\"quantity\":1,\"total_price\":401,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":401,\"has_discount\":true,\"discount_type\":\"fixed\",\"discount_amount\":34}}', 1, 19, '2025-09-13 17:04:13'),
(18, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-13 17:04:27'),
(19, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-13 17:04:27'),
(20, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 16:37:18'),
(21, 'order_placed', '{\"order_id\":\"92\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"as, as, as, as - 324343\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 16:37:30'),
(22, 'payment_done', '{\"payment_id\":\"PAYMENT_1757867850427\",\"order_id\":\"92\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 16:37:30'),
(23, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 16:46:45'),
(24, 'order_placed', '{\"order_id\":\"93\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"fds, sd, ds, sdf - 243423\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 16:46:58'),
(25, 'payment_done', '{\"payment_id\":\"PAYMENT_1757868418551\",\"order_id\":\"93\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 16:46:58'),
(26, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 16:55:02'),
(27, 'order_placed', '{\"order_id\":\"94\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"ad, das, das, sda - 324234\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 16:55:16'),
(28, 'payment_done', '{\"payment_id\":\"PAYMENT_1757868916560\",\"order_id\":\"94\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 16:55:17'),
(29, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 17:03:56'),
(30, 'order_placed', '{\"order_id\":\"95\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"sdf, sd, dsf, sdf - 342343\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 17:04:12'),
(31, 'payment_done', '{\"payment_id\":\"PAYMENT_1757869452701\",\"order_id\":\"95\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 17:04:12'),
(32, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 17:13:13'),
(33, 'order_placed', '{\"order_id\":\"96\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"vfd, df, dg, gd - 423234\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 17:13:27'),
(34, 'payment_done', '{\"payment_id\":\"PAYMENT_1757870007577\",\"order_id\":\"96\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 17:13:27'),
(35, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 17:27:33'),
(36, 'order_placed', '{\"order_id\":\"97\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"sdf, dsf, sd, sdf - 324432\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 17:27:50'),
(37, 'payment_done', '{\"payment_id\":\"PAYMENT_1757870870834\",\"order_id\":\"97\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 17:27:50'),
(38, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 19:00:27'),
(39, 'order_placed', '{\"order_id\":\"98\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"sad, dsa, ads, ads - 324234\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 19:00:40'),
(40, 'payment_done', '{\"payment_id\":\"PAYMENT_1757876440224\",\"order_id\":\"98\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 19:00:40'),
(41, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 19:34:07'),
(42, 'order_placed', '{\"order_id\":\"99\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"dg, dfg, dfg, df - 536545\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 19:34:23'),
(43, 'payment_done', '{\"payment_id\":\"PAYMENT_1757878463784\",\"order_id\":\"99\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 19:34:24'),
(44, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 19:39:26'),
(45, 'order_placed', '{\"order_id\":\"100\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"asd, dsa, ads, sa - 324324\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 19:39:40'),
(46, 'payment_done', '{\"payment_id\":\"PAYMENT_1757878780191\",\"order_id\":\"100\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 19:39:40'),
(47, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 19:50:08'),
(48, 'order_placed', '{\"order_id\":\"101\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"xb, vcx, vcx, vcxc - 453345\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 19:50:31'),
(49, 'payment_done', '{\"payment_id\":\"PAYMENT_1757879431297\",\"order_id\":\"101\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 19:50:31'),
(50, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 20:02:30'),
(51, 'order_placed', '{\"order_id\":\"1004\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"dg, fd, fgd, fdg - 345345\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 20:09:55'),
(52, 'payment_done', '{\"payment_id\":\"PAYMENT_1757880595609\",\"order_id\":\"1004\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 20:09:55'),
(53, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 20:24:49'),
(54, 'order_placed', '{\"order_id\":\"1005\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"ca, zc, xz, xc - 234423\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 20:25:06'),
(55, 'payment_done', '{\"payment_id\":\"PAYMENT_1757881506836\",\"order_id\":\"1005\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 20:25:07'),
(56, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 20:38:32'),
(57, 'order_placed', '{\"order_id\":\"1006\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"sad, sd, as, dsa - 124324\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 20:38:45'),
(58, 'payment_done', '{\"payment_id\":\"PAYMENT_1757882325607\",\"order_id\":\"1006\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 20:38:45'),
(59, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 20:41:46'),
(60, 'order_placed', '{\"order_id\":\"1007\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"ds, cv, cxz, cx - 454534\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 20:42:10'),
(61, 'payment_done', '{\"payment_id\":\"PAYMENT_1757882530145\",\"order_id\":\"1007\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 20:42:10'),
(62, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 20:43:11'),
(63, 'order_placed', '{\"order_id\":\"1008\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"dsa, sda, dsa, asdads - 234234\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 20:43:26'),
(64, 'payment_done', '{\"payment_id\":\"PAYMENT_1757882606495\",\"order_id\":\"1008\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 20:43:26'),
(65, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 20:58:32'),
(66, 'order_placed', '{\"order_id\":\"1009\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"sa, ds, as, sad - 342342\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 20:58:51'),
(67, 'new_order_notification', '{\"order_id\":1009,\"total_amount\":2,\"delivery_address\":\"sa, ds, as, sad - 342342\",\"user_id\":\"19\",\"message\":\"New order #1009 received!\",\"timestamp\":\"2025-09-14T22:58:51Z\",\"notified_vendor_id\":11,\"notification_type\":\"new_order_notification\"}', 1, 11, '2025-09-14 20:58:51'),
(68, 'payment_done', '{\"payment_id\":\"PAYMENT_1757883531260\",\"order_id\":\"1009\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 20:58:51'),
(69, 'payment_received_notification', '{\"order_id\":1009,\"payment_id\":\"PAYMENT_1757883531260\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"message\":\"Payment received for order #1009!\",\"timestamp\":\"2025-09-14T22:58:51Z\",\"notified_vendor_id\":11,\"notification_type\":\"payment_received_notification\"}', 1, 11, '2025-09-14 20:58:51'),
(70, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 20:59:32'),
(71, 'order_placed', '{\"order_id\":\"1010\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"dfs, ds, ds, ds - 342343\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 20:59:45'),
(72, 'new_order_notification', '{\"order_id\":1010,\"total_amount\":2,\"delivery_address\":\"dfs, ds, ds, ds - 342343\",\"user_id\":\"19\",\"message\":\"New order #1010 received!\",\"timestamp\":\"2025-09-14T22:59:45Z\",\"notified_vendor_id\":11,\"notification_type\":\"new_order_notification\"}', 1, 11, '2025-09-14 20:59:45'),
(73, 'payment_done', '{\"payment_id\":\"PAYMENT_1757883585414\",\"order_id\":\"1010\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 20:59:45'),
(74, 'payment_received_notification', '{\"order_id\":1010,\"payment_id\":\"PAYMENT_1757883585414\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"message\":\"Payment received for order #1010!\",\"timestamp\":\"2025-09-14T22:59:45Z\",\"notified_vendor_id\":11,\"notification_type\":\"payment_received_notification\"}', 1, 11, '2025-09-14 20:59:45'),
(75, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 21:00:37'),
(76, 'order_placed', '{\"order_id\":\"1011\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"sad, dsa, ads, ads - 234343\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 21:00:57'),
(77, 'new_order_notification', '{\"order_id\":1011,\"total_amount\":2,\"delivery_address\":\"sad, dsa, ads, ads - 234343\",\"user_id\":\"19\",\"message\":\"New order #1011 received!\",\"timestamp\":\"2025-09-14T23:00:57Z\",\"notified_vendor_id\":11,\"notification_type\":\"new_order_notification\"}', 1, 11, '2025-09-14 21:00:58'),
(78, 'payment_done', '{\"payment_id\":\"PAYMENT_1757883657972\",\"order_id\":\"1011\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 21:00:58'),
(79, 'payment_received_notification', '{\"order_id\":1011,\"payment_id\":\"PAYMENT_1757883657972\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"message\":\"Payment received for order #1011!\",\"timestamp\":\"2025-09-14T23:00:58Z\",\"notified_vendor_id\":11,\"notification_type\":\"payment_received_notification\"}', 1, 11, '2025-09-14 21:00:58'),
(80, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 21:12:38'),
(81, 'order_placed', '{\"order_id\":\"1012\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"vc, gfb, f, f - 566554\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 21:12:52'),
(82, 'new_order_notification', '{\"order_id\":1012,\"total_amount\":2,\"delivery_address\":\"vc, gfb, f, f - 566554\",\"user_id\":\"19\",\"message\":\"New order #1012 received!\",\"timestamp\":\"2025-09-14T23:12:52Z\",\"notified_vendor_id\":11,\"notification_type\":\"new_order_notification\"}', 6, 11, '2025-09-14 21:12:52'),
(83, 'payment_done', '{\"payment_id\":\"PAYMENT_1757884372782\",\"order_id\":\"1012\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 21:12:53'),
(84, 'payment_received_notification', '{\"order_id\":1012,\"payment_id\":\"PAYMENT_1757884372782\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"message\":\"Payment received for order #1012!\",\"timestamp\":\"2025-09-14T23:12:53Z\",\"notified_vendor_id\":11,\"notification_type\":\"payment_received_notification\"}', 6, 11, '2025-09-14 21:12:53'),
(85, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 21:23:33'),
(86, 'order_placed', '{\"order_id\":\"1013\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"f, f, f, f - 435435\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 21:23:51'),
(87, 'payment_done', '{\"payment_id\":\"PAYMENT_1757885030985\",\"order_id\":\"1013\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 21:23:51'),
(88, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 21:44:42'),
(89, 'order_placed', '{\"order_id\":\"1015\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"sa, ds, ss, s - 324243\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 21:44:57'),
(90, 'new_order_notification', '{\"order_id\":1015,\"total_amount\":2,\"delivery_address\":\"sa, ds, ss, s - 324243\",\"user_id\":\"19\",\"message\":\"New order #1015 received!\",\"timestamp\":\"2025-09-14T23:44:57Z\",\"notified_vendor_id\":11,\"notification_type\":\"new_order_notification\"}', 1, 11, '2025-09-14 21:44:57'),
(91, 'payment_done', '{\"payment_id\":\"PAYMENT_1757886297187\",\"order_id\":\"1015\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 21:44:57'),
(92, 'payment_received_notification', '{\"order_id\":1015,\"payment_id\":\"PAYMENT_1757886297187\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"message\":\"Payment received for order #1015!\",\"timestamp\":\"2025-09-14T23:44:57Z\",\"notified_vendor_id\":11,\"notification_type\":\"payment_received_notification\"}', 1, 11, '2025-09-14 21:44:57'),
(93, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 21:54:06'),
(94, 'order_placed', '{\"order_id\":\"1016\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"fds, dsf, dsf, sdf - 425423\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 21:54:25'),
(95, 'new_order_notification', '{\"order_id\":1016,\"total_amount\":2,\"delivery_address\":\"fds, dsf, dsf, sdf - 425423\",\"user_id\":\"19\",\"message\":\"New order #1016 received!\",\"timestamp\":\"2025-09-14T23:54:25Z\",\"notified_vendor_id\":11,\"notification_type\":\"new_order_notification\"}', 6, 11, '2025-09-14 21:54:25'),
(96, 'payment_done', '{\"payment_id\":\"PAYMENT_1757886865684\",\"order_id\":\"1016\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 21:54:25'),
(97, 'payment_received_notification', '{\"order_id\":1016,\"payment_id\":\"PAYMENT_1757886865684\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"message\":\"Payment received for order #1016!\",\"timestamp\":\"2025-09-14T23:54:26Z\",\"notified_vendor_id\":11,\"notification_type\":\"payment_received_notification\"}', 6, 11, '2025-09-14 21:54:26'),
(98, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 21:55:09'),
(99, 'order_placed', '{\"order_id\":\"1017\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"t, df, df, fd - 435544\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 21:55:20'),
(100, 'new_order_notification', '{\"order_id\":1017,\"total_amount\":2,\"delivery_address\":\"t, df, df, fd - 435544\",\"user_id\":\"19\",\"message\":\"New order #1017 received!\",\"timestamp\":\"2025-09-14T23:55:21Z\",\"notified_vendor_id\":11,\"notification_type\":\"new_order_notification\"}', 6, 11, '2025-09-14 21:55:21'),
(101, 'payment_done', '{\"payment_id\":\"PAYMENT_1757886920851\",\"order_id\":\"1017\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 21:55:21'),
(102, 'payment_received_notification', '{\"order_id\":1017,\"payment_id\":\"PAYMENT_1757886920851\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"message\":\"Payment received for order #1017!\",\"timestamp\":\"2025-09-14T23:55:21Z\",\"notified_vendor_id\":11,\"notification_type\":\"payment_received_notification\"}', 6, 11, '2025-09-14 21:55:21'),
(103, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 22:04:19'),
(104, 'order_placed', '{\"order_id\":\"1018\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"d, d, d, d - 342342\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 22:04:44'),
(105, 'payment_done', '{\"payment_id\":\"PAYMENT_1757887484912\",\"order_id\":\"1018\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 22:04:45'),
(106, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 22:05:21'),
(107, 'order_placed', '{\"order_id\":\"1019\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"hgf, ghd, dgh, f - 654665\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 22:05:34'),
(108, 'payment_done', '{\"payment_id\":\"PAYMENT_1757887534298\",\"order_id\":\"1019\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 22:05:34'),
(109, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 22:06:34'),
(110, 'order_placed', '{\"order_id\":\"1020\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"j, j, j, j - 688788\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 22:06:51'),
(111, 'payment_done', '{\"payment_id\":\"PAYMENT_1757887611144\",\"order_id\":\"1020\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 22:06:51'),
(112, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 22:14:24'),
(113, 'order_placed', '{\"order_id\":\"1021\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"sdv, sv, dsv, sdv - 435454\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 22:14:54'),
(114, 'new_order_notification', '{\"order_id\":1021,\"total_amount\":2,\"delivery_address\":\"sdv, sv, dsv, sdv - 435454\",\"user_id\":\"19\",\"message\":\"New order #1021 received!\",\"timestamp\":\"2025-09-15T00:14:54Z\",\"notified_vendor_id\":11,\"notification_type\":\"new_order_notification\"}', 10, 11, '2025-09-14 22:14:54'),
(115, 'payment_done', '{\"payment_id\":\"PAYMENT_1757888094360\",\"order_id\":\"1021\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 22:14:54'),
(116, 'payment_received_notification', '{\"order_id\":1021,\"payment_id\":\"PAYMENT_1757888094360\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"message\":\"Payment received for order #1021!\",\"timestamp\":\"2025-09-15T00:14:54Z\",\"notified_vendor_id\":11,\"notification_type\":\"payment_received_notification\"}', 10, 11, '2025-09-14 22:14:54'),
(117, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 22:23:21'),
(118, 'order_placed', '{\"order_id\":\"1022\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"fdg, fdg, dfg, fd - 435435\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 22:23:33'),
(119, 'new_order_notification', '{\"order_id\":1022,\"total_amount\":2,\"delivery_address\":\"fdg, fdg, dfg, fd - 435435\",\"user_id\":\"19\",\"message\":\"New order #1022 received!\",\"timestamp\":\"2025-09-15T00:23:33Z\",\"notified_vendor_id\":11,\"notification_type\":\"new_order_notification\"}', 11, 11, '2025-09-14 22:23:33'),
(120, 'payment_done', '{\"payment_id\":\"PAYMENT_1757888613464\",\"order_id\":\"1022\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 22:23:33'),
(121, 'payment_received_notification', '{\"order_id\":1022,\"payment_id\":\"PAYMENT_1757888613464\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"message\":\"Payment received for order #1022!\",\"timestamp\":\"2025-09-15T00:23:33Z\",\"notified_vendor_id\":11,\"notification_type\":\"payment_received_notification\"}', 11, 11, '2025-09-14 22:23:33'),
(122, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 22:26:45'),
(123, 'order_placed', '{\"order_id\":\"1023\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"c, c, c, c - 435345\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 22:26:58'),
(124, 'new_order_notification', '{\"order_id\":1023,\"total_amount\":2,\"delivery_address\":\"c, c, c, c - 435345\",\"user_id\":\"19\",\"message\":\"New order #1023 received!\",\"timestamp\":\"2025-09-15T00:26:58Z\",\"notified_vendor_id\":11,\"notification_type\":\"new_order_notification\"}', 12, 11, '2025-09-14 22:26:58'),
(125, 'payment_done', '{\"payment_id\":\"PAYMENT_1757888818091\",\"order_id\":\"1023\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 22:26:58'),
(126, 'payment_received_notification', '{\"order_id\":1023,\"payment_id\":\"PAYMENT_1757888818091\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"message\":\"Payment received for order #1023!\",\"timestamp\":\"2025-09-15T00:26:58Z\",\"notified_vendor_id\":11,\"notification_type\":\"payment_received_notification\"}', 12, 11, '2025-09-14 22:26:58'),
(127, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 22:28:06'),
(128, 'order_placed', '{\"order_id\":\"1024\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"g, g, g, g - 262655\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 22:28:24'),
(129, 'new_order_notification', '{\"order_id\":1024,\"total_amount\":2,\"delivery_address\":\"g, g, g, g - 262655\",\"user_id\":\"19\",\"message\":\"New order #1024 received!\",\"timestamp\":\"2025-09-15T00:28:24Z\",\"notified_vendor_id\":11,\"notification_type\":\"new_order_notification\"}', 12, 11, '2025-09-14 22:28:24'),
(130, 'payment_done', '{\"payment_id\":\"PAYMENT_1757888904148\",\"order_id\":\"1024\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 22:28:24'),
(131, 'payment_received_notification', '{\"order_id\":1024,\"payment_id\":\"PAYMENT_1757888904148\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"message\":\"Payment received for order #1024!\",\"timestamp\":\"2025-09-15T00:28:24Z\",\"notified_vendor_id\":11,\"notification_type\":\"payment_received_notification\"}', 12, 11, '2025-09-14 22:28:24'),
(132, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 22:29:06'),
(133, 'order_placed', '{\"order_id\":\"1025\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"c, x, x, x - 324234\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 22:29:22'),
(134, 'new_order_notification', '{\"order_id\":1025,\"total_amount\":2,\"delivery_address\":\"c, x, x, x - 324234\",\"user_id\":\"19\",\"message\":\"New order #1025 received!\",\"timestamp\":\"2025-09-15T00:29:22Z\",\"notified_vendor_id\":11,\"notification_type\":\"new_order_notification\"}', 12, 11, '2025-09-14 22:29:22'),
(135, 'payment_done', '{\"payment_id\":\"PAYMENT_1757888962333\",\"order_id\":\"1025\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 22:29:22');
INSERT INTO `websocket_events` (`id`, `event_type`, `event_data`, `client_id`, `user_id`, `created_at`) VALUES
(136, 'payment_received_notification', '{\"order_id\":1025,\"payment_id\":\"PAYMENT_1757888962333\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"message\":\"Payment received for order #1025!\",\"timestamp\":\"2025-09-15T00:29:22Z\",\"notified_vendor_id\":11,\"notification_type\":\"payment_received_notification\"}', 12, 11, '2025-09-14 22:29:22'),
(137, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 22:30:02'),
(138, 'order_placed', '{\"order_id\":\"1026\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"df, f, f, f - 345543\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 22:30:16'),
(139, 'new_order_notification', '{\"order_id\":1026,\"total_amount\":2,\"delivery_address\":\"df, f, f, f - 345543\",\"user_id\":\"19\",\"message\":\"New order #1026 received!\",\"timestamp\":\"2025-09-15T00:30:16Z\",\"notified_vendor_id\":11,\"notification_type\":\"new_order_notification\"}', 12, 11, '2025-09-14 22:30:16'),
(140, 'payment_done', '{\"payment_id\":\"PAYMENT_1757889016377\",\"order_id\":\"1026\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 22:30:16'),
(141, 'payment_received_notification', '{\"order_id\":1026,\"payment_id\":\"PAYMENT_1757889016377\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"message\":\"Payment received for order #1026!\",\"timestamp\":\"2025-09-15T00:30:16Z\",\"notified_vendor_id\":11,\"notification_type\":\"payment_received_notification\"}', 12, 11, '2025-09-14 22:30:16'),
(142, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 22:38:17'),
(143, 'order_placed', '{\"order_id\":\"1027\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"v, c, c, c - 435354\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 22:38:33'),
(144, 'new_order_notification', '{\"order_id\":1027,\"total_amount\":2,\"delivery_address\":\"v, c, c, c - 435354\",\"user_id\":\"19\",\"message\":\"New order #1027 received!\",\"timestamp\":\"2025-09-15T00:38:33Z\",\"notified_vendor_id\":11,\"notification_type\":\"new_order_notification\"}', 13, 11, '2025-09-14 22:38:33'),
(145, 'payment_done', '{\"payment_id\":\"PAYMENT_1757889513197\",\"order_id\":\"1027\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 22:38:33'),
(146, 'payment_received_notification', '{\"order_id\":1027,\"payment_id\":\"PAYMENT_1757889513197\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"message\":\"Payment received for order #1027!\",\"timestamp\":\"2025-09-15T00:38:33Z\",\"notified_vendor_id\":11,\"notification_type\":\"payment_received_notification\"}', 13, 11, '2025-09-14 22:38:33'),
(147, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 22:39:59'),
(148, 'order_placed', '{\"order_id\":\"1028\",\"user_id\":\"19\",\"total_amount\":2,\"items\":[{\"product_id\":96,\"name\":\"elaichi\",\"quantity\":1,\"price\":2,\"total_price\":2,\"addons\":null}],\"delivery_address\":\"k, kk, k, k - 545454\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 22:40:15'),
(149, 'new_order_notification', '{\"order_id\":1028,\"total_amount\":2,\"delivery_address\":\"k, kk, k, k - 545454\",\"user_id\":\"19\",\"message\":\"New order #1028 received!\",\"timestamp\":\"2025-09-15T00:40:15Z\",\"notified_vendor_id\":11,\"notification_type\":\"new_order_notification\"}', 13, 11, '2025-09-14 22:40:15'),
(150, 'payment_done', '{\"payment_id\":\"PAYMENT_1757889614984\",\"order_id\":\"1028\",\"user_id\":\"19\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"status\":\"completed\",\"additional_data\":{\"cart_item_count\":1,\"subtotal\":2,\"total_discount\":0,\"coupon_discount\":0,\"coupon_code\":null}}', 1, 19, '2025-09-14 22:40:15'),
(151, 'payment_received_notification', '{\"order_id\":1028,\"payment_id\":\"PAYMENT_1757889614984\",\"amount\":2,\"payment_method\":\"cash_on_delivery\",\"message\":\"Payment received for order #1028!\",\"timestamp\":\"2025-09-15T00:40:15Z\",\"notified_vendor_id\":11,\"notification_type\":\"payment_received_notification\"}', 13, 11, '2025-09-14 22:40:15'),
(152, 'new_product', '{\"product_id\":\"96\",\"product_name\":\"elaichi\",\"price\":2,\"category\":\"Cart Item\",\"user_id\":\"19\",\"image_url\":\"grocery_1757735554_0.jpg]\",\"additional_data\":{\"quantity\":1,\"total_price\":2,\"addons\":null,\"cart_item_id\":0,\"discounted_price\":2,\"has_discount\":true,\"discount_type\":\"\",\"discount_amount\":0}}', 1, 19, '2025-09-14 22:40:41');

-- --------------------------------------------------------

--
-- Table structure for table `websocket_order_activity`
--

CREATE TABLE `websocket_order_activity` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `activity_type` enum('order_placed','order_confirmed','order_preparing','order_ready','order_delivered','order_cancelled') DEFAULT 'order_placed',
  `total_amount` decimal(10,2) NOT NULL,
  `item_count` int(11) DEFAULT 0,
  `delivery_address` text DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `websocket_payment_activity`
--

CREATE TABLE `websocket_payment_activity` (
  `id` int(11) NOT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `activity_type` enum('payment_initiated','payment_completed','payment_failed','payment_refunded') DEFAULT 'payment_initiated',
  `amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `transaction_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `websocket_product_activity`
--

CREATE TABLE `websocket_product_activity` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cart_item_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT 1,
  `price` decimal(10,2) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `activity_type` enum('added_to_cart','removed_from_cart','quantity_changed') DEFAULT 'added_to_cart',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `websocket_realtime_stats`
-- (See below for the actual view)
--
CREATE TABLE `websocket_realtime_stats` (
);

-- --------------------------------------------------------

--
-- Table structure for table `websocket_user_activity`
--
-- Error reading structure for table instachow.websocket_user_activity: #1932 - Table &#039;instachow.websocket_user_activity&#039; doesn&#039;t exist in engine
-- Error reading data for table instachow.websocket_user_activity: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `instachow`.`websocket_user_activity`&#039; at line 1

-- --------------------------------------------------------

--
-- Structure for view `websocket_realtime_stats`
--
DROP TABLE IF EXISTS `websocket_realtime_stats`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `websocket_realtime_stats`  AS SELECT (select count(0) from `websocket_events` where cast(`websocket_events`.`created_at` as date) = curdate()) AS `websocket_events_today`, (select count(0) from `websocket_connections` where `websocket_connections`.`status` = 'connected') AS `active_connections`, (select count(0) from `websocket_user_activity` where `websocket_user_activity`.`activity_type` = 'online' and cast(`websocket_user_activity`.`created_at` as date) = curdate()) AS `users_online_today`, (select count(0) from `websocket_product_activity` where `websocket_product_activity`.`activity_type` = 'added_to_cart' and cast(`websocket_product_activity`.`created_at` as date) = curdate()) AS `products_added_today`, (select count(0) from `orders` where cast(`orders`.`created_at` as date) = curdate()) AS `orders_today`, (select coalesce(sum(`orders`.`total_amount`),0) from `orders` where cast(`orders`.`created_at` as date) = curdate()) AS `revenue_today`, (select count(0) from `payfast_payments` where `payfast_payments`.`payment_status` = 'COMPLETE' and cast(`payfast_payments`.`created_at` as date) = curdate()) AS `payments_completed_today`, (select coalesce(sum(`payfast_payments`.`amount_gross`),0) from `payfast_payments` where `payfast_payments`.`payment_status` = 'COMPLETE' and cast(`payfast_payments`.`created_at` as date) = curdate()) AS `payments_amount_today`, (select count(0) from `users` where cast(`users`.`created_at` as date) = curdate()) AS `new_users_today`, (select count(0) from `users`) AS `active_users_total` ;

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
  ADD KEY `delivery_partner_id` (`delivery_partner_id`);

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
-- Indexes for table `websocket_connections`
--
ALTER TABLE `websocket_connections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_client_id` (`client_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_connected_at` (`connected_at`);

--
-- Indexes for table `websocket_events`
--
ALTER TABLE `websocket_events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_event_type` (`event_type`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_client_id` (`client_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_websocket_events_composite` (`event_type`,`created_at`,`user_id`);

--
-- Indexes for table `websocket_order_activity`
--
ALTER TABLE `websocket_order_activity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order_id` (`order_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_activity_type` (`activity_type`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_websocket_order_activity_composite` (`user_id`,`activity_type`,`created_at`),
  ADD KEY `idx_vendor_id` (`vendor_id`);

--
-- Indexes for table `websocket_payment_activity`
--
ALTER TABLE `websocket_payment_activity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_payment_id` (`payment_id`),
  ADD KEY `idx_order_id` (`order_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_activity_type` (`activity_type`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_websocket_payment_activity_composite` (`user_id`,`activity_type`,`created_at`),
  ADD KEY `idx_vendor_id` (`vendor_id`);

--
-- Indexes for table `websocket_product_activity`
--
ALTER TABLE `websocket_product_activity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_product_id` (`product_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_cart_item_id` (`cart_item_id`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_activity_type` (`activity_type`),
  ADD KEY `idx_websocket_product_activity_composite` (`user_id`,`activity_type`,`created_at`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addons`
--
ALTER TABLE `addons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `addon_options`
--
ALTER TABLE `addon_options`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `admin_logs`
--
ALTER TABLE `admin_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `allergen_master`
--
ALTER TABLE `allergen_master`
  MODIFY `allergen_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=143;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `cart_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=232;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `coupon_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `coupon_usages`
--
ALTER TABLE `coupon_usages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  MODIFY `maste_cat_food_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nutrition_master`
--
ALTER TABLE `nutrition_master`
  MODIFY `nutrition_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `offers`
--
ALTER TABLE `offers`
  MODIFY `offer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1068;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_items_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=171;

--
-- AUTO_INCREMENT for table `payfast_payments`
--
ALTER TABLE `payfast_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT for table `product_allergens`
--
ALTER TABLE `product_allergens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `product_nutritions`
--
ALTER TABLE `product_nutritions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sub_categories`
--
ALTER TABLE `sub_categories`
  MODIFY `categories_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `user_otp`
--
ALTER TABLE `user_otp`
  MODIFY `otp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `store_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `websocket_connections`
--
ALTER TABLE `websocket_connections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `websocket_events`
--
ALTER TABLE `websocket_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=153;

--
-- AUTO_INCREMENT for table `websocket_order_activity`
--
ALTER TABLE `websocket_order_activity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `websocket_payment_activity`
--
ALTER TABLE `websocket_payment_activity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `websocket_product_activity`
--
ALTER TABLE `websocket_product_activity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

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

--
-- Constraints for table `websocket_connections`
--
ALTER TABLE `websocket_connections`
  ADD CONSTRAINT `websocket_connections_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `websocket_events`
--
ALTER TABLE `websocket_events`
  ADD CONSTRAINT `fk_ws_event_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `websocket_order_activity`
--
ALTER TABLE `websocket_order_activity`
  ADD CONSTRAINT `fk_ws_order_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ws_order_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `websocket_payment_activity`
--
ALTER TABLE `websocket_payment_activity`
  ADD CONSTRAINT `fk_ws_payment_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ws_payment_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `websocket_product_activity`
--
ALTER TABLE `websocket_product_activity`
  ADD CONSTRAINT `fk_ws_prod_cart` FOREIGN KEY (`cart_item_id`) REFERENCES `cart_items` (`cart_item_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_ws_prod_prod` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ws_prod_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
