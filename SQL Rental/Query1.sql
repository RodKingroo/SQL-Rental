/*
--  [Russian]
--	Запрос 1. 
--	Требуется получить информацию о том, кто и когда арендовал автомобиль, и какой модели была машина.

--	Ремарка:
--	Имеется 5 таблиц:
--		1. 	Таблица [Rental]
--		2. 	Таблица [Client]
--		3. 	Таблица [Car]
--		4. 	Таблица [Model_Car]
--		5. 	Таблица [Brand]

-- 	Таблицы связаны между собой следующим образом:
--		1. 	Таблица [Клиент] привязана к таблице [Прокат] по ключу [id_client]
--		2. 	Таблица [Автомобиль] привязана к таблице [Прокат] по ключу [id_car]
--		3. 	Таблица [Модель автомобиля] привязана к таблице [Автомобиль] по ключу [id_model]
--		4. 	Таблица [Бренд] привязана к таблице [Модель автомобиля] по ключу [id_brand]



-- 	[English]
-- 	Query 1.
-- 	Is required to get information about who rented the car, and what model was rented.
-- 	Remark:
-- 	There are 5 tables:
--		1. 	Table [Rental]
--		2. 	Table [Client]
--		3. 	Table [Car]
--		4. 	Table [Model_Car]
--		5. 	Table [Brand]

-- 	Tables linked to the following way:
-- 		1.	Table [Client] connected to table [Rental] by key [id_client]
-- 		2.	Table [Car] connected to table [Rental] by key [id_car]
-- 		3.	Table [Model_Car] connected to table [Car] by key [id_model]
-- 		4.	Table [Brand] connected to table [Model_Car] by key [id_brand]
*/

SELECT 
	[id_rental],
	[second_name_client],
	[first_name_client],
	[middle_name_client],
	[date_start_rental],
	[Brand].[name_brand],
	[Model_Car].[name_model]
FROM 
	[RentalDB].[dbo].[Rental] 
JOIN 
	[RentalDB].[dbo].[Client] 
ON 
	[Rental].[id_client_rental] = [Client].[id_client]
JOIN 
	[RentalDB].[dbo].[Car] 
ON 
	[Rental].[id_car_rental] = [Car].[id_car]
JOIN 
	[RentalDB].[dbo].[Model_Car] 
ON 
	[Car].[name_car] = [Model_Car].[id_model]
JOIN 
	[RentalDB].[dbo].[Brand] 
ON 
	[Model_Car].[name_brand] = [Brand].[id_brand];