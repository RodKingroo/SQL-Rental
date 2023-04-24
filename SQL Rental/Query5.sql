/*

-- [Russian]
-- Запрос 5.
-- Понизить стоимость аренды, автомобилям, которые заказали меньше всего раз.

-- Ремарка:
-- 	Имеется 2 таблицы:
--		1. 	Таблица [Rental]
--		2. 	Таблица [Car]

-- Таблицы связаны между собой следующим образом:
--		1. 	Table [Car] is linked to table [Rental] by the key [id_car]

-- [English]
-- Query 5.
-- Reduce the price of rent, car, which ordered less than all.

-- Remark:
--	There are 2 tables:
--		1. 	Table [Rental]
--		2. 	Table [Car]

-- The tables are connected by the following way:
--		1. 	Table [Car] is linked to table [Rental] by the key [id_car]

*/

UPDATE 
    Car 
SET
    price_rental_car = price_rental_car / 2
WHERE 
    id_car 
IN
(
    SELECT 
        id_car_rental
    FROM 
        Rental
    GROUP BY 
        id_car_rental
    HAVING 
        COUNT(id_car_rental) = 
        (SELECT 
            MIN(m.c) 
        FROM
	        (SELECT 
                COUNT(id_car_rental)c 
            FROM 
                Rental 
            GROUP BY 
                id_car_rental)m
    )
);


