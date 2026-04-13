-- 1. Наповнення категорій (батьківська таблиця)
INSERT INTO categories (name) VALUES 
('Смартфони'), 
('Ноутбуки'), 
('Аксесуари'), 
('Планшети'), 
('Аудіо');

-- 2. Реєстрація клієнтів (батьківська таблиця)
INSERT INTO customers (first_name, email) VALUES 
('Роман', 'roman@kpi.ua'),
('Олексій', 'alex@gmail.com'),
('Марія', 'mary@ukr.net'),
('Іван', 'ivan@outlook.com'),
('Олена', 'olena@meta.ua');

-- 3. Додавання товарів (посилається на categories)
INSERT INTO products (category_id, name, price) VALUES 
(1, 'iPhone 15', 35000.00),
(2, 'MacBook Air M2', 48000.00),
(1, 'Samsung Galaxy S23', 31000.00),
(3, 'Чохол MagSafe', 1200.00),
(5, 'AirPods Pro', 9500.00);

-- 4. Створення замовлень (посилається на customers)
INSERT INTO orders (customer_id) VALUES 
(1), -- Роман
(2), -- Олексій
(1), -- Роман зробив ще одне замовлення
(3), -- Марія
(5); -- Олена

-- 5. Деталізація замовлень (посилається на orders та products)
INSERT INTO order_items (order_id, product_id, quantity) VALUES 
(1, 1, 1), -- Замовлення #1: 1 iPhone
(2, 2, 1), -- Замовлення #2: 1 MacBook
(3, 4, 2), -- Замовлення #3: 2 чохли
(4, 5, 1), -- Замовлення #4: 1 AirPods
(5, 3, 1); -- Замовлення #5: 1 Samsung