-- Вывести объединенные данные Country, City, Address. Получить записи вида, Страна, Город, Адрес.
select
	country as 'страна',
	city as 'город',
	address as 'адрес'
from country c 
join city c2 on c.country_id = c2.country_id 
join address a on c2.city_id = a.city_id;

-- Вывести Адрес(полный), менеджера для Store
select
	address as manager_address,
	concat(first_name, ' ', last_name) as manager_name 
from address a 
join staff s on a.address_id = s.address_id;

-- Вывести данные об аренде (Какой фильм, какой магазин, полный адрес магазина, ФИО клиента и ФИО сотрудника
select
	f.title,
	s2.store_id,
	concat(a.address, ' ', a.district) as address,
	concat(c.first_name, ' ', c.last_name) as customer_name,
	concat(s.first_name, ' ', s.last_name) as staff_name
from rental r
left join inventory i on r.inventory_id = i.inventory_id 
left join film f on i.film_id = f.film_id 
left join store s2 on i.store_id = s2.store_id 
left join address a on s2.address_id = a.address_id 
left join customer c on r.customer_id = c.customer_id 
left join staff s on r.staff_id = s.staff_id 
	
-- Получить данные о платежах (Какой магазин, полный адрес магазина, ФИО клиента и ФИО сотрудника, Сумма, платежный день)
select
	s.store_id,
	a.address,
	concat(c.first_name, ' ', c.last_name) as customer_name,
	concat(s.first_name, ' ', s.last_name) as staff_name,
	amount,
	payment_date
from payment p
join customer c on p.customer_id = c.customer_id
left join staff s on s.staff_id = p.staff_id
left join store s2 on s.store_id = s2.store_id 
left join address a on s2.address_id = a.address_id;
	
-- Сформировать View для запроса 4, после чего сгруппировать данные по клиентам и магазинам и вывести Общую сумму платежей!
create view rental_view as (
	select
		s.store_id,
		a.address,
		concat(c.first_name, ' ', c.last_name) as customer_name,
		concat(s.first_name, ' ', s.last_name) as staff_name,
		amount,
		payment_date
	from payment p
	join customer c on p.customer_id = c.customer_id
	left join staff s on s.staff_id = p.staff_id
	left join store s2 on s.store_id = s2.store_id 
	left join address a on s2.address_id = a.address_id);
	
select distinct 
	store_id,
	customer_name,
	sum(amount) over() as `sum`
from rental_view;