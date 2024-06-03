create database store;

use store;

create table Users (
	user_id int auto_increment primary key,
	second_name char(100) not null,
	first_name char(100) not null,
	b_year int not null,
	check (1900 < b_year < 2008));
	
create table UserInfo (
	user_id int primary key,
	email char(100) unique not null,
	address char(255) default 'не предоставлен',
	foreign key (user_id) references Users(user_id));
	
create table Product (
	product_id int auto_increment primary key,
	name char(100) unique not null,
	description text not null,
	`count` int not null,
	check (0 < `count` and `count` < 10000),
	price decimal(8, 2) not null,
	check (price > 100.00));
	
create table Orders (
	user_id int,
	foreign key (user_id) references Users(user_id),
	product_id int,
	foreign key (product_id) references Product(product_id),
	unique (user_id, product_id),
	`count` int not null,
	check (`count` <= 30));
	
create table Comment (
	product_id int,
	foreign key (product_id) references Product(product_id),
	`text` text not null);

drop database store;