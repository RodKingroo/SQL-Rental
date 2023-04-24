/*
--  [Russian]
--	Запрос 4.
--  Удалить клиентов, которые в последний раз арендовали авто ранее 2020 года

--	Ремарка:
-- 	Имеется 2 таблицы:
--		1. 	Таблица [Rental]
--		2. 	Таблица [Client]

--	Таблицы связаны между собой следующим образом:
--		1. 	Таблица [Клиент] привязана к таблице [Прокат] по ключу [id_client]

--	[English]
--	Query 4.
--	Delete the clients who rented before 2020

--	Remark:
-- 	There are 2 tables:
--		1. 	Table [Rental]
--		2. 	Table [Client]

--	The tables are connected by the following way:
--		1. 	Table [Client] is linked to table [Rental] by the key [id_client]
*/

DELETE 
    [RentalDB].[dbo].[Client] 
WHERE 
    [id_client] 
IN (
    SELECT 
        [Rental].[id_client_rental] 
    FROM 
        [RentalDB].[dbo].[Rental]
    GROUP BY 
        [Rental].[id_client_rental]
    HAVING 
        max(year([Rental].[date_start_rental])) < 2020
);



-- [RU] Вывести все строки таблицы [Client]
-- [EN] Print all rows of the table [Client]
SELECT * 
FROM [RentalDB].[dbo].[Client] ;