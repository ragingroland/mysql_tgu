create schema if not exists library_reader_service;

create table library_reader_service.authors (
	author_id serial primary key not null,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	date_of_birth date not null);
	
create table library_reader_service.books (
	book_id serial primary key not null,
	title varchar(100) unique not null,
	author_id int not null,
	foreign key (author_id) references library_reader_service.authors(author_id),
	genre varchar(20) not null,
	published_year smallint not null,
	total_copies int default 0 not null,
	available_copies int default 0 not null);

create table library_reader_service.members (
	member_id serial primary key not null,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	email varchar(50) unique not null,
	membership_start_date date default current_date not null,
	membership_end_date date default current_date not null,
	check (membership_start_date <= membership_end_date);
	
create table library_reader_service.rentals (
	rental_id serial primary key not null,
	book_id int not null,
	foreign key (book_id) references library_reader_service.books(book_id),
	member_id int not null,
	foreign key (member_id) references library_reader_service.members(member_id),
	rental_date date default current_date not null,
	return_date date default current_date not null);