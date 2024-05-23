CREATE TABLE IF NOT EXISTS  social_media (
    "username" TEXT,
    "month" INT,
    "change_in_followers" NUMERIC(3, 2),
    "change_in_following" INT,
    "posts" INT
);
INSERT INTO social_media VALUES
    ('instagram',1,6.27,-4,32),
    ('instagram',2,4.71,-1,39),
    ('instagram',3,5.73,2,39),
    ('instagram',4,5.43,-136,41),
    ('instagram',5,4.99,-2,45),
    ('instagram',6,2.52,-8,5),
    ('instagram',7,4.61,-10,41),
    ('instagram',8,3.91,-9,44),
    ('cristiano',1,5.33,-10,21),
    ('cristiano',2,4.93,5,19),
    ('cristiano',3,4.3,-2,7),
    ('cristiano',4,5.74,8,17),
    ('cristiano',5,5.81,2,20),
    ('cristiano',6,5.74,1,19),
    ('cristiano',7,5.99,0,15),
    ('cristiano',8,4.6,2,21),
    ('arianagrande',1,3.69,3,12),
    ('arianagrande',2,4.4,-6,22),
    ('arianagrande',3,4.93,-2,14),
    ('arianagrande',4,4.12,1,22),
    ('arianagrande',5,5.47,-216,48),
    ('arianagrande',6,4.01,28,14),
    ('arianagrande',7,3.71,-4,23),
    ('arianagrande',8,4.02,-11,24),
    ('therock',1,3.75,10,44),
    ('therock',2,3.15,2,44),
    ('therock',3,3.5,4,36),
    ('therock',4,4.4,9,56),
    ('therock',5,3.77,9,70),
    ('therock',6,3.25,7,19),
    ('therock',7,3.54,14,62),
    ('therock',8,4.32,5,56),
    ('aliaabhatt',1,1.15,6,9),
    ('aliaabhatt',2,1.16,2,14),
    ('aliaabhatt',3,1.52,8,25),
    ('aliaabhatt',4,1.57,8,9),
    ('aliaabhatt',5,1.47,11,9),
    ('aliaabhatt',6,-0.76,10,7),
    ('aliaabhatt',7,1.09,6,5),
    ('aliaabhatt',8,1,-1,13),
    ('theellenshow',1,1.76,2,129),
    ('theellenshow',2,1.43,6,123),
    ('theellenshow',3,1.88,2,126),
    ('theellenshow',4,1.41,2,104),
    ('theellenshow',5,1.73,4,121),
    ('theellenshow',6,1.26,11,72),
    ('theellenshow',7,1.16,2,30),
    ('theellenshow',8,0.79,-4,0),
    ('codecademy',1,0.03,2,2),
    ('codecademy',2,0.01,1,4),
    ('codecademy',3,0.02,0,1),
    ('codecademy',4,0.01,5,3),
    ('codecademy',5,0.01,-1,2),
    ('codecademy',6,0.01,3,1),
    ('codecademy',7,0.03,2,0),
    ('codecademy',8,0.05,1,2),
    ('sonnynomnom',1,0,6,1),
    ('sonnynomnom',2,0,2,1),
    ('sonnynomnom',3,0,1,0),
    ('sonnynomnom',4,0,8,1),
    ('sonnynomnom',5,0,3,0),
    ('sonnynomnom',6,0,2,2),
    ('sonnynomnom',7,0,0,0),
    ('sonnynomnom',8,0,12,1);

--вывести данные о сумме прироста подписчиков для аккаунта инстаграм за весь период
select
	sm.username,
	sum(sm.change_in_followers)
from social_media as sm
where username = 'instagram'
group by username;

--вывести столбцы месяц и кол-во подписчиков для аккаунта инстаграм, а также 
--добавьте еще один столбец running_total, который будет отображать нарастающую сумму подписчиков
select
	sm.month,
	sm.change_in_followers,
	sum(sm.change_in_followers) over(order by sm.month asc) as growth_overtime
from social_media as sm
where username = 'instagram';

--задача выше, но найти нарастающее среднее
select
	sm.month,
	sm.change_in_followers,
	round(avg(sm.change_in_followers) over(order by sm.month asc), 2) as growth_overtime_avg
from social_media as sm
where username = 'instagram';

--выведем всех пользователей
select
	sm.username,
	sm.month,
	sm.change_in_followers,
	sum(sm.change_in_followers) over(order by sm.month asc) as growth_overtime,
	round(avg(sm.change_in_followers) over(order by sm.month asc), 2) as growth_overtime_avg
from social_media as sm

--работа PARTITION BY, first_value
select
	sm.username,
	sm.posts,
	first_value(sm.posts) 
from social_media as sm














drop table social_media;