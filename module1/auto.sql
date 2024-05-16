use world;

create table automobile (
	reg_number char(6) primary key,
	car_brand varchar(20),
	model varchar(50),
	price int check (price >= 10000 and price <= 1000000),
	category  varchar(15) default 'легковой',
	color varchar(15)
);

alter table automobile 
add column condit char(11) check (condit in ('новая', 'подержанная')) default 'новая' not null;

alter table automobile
alter column condit set default 'подержанная';

alter table automobile
drop column condit;

insert into automobile (reg_number, car_brand, model, price, category, color) values
('а086аа', 'Лада', 'Гранта', 200000, default, 'черный'),
('б871бб', 'MAN', 'X8-2', 350000, 'грузовой', 'белый'),
('в351вв', 'Peugeot', 'SportXL', 602000, 'легковой', 'зеленый'),
('г112гг', 'Porsche', '356B', 999999, 'легковой', 'кремовый');

update automobile
set price = price / 2;

update automobile
set color = 'красный' 
where color = 'черный';

update automobile
set price = case
	when price > 300000 then price / 2
	else price * 2
end;

delete from automobile where category = 'легковой';

drop table automobile;