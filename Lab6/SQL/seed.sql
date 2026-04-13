-- =========================================================
-- Lab 6 Preparation: Seeding Data for BI Analysis
-- =========================================================

-- 1. Додаємо бренди (Виробники)
INSERT INTO brands (name, country) VALUES
('Apple', 'USA'),
('Samsung', 'South Korea'),
('Lenovo', 'China'),
('Asus', 'Taiwan'),
('Sony', 'Japan'),
('Xiaomi', 'China');

-- 2. Додаємо категорії
INSERT INTO categories (name) VALUES
('Смартфони'),
('Ноутбуки'),
('Навушники'),
('Планшети');

-- 3. Додаємо товари (прив'язуємо до брендів і категорій)
INSERT INTO products (category_id, brand_id, name, price) VALUES
(1, 1, 'iPhone 15 Pro', 45000.00),
(1, 2, 'Galaxy S24 Ultra', 42000.00),
(2, 3, 'Legion Pro 5', 55000.00),
(2, 4, 'ROG Zephyrus G14', 62000.00),
(3, 5, 'Sony WH-1000XM5', 12000.00),
(1, 6, 'Xiaomi 14 Ultra', 38000.00),
(4, 1, 'iPad Air M2', 28000.00),
(2, 1, 'MacBook Air M3', 48000.00);

-- 4. Додаємо клієнтів
INSERT INTO customers (first_name, email) VALUES
('Роман', 'roman@kpi.ua'),
('Олексій', 'alex@gmail.com'),
('Марія', 'mary@ukr.net'),
('Дмитро', 'dima@outlook.com');

-- 5. Додаємо адреси
INSERT INTO addresses (customer_id, city, street) VALUES
(1, 'Київ', 'Політехнічна 14'),
(2, 'Київ', 'Борщагівська 126'),
(3, 'Львів', 'вул. Франка 5'),
(4, 'Одеса', 'Дерибасівська 1');

-- 6. Додаємо замовлення (Різні дати для графіків!)
INSERT INTO orders (customer_id, address_id, order_date) VALUES
(1, 1, '2026-03-01 10:00:00'),
(2, 2, '2026-03-05 14:30:00'),
(3, 3, '2026-03-10 09:15:00'),
(4, 4, '2026-03-15 18:45:00'),
(1, 1, '2026-03-20 12:00:00'),
(2, 2, '2026-04-01 11:30:00'),
(3, 3, '2026-04-05 16:00:00'),
(1, 1, CURRENT_TIMESTAMP);

-- 7. Додаємо товари в замовлення
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1), (1, 5, 2), -- Роман купив iPhone і 2 навушників
(2, 3, 1),           -- Олексій купив ноутбук
(3, 2, 1), (3, 7, 1), -- Марія купила Galaxy і iPad
(4, 4, 1),           -- Дмитро купив ROG Zephyrus
(5, 8, 1),           -- Роман купив MacBook
(6, 6, 1),           -- Олексій купив Xiaomi
(7, 5, 1),           -- Марія купила навушники
(8, 1, 1);           -- Останнє замовлення Романа