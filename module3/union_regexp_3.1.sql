create database university;

use university;

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

-- Отобразить ФИО из таблиц: работник, преподаватель, студент в одном запросе;
select ФИО from преподаватель
union
select ФИО from работник
union
select ФИО from студент;

-- Отобразить ФИО из таблиц: работник, преподаватель, студент в одном запросе с отображением строк-дубликатов с сортировкой по убыванию;
select ФИО from преподаватель
union all
select ФИО from работник
union all
select ФИО from студент
order by 1 desc;

-- Отобразить ФИО из таблиц: работник, преподаватель, студент где ФИО = ‘Катич Б.Д’ в одном запросе.
select * from (
	select ФИО from преподаватель
	union all
	select ФИО from работник
	union all
	select ФИО from студент) as FIO
where ФИО = 'Катич Б.Д';

-- Оператор REGEXP
use world;

-- Отобразить имя (Name) и округ (District) из таблицы city где названии округа имеется слово ‘Central’.
select Name, District
from city c 
where District regexp 'Central'

-- Отобразить имя (Name) из таблицы city где в имени имеется символ Ã.
select Name
from city c 
where Name regexp '[Ã]';

-- Отобразите всю информацию о городах, где код страны заканчивается символом ‘N’
select Name
from city c 
where CountryCode regexp 'N$';

-- Отобразите всю информацию о городах, где код страны начинается с символа ‘N’
select Name
from city c 
where CountryCode regexp '^N';

-- Отобразите всю информацию о городах, где код страны начинается или заканчивается символом ‘N’
select Name
from city c 
where CountryCode regexp '(^N|N$)';