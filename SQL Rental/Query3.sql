/*
--	[Russian]
--	Запрос 3. 
--	Выдать скидку 10% клиентам, которые заказали авто больше 5 раз.

--	Ремарка:
-- 	Имеется 3 таблицы:
--		1. 	Таблица [Rental]
--		2. 	Таблица [Client]
--		3. 	Таблица [Discount]

--	Таблицы связаны между собой следующим образом:
--		1. 	Таблица [Клиент] привязана к таблице [Прокат] по ключу [id_client]
--		2. 	Таблица [Скидка] привязана к таблице [Client] по ключу [id_discount]

-- 	НУЖНО: 
-- 		Обновить таблицу [Клиенты] по ключу [id_discount] так, что если клиент заказал авто больше 5 раз, то ключ [id_discount] меняется на 1.


--	[English]
--	Query 3.
--	Give a 10% discount to the clients who ordered more than 5 cars.

-- 	Remark:
-- 	There are 3 tables:
--		1. 	Table [Rental]
--		2. 	Table [Client]
--		3. 	Table [Discount]

--	The tables are connected by the following way:
--		1. 	Table [Client] is linked to table [Rental] by the key [id_client]
--		2. 	Table [Discount] is linked to table [Client] by the key [id_discount]

-- NEED:
-- 	Update the table [Client] by the key [id_discount] if the client ordered more than 5 cars, so that the key [id_discount] updates to 1.
*/

UPDATE 
	[RentalDB].[dbo].[Client]
SET 
	[discount_rental] = 1
WHERE 
	[id_client] 
IN 
	(
		SELECT 
			[Client].[id_client]
		FROM 
			[RentalDB].[dbo].[Rental]
		JOIN 
			[RentalDB].[dbo].[Client] 
		ON 
			[Rental].[id_client_rental] = [Client].[id_client]
		GROUP BY
			[Client].[id_client],
			[Client].[second_name_client], 
			[Client].[first_name_client], 
			[Client].[middle_name_client],
			[Client].[telephone_client],
			[Client].[address_client]
		HAVING 
			COUNT([id_client_rental]) > 5
	)

-- [RU] Вывести все строки таблицы [Client], где [discount_rental] = 1
-- [EN] Output all rows of the clients table, where [discount_rental] = 1
SELECT * 
FROM 
	[RentalDB].[dbo].[Client] 
WHERE 
	[discount_rental] = 1