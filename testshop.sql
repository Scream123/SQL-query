SET
SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET
time_zone = "+00:00";

-- Database: `testhop`
CREATE
DATABASE IF NOT EXISTS `testshop`



-- Table structure `categories`
CREATE TABLE IF NOT EXISTS `categories`
(
    `id` int
(
    11
) NOT NULL,
    `name` varchar
(
    300
) COLLATE utf8mb4_unicode_ci NOT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE =utf8mb4_unicode_ci;


INSERT INTO `categories` (`id`, `name`)
VALUES (1, 'mobile'),
       (2, 'computer');

-- Table structure `categories_products`


CREATE TABLE IF NOT EXISTS `categories_products`
(
    `id` int
(
    11
) NOT NULL,
    `product_id` int
(
    11
) NOT NULL,
    `category_id` int
(
    11
) NOT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE =utf8mb4_unicode_ci;


INSERT INTO `categories_products` (`id`, `product_id`, `category_id`)
VALUES (1, 2, 2),
       (2, 1, 1);


-- Table structure `orders`
CREATE TABLE IF NOT EXISTS `orders`
(
    `id` int
(
    11
) NOT NULL,
    `name` varchar
(
    300
) COLLATE utf8mb4_unicode_ci NOT NULL,
    `description` date NOT NULL,
    `created_at` varchar
(
    250
) COLLATE utf8mb4_unicode_ci NOT NULL,
    `updated_at` varchar
(
    250
) COLLATE utf8mb4_unicode_ci NOT NULL,
    `status` tinyint
(
    4
) NOT NULL DEFAULT '1',
    `user_id` int
(
    11
) NOT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE =utf8mb4_unicode_ci;

-- Table structure `products`
CREATE TABLE IF NOT EXISTS `products`
(
    `id` int
(
    11
) NOT NULL,
    `name` varchar
(
    300
) COLLATE utf8mb4_unicode_ci NOT NULL,
    `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
    `price` float NOT NULL,
    `image` varchar
(
    250
) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `status` tinyint
(
    4
) NOT NULL DEFAULT '1'
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE =utf8mb4_unicode_ci;


INSERT INTO `products` (`id`, `name`, `description`, `price`, `image`, `status`)
VALUES (1, 'iphone5', 'description	for iphone5', 1000, NULL, 1),
       (2, 'asus', 'description for computer asus', 3000, NULL, 1);

-- Table structure `role`
CREATE TABLE IF NOT EXISTS `role`
(
    `id` int
(
    11
) NOT NULL,
    `name` varchar
(
    300
) COLLATE utf8mb4_unicode_ci NOT NULL,
    `id_role` int
(
    11
) NOT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE =utf8mb4_unicode_ci;

INSERT INTO `role` (`id`, `name`, `id_role`)
VALUES (1, 'admin', 1),
       (2, 'manager', 2),
       (3, 'guest', 3);

-- Структура таблицы `users`
CREATE TABLE IF NOT EXISTS `users`
(
    `id` int
(
    11
) NOT NULL,
    `name` varchar
(
    300
) COLLATE utf8mb4_unicode_ci NOT NULL,
    `surname` varchar
(
    300
) COLLATE utf8mb4_unicode_ci NOT NULL,
    `email` varchar
(
    300
) COLLATE utf8mb4_unicode_ci NOT NULL,
    `phone` varchar
(
    250
) COLLATE utf8mb4_unicode_ci NOT NULL,
    `address` varchar
(
    250
) COLLATE utf8mb4_unicode_ci NOT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE =utf8mb4_unicode_ci;



INSERT INTO `users` (`id`, `name`, `surname`, `email`, `phone`, `address`)
VALUES (1, 'John', 'Silver', 'silvertest@gmail.com', '11-11-111', ''),
       (2, 'Tom', 'Sayer', 'sayertest@gmail.com', '22-222', ''),
       (3, 'Iren', 'Myer', 'myertest@gmail.com', '333-333', '');

-- Table structure `user_roles`
CREATE TABLE IF NOT EXISTS `user_roles`
(
    `id` int
(
    11
) NOT NULL,
    `user_id` int
(
    11
) NOT NULL,
    `role_id` int
(
    11
) NOT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE =utf8mb4_unicode_ci;

INSERT INTO `user_roles` (`id`, `user_id`, `role_id`)
VALUES (1, 1, 1),
       (2, 2, 2),
       (3, 3, 3);

-- Table indexes `categories`
ALTER TABLE `categories`
    ADD PRIMARY KEY (`id`);


-- Table indexes `categories_products`
ALTER TABLE `categories_products`
    ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `category_id` (`category_id`);

-- Table indexes `orders`
ALTER TABLE `orders`
    ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

-- Table indexes `products`
ALTER TABLE `products`
    ADD PRIMARY KEY (`id`);

-- Table indexes `role`
ALTER TABLE `role`
    ADD PRIMARY KEY (`id`);

-- Table indexes `users`
ALTER TABLE `users`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--Table indexes `user_roles`
ALTER TABLE `user_roles`
    ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `role_id` (`role_id`);


-- AUTO_INCREMENT for table `categories`
ALTER TABLE `categories`
    MODIFY `id` int (11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

-- AUTO_INCREMENT для таблицы `categories_products`
ALTER TABLE `categories_products`
    MODIFY `id` int (11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;


-- AUTO_INCREMENT for table `orders`
ALTER TABLE `orders`
    MODIFY `id` int (11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT for the `products` table
ALTER TABLE `products`
    MODIFY `id` int (11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

-- AUTO_INCREMENT dlya tablitsy `role`
-- 33 / 5000
-- Результаты перевода
-- AUTO_INCREMENT for table `role`
ALTER TABLE `role`
    MODIFY `id` int (11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

-- AUTO_INCREMENT for table `users`
ALTER TABLE `users`
    MODIFY `id` int (11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

-- AUTO_INCREMENT for table `user_roles`
ALTER TABLE `user_roles`
    MODIFY `id` int (11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

-- Foreign key constraints of the `categories_products` table
ALTER TABLE `categories_products`
    ADD CONSTRAINT `categories_products_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `categories_products_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON
DELETE
CASCADE ON
UPDATE CASCADE;

- Foreign key constraints of the table `orders`
ALTER TABLE `orders`
    ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_roles` (`user_id`) ON UPDATE CASCADE;

-- Foreign key constraints of the `user_roles` table
ALTER TABLE `user_roles`
    ADD CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON
DELETE
CASCADE ON
UPDATE CASCADE;
COMMIT;

