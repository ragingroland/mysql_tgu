create schema if not exists online_store;

create table online_store.customers (
	customer_id serial primary key not null,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	email varchar(50) unique not null,
	phone_number char(12) unique,
	address varchar(100));
	
create table online_store.products (
	product_id serial primary key not null,
	product_name varchar(50) not null,
	description varchar(100),
	price decimal(10, 2) not null,
	stock_quantity int default 0);
	
create table online_store.orders (
	order_id serial primary key not null,
	customer_id int not null,
	foreign key (customer_id) references online_store.customers(customer_id),
	order_date date not null,
	total_amount decimal(10, 2) not null);
	
create table online_store.order_items (
	order_item_id serial primary key not null,
	order_id int not null,
	foreign key (order_id) references online_store.orders(order_id),
	product_id int not null,
	foreign key (product_id) references online_store.products(product_id),
	quantity int not null default 0,
	price decimal(10, 2) not null);
	
drop schema online_store cascade;