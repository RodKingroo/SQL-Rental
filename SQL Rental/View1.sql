/*
--  [Russian]
--  Представление 1.
--  Создать представление, через которое можно будет вставить данные о новом заказе.

--  Ремарка:
--  Используется база данных RentalDB.
--  Таблицы 
--      [Rental] (id_worker-rental, id_client_rental, id_car_rental, date_start_rental, date_end_rental), 
--      [Client] (second_name_client, first_name_client, middle_name_client, telephone, address_client, 
                  birthday_client, address_client, serial_passport_client, nomer_passport_client).
--  Главная таблица для представления [Rental].

--	НУЖНО:
--	Cоздать представление, через которое будет происходить добавление данных в [Rental] и [Client] таблицы.
--	Если [id_client] не существует, то добавляется новый клиент.

--  [English]
--  View 1.
--  Create view, using which you can insert data about new order.

--  Remark:
--  Uses database RentalDB.
--  Tables
--      [Rental] (id_worker-rental, id_client_rental, id_car_rental, date_start_rental, date_end_rental),
--      [Client] (second_name_client, first_name_client, middle_name_client, telephone, address_client,
                  birthday_client, address_client, serial_passport_client, nomer_passport_client).
--  Main table for view [Rental].

--  NEED:
--  Create view, using which you can insert data about new order.
--  If [id_client] does not exist, new client is added.
*/

CREATE OR ALTER VIEW [NewOrders] AS
SELECT 
    id_worker_rental AS worker_id, 
    second_name_client AS client_last_name, 
    first_name_client AS client_first_name, 
    middle_name_client AS client_middle_name, 
    telephone_client AS client_telephone, 
    address_client AS client_address, 
    birthday_client AS client_birthday, 
    serial_passport_client AS client_passport_serial, 
    nomer_passport_client AS client_passport_number, 
    id_car_rental AS car_id, 
    date_start_rental AS start_date, 
    date_end_rental AS end_date
FROM 
	Rental
INNER JOIN 
	Client 
ON 
	id_client_rental = id_client;

go
CREATE OR ALTER PROCEDURE InsertNewOrder
    @worker_id INT,
    @client_last_name NVARCHAR(20),
    @client_first_name NVARCHAR(15),
    @client_middle_name NVARCHAR(25),
    @client_telephone NVARCHAR(11),
    @client_address NVARCHAR(100),
    @client_birthday DATETIME,
    @client_passport_serial NVARCHAR(10),
    @client_passport_number NVARCHAR(20),
    @car_id INT,
    @start_date DATETIME,
    @end_date DATETIME
AS
BEGIN
    SET NOCOUNT ON;
    -- Вставляем новую строку в таблицу Client
    INSERT INTO Client (second_name_client, first_name_client, middle_name_client, telephone_client, address_client, 
                        birthday_client, serial_passport_client, nomer_passport_client)
    VALUES (@client_last_name, @client_first_name, @client_middle_name, @client_telephone, @client_address, 
            @client_birthday, @client_passport_serial, @client_passport_number);

    -- Получаем идентификатор нового клиента
    DECLARE @client_id INT = SCOPE_IDENTITY();

    -- Вставляем новую строку в таблицу Rental
    INSERT INTO Rental (id_worker_rental, id_client_rental, id_car_rental, date_start_rental, date_end_rental)
    VALUES (@worker_id, @client_id, @car_id, @start_date, @end_date);

    -- Вызываем представление Orders для получения информации о новом заказе
    SELECT * FROM NewOrders
END
go

EXEC InsertNewOrder 
    @worker_id = 1, 
    @client_last_name = 'Иванов', 
    @client_first_name = 'Иван', 
    @client_middle_name = 'Иванович', 
    @client_telephone = '123-45-67', 
    @client_address = 'Ivanov@gmail.com', 
    @client_birthday = '1990-01-01', 
    @client_passport_serial = '1234', 
    @client_passport_number = '567890', 
    @car_id = 1, 
    @start_date = '2022-01-01', 
    @end_date = '2022-01-10';