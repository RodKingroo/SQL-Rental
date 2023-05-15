/*
--  [Russian]
--  Триггер 1.
--  Создать триггер, который бы по запросу пользователя удалял работников из БД

-- Ремарка:
-- Используется база данных RentalDB.
-- Таблица:
--      [Worker](id_worker, second_name_worker, first_name_worker, middle_name_worker,
	             telephone_worker, email_worker, experience_worker).

--  НУЖНО
--  Создать триггер, который бы по запросу пользователя удалял работников из БД
--  Использование, курсоров и процедур, по необходимости

--  [English]
--  Trigger 1.
--  Create a trigger, which removes workers from the database.

--  Remark:
--  Use database RentalDB.
--  Table:
--      [Worker](id_worker, second_name_worker, first_name_worker, middle_name_worker,
                 telephone_worker, email_worker, experience_worker).
    
--  NEED
--  Create a trigger, which removes workers from the database.
--  Use cursorors and procedures, if needed
*/
GO
DECLARE @id_worker INT;
SET @id_worker = 3;
DELETE FROM Worker WHERE id_worker = @id_worker

GO
CREATE OR ALTER TRIGGER DeleteWorkerTrigger
ON Worker
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @id INT;
    DECLARE cur_for_delete CURSOR FOR SELECT id_worker FROM deleted;
    OPEN cur_for_delete;
    FETCH NEXT FROM cur_for_delete INTO @id;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        DELETE FROM Rental WHERE id_worker_rental = @id;
        DELETE FROM Worker WHERE id_worker = @id;
        FETCH NEXT FROM cur_for_delete INTO @id;
    END
    CLOSE cur_for_delete;
    DEALLOCATE cur_for_delete;
END


GO
SELECT * FROM Worker
