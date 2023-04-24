/*
-- [Russian]
-- Создание базы данных проката автомобилей.

-- [English]
-- Create Database RentalDB
*/


USE master;


/*
--	[RU] Удаление базы данных
--	[EN] Drop Database RentalDB
*/
IF DB_ID('RentalDB') IS NOT NULL DROP DATABASE RentalDB;


/*
--	[RU] Создание базы данных RentalDB
--	[EN] Create Database RentalDB
*/
CREATE DATABASE RentalDB
GO
	USE RentalDB
GO


/*
	--	[RU] Создание таблиц и наполнение их данными
	-- 	[EN] Create Tables and insert data
*/



/*
--	[RU] Создание таблицы Worker
--	[EN] Create Table Worker
*/
CREATE TABLE [Worker]
(
	[id_worker] INT PRIMARY KEY IDENTITY NOT NULL,
	[second_name_worker] NVARCHAR(20) NOT NULL,
	[first_name_worker] NVARCHAR(15) NOT NULL,
	[middle_name_worker] NVARCHAR(25),
	[telephone_worker] VARCHAR(11) NOT NULL,
	[email_worker] VARCHAR(100) NOT NULL,
	[experience_worker] DATETIME NOT NULL
	UNIQUE([id_worker])
);


/*
--	[RU] Создание таблицы Type_Car
--	[EN] Create Table Type_Car
*/
CREATE TABLE [Type_Car]
(
	[id_type] INT PRIMARY KEY IDENTITY NOT NULL,
	[name_type] NVARCHAR(255) NOT NULL,
	UNIQUE([id_type])
);


/*
--	[RU] Создание таблицы Transmission_Car
--	[EN] Create Table Transmission_Car
*/
CREATE TABLE [Transmission_Car]
(
	[id_transmission] INT PRIMARY KEY IDENTITY NOT NULL,
	[name_transmission] NVARCHAR(255) NOT NULL,
	UNIQUE([id_transmission])
);


/*
--	[RU] Создание таблицы Brand
--	[EN] Create Table Brand
*/
CREATE TABLE [Brand]
(
	[id_brand] INT PRIMARY KEY IDENTITY NOT NULL,
	[name_brand] NVARCHAR(255) NOT NULL,
	UNIQUE([id_brand])
);


/*
--	[RU] Создание таблицы Model_Car
--	[EN] Create Table Model_Car
*/
CREATE TABLE [Model_Car]
(
	[id_model] INT PRIMARY KEY IDENTITY NOT NULL,
	[name_model] NVARCHAR(255) NOT NULL,
	[name_brand] INT CONSTRAINT FK_brand REFERENCES [Brand]([id_brand]) NOT NULL,
	[type_car] INT CONSTRAINT FK_type_car REFERENCES [Type_Car]([id_type]) NOT NULL,
	[transmission_car] INT CONSTRAINT FK_transmission_car REFERENCES [Transmission_Car]([id_transmission]) NOT NULL,
	UNIQUE([id_model])
);


/*
--	[RU] Создание таблицы Progress
--	[EN] Create Table Progress
*/
CREATE TABLE [Progress]
(
	[id_progress] INT PRIMARY KEY IDENTITY NOT NULL,
	[name_progress] NVARCHAR(50) NOT NULL,
	UNIQUE([id_progress])
);


/*
--	[RU] Создание таблицы Car
-- 	[EN] Create Table Car
*/
CREATE TABLE [Car]
(
	[id_car] INT PRIMARY KEY IDENTITY NOT NULL,
	[name_car] INT CONSTRAINT FK_name_car REFERENCES [Model_Car]([id_model]) NOT NULL,
	[year_old_car] INT NOT NULL,
	[tech_pass_car] NVARCHAR(16) NOT NULL,
	[price_rental_car] INT NOT NULL,
);

/*
--	[RU] Создание таблицы Problem
--	[EN] Create Table Problem
*/
CREATE TABLE [Problem]
(
	[id_problem] INT PRIMARY KEY IDENTITY NOT NULL,
	[name_problem] VARCHAR(255) NOT NULL,
	[id_car_problem] INT CONSTRAINT FK_id_car_problem REFERENCES [Car]([id_car]) NOT NULL,
	[progress] INT CONSTRAINT FK_id_progress REFERENCES [Progress]([id_progress]) NOT NULL,
);

/*
--	[RU] Создание таблицы Overdue
--	[EN] Create Table Overdue
*/
CREATE TABLE [Overdue]
(
	[id_overdue] INT PRIMARY KEY IDENTITY NOT NULL,
	[name_overdue] VARCHAR(255) NOT NULL,
	[price_overdue] INT NOT NULL
);

/*
--	[RU] Создание таблицы Discount
--	[EN] Create Table Discount
*/
CREATE TABLE [Discount]
(
	[id_discount] INT PRIMARY KEY IDENTITY NOT NULL,
	[name_discount] VARCHAR(255) NOT NULL,
	[price_discount] INT NOT NULL
);


/*
--	[RU] Создание таблицы Client
--	[EN] Create Table Client
*/
CREATE TABLE Client
(
	[id_client] INT PRIMARY KEY IDENTITY NOT NULL,
	[second_name_client] NVARCHAR(20) NOT NULL,
	[first_name_client] NVARCHAR(15) NOT NULL,
	[middle_name_client] NVARCHAR(25),
	[telephone_client] VARCHAR(11),
	[address_client] VARCHAR(100) NOT NULL,
	[birthday_client] DATETIME NOT NULL,
	[serial_passport_client] INT NOT NULL,
	[nomer_passport_client] INT NOT NULL, 
	[overdue_rental] INT CONSTRAINT FK_overdue_rental REFERENCES [Overdue]([id_overdue]),
	[discount_rental] INT CONSTRAINT FK_discount_rental REFERENCES [Discount]([id_discount]),
	UNIQUE([id_client])
)

/*
--	[RU] Создание таблицы Rental
--	[EN] Create Table Rental
*/
CREATE TABLE Rental
(
	[id_rental] INT PRIMARY KEY IDENTITY,
	[id_worker_rental] INT CONSTRAINT FK_worker_rental REFERENCES Worker(id_worker) NOT NULL,
	[id_client_rental] INT CONSTRAINT FK_client_rental REFERENCES Client(id_client) ON DELETE CASCADE NOT NULL,
	[id_car_rental] INT CONSTRAINT FK_car_rental REFERENCES Car(id_car) NOT NULL,
	[date_start_rental] DATETIME NOT NULL,
	[date_end_rental] DATETIME NOT NULL,
)

/*
-- 	[RU] Наполнение данными таблицы Worker
--		 Таблица Worker имеет такие столбцы: 
--			ID Работника, Фамилия, Имя, Отчество, Телефон, Email, Дата вступления на работу

-- 	[EN] Insert Data Worker
--		 Table Type_Car has these columns:
--			ID Worker, Last Name, First Name, Middle Name, Phone, Email, Date of Birth
*/
INSERT INTO [Worker] VALUES ('Kravets', 'Gerasim', 'Trofimovich', '89501568954', 'vitaliy1981@gmail.com', '2018-11-24');
INSERT INTO [Worker] VALUES ('Shulepin', 'Philip', 'Yefimovich', '89512568954', 'filipp1972@ya.ru', '2020-09-23');
INSERT INTO [Worker] VALUES ('Ivlev', 'Evgeny', 'Vlasovich', '89545264895', 'evgeniy21@gmail.com', '2021-02-18');
INSERT INTO [Worker] VALUES ('Yankevich', 'Pavel', 'Ivanovich', '85922485948', 'pavel1970@ya.ru', '2018-05-18');
INSERT INTO [Worker] VALUES ('Kapriyanov', 'Roman', 'Valerianovich', '84895468855', 'roman7977@rambler.ru', '2018-09-25');


/*
-- 	[RU] Наполнение данными таблицы Type_Car
-- 		 Таблица Type_Car имеет такие столбцы: 
--			ID Типа машины, Наименование

-- 	[EN] Insert Data Type_Car
--		 Table Type_Car has these columns: 
--			ID Type Car, Name
*/
INSERT INTO [Type_Car] VALUES ('Hatchback');
INSERT INTO [Type_Car] VALUES ('Sedan');
INSERT INTO [Type_Car] VALUES ('Liftback');
INSERT INTO [Type_Car] VALUES ('Station wagon');
INSERT INTO [Type_Car] VALUES ('Compartment');
INSERT INTO [Type_Car] VALUES ('Crossover');
INSERT INTO [Type_Car] VALUES ('Off-road vehicle');
INSERT INTO [Type_Car] VALUES ('Minivan');



/*
-- 	[RU] Наполнение данными таблицы Transmission_Car
--		 Таблица Transmission_Car имеет такие столбцы: 
--			ID Типа трансмиссии, Наименование

-- 	[EN] Insert Data Transmission_Car
--		 Table Transmission_Car has these columns: 
--			ID Transmission Car, Name
*/
INSERT INTO [Transmission_Car] VALUES ('Manual');
INSERT INTO [Transmission_Car] VALUES ('Automatic');
INSERT INTO [Transmission_Car] VALUES ('Variator');
INSERT INTO [Transmission_Car] VALUES ('Robot');


/*
-- 	[RU] Наполнение данными таблицы Brand
--		 Таблица Brand имеет такие столбцы: 
--			ID Бренда, Наименование

-- 	[EN] Insert Data Brand
--		 Table Brand has these columns: 
--			ID Brand, Name
*/
INSERT INTO [Brand] VALUES ('Solrain');
INSERT INTO [Brand] VALUES ('Procket');
INSERT INTO [Brand] VALUES ('Motoriot');
INSERT INTO [Brand] VALUES ('Brande');
INSERT INTO [Brand] VALUES ('Bodybox');
INSERT INTO [Brand] VALUES ('Sportax');
INSERT INTO [Brand] VALUES ('Drivecar');
INSERT INTO [Brand] VALUES ('Petroll');
INSERT INTO [Brand] VALUES ('Proscher');
INSERT INTO [Brand] VALUES ('Sinnal');


/*
-- 	[RU] Наполнение данными таблицы Model_Car
--		 Таблица Model_Car имеет такие столбцы: 
--			ID Модели, Название модели, ID Бренда, ID Типа машины, ID Трансмиссии

-- 	[EN] Insert Data Model_Car
--		 Table Model_Car has these columns: 
--			ID Model Car, Name Model, ID Brand, ID Type Car, ID Transmission Car
*/
INSERT INTO [Model_Car] VALUES ('Tricket', 2, 3, 4);
INSERT INTO [Model_Car] VALUES ('MODEL F', 2, 4, 1);
INSERT INTO [Model_Car] VALUES ('TEACHE', 6, 4, 4);
INSERT INTO [Model_Car] VALUES ('Couperse', 8, 2, 3);
INSERT INTO [Model_Car] VALUES ('Chipmunk', 4, 2, 3);
INSERT INTO [Model_Car] VALUES ('Frightful', 5, 8, 1);
INSERT INTO [Model_Car] VALUES ('Rycar', 1, 2, 3);
INSERT INTO [Model_Car] VALUES ('Strendz', 1, 4, 3);
INSERT INTO [Model_Car] VALUES ('Spaun', 5, 2, 1);
INSERT INTO [Model_Car] VALUES ('Picture', 4, 6, 4);
INSERT INTO [Model_Car] VALUES ('Tank', 7, 7, 4);
INSERT INTO [Model_Car] VALUES ('Serber', 8, 7, 2);
INSERT INTO [Model_Car] VALUES ('Shelder', 6, 7, 3);
INSERT INTO [Model_Car] VALUES ('Murk', 5, 8, 2);
INSERT INTO [Model_Car] VALUES ('Calm', 4, 8, 4);
INSERT INTO [Model_Car] VALUES ('Sight', 3, 5, 2);
INSERT INTO [Model_Car] VALUES ('Horse', 2, 4, 1);
INSERT INTO [Model_Car] VALUES ('Dingo', 2, 3, 4);
INSERT INTO [Model_Car] VALUES ('Wise', 2, 3, 2);
INSERT INTO [Model_Car] VALUES ('Gott', 7, 4, 2);
INSERT INTO [Model_Car] VALUES ('Coscienza', 6, 4, 2);
INSERT INTO [Model_Car] VALUES ('Scrittore', 7, 4, 3);
INSERT INTO [Model_Car] VALUES ('Coast', 6, 5, 3);
INSERT INTO [Model_Car] VALUES ('Hippopotamus', 4, 5, 4);
INSERT INTO [Model_Car] VALUES ('Lynx', 5, 6, 4);
INSERT INTO [Model_Car] VALUES ('Letter', 5, 7, 1);
INSERT INTO [Model_Car] VALUES ('Unborder', 5, 5, 3);
INSERT INTO [Model_Car] VALUES ('Quantity', 3, 3, 2);
INSERT INTO [Model_Car] VALUES ('Principle', 3, 3, 3);
INSERT INTO [Model_Car] VALUES ('Percent', 3, 3, 2);
INSERT INTO [Model_Car] VALUES ('Name', 2, 2, 1);
INSERT INTO [Model_Car] VALUES ('Usual', 3, 2, 4);
INSERT INTO [Model_Car] VALUES ('Popular', 5, 1, 2);
INSERT INTO [Model_Car] VALUES ('Sleep', 4, 3, 3);
INSERT INTO [Model_Car] VALUES ('Sky', 4, 5, 2);
INSERT INTO [Model_Car] VALUES ('Connection', 6, 6, 1);
INSERT INTO [Model_Car] VALUES ('Otter', 5, 4, 2);
INSERT INTO [Model_Car] VALUES ('Different', 7, 2, 2);
INSERT INTO [Model_Car] VALUES ('Rude', 5, 1, 1);
INSERT INTO [Model_Car] VALUES ('Sillen', 7, 1, 2);
INSERT INTO [Model_Car] VALUES ('Herrose', 3, 1, 3);
INSERT INTO [Model_Car] VALUES ('XF-238', 9, 3, 3);


/*
-- 	[RU] Наполнение данными таблицы Progress
--		 Таблица Progress имеет такие столбцы: 
--			ID Прогресса, Наименование

-- 	[EN] Insert Data Progress
--		 Table Progress has these columns: 
--			ID Progress, Name
*/
INSERT INTO [Progress] VALUES ('Analysis');
INSERT INTO [Progress] VALUES ('Check');
INSERT INTO [Progress] VALUES ('Repair');
INSERT INTO [Progress] VALUES ('Postponed');
INSERT INTO [Progress] VALUES ('Transit');
INSERT INTO [Progress] VALUES ('Add - on');
INSERT INTO [Progress] VALUES ('Garage');


/*
-- 	[RU] Наполнение данными таблицы Car
--		 Таблица Car имеет такие столбцы: 
--			ID Машины, Модель, Год выпуска, Код машины, Цена

-- 	[EN] Insert Data Car
--		 Table Car has these columns: 
--			ID Car, ID Model, Year, Code Car, Price
*/
INSERT INTO [Car] VALUES (24, 2005, '651FW87SX8FX5', 48000);
INSERT INTO [Car] VALUES (32, 2020, 'T4MUTJ34J0T4J', 65000);
INSERT INTO [Car] VALUES (20, 2021, 'JTI34OJHT034T', 45000);
INSERT INTO [Car] VALUES (5, 2020, 'TIO34J0T3J49G', 36000);
INSERT INTO [Car] VALUES (8, 2017, 'J4305J0RETNET', 58000);
INSERT INTO [Car] VALUES (24, 2013, 'J0TER9JT09340', 68000);
INSERT INTO [Car] VALUES (32, 2021, 'UG09U04UG034U', 56000);
INSERT INTO [Car] VALUES (33, 2007, 'WHE1098H81HHE', 75000);
INSERT INTO [Car] VALUES (25, 2013, 'RJ13R3ONORO3U', 35000);
INSERT INTO [Car] VALUES (35, 2008, '01E2J2J0JE2JE', 75000);
INSERT INTO [Car] VALUES (7, 2020, 'R30J2R9032J0R', 65000);
INSERT INTO [Car] VALUES (18, 2013, 'R23KREWNROO', 34000);
INSERT INTO [Car] VALUES (2, 2010, '11CR3H809CH', 54000);
INSERT INTO [Car] VALUES (4, 2016, 'ROPXQJRPJPOR3', 54000);
INSERT INTO [Car] VALUES (33, 2019, 'R30J2JR03J2JR', 23000);
INSERT INTO [Car] VALUES (5, 2011, 'J23I0JR023JII', 43000);
INSERT INTO [Car] VALUES (30, 2011, 'CR3J2RCJ3200U', 23000);
INSERT INTO [Car] VALUES (18, 2017, 'R238JC283R9HC', 43000);
INSERT INTO [Car] VALUES (14, 2021, 'IAUCHR99C2348', 53000);
INSERT INTO [Car] VALUES (7, 2018, 'CRH32R9CH293H', 25000);
INSERT INTO [Car] VALUES (38, 2018, 'RCH293RHC9329', 43000);
INSERT INTO [Car] VALUES (27, 2015, 'CZJHERHC38487', 12000);
INSERT INTO [Car] VALUES (33, 2019, 'H49234HC92384', 43000);
INSERT INTO [Car] VALUES (2, 2011, 'EO21HE8021E0U', 53000);
INSERT INTO [Car] VALUES (9, 2014, '3H2R0H3208R02', 29000);
INSERT INTO [Car] VALUES (27, 2013, 'R392UHR2H3RHU', 48000);
INSERT INTO [Car] VALUES (10, 2011, 'R3O2HRH238748', 23000);
INSERT INTO [Car] VALUES (20, 2004, 'CRNO23HNRC320', 53000);
INSERT INTO [Car] VALUES (2, 2011, '3C4H098CY2903', 64000);
INSERT INTO [Car] VALUES (20, 2008, 'C3RU92YC382Y8', 26000);
INSERT INTO [Car] VALUES (39, 2020, 'C4H923HC49823', 44000);
INSERT INTO [Car] VALUES (1, 2009, '3C924YC923Y94', 64000);
INSERT INTO [Car] VALUES (21, 2003, '4CY9238Y4C9Y3', 24000);
INSERT INTO [Car] VALUES (29, 2005, 'JNCODHOFH454H', 24000);
INSERT INTO [Car] VALUES (32, 2006, 'HICARH908343D', 45000);
INSERT INTO [Car] VALUES (19, 2006, '4HC312H429OIH', 53000);
INSERT INTO [Car] VALUES (14, 2016, '4COI23H49CH23', 23000);
INSERT INTO [Car] VALUES (8, 2018, 'OICAEHOR38743', 43000);
INSERT INTO [Car] VALUES (32, 2019, 'DDXOQWH9UXH83', 23000);
INSERT INTO [Car] VALUES (37, 2014, 'O4IC3120N4C80', 62000);
INSERT INTO [Car] VALUES (11, 2007, 'C4HI3H9C48H34', 26000);
INSERT INTO [Car] VALUES (23, 2005, 'C3HWQIRH92YR9', 45000);
INSERT INTO [Car] VALUES (24, 2003, '3CJ042UC2I3JH', 45000);
INSERT INTO [Car] VALUES (4, 2008, 'HR3OCUI2HJ3OH', 89000);
INSERT INTO [Car] VALUES (2, 2019, '34H92H394CH32', 23000);
INSERT INTO [Car] VALUES (13, 2018, 'JBCIDFHIU2HER', 43000);
INSERT INTO [Car] VALUES (11, 2017, 'CHR2839Y9CRYH', 23000);
INSERT INTO [Car] VALUES (27, 2015, 'CR2U3HCRH239Y', 53000);
INSERT INTO [Car] VALUES (15, 2013, 'CJIAHERICH3Y4', 43000);
INSERT INTO [Car] VALUES (39, 2011, 'IHGEIRIVG3848', 12000);
INSERT INTO [Car] VALUES (12, 2012, 'EC1JHEOICHO12', 32000);
INSERT INTO [Car] VALUES (21, 2017, 'EC1H2HCEIOH2E', 42000);
INSERT INTO [Car] VALUES (4, 2018, 'ECH21IOHEC2HH', 64000);
INSERT INTO [Car] VALUES (15, 2019, 'EXO1IH2OEIXHE', 34000);
INSERT INTO [Car] VALUES (22, 2020, 'EC12IHECH2O1I', 54000);
INSERT INTO [Car] VALUES (8, 2020, 'E1C2HUIOHECU2', 23000);
INSERT INTO [Car] VALUES (3, 2006, 'ECHI12GCG2I1G', 43000);
INSERT INTO [Car] VALUES (11, 2008, 'EI12HOICEHOI1', 24000);
INSERT INTO [Car] VALUES (34, 2009, 'AIEWHCIUHEU23', 63000);
INSERT INTO [Car] VALUES (4, 2010, 'CWJIOQEJROCIQ', 24000);
INSERT INTO [Car] VALUES (31, 2011, 'HZCOIFHOQEOWR', 53000);
INSERT INTO [Car] VALUES (9, 2012, 'ROIJEWOIRU3O0', 23000);
INSERT INTO [Car] VALUES (22, 2013, 'RI32CYG823GRR', 43000);
INSERT INTO [Car] VALUES (24, 2017, 'RC2U3HR89C7Y3', 53000);
INSERT INTO [Car] VALUES (7, 2017, 'CR3U2HCR932HR', 65000);
INSERT INTO [Car] VALUES (5, 2008, 'RCU23HR9C238R', 46000);
INSERT INTO [Car] VALUES (28, 2009, 'HRCOIAEHOIRCR', 47000);
INSERT INTO [Car] VALUES (33, 2009, 'OFICJO234JH04', 44000);
INSERT INTO [Car] VALUES (6, 2018, 'RCOI32HORCHO3', 46000);
INSERT INTO [Car] VALUES (21, 2016, 'RCO32HRCH23OH', 34000);
INSERT INTO [Car] VALUES (32, 2015, 'RCO23HORCH32O', 23000);
INSERT INTO [Car] VALUES (11, 2014, 'AJHCHFHAHIRUE', 53000);
INSERT INTO [Car] VALUES (6, 2011, 'ORHCOIH23RHCU', 34000);
INSERT INTO [Car] VALUES (14, 2020, 'AHRCOIHECHARI', 53000);
INSERT INTO [Car] VALUES (22, 2008, 'VIWHIEOHEYRUE', 23000);
INSERT INTO [Car] VALUES (38, 2006, 'WERJHCOH23IIR', 64000);
INSERT INTO [Car] VALUES (33, 2004, 'RCIH23IRUCH2I', 23000);
INSERT INTO [Car] VALUES (19, 2005, 'OCIRHQOERCO23', 54000);
INSERT INTO [Car] VALUES (9, 2006, 'RC3O2HRCIH3IU', 64000);
INSERT INTO [Car] VALUES (38, 2008, 'RCQ3UIHRCIU3H', 23000);
INSERT INTO [Car] VALUES (24, 2006, 'RCO3QHOHRCO3I', 43000);
	

/*
-- 	[RU] Наполнение данными таблицы Problem
-- 		 Таблица Problem имеет такие столбцы: 
--			ID Проблемы, Наименование, ID Машины, ID Процесса

-- 	[EN] Insert data Problem
-- 		 Table Problem has these columns: 
--			ID Problem, Name Problem, ID Car, ID Process
*/
INSERT INTO [Problem] VALUES ('Destruction of the muffler nozzle', 32, 3);
INSERT INTO [Problem] VALUES ('Engine reassembly', 15, 7);
INSERT INTO [Problem] VALUES ('5 engine valve - replacement', 19, 5);
INSERT INTO [Problem] VALUES ('3 engine valve - replacement', 16, 4);
INSERT INTO [Problem] VALUES ('Polishing the left wing', 22, 4);
INSERT INTO [Problem] VALUES ('Polishing the left wing', 24, 2);
INSERT INTO [Problem] VALUES ('Destruction of the muffler nozzle', 35, 1);
INSERT INTO [Problem] VALUES ('Destruction of the muffler nozzle', 32, 3);
INSERT INTO [Problem] VALUES ('3 engine valve - replacement', 21, 2);
INSERT INTO [Problem] VALUES ('Polishing the left wing', 22, 4);
INSERT INTO [Problem] VALUES ('Replacement of air valves', 10, 2);
INSERT INTO [Problem] VALUES ('Replacement of air valves', 13, 3);
INSERT INTO [Problem] VALUES ('Replacement of air valves', 25, 7);
INSERT INTO [Problem] VALUES ('Polishing the left wing', 34, 2);
INSERT INTO [Problem] VALUES ('3 engine valve - replacement', 29, 2);	
INSERT INTO [Problem] VALUES ('�orrection of scratches after impact', 28, 6);
INSERT INTO [Problem] VALUES ('�orrection of scratches after impact', 28, 6);
INSERT INTO [Problem] VALUES ('Destruction of the muffler nozzle', 25, 1);
INSERT INTO [Problem] VALUES ('Replacement of air valves', 20, 5);
INSERT INTO [Problem] VALUES ('5 engine valve - replacement', 22, 3);
INSERT INTO [Problem] VALUES ('�orrection of scratches after impact', 25, 1);
INSERT INTO [Problem] VALUES ('�orrection of scratches after impact', 25, 1);
INSERT INTO [Problem] VALUES ('Engine reassembly', 25, 4);
INSERT INTO [Problem] VALUES ('4 engine valve - replacement', 15, 3);
INSERT INTO [Problem] VALUES ('4 engine valve - replacement', 31, 2);
INSERT INTO [Problem] VALUES ('Engine reassembly', 35, 4);
INSERT INTO [Problem] VALUES ('3 engine valve - replacement', 36, 4);
INSERT INTO [Problem] VALUES ('Engine reassembly', 32, 2);

/*
-- 	[RU] Наполнение данными таблицы Overdue
--		 Таблица Overdue имеет такие столбцы: 
--			ID Просрочки, Наименование, Стоимость

-- 	[EN] Insert data Overdue
--		 Table Overdue has these columns: 
--			ID Overdue, Name Overdue, Cost Overdue
*/
INSERT INTO [Overdue] VALUES ('Weekly delay', 2500);
INSERT INTO [Overdue] VALUES ('Mouth delay', 10000);
INSERT INTO [Overdue] VALUES ('Year delay', 120000);

/*
-- 	[RU] Наполнение данными таблицы Discount
--		 Таблица Discount имеет такие столбцы: 
--			ID Скидки, Наименование, Стоимость

-- 	[EN] Insert data Discount
--		 Table Discount has these columns: 
--			ID Discount, Name Discount, Cost Discount
*/
INSERT INTO [Discount] VALUES ('discount 1 stage', 10);
INSERT INTO [Discount] VALUES ('discount 2 stage', 20);
INSERT INTO [Discount] VALUES ('discount 3 stage', 30);
INSERT INTO [Discount] VALUES ('elite discount', 40);

/*
-- 	[RU] Наполнение данными таблицы Client
--		 Таблица Client имеет такие столбцы: 
--			ID Клиента, Фамилия, Имя, Отчество, Телефон, Почта, Дата рождения, Серия паспорта, Просрочка, Скидка

-- 	[EN] Insert data Client
--		 Table Client has these columns: 
--		 	ID Client, Surname Client, Name Client, Patronymic Client, Phone Client, Email Client, Date of birth Client, Passport Series Client, Overdue, Discount
*/
INSERT INTO [Client] VALUES ('Koporikov', 'Nikolay', 'Savveyevich', '89265652963', 'nikolay22091971@gmail.com', '1971-09-20', 6546, 645894, null, null);
INSERT INTO [Client] VALUES ('Chigrakova', 'Pelageya', 'Leontievnah', '89265654980', 'pelageya1972@rambler.ru', '1980-12-06', 3126, 156145, null, null);
INSERT INTO [Client] VALUES ('Nefedova', 'Mariana', 'Viktorovna', '89256523468', 'maryamna44@yandex.ru', '1985-05-03', 4654, 634488, null, null);
INSERT INTO [Client] VALUES ('Ivanova', 'Elsa', 'Ignatievna', '89569879789', 'ermiy26@gmail.com', '1995-12-15', 5646, 464848, null, null);
INSERT INTO [Client] VALUES ('Orlova', 'Nina', 'Nifontovna', '89645488979', 'prohor11051995@mail.ru', '2000-06-25', 5464, 348488, null, null);
INSERT INTO [Client] VALUES ('Sysoeva', 'Juliana', 'Savvanovna', '89734568547', 'timofey.romanov@gmail.com', '1995-25-01', 3468, 654345, null, null);
INSERT INTO [Client] VALUES ('Fenenko', 'Alyona', 'Grigorievna', '89156798567', 'valeriy03041988@rambler.ru', '1987-11-25', 4879, 465487, null, null);
INSERT INTO [Client] VALUES ('Kaipanov', 'Felix', 'Porfirievich', '8950464334', 'pavsikakiy07051976@gmail.com', '1979-09-27', 4658, 348789, null, null);
INSERT INTO [Client] VALUES ('Inozemtsev', 'Kirill', 'Maksimovich', '85464528975', 'arefiy3902@ya.ru', '1998-12-18', 4564, 654879, null, null);
INSERT INTO [Client] VALUES ('Kudrov', 'Arkady', 'Ivanovich', '85648541968', 'arseniy1978@rambler.ru', '1971-09-22', 4853, 887878, null, null);
INSERT INTO [Client] VALUES ('Efremova', 'Lyudmila', 'Llvona', '89563215498', 'vesta25111967@ya.ru', '1984-12-08', 4846, 634654, null, null);
INSERT INTO [Client] VALUES ('Karibzhanova', 'Evgeniya', 'Evgenievna', '89634678521', 'iolanta1975@ya.ru', '1971-08-15', 2188, 787668, null, null);
INSERT INTO [Client] VALUES ('Oborin', 'Georgy', 'Prokopievich', '87384687562', 'aleksiya08051981@outlook.com', '1985-09-27', 4563, 765466, null, null);
INSERT INTO [Client] VALUES ('Kustov', 'Konstantin', 'Nikitovich', '89562458563', 'liana.kolcova@mail.ru', '1971-09-22', 6542, 498789, null, null);
INSERT INTO [Client] VALUES ('Yakobson', 'Margarita', 'Denisovna', '84898563546', 'daniela1980@yandex.ru', '1979-03-09', 4879, 545643, null, null);
INSERT INTO [Client] VALUES ('Pirogova', 'Varvara', 'Egorovna', '86543245852', 'valeriya1976@mail.ru', '1983-05-17', 4562, 564543, null, null);
INSERT INTO [Client] VALUES ('Pokalyuk', 'Valentin', 'Germanovich', '89135748652', 'elmira15011960@outlook.com', '1986-12-30', 7564, 546543, null, null);
INSERT INTO [Client] VALUES ('Zanina', 'Yulia', 'Valeryevna', '89908564835', 'zara26101962@mail.ru', '1989-04-27', 7853, 564324, null, null);
INSERT INTO [Client] VALUES ('Baltabev', 'Peter', 'Alekseevich', '89861115646', 'vassa50@hotmail.com', '1989-12-03', 7654, 848978, null, null);
INSERT INTO [Client] VALUES ('Kaznova', 'Vera', 'Emelyanovna', '86434868796', 'nika13@yandex.ru', '1969-11-05', 8765, 876545, null, null);
INSERT INTO [Client] VALUES ('Katkin', 'Arkady', 'Innokentievich', '86432158786', 'anelya03111971@hotmail.com', '1995-10-22', 8746, 785645, null, null);
INSERT INTO [Client] VALUES ('Mishina', 'Antonina', 'Filippovna', '84523596875', 'nadejda13081990@rambler.ru', '1979-07-24', 3484, 465487, null, null);
INSERT INTO [Client] VALUES ('Zhilenkova', 'Valentina', 'Ivanovna', '86542468954', 'vladislava.kacenelenbogena@outlook.com', '1993-06-14', 3464, 546487, null, null);
INSERT INTO [Client] VALUES ('Zolotukhin', 'Georgy', 'Ignatievich', '86522458563', 'nikol3306@mail.ru', '1992-10-20', 4884, 346548, null, null);
INSERT INTO [Client] VALUES ('Ageykin', 'Afanasy', 'Arsenyevich', '89542658546', 'tamara11031989@gmail.com', '1979-04-26', 8489, 876543, null, null);
INSERT INTO [Client] VALUES ('Avodkova', 'Anastasia', 'Sevastyanovna', '86487565235', 'aleksiya8162@yandex.ru', '1981-02-12', 3487, 786465, null, null);
INSERT INTO [Client] VALUES ('Fonvizin', 'Stepan', 'Yakovlevich', '89054879535', 'yunona8791@outlook.com', '1991-11-22', 7654, 876456, null, null);
INSERT INTO [Client] VALUES ('Stepencov', 'Yurii', 'Nikolaevich', '89564868987', 'Yura12389@gmail.com', '1976-11-24', 8959, 392840, null, null);
INSERT INTO [Client] VALUES ('Novak', 'Lev', 'Semenovich', '89050069107', 'LevNovak364@outlook.com', '1992-08-21', 8785, 494984, null, null);
INSERT INTO [Client] VALUES ('Fedorov', 'Danila', 'Grigorievich', '89757883097', 'DanilaFedorov135@yandex.ru', '1996-10-26', 4648, 548975, null, null);
INSERT INTO [Client] VALUES ('Ohota', 'Margarita', 'Viktorovna', '85967489756', 'MargaritaOhota268@ya.ru', '1990-04-14', 4889, 484894, null, null);
INSERT INTO [Client] VALUES ('Kuzmina', 'Vlada', 'Nikolaevna', '81987895548', 'VladaKuzmina620@gmail.com', '1984-04-28', 4908, 489309, null, null);
INSERT INTO [Client] VALUES ('Tolmachev', 'Oleg', 'Petrovich', '89541689544', 'OlegTolmachev773@bk.ru', '1994-09-22', 6579, 616565, null, null);
INSERT INTO [Client] VALUES ('Tikhomirov', 'Potap', 'Viktorovich', '86548945685', 'PotapTihomirov170@index.ru', '1974-03-22', 8495, 654878, null, null);
INSERT INTO [Client] VALUES ('Dorzhinova', 'Adelaida', 'Platonovna', '86548798595', 'AdelaidaDorzhinova56@mail.ru', '1984-11-02', 4898, 324878, null, null);
INSERT INTO [Client] VALUES ('Oblomov', 'Luka', 'Borisovich', '84984886548', 'LukaOblomov835@mail.ru', '1969-02-29', 4848, 654895, null, null);
INSERT INTO [Client] VALUES ('Panchenko', 'Tamara', 'Tarasovna', '88945654595', 'TamaraPanchenko232@ya.ru', '1984-04-28', 4898, 845468, null, null);
INSERT INTO [Client] VALUES ('Orlovsky', 'Irakli', 'Arkadievich', '85954895456', 'IrakliyOrlovskiy278@gmail.com', '1990-07-29', 6548, 654895, null, null);
INSERT INTO [Client] VALUES ('Varfolomeev', 'Gerasim', 'Eldarovich', '89548566515', 'GerasimVarfolomeev420@gmail.com', '1995-09-15', 8778, 654895, null, null);
INSERT INTO [Client] VALUES ('Malyshev', 'Rurik', 'Nikolaevich', '85149884868', 'RyurikMalyshev634@ya.ru', '1983-03-18', 6489, 489532, null, null);
INSERT INTO [Client] VALUES ('Mechnikov', 'Julian', 'Kirillovich', '88946589789', 'YulianMechnikov540@bk.ru', '1984-09-18', 4908, 489309, null, null);
INSERT INTO [Client] VALUES ('Dotsenko', 'Henrietta', 'Borisovna', '85695845525', 'GenriettaDotsenko477@outlook.com', '1991-04-20', 4568, 658987, null, null);
INSERT INTO [Client] VALUES ('Polyakova', 'Maria', 'Artemovna', '85958795987', 'MariyaPolyakova575@outlook.com', '1989-09-06', 5689, 568975, null, null);
INSERT INTO [Client] VALUES ('Leontieva', 'Vladlena', 'Romanovna', '88194895588', 'VladlenaLeontieva489@gmail.com', '1989-04-06', 5985, 485265, null, null);
INSERT INTO [Client] VALUES ('Komarov', 'Demyan', 'Timurovich', '89856528548', 'DemyanKomarow423@rambler.ru', '2000-09-18', 1589, 895489, null, null);
INSERT INTO [Client] VALUES ('Karpova', 'Bronislava', 'Antonovna', '85984865857', 'BronslavaKarpova435@protonmail.com', '1998-12-03', 5985, 589485, null, null);
INSERT INTO [Client] VALUES ('Rustamova', 'Erika', 'Valentinovna', '85495289548', 'ErikaRustamova@gmail.com', '1992-09-14', 8595, 589287, null, null);
INSERT INTO [Client] VALUES ('Zimina', 'Fedosya', 'Tarasovna', '85289577758', 'FedosyaTarasovna708@rambler.ru', '1982-08-03', 5985, 159854, null, null);
INSERT INTO [Client] VALUES ('Andreev', 'Lavr', 'Evgenievich', '82564256956', 'LavrAndreev432@gmail.com', '1996-07-31', 5983, 159854, null, null);
INSERT INTO [Client] VALUES ('Vladimirova', 'Ekaterina', 'Maximovna', '85981565896', 'EkaterinaVladimirova893@gmail.com', '1988-07-11', 1568, 565415, null, null);
INSERT INTO [Client] VALUES ('Sanin', 'Bronislav', 'Pavlovich', '82561889560', 'BronislavSanin874@ya.ru', '1993-01-30', 6556, 568595, null, null);
INSERT INTO [Client] VALUES ('Shakhuro', 'Karp', 'Grigorievich', '87983427898', 'KarpShakhuro432@outlook.com', '1992-07-21', 5669, 854983, null, null);
INSERT INTO [Client] VALUES ('Nikiforov', 'Yan', 'Valerievich', '83267837182', 'YanNikiforov723@gmail.com', '1998-01-28', 9859, 489318, null, null);
INSERT INTO [Client] VALUES ('Betrozova', 'Victoria', 'Danilovna', '81987895548', 'VladaKuzmina620@gmail.ru', '1984-04-28', 4908, 489309, null, null);

/*
-- 	[RU] Наполнение данными таблицы Rental
-- 	[EN] Insert Data Rental 
*/
INSERT INTO [Rental] VALUES (1, 29, 43, '2022-10-14', '2022-11-14');
INSERT INTO [Rental] VALUES (2, 23, 78, '2022-06-28', '2022-07-28');
INSERT INTO [Rental] VALUES (3, 39, 12, '2019-11-19', '2019-12-19');
INSERT INTO [Rental] VALUES (4, 36, 46, '2012-12-10', '2013-01-10');
INSERT INTO [Rental] VALUES (5, 8, 68, '2014-09-02', '2014-10-02');
INSERT INTO [Rental] VALUES (4, 37, 8, '2013-05-15', '2013-06-15');
INSERT INTO [Rental] VALUES (4, 15, 78, '2014-07-14', '2014-08-14');
INSERT INTO [Rental] VALUES (2, 50, 5, '2019-09-30', '2019-10-30');
INSERT INTO [Rental] VALUES (3, 12, 80, '2019-07-08', '2019-08-08');
INSERT INTO [Rental] VALUES (2, 35, 50, '2018-07-12', '2018-08-12');
INSERT INTO [Rental] VALUES (4, 20, 42, '2013-11-05', '2013-12-05');
INSERT INTO [Rental] VALUES (5, 30, 11, '2012-02-14', '2012-03-14');
INSERT INTO [Rental] VALUES (2, 44, 37, '2010-01-09', '2010-02-09');
INSERT INTO [Rental] VALUES (4, 52, 24, '2018-03-01', '2018-04-01');
INSERT INTO [Rental] VALUES (1, 9, 46, '2016-12-11', '2017-01-11');
INSERT INTO [Rental] VALUES (2, 53, 40, '2010-06-24', '2010-07-24');
INSERT INTO [Rental] VALUES (5, 54, 31, '2019-01-14', '2019-02-14');
INSERT INTO [Rental] VALUES (3, 49, 78, '2012-11-23', '2012-12-23');
INSERT INTO [Rental] VALUES (4, 41, 55, '2015-05-31', '2015-06-31');
INSERT INTO [Rental] VALUES (1, 23, 67, '2012-09-21', '2012-10-21');
INSERT INTO [Rental] VALUES (1, 19, 81, '2015-02-17', '2015-03-17');
INSERT INTO [Rental] VALUES (2, 26, 37, '2010-10-06', '2010-11-06');
INSERT INTO [Rental] VALUES (2, 51, 28, '2020-12-25', '2021-01-25');
INSERT INTO [Rental] VALUES (3, 49, 55, '2019-03-13', '2019-04-13');
INSERT INTO [Rental] VALUES (4, 5, 31, '2016-06-07', '2016-07-07');
INSERT INTO [Rental] VALUES (2, 52, 40, '2019-07-27', '2019-08-27');
INSERT INTO [Rental] VALUES (5, 47, 39, '2018-11-07', '2018-12-07');
INSERT INTO [Rental] VALUES (2, 22, 38, '2012-12-14', '2013-01-14');
INSERT INTO [Rental] VALUES (5, 43, 53, '2014-06-06', '2014-07-06');
INSERT INTO [Rental] VALUES (2, 11, 66, '2010-07-10', '2010-08-10');
INSERT INTO [Rental] VALUES (2, 10, 51, '2014-04-23', '2014-05-23');
INSERT INTO [Rental] VALUES (1, 19, 44, '2019-02-27', '2019-03-27');
INSERT INTO [Rental] VALUES (4, 50, 49, '2016-04-24', '2016-04-24');
INSERT INTO [Rental] VALUES (2, 3, 27, '2012-01-17', '2012-02-17');
INSERT INTO [Rental] VALUES (3, 29, 62, '2020-11-12', '2020-12-12');
INSERT INTO [Rental] VALUES (2, 17, 64, '2015-07-30', '2015-08-30');
INSERT INTO [Rental] VALUES (4, 41, 63, '2016-03-11', '2016-04-11');
INSERT INTO [Rental] VALUES (5, 4, 19, '2018-06-15', '2018-07-15');
INSERT INTO [Rental] VALUES (2, 6, 72, '2019-10-06', '2019-11-06');
INSERT INTO [Rental] VALUES (2, 6, 76, '2017-06-02', '2017-07-02');
INSERT INTO [Rental] VALUES (3, 26, 28, '2017-06-18', '2017-07-18');
INSERT INTO [Rental] VALUES (2, 30, 39, '2014-02-17', '2014-03-17');
INSERT INTO [Rental] VALUES (1, 29, 44, '2016-02-24', '2016-03-24');
INSERT INTO [Rental] VALUES (3, 44, 10, '2017-10-15', '2017-11-15');
INSERT INTO [Rental] VALUES (4, 35, 66, '2016-05-28', '2016-06-28');
INSERT INTO [Rental] VALUES (2, 7, 74, '2017-09-03', '2017-10-03');
INSERT INTO [Rental] VALUES (3, 5, 36, '2018-03-23', '2018-04-23');
INSERT INTO [Rental] VALUES (4, 31, 17, '2020-07-01', '2020-08-01');
INSERT INTO [Rental] VALUES (2, 40, 7, '2013-04-14', '2013-05-14');
INSERT INTO [Rental] VALUES (3, 7, 43, '2011-05-26', '2011-06-26');
INSERT INTO [Rental] VALUES (3, 27, 8, '2018-08-21', '2018-09-21');
INSERT INTO [Rental] VALUES (2, 13, 58, '2014-09-30', '2014-10-30');
INSERT INTO [Rental] VALUES (3, 7, 16, '2013-03-08', '2013-04-08');
INSERT INTO [Rental] VALUES (2, 7, 73, '2010-06-24', '2010-07-24');
INSERT INTO [Rental] VALUES (4, 7, 53, '2016-04-02', '2016-05-02');
INSERT INTO [Rental] VALUES (2, 6, 81, '2018-11-18', '2018-12-18');
INSERT INTO [Rental] VALUES (4, 35, 57, '2011-02-23', '2011-03-23');
INSERT INTO [Rental] VALUES (2, 34, 71, '2015-03-25', '2015-04-25');
INSERT INTO [Rental] VALUES (4, 11, 20, '2013-08-04', '2013-09-04');
INSERT INTO [Rental] VALUES (2, 52, 32, '2010-04-30', '2010-05-30');
INSERT INTO [Rental] VALUES (1, 44, 63, '2016-08-13', '2016-09-13');
INSERT INTO [Rental] VALUES (2, 6, 23, '2014-02-03', '2014-03-03');
INSERT INTO [Rental] VALUES (4, 7, 34, '2014-10-08', '2014-11-08');
INSERT INTO [Rental] VALUES (5, 32, 2, '2016-06-28', '2016-07-28');
INSERT INTO [Rental] VALUES (2, 54, 8, '2022-08-26', '2022-09-26');
INSERT INTO [Rental] VALUES (4, 44, 77, '2015-09-05', '2015-10-05');
INSERT INTO [Rental] VALUES (2, 47, 58, '2010-03-19', '2010-04-19');
INSERT INTO [Rental] VALUES (3, 18, 16, '2016-10-14', '2016-11-14');
INSERT INTO [Rental] VALUES (2, 4, 73, '2015-12-15', '2016-01-15');
INSERT INTO [Rental] VALUES (3, 13, 53, '2016-05-17', '2016-06-17');
INSERT INTO [Rental] VALUES (2, 37, 81, '2017-06-23', '2017-07-23');
INSERT INTO [Rental] VALUES (1, 54, 7, '2011-08-25', '2011-09-25');
INSERT INTO [Rental] VALUES (2, 18, 57, '2017-12-09', '2018-01-09');
INSERT INTO [Rental] VALUES (3, 4, 71, '2016-01-08', '2016-02-08');
INSERT INTO [Rental] VALUES (4, 13, 20, '2015-12-06', '2016-01-06');
INSERT INTO [Rental] VALUES (2, 37, 32, '2016-01-19', '2016-02-19');
INSERT INTO [Rental] VALUES (3, 54, 63, '2014-10-13', '2014-11-13');
INSERT INTO [Rental] VALUES (2, 18, 23, '2014-01-27', '2014-02-27');
INSERT INTO [Rental] VALUES (3, 34, 34, '2013-09-08', '2013-10-08');
INSERT INTO [Rental] VALUES (2, 32, 2, '2017-04-03', '2017-05-03');
INSERT INTO [Rental] VALUES (1, 33, 8, '2020-07-07', '2020-08-07');
INSERT INTO [Rental] VALUES (2, 39, 77, '2020-12-17', '2021-01-17');
INSERT INTO [Rental] VALUES (1, 4, 18, '2013-01-24', '2013-02-24');
INSERT INTO [Rental] VALUES (4, 38, 72, '2020-04-29', '2020-05-29');
INSERT INTO [Rental] VALUES (2, 20, 10, '2019-07-31', '2019-08-30');
INSERT INTO [Rental] VALUES (3, 6, 53, '2012-12-14', '2013-01-14');
INSERT INTO [Rental] VALUES (3, 18, 45, '2018-03-06', '2018-04-06');
INSERT INTO [Rental] VALUES (4, 32, 19, '2014-05-08', '2014-06-08');
INSERT INTO [Rental] VALUES (5, 30, 49, '2020-11-27', '2020-12-27');
INSERT INTO [Rental] VALUES (4, 44, 57, '2019-10-15', '2019-11-15');
INSERT INTO [Rental] VALUES (2, 23, 75, '2022-08-02', '2022-09-02');
INSERT INTO [Rental] VALUES (4, 27, 69, '2013-09-07', '2013-10-07');
INSERT INTO [Rental] VALUES (1, 1, 60, '2012-07-01', '2012-08-01');
INSERT INTO [Rental] VALUES (1, 53, 9, '2013-10-16', '2013-11-16');
INSERT INTO [Rental] VALUES (1, 4, 81, '2014-06-26', '2014-07-26');
INSERT INTO [Rental] VALUES (2, 52, 12, '2014-05-25', '2014-06-25');
INSERT INTO [Rental] VALUES (3, 4, 57, '2019-05-12', '2019-06-12');
INSERT INTO [Rental] VALUES (4, 38, 31, '2019-12-27', '2020-01-27');
INSERT INTO [Rental] VALUES (2, 20, 12, '2020-10-02', '2020-11-02');
INSERT INTO [Rental] VALUES (2, 32, 74, '2014-06-17', '2014-07-17');
INSERT INTO [Rental] VALUES (3, 18, 2, '2017-09-07', '2017-10-07');
INSERT INTO [Rental] VALUES (1, 21, 71, '2014-11-02', '2014-12-02');
INSERT INTO [Rental] VALUES (2, 10, 37, '2012-01-19', '2012-02-19');
INSERT INTO [Rental] VALUES (3, 51, 61, '2017-08-03', '2017-09-03');
INSERT INTO [Rental] VALUES (4, 30, 8, '2014-12-20', '2015-01-20');
INSERT INTO [Rental] VALUES (3, 44, 59, '2013-05-02', '2013-06-02');
INSERT INTO [Rental] VALUES (2, 1, 72, '2019-04-19', '2019-05-19');
INSERT INTO [Rental] VALUES (3, 23, 24, '2018-06-26', '2018-07-26');
INSERT INTO [Rental] VALUES (2, 27, 59, '2019-09-29', '2019-10-29');
INSERT INTO [Rental] VALUES (3, 29, 11, '2013-10-23', '2013-11-23');
INSERT INTO [Rental] VALUES (4, 25, 20, '2011-05-24', '2011-06-24');
INSERT INTO [Rental] VALUES (2, 11, 48, '2020-10-22', '2020-11-22');
INSERT INTO [Rental] VALUES (3, 54, 55, '2012-10-28', '2012-11-28');
INSERT INTO [Rental] VALUES (3, 49, 60, '2017-02-24', '2017-03-24');
INSERT INTO [Rental] VALUES (1, 29, 40, '2010-05-16', '2010-06-16');
INSERT INTO [Rental] VALUES (3, 52, 71, '2011-07-17', '2011-08-17');
INSERT INTO [Rental] VALUES (2, 25, 22, '2017-07-29', '2017-08-29');
INSERT INTO [Rental] VALUES (4, 16, 53, '2020-09-10', '2020-10-10');
INSERT INTO [Rental] VALUES (5, 10, 75, '2015-03-08', '2015-04-08');
INSERT INTO [Rental] VALUES (2, 6, 75, '2015-10-13', '2015-11-13');
INSERT INTO [Rental] VALUES (2, 17, 75, '2016-01-10', '2016-02-10');
INSERT INTO [Rental] VALUES (1, 27, 22, '2017-07-25', '2017-08-25');
INSERT INTO [Rental] VALUES (2, 43, 61, '2011-06-21', '2011-07-21');
INSERT INTO [Rental] VALUES (2, 24, 69, '2013-01-25', '2013-02-25');
INSERT INTO [Rental] VALUES (3, 51, 51, '2010-10-29', '2010-11-29');
INSERT INTO [Rental] VALUES (1, 7, 64, '2017-06-11', '2017-07-11');
INSERT INTO [Rental] VALUES (2, 8, 44, '2014-04-29', '2014-05-29');
INSERT INTO [Rental] VALUES (3, 6, 73, '2010-08-10', '2010-09-10');
INSERT INTO [Rental] VALUES (32, 34, 50, '2020-11-01', '2020-12-01');
INSERT INTO [Rental] VALUES (3, 34, 3, '2010-03-09', '2010-04-09');
INSERT INTO [Rental] VALUES (2, 22, 79, '2018-08-16', '2018-09-16');
INSERT INTO [Rental] VALUES (2, 7, 75, '2010-07-06', '2010-08-06');
INSERT INTO [Rental] VALUES (3, 7, 17, '2015-03-12', '2015-04-12');
INSERT INTO [Rental] VALUES (1, 3, 12, '2015-07-31', '2015-08-31');
INSERT INTO [Rental] VALUES (2, 41, 9, '2016-02-20', '2016-03-20');
INSERT INTO [Rental] VALUES (2, 29, 27, '2011-10-03', '2011-11-03');
INSERT INTO [Rental] VALUES (4, 5, 26, '2020-10-10', '2020-11-10');
INSERT INTO [Rental] VALUES (5, 6, 69, '2019-01-09', '2019-02-09');
INSERT INTO [Rental] VALUES (3, 29, 32, '2014-08-19', '2014-09-19');
INSERT INTO [Rental] VALUES (2, 25, 1, '2012-02-26', '2012-03-26');
INSERT INTO [Rental] VALUES (3, 48, 11, '2015-11-14', '2015-12-14');
INSERT INTO [Rental] VALUES (2, 3, 24, '2014-08-16', '2014-09-16');
INSERT INTO [Rental] VALUES (4, 35, 11, '2013-11-04', '2013-12-04');
INSERT INTO [Rental] VALUES (5, 5, 38, '2016-08-01', '2016-09-01');
INSERT INTO [Rental] VALUES (3, 29, 30, '2020-05-07', '2020-06-07');
