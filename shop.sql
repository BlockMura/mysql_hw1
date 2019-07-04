DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NULL COMMENT 'Название раздела'/*,
  UNIQUE unique_name(name(10)) Условие надо убрать, так как будет выдавать ошибку если значений ноль или пустых строк будет больше одной*/
) COMMENT = 'Раздел интеренет магазина'


-- INSERT INTO catalogs VALUES (NULL, 'Процессоры');
-- INSERT INTO catalogs (id, name) VALUES (NULL, 'Мат.платы');
-- INSERT INTO catalogs VALUES (DEFAULT, 'Видеокарты');

INSERT IGNORE INTO catalogs VALUES 
  (DEFAULT, 'Процессоры'),
  (DEFAULT, 'Мат.платы'),
  (DEFAULT, 'Видеокарты'),
  (DEFAULT, 0),
  (DEFAULT, NULL);
  
UPDATE
	catalogs
SET
	name = 'Процессоры (INTEL)'
WHERE
	name = 'Процессоры';

UPDATE
	catalogs
SET
	name = 'empty'
WHERE
	name IS NULL;

SELECT id, name FROM catalogs;

DROP TABLE IF EXISTS cat;
CREATE TABLE cat (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NULL COMMENT 'Название раздела'/*,
  UNIQUE unique_name(name(10))*/
) COMMENT = 'Раздел интеренет магазина'

INSERT INTO
	cat 
SELECT
	*
FROM
	catalogs;

SELECT * FROM cat;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE  COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели'

INSERT INTO users (id, name, birthday_at) VALUES ( 1, 'Hello', '1970-01-27');
SELECT * FROM users;

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL(11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id(catalog_id)
) COMMENT = 'Раздел интеренет магазина'

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = 'Заказы'

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  id SERIAL PRIMARY KEY,
  order_id INT UNSIGNED,
  product_id INT UNSIGNED,
  total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP  
) COMMENT = 'Состав заказа'

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  product_id INT UNSIGNED,
  discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
  started_at DATETIME,
  finish_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id),
  KEY index_of_product_id(product_id)
) COMMENT = 'Скидки'


DROP TABLE IF EXISTS storehauses;
CREATE TABLE storehauses (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Cклады'

DROP TABLE IF EXISTS storehauses_product;
CREATE TABLE storehauses_product (
  id SERIAL PRIMARY KEY,
  storehause_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе'


