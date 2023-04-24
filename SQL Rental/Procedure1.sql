/*

-- [Russian]
-- Процедура 1.
-- Создать процедуру которая бы увеличила на 10% стоимость проката, если эта машина cамая популярная.

-- Ремарка:
-- 	Имеется 2 таблицы:
--		1. 	Таблица [Rental]
--		2. 	Таблица [Car]

-- Таблицы связаны между собой следующим образом:
--		1. 	Table [Car] is linked to table [Rental] by the key [id_car]

-- [English]
-- Procedure 1.
-- Create a procedure that increases the price of rent, if the most popular car is the most popular.

-- Remark:
--	There are 2 tables:
--		1. 	Table [Rental]
--		2. 	Table [Car]

-- The tables are connected by the following way:
--		1. 	Table [Car] is linked to table [Rental] by the key [id_car]

*/

-- [RU] Создать процедуру которая бы увеличила на 10% стоимость проката, если эта машина cамая популярная.
-- [EN] Create a procedure that increases the price of rent, if the most popular car is the most popular.
USE RentalDB;
GO

CREATE PROCEDURE proc1 AS
    UPDATE 
        Car 
    SET
        price_rental_car = price_rental_car * 1.1
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
            COUNT(id_car_rental) = (
                SELECT 
                MAX(m.c)
            FROM
                (SELECT 
                    COUNT(id_car_rental)c 
                FROM 
                    Rental 
                GROUP BY 
                    id_car_rental)m
            )
    );