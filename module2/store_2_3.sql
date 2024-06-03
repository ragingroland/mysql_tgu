-- Вывести объединенные данные User и UserInfo
select
	second_name,
	first_name,
	b_year,
	address,
	email
from Users
join UserInfo on Users.user_id = UserInfo.user_id;

-- Вывести объединенные данные Product и Comment, так же необходимо вывести
-- продукты без комментариев.
select
	name,
	price
from Product
join Comment on Product.product_id = Comment.product_id;

--  Вывести объединенные данные User, UserInfo и Orders так же необходимо учитывать,
-- что пользователь может не содержать данных о себе, но не выводить пользователей без
-- заказов!
select
	users.user_id,
	second_name,
	first_name,
	address,
	email,
	product_id,
	count
from users
join userinfo on users.user_id = userinfo.user_id 
join orders on users.user_id = orders.user_id;

-- Вывести наименование продукта, кол-во на складе и кол-во в
-- заказах.
select
	p.name as 'наименование',
	p.count as 'доступно',
	o.count as 'куплено'
from product p 
join orders o on p.product_id = o.product_id;

-- Вывести связь М:М User и Product, чтобы показать какой
-- пользователь (ФИО) заказал какой-то продукт (наименование) и в каком кол-ве.
select
	concat(u.first_name, ' ', u.second_name) as cust_name,
	p.name as product_name,
	o.`count` as bought
from Users u
join Orders o on u.user_id = o.user_id
join Product p on o.product_id = p.product_id;