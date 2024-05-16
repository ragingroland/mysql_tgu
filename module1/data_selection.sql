select * from world.City;
select * from world.City where CountryCode  = 'BRA';
select Name, Population from world.City where Population > 9000000;

select payment_id, amount, customer_id from sakila.payment order by amount desc;
select payment_id, amount, customer_id from sakila.payment order by amount;
select * from sakila.actor where first_name in ('John', 'Johnny');
select * from sakila.actor where first_name in ('John', 'Johnny') and last_name != 'Cage';

select Code, Name, Region from world.Country where IndepYear is NULL;
select Code, Name, Region from world.Country where IndepYear is not NULL;
select Name as 'Европа' from world.Country where Continent in ('Europe');
select Name from world.Country where SurfaceArea between 200000 and 250000;

select title as 'Драма' from sakila.film where description like '%drama%';