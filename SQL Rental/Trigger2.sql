/*
--  [Russian]
--  Триггер 2.
--  Создать триггер, который при добавлении/обновлении данных работника пишет его фамилию ЗАГЛАВНЫМИ буквами

--  Ремарка:
--  Используется база данных RentalDB.
--  Таблица:
--      [Worker](id_worker, second_name_worker, first_name_worker, middle_name_worker,
-- 	             telephone_worker, email_worker, experience_worker).

--  НУЖНО:
--  Создать триггер, который при добавлении/обновлении данных работника пишет его фамилию ЗАГЛАВНЫМИ буквами
--  В случае если все уже в существующих работников фамилия обновилась по правилам выше

--  [English]
--  Trigger 2.
--  Create a trigger, which when adding a worker writes his last name in upper case

--  Remark:
--  Uses database RentalDB.
--  Table:
--      [Worker](id_worker, second_name_worker, first_name_worker, middle_name_worker,
--                  telephone_worker, email_worker, experience_worker).

--  NEED:
--  Create a trigger, which when adding a worker writes his last name in upper case.
--  If all workers already exist in the database, the last name is updated according to the rules
*/

GO
INSERT INTO Worker
VALUES ('Иванов', 'Иван', 'Иванович', '88005553535', 'ivanov@mail.ru', '2021-01-01');

UPDATE Worker 
SET second_name_worker = UPPER(w.second_name_worker)
FROM Worker w


GO
CREATE OR ALTER TRIGGER TrgWorkerInsert
ON Worker
INSTEAD OF INSERT, UPDATE
AS
BEGIN
    UPDATE Worker
    SET second_name_worker = UPPER(w.second_name_worker)
    FROM Worker w
    JOIN inserted ON w.id_worker = inserted.id_worker
END


GO
SELECT * FROM Worker;