-- =========================================================
-- Lab 4. SQL Data Manipulation (OLAP)
-- Project: Electronics Online Store
-- =========================================================

-- 1. Підрахунок загальної кількості замовлень
-- Аналіз загальної активності покупців
SELECT COUNT(*) AS total_orders
FROM orders;

-- 2. Обчислення середньої ціни товару
-- Дозволяє оцінити ціновий сегмент асортименту магазину
SELECT ROUND(AVG(price), 2) AS avg_product_price
FROM products;

-- 3. Кількість товарів у кожній категорії
-- Аналіз наповненості каталогу (JOIN + GROUP BY)
SELECT c.name AS category_name,
       COUNT(p.product_id) AS product_count
FROM categories c
JOIN products p ON p.category_id = c.category_id
GROUP BY c.name;

-- 4. Кількість замовлень по клієнтах
-- Виявлення найактивніших покупців
SELECT cu.first_name,
       COUNT(o.order_id) AS order_count
FROM customers cu
JOIN orders o ON o.customer_id = cu.customer_id
GROUP BY cu.first_name;

-- additionally. Додавання клієнта та категорії без покупок/товарів для подальшого аналізу
-- (Важливо виконати перед наступними запитами, щоб побачити різницю)
INSERT INTO customers (first_name, email) VALUES ('Максим', 'max_test@ukr.net');
INSERT INTO categories (name) VALUES ('Смарт-годинники');

-- 5. Клієнти, які зробили більше одного замовлення
-- Фільтрація постійних клієнтів за допомогою HAVING
SELECT cu.first_name,
       COUNT(o.order_id) AS order_count
FROM customers cu
JOIN orders o ON o.customer_id = cu.customer_id
GROUP BY cu.first_name
HAVING COUNT(o.order_id) > 1;

-- 6. Всі клієнти та кількість їх замовлень (LEFT JOIN)
-- Включає клієнтів, які ще не робили покупок (наприклад, щойно доданий Максим)
SELECT cu.first_name,
       COUNT(o.order_id) AS order_count
FROM customers cu
LEFT JOIN orders o ON o.customer_id = cu.customer_id
GROUP BY cu.first_name;

-- 7. Клієнти без жодного замовлення
-- Виявлення зареєстрованих, але неактивних користувачів
SELECT cu.first_name, cu.email
FROM customers cu
LEFT JOIN orders o ON o.customer_id = cu.customer_id
WHERE o.order_id IS NULL;

-- 8. Товари, які дорожчі за середнє значення
-- Підзапит використовується для порівняння з середнім показником ціни
SELECT name, price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);

-- 9. Клієнт з максимальною кількістю замовлень
-- Підзапит використовується для пошуку "клієнта місяця"
SELECT first_name
FROM customers
WHERE customer_id = (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    ORDER BY COUNT(order_id) DESC
    LIMIT 1
);

-- 10. Загальна кількість проданих одиниць товару за категоріями
-- Аналіз популярності різних категорій за допомогою кількох об'єднань
SELECT c.name AS category_name,
       SUM(oi.quantity) AS total_items_sold
FROM categories c
JOIN products p ON p.category_id = c.category_id
JOIN order_items oi ON oi.product_id = p.product_id
GROUP BY c.name;