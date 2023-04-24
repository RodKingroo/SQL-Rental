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

-- [RU] Обьявление переменной
-- [EN] Declaration of variables
DECLARE @CNT INT;

-- [RU] Количество строк в таблице.
-- [EN] Number of rows in table.
SET @CNT = (SELECT COUNT(*) FROM Car);

-- [RU] Получение последних строк
-- [EN] Get the last rows
SELECT * 
FROM [Car] 
ORDER BY [id_car] 
OFFSET @CNT - 3 ROWS FETCH NEXT 3 ROWS ONLY;