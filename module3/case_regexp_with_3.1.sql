use sakila;

/* Выведите title, replacement_cost, rental_duration, Состояние из таблицы film, где столбец Состояние формируется за счет использования конструкции CASE со следующими условиями:
· Вывести ‘ОК’ если rental_duration равен 3;
· Вывести ‘Внимание!’ если rental_duration равен 4 или 5;
· Вывести ‘Штраф: ’ и величину штрафа в размере 30% от replacement_cost если rental_duration равен 6;
· Вывести ‘Штраф: ’ и величину штрафа в размере 50% от replacement_cost если rental_duration равен 7 и replacement_cost меньше 20;
· Вывести ‘Штраф: ’ и величину штрафа в размере 100% от replacement_cost если rental_duration равен 7 и replacement_cost больше либо равна 20;
В выборке участвуют только фильмы, имеющие film_id меньше 100 */
select 
	title,
	replacement_cost,
	rental_duration,
	case
		when rental_duration = 3 then 'ok'
		when rental_duration = 4 or rental_duration = 5 then 'attention'
		when rental_duration = 6 then concat('fine:', ' ', cast(replacement_cost + (replacement_cost * (30 / 100)) as decimal(8, 2)))
		when rental_duration = 7 and replacement_cost < 20 then concat('fine:', ' ', cast(replacement_cost + (replacement_cost * (50 / 100)) as decimal(8, 2)))
		when rental_duration = 7 and replacement_cost >= 20 then concat('fine:', ' ', cast(replacement_cost * 2 as decimal(8, 2)))
	end as rent_cond
from film
where film_id < 100;

/* Отобразите всю информацию из таблицы sakila.film, где:
· в описании фильма (description) говорится о драме девушки или робота (ключевые слова: ‘Drama of a’, ‘Girl’, ‘Robot’);
· поле special_features содержит слово ‘Trailers’;
· поле rating начинается с символа ‘P’ или заканчивается символом (цифрой) ‘3’;
· поле rental_rate содержит символы (цифры) в диапазоне от 1 до 4;
· поле title содержит слово ‘GUN’ */
select * from film
where 
	description regexp 'Drama of a.*Girl.*Robot'
	and special_features regexp 'Trailers'
	and rating regexp '^P.*3$'
	and rental_rate regexp '[1, 2, 3, 4]'
	and title regexp 'GUN$'
	
/* Напишите следующий запрос с обобщенным запросом:
Подзапрос codes(code): выбрать customer_id из таблицы customer, значения которых находятся в подзапросе на выборку customer_id в таблице payment
где значения rental_id находятся в подзапросе на выборку rental_id в таблице rental,
где значения inventory_id находятся в подзапросе на выборку inventory_id в таблице inventory,
где значения film_id находятся в подзапросе на выборку film_id из таблицы film,
где значения столбца description содержит слово ‘Drama’ и rating = ‘R’ и length > 170.
Запрос:
· Выбрать customer_id (назовите его Код), сумму всех выплат (amount) из таблицы payment, где значения customer_id находятся в подзапросе на выборку code из обобщенного запроса codes.
· Выполните группировку по customer_id.
· Добавить CASE Категория со следующими вариантами:
	o Если сумма платежей >= 1 и <= 90, то вывести ‘Classic’;
	o Если сумма платежей >= 91 и <= 150, то вывести ‘PREMIUM’;
	o Иначе вывести ‘PREMIUM+’ */
with codes as (
	select 
		customer_id
	from customer 
	where customer_id in 
	(select customer_id from payment where customer_id in
	(select rental_id from rental where inventory_id in
	(select inventory_id from inventory where film_id in
	(select film_id from film where description regexp 'Drama' and rating = 'R' and length > 170)))))
select 
	customer_id as 'Код', 
	sum(amount) as 'Сумма всех выплат',
	case 
		when sum(amount) between 1 and 90 then 'Classic'
		when sum(amount) between 91 and 150 then 'PREMIUM'
		else 'ULTRA MEGA SUPER VIP'
	end as 'Категория'
from payment
where customer_id in (select customer_id from codes)
group by 1;