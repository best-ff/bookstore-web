-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th9 03, 2024 lúc 04:55 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `dtb_bookstore`
--
CREATE DATABASE IF NOT EXISTS `.v.c` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `dtb_bookstore`;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tb_cart`
--

DROP TABLE IF EXISTS `tb_cart`;
CREATE TABLE IF NOT EXISTS `tb_cart` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quantity` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `product` int(11) NOT NULL,
  `user` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tb_cart_product_175976cc_fk_tb_product_product_id` (`product`),
  KEY `tb_cart_user_89053dc8_fk_tb_user_user_name` (`user`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Bẫy `tb_cart`
--
DROP TRIGGER IF EXISTS `tg_insert_cart_price`;
DELIMITER $$
CREATE TRIGGER `tg_insert_cart_price` BEFORE INSERT ON `tb_cart` FOR EACH ROW BEGIN
    DECLARE tg_price DECIMAL(10, 2);
    SELECT discount_price INTO tg_price FROM tb_product WHERE product_id = NEW.product;
    IF tg_price IS NOT NULL THEN
        SET NEW.total = tg_price * NEW.quantity;    
    END IF;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `tg_update_cart_price`;
DELIMITER $$
CREATE TRIGGER `tg_update_cart_price` BEFORE UPDATE ON `tb_cart` FOR EACH ROW BEGIN
    DECLARE tg_price DECIMAL(10, 2);
    IF NEW.product IS NOT NULL AND NEW.quantity IS NOT NULL THEN
        SELECT discount_price INTO tg_price FROM tb_product WHERE product_id = NEW.product;
        IF tg_price IS NOT NULL THEN
            SET NEW.total = tg_price * NEW.quantity;
        END IF;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tb_product`
--

DROP TABLE IF EXISTS `tb_product`;
CREATE TABLE IF NOT EXISTS `tb_product` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) NOT NULL,
  `star_rating` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `short_description` longtext NOT NULL,
  `detailed_description` longtext NOT NULL,
  `ingredients` longtext NOT NULL,
  `regular_price` decimal(10,2) NOT NULL,
  `discount_price` decimal(10,2) NOT NULL,
  `image_url` varchar(200) NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tb_product`
--

INSERT INTO `tb_product` (`product_id`, `product_name`, `star_rating`, `quantity`, `short_description`, `detailed_description`, `ingredients`, `regular_price`, `discount_price`, `image_url`) VALUES
(1, 'Life Skills Book', 4, 10, 'This book provides important life skills to succeed in everyday life.', 'This book helps you develop time management, communication, and problem-solving skills.', 'Paper, ink, and more', 20.00, 15.00, 'img/product-large-1.png'),
(2, 'Career Success', 5, 15, 'This book provides effective strategies to achieve career goals.', 'The author shares experiences and secrets to advance in your career.', 'Paper, ink, and more', 25.00, 20.00, 'img/product-large-2.png'),
(3, 'My Book', 3, 8, 'This is my book about life experiences.', 'I share stories and lessons from my life.', 'Paper, ink, and more', 30.00, 25.00, 'img/product-large-3.png'),
(4, 'Leadership Skills', 2, 20, 'This book helps you develop leadership skills to lead a successful team.', 'Learn to shape a positive work environment and motivate your team.', 'Paper, ink, and more', 35.00, 30.00, 'img/product-large-1.png'),
(5, 'Python Guide Book', 4, 12, 'This book provides detailed guidance on Python programming from basics to advanced.', 'Learn to write efficient Python code and create software applications.', 'Paper, ink, and more', 40.00, 35.00, 'img/product-large-2.png'),
(6, 'My Heart', 3, 8, 'This is my book about life experiences.', 'I share stories and lessons from my life.', 'Paper, ink, and more', 30.00, 25.00, 'img/product-large-3.png'),
(7, 'Life Skills Book', 4, 10, 'This book provides important life skills to succeed in everyday life.', 'This book helps you develop time management, communication, and problem-solving skills.', 'Paper, ink, and more', 20.00, 15.00, 'img/product-large-1.png'),
(8, 'Career Success', 5, 15, 'This book provides effective strategies to achieve career goals.', 'The author shares experiences and secrets to advance in your career.', 'Paper, ink, and more', 25.00, 20.00, 'img/product-large-2.png'),
(9, 'My Book', 3, 8, 'This is my book about life experiences.', 'I share stories and lessons from my life.', 'Paper, ink, and more', 30.00, 25.00, 'img/product-large-3.png'),
(10, 'Leadership Skills', 2, 20, 'This book helps you develop leadership skills to lead a successful team.', 'Learn to shape a positive work environment and motivate your team.', 'Paper, ink, and more', 35.00, 30.00, 'img/product-large-1.png'),
(11, 'Python Guide Book', 4, 12, 'This book provides detailed guidance on Python programming from basics to advanced.', 'Learn to write efficient Python code and create software applications.', 'Paper, ink, and more', 40.00, 35.00, 'img/product-large-2.png'),
(12, 'My Heart', 3, 8, 'This is my book about life experiences.', 'I share stories and lessons from my life.', 'Paper, ink, and more', 30.00, 25.00, 'img/product-large-3.png');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tb_user`
--

DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE IF NOT EXISTS `tb_user` (
  `user_name` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobile_no` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tb_user`
--

INSERT INTO `tb_user` (`user_name`, `password`, `first_name`, `last_name`, `email`, `mobile_no`) VALUES
('abc', '123', '', '', '', NULL),
('z', 'x', '', '', '', NULL);

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `tb_cart`
--
ALTER TABLE `tb_cart`
  ADD CONSTRAINT `tb_cart_product_175976cc_fk_tb_product_product_id` FOREIGN KEY (`product`) REFERENCES `tb_product` (`product_id`),
  ADD CONSTRAINT `tb_cart_user_89053dc8_fk_tb_user_user_name` FOREIGN KEY (`user`) REFERENCES `tb_user` (`user_name`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
