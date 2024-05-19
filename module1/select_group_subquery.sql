select customer_id as 'Клиент', sum(amount) as 'Всего' from sakila.payment group by customer_id;
select staff_id as 'Сотрудник', count(payment_id) as 'Всего оплат' from sakila.payment group by staff_id;
select customer_id as 'Особые клиенты' from sakila.customer where customer_id = all (select customer_id from sakila.payment where rental_id = 4219);
select actor_id as 'В фильме 1 снимались' from sakila.actor  where actor_id = any (select actor_id from sakila.film_actor where film_id = 1);
select first_name as 'Имя', last_name as 'Фамилия' from sakila.actor where first_name in ('Johnny', 'Nick', 'Julia');

select Continent as 'Континент', count(Name) as 'Кол-во стран' from world.Country group by Continent having count(Name) > 50;