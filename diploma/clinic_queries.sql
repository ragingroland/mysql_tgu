USE clinic;

-- Запрос с использованием операторов: WHERE, AND, OR
SELECT *
FROM ПРИЁМ
WHERE (Дата_приёма BETWEEN '2024-06-18' AND '2024-06-22')
    AND (Врач = 1 OR Врач = 3);

-- Запрос с использованием операторов: BETWEEN, ORDER BY
SELECT *
FROM ПАЦИЕНТ
WHERE СНИЛС BETWEEN '234-567-890 12' AND '567-890-123 45'
ORDER BY ФИО;

-- Запрос с использованием конструкции GROUP BY в сочетании с любой агрегатной функцией
SELECT Врач, COUNT(*) AS Количество_приёмов
FROM ПРИЁМ
GROUP BY Врач;

-- Запрос с подзапросом и ANY или ALL
SELECT *
FROM ПАЦИЕНТ
WHERE ID_Пациента IN (
    SELECT Пациент
    FROM ДИАГНОЗ
    WHERE Код_заболевания > ALL (
        SELECT Код_Заболевания
        FROM ЗАБОЛЕВАНИЕ
        WHERE Код_Заболевания >= 5
    )
);

-- Объединенные запросы с использованием оператора UNION/UNION ALL
SELECT ID_Пациента AS Идентификатор, ФИО, 'Пациент' AS Тип
FROM ПАЦИЕНТ
UNION
SELECT ID_Врача, ФИО, 'Врач'
FROM ВРАЧ;

-- Запрос с использованием оператора LIKE
SELECT *
FROM ЗАБОЛЕВАНИЕ
WHERE Расшифровка LIKE 'Г%';

-- Запрос с использованием конструкции CASE
SELECT *,
    CASE
        WHEN Дата_приёма > NOW() THEN 'Предстоящий прием'
        ELSE 'Прошедший прием'
    END AS Статус_приёма
FROM ПРИЁМ;

-- INSERT
INSERT INTO ПАЦИЕНТ (ФИО, СНИЛС)
VALUES ('Зайцева Екатерина Владимировна', '123-123-123 45');

-- UPDATE
UPDATE ВРАЧ
SET Специализация = 'Отоларинголог'
WHERE ID_Врача = 2;

-- DELETE
DELETE FROM ПРИЁМ
WHERE Дата_приёма < NOW();
