create table category (
	id serial primary key,
	name char(50));

create table products (
	prod_id serial primary key,
	name char(100),
	category_id int,
	avialable bool);
	
alter table products
add constraint fk_category
foreign key (category_id)
references category (id)
on delete cascade
on update cascade;

drop table category;
drop table products;