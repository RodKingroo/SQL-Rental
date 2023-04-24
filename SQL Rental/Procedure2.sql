/*
--  [Russian]
--  Процедура 2.
--  Требуется вывести последние 3 записи с таблицы [Car].

--  Ремарка:
-- 	Имеется 1 таблица: [Car]

--  [English]
--  Procedure 2.
--  Print the last 3 records of table [Car].

--  Remark:
-- 	There is 1 table: [Car]
*/

-- [RU] Требуется вывести последние 3 записи с таблицы [Car].
-- [EN] Print the last 3 records of table [Car].
USE RentalDB;
GO

CREATE PROCEDURE proc2 AS
    SELECT TOP 3
        *
    FROM 
        Car
    ORDER BY 
        id_car 