/*
-- 	[Russian]
--	Запрос 2. 
--	Вывести клиента, который арендовал больше всего транспорта за всё время.

--	Ремарка:
-- 	Имеется 2 таблицы:
--		1. 	Таблица [Rental]
--		2. 	Таблица [Client]

-- 	Таблицы связаны между собой следующим образом:
--		1. 	Таблица [Клиент] привязана к таблице [Прокат] по ключу [id_client]


--	[English]
--	Query 2.
--	Display the client who rented the most transport for all time.

--	Remark:
-- 	There are 2 tables:
--		1. 	Table [Rental]
--		2. 	Table [Client]

--	The tables are connected by the following way:
--		1. 	Table [Client] is linked to table [Rental] by the key [id_client]
*/

SELECT
	[Client].[id_client], 
	[Client].[second_name_client], 
	[Client].[first_name_client], 
	[Client].[middle_name_client],
	[Client].[telephone_client],
	[Client].[address_client],
	COUNT([id_client_rental]) 
AS 
	count_rental 
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
	COUNT([id_client_rental]) =
	(
		SELECT MAX([m].[c])
		FROM
		(
			SELECT
				COUNT([id_client_rental]) 
			AS 
				c
			FROM 
				[RentalDB].[dbo].[Rental]
			JOIN 
				[RentalDB].[dbo].[Client] 
			ON 
				[Rental].[id_client_rental] = [Client].[id_client]
			GROUP BY
				[Client].[id_client]
		)m

	)