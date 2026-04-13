# Проектування бази даних «Інтернет-магазин електроніки»

## Мета системи
Система призначена для автоматизації процесів продажу цифрової техніки, керування каталогом товарів, реєстрації клієнтів та відстеження історії замовлень.

## Зацікавлені сторони
* **Клієнти** — переглядають доступні товари, додають їх до кошика та оформлюють замовлення.
* **Менеджери магазину** — оновлюють асортимент, змінюють ціни та відстежують статус виконання замовлень.
* **Адміністратори бази даних** — відповідають за цілісність даних та технічну підтримку СУБД.

## Дані для зберігання
* Категорії товарів (назва, опис).
* Детальна інформація про товари (назва, ціна, категорія).
* Профілі клієнтів (контактні дані).
* Дані про замовлення (дата, клієнт).
* Склад кожного замовлення (перелік товарів та їх кількість).

## Бізнес-правила
1. Кожен товар обов'язково має бути закріплений за певною категорією.
2. Один клієнт може мати необмежену кількість замовлень.
3. Ціна товару в каталозі повинна бути більшою за нуль.
4. Одне замовлення може містити декілька одиниць одного і того ж товару.
5. Замовлення не може бути створене без прив'язки до існуючого клієнта.

## ER діаграма
[![](https://mermaid.ink/img/pako:eNp9U8tuwjAQ_JVoz4CSQALxreJRVQiBKD20ioSs2ASriZ06jlQK_HudB1QxUJ-yu7MzsxvtESJBKCCgcsJwLHEacku_8dNm-rxcv1unU7crjtZqvZy8jTcWsiLBFWY8r3GXfANbrifT9fZlM11oJONRUhBKtozX4KpaQU8GtE06fnvdLBcN9MKqUVmCI6oxhsVjHZePcWVFWNFYyMOWEWs1_6vlSjIeWxyntE6e2yMYNJkUpIiUyWIqzP5TKN8uEbhkY1Fb9jqkab_IlUipfGB_x2Sutm2JpkRTzJKWRr04Q0BIcstuKt8Zq-4jevZbjfo_3hdSNL2ndrUxmz9cvFn6KjBXTB0aA9CBWDICSMmCdkBb1xvQIVRGQlB7qtcESH8SLD9DCHnZk2H-IUR6aZOiiPeAdjjJdVRk5YTNLVyzknLtdiwKrgD13aAiAXSEb0CuN-o59sgJbNexh7p0AOT3e55ne-7IDvyBP3Tccwd-Kk27p6NgFAwHQ88duL7jdYASpoRc1IeoT2HHYjj_AhNwEq4?type=png)](https://mermaid.live/edit#pako:eNp9U8tuwjAQ_JVoz4CSQALxreJRVQiBKD20ioSs2ASriZ06jlQK_HudB1QxUJ-yu7MzsxvtESJBKCCgcsJwLHEacku_8dNm-rxcv1unU7crjtZqvZy8jTcWsiLBFWY8r3GXfANbrifT9fZlM11oJONRUhBKtozX4KpaQU8GtE06fnvdLBcN9MKqUVmCI6oxhsVjHZePcWVFWNFYyMOWEWs1_6vlSjIeWxyntE6e2yMYNJkUpIiUyWIqzP5TKN8uEbhkY1Fb9jqkab_IlUipfGB_x2Sutm2JpkRTzJKWRr04Q0BIcstuKt8Zq-4jevZbjfo_3hdSNL2ndrUxmz9cvFn6KjBXTB0aA9CBWDICSMmCdkBb1xvQIVRGQlB7qtcESH8SLD9DCHnZk2H-IUR6aZOiiPeAdjjJdVRk5YTNLVyzknLtdiwKrgD13aAiAXSEb0CuN-o59sgJbNexh7p0AOT3e55ne-7IDvyBP3Tccwd-Kk27p6NgFAwHQ88duL7jdYASpoRc1IeoT2HHYjj_AhNwEq4)
## Сутності та їх атрибути

### Category
Представляє групи, до яких відносяться товари.
* `category_id` (PK) — унікальний ідентифікатор категорії.
* `name` — назва (наприклад, "Смартфони", "Ноутбуки").

**Звʼязки:**
- Одна категорія містить багато товарів.

---

### Product
Конкретний товар, який виставлений на продаж.
* `product_id` (PK) — унікальний ідентифікатор товару.
* `category_id` (FK) — посилання на категорію.
* `name` — назва моделі.
* `price` — вартість товару.

**Звʼязки:**
- Належить до однієї категорії.
- Може бути частиною багатьох замовлень.

---

### Customer
Зареєстрований користувач магазину.
* `customer_id` (PK) — унікальний ідентифікатор клієнта.
* `first_name` — ім'я.
* `email` — унікальна адреса електронної пошти.

**Звʼязки:**
- Клієнт може оформити багато замовлень.

---

### Order
Документ, що фіксує факт покупки.
* `order_id` (PK) — унікальний номер замовлення.
* `customer_id` (FK) — посилання на покупця.
* `order_date` — дата і час створення замовлення.

**Звʼязки:**
- Замовлення належить одному клієнту.
- Містить кілька позицій товарів через таблицю OrderItem.

---

### OrderItem
Позиція товару всередині конкретного замовлення.
* `order_item_id` (PK) — ідентифікатор рядка.
* `order_id` (FK) — посилання на замовлення.
* `product_id` (FK) — посилання на товар.
* `quantity` — кількість одиниць купленого товару.

**Звʼязки:**
- Пов'язує замовлення та товари (реалізація зв'язку M:N).