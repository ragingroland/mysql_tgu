ЗАДАНИЕ 3.1.1
I. Создайте новую базу данных под названием “университет” (при помощи запроса или интерфейса СУБД);
II. Выберите созданную базу в качестве базы по умолчанию.
1. Создайте таблицы при помощи следующих запросов:

CREATE TABLE студент (
ID INT NOT NULL AUTO_INCREMENT,
ФИО VARCHAR(30) NOT NULL,
PRIMARY KEY (ID)
);
CREATE TABLE преподаватель (
ID INT NOT NULL AUTO_INCREMENT,
ФИО VARCHAR(30) NOT NULL,
PRIMARY KEY (ID)
);
CREATE TABLE работник (
ID INT NOT NULL AUTO_INCREMENT,
ФИО VARCHAR(30) NOT NULL,
PRIMARY KEY (ID)
);

2. Заполните таблицы данными при помощи следующих запросов:

INSERT INTO преподаватель (ФИО)
VALUES ('Иванов И.И'), ('Петров С.Ф'), ('Воробьёв Ч.Е'),
('Гетс У.К'), ('Варич Р.П'), ('Лебедев О.О'),
('Тодорович Л.К'), ('Катич Б.Д'), ('Шоц Р.И');
INSERT INTO работник (ФИО)
VALUES ('Петрович Н.В'), ('Горов Л.В'), ('Катич Б.Д'),
('Говоров З.Ф'), ('Воронова Л.Ш'), ('Птичкина В.О'),
('Гладенцева Ф.Н'), ('Лодка Л.П'), ('Варич Р.П');
INSERT INTO студент (ФИО)
VALUES ('Котов Л.У'), ('Щедрова Т.К'), ('Зверев Р.П'),
('Головко Л.Д'), ('Кротов И.П'), ('Катич Б.Д'),
('Вари Е.С'), ('Варич Р.П'), ('Долженников З.Е');

Конструкция UNION

1. Отобразить ФИО из таблиц: работник, преподаватель, студент в одном запросе;
2. Отобразить ФИО из таблиц: работник, преподаватель, студент в одном запросе с отображением строк-дубликатов с сортировкой по убыванию;
3. Отобразить ФИО из таблиц: работник, преподаватель, студент где ФИО = ‘Катич Б.Д’ в одном запросе.

Оператор REGEXP

Выберите базу world в качестве базы по умолчанию.

1. Отобразить имя (Name) и округ (District) из таблицы city где названии округа имеется слово ‘Central’.
2. Отобразить имя (Name) из таблицы city где в имени имеется символ Ã.
3. Отобразите всю информацию о городах, где код страны заканчивается символом ‘N’
4. Отобразите всю информацию о городах, где код страны начинается с символа ‘N’
5. Отобразите всю информацию о городах, где код страны начинается или заканчивается символом ‘N’

Задание 3.1.2
Выберите базу sakila в качестве базы по умолчанию.

Вам необходимо провести проверку текущего положения дел в прокате фильмов.

Примем следующие условия:

· Столбец rental_duration – время (в днях), которое фильм находится у клиента в аренде. Для данного столбца существуют следующие условности:
o Срок величиной 3 дня – норма;
o Срок величиной 4-5дней – требует внимания (ставим на учет);
o Срок величиной 6 дней карается штрафом в размере 30% от стоимости замены (replacement_cost);
o Срок величиной 7 дней для фильмов стоимостью меньше 20$ карается штрафом в размере 50% от стоимости замены (replacement_cost);
o Срок величиной 7 дней для фильмов стоимостью равную 20$ или более карается штрафом в размере 100% от стоимости замены (replacement_cost);

· Проверка производится над фильмами, код которых (film_id) меньше 100.

Принимая во внимание перечисленные условия, напишите следующий запрос:

Выведите title, replacement_cost, rental_duration, Состояние из таблицы film, где столбец Состояние формируется за счет использования конструкции CASE со следующими условиями:
· Вывести ‘ОК’ если rental_duration равен 3;
· Вывести ‘Внимание!’ если rental_duration равен 4 или 5;
· Вывести ‘Штраф: ’ и величину штрафа в размере 30% от replacement_cost если rental_duration равен 6;
· Вывести ‘Штраф: ’ и величину штрафа в размере 50% от replacement_cost если rental_duration равен 7 и replacement_cost меньше 20;
· Вывести ‘Штраф: ’ и величину штрафа в размере 100% от replacement_cost если rental_duration равен 7 и replacement_cost больше либо равна 20;
В выборке участвуют только фильмы, имеющие film_id меньше 100.
//Для вывода штрафа (текст + число) используйте функцию CONCAT.