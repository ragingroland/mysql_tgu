use world;

create table data_types (
	id int primary key auto_increment not null,
	name varchar(15) not null,
	description varchar(45) default 'Отсутсвует',
	float_value double(5,3) not null,
	fore_key_city int not null,
	date_ datetime default current_timestamp not null,
	bit_ bit(1) not null
);

alter table data_types
add constraint fk_city
foreign key (fore_key_city)
references City (ID)
on delete cascade
on update cascade;

insert into data_types (name, float_value, bit_, fore_key_city)
values ('Test', 5.2512412, FALSE, 1);

drop table data_types;