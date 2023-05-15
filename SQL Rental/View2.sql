/*
--  [Russian]
--  Представление 2.
--  Создать преставление, которое выводит данные об автомобилях и об оказанных 
--      сервисных услугах над ними, разница стоимости проката, которых 
--      не более 20% от максимальной стоймостьи автомобиля из прокатного центра.

--  Ремарка:
--  Используется база данных RentalDB.
--  Таблицы
--      [Car] (model_car, name_car, year_old_car, tech_pass_car, price_rental_car).
--      [Problem] (name_problem, id_car, id_proccess).
--      [Progress] (name_progress).
--      [Transmission_Car] (name_transmission).
--      [Brand] (name_brand).
--      [Model_Car] (name_model, id_brand, type_car, transmission_car).
--      [Type_Car] (name_type).

-- НУЖНО
--  Создать представление, которое выводит данные об автомобилях и об оказанных 
--      сервисных услугах над ними, разница стоимости проката, которых 
--      не более 10% от максимальной стоймостьи автомобиля из прокатного центра.

--  [English]
--  View 2.
--  Create a view that displays the data of the car and the services provided to the car by the car.
--  Remark:
--  Use the database RentalDB.
--  Tables
--      [Car] (model_car, name_car, year_old_car, tech_pass_car, price_rental_car).
--      [Problem] (name_problem, id_car, id_proccess).
--      [Progress] (name_progress).
--      [Transmission_Car] (name_transmission).
--      [Brand] (name_brand).
--      [Model_Car] (name_model, id_brand, type_car, transmission_car).
--      [Type_Car] (name_type).
--  Need
--      Create a view that displays the data of the car and the services provided to the car by the car.
--      The difference between the price of the car and the maximum price of the car from the rental center is not more than 10%.

*/
go
CREATE OR ALTER VIEW CarServiceData AS
SELECT 
	Brand.name_brand, mc.name_model, name_transmission, name_type, name_car, price_rental_car, name_problem, name_progress
FROM Car
JOIN Problem ON id_car = id_car_problem
JOIN Progress ON progress = id_progress
JOIN Model_Car mc ON name_car = mc.id_model
JOIN Brand ON mc.name_brand = id_brand
JOIN Type_Car ON mc.type_car = id_type
JOIN Transmission_Car ON mc.transmission_car = id_transmission
WHERE 
	price_rental_car >= 0.8 * (SELECT MAX(price_rental_car) FROM Car)
go

SELECT * FROM CarServiceData