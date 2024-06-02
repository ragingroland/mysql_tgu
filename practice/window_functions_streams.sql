CREATE TABLE IF NOT EXISTS "streams" (
    "artist" TEXT,
    "week" INT,
    "streams_millions" NUMERIC(4, 1),
    "chart_position" INT
);
INSERT INTO "streams" VALUES
    ('Drake',1,288.2,1),
    ('Drake',2,160.9,1),
    ('Drake',3,140,2),
    ('Drake',4,131.8,2),
    ('Drake',5,123.7,1),
    ('Drake',6,126.2,1),
    ('Drake',7,122.6,1),
    ('Drake',8,117.6,1),
    ('The Weeknd',1,76.3,6),
    ('The Weeknd',2,72.6,9),
    ('The Weeknd',3,69.9,9),
    ('The Weeknd',4,71.4,9),
    ('The Weeknd',5,66.1,9),
    ('The Weeknd',6,67.3,8),
    ('The Weeknd',7,63.6,8),
    ('The Weeknd',8,60.6,8),
    ('Taylor Swift',1,47.7,15),
    ('Taylor Swift',2,48,18),
    ('Taylor Swift',3,54.1,13),
    ('Taylor Swift',4,51,15),
    ('Taylor Swift',5,47.9,16),
    ('Taylor Swift',6,48.9,14),
    ('Taylor Swift',7,47.8,14),
    ('Taylor Swift',8,48.3,15),
    ('Doja Cat',1,41.7,17),
    ('Doja Cat',2,39.5,23),
    ('Doja Cat',3,38.5,23),
    ('Doja Cat',4,34.5,25),
    ('Doja Cat',5,28.9,42),
    ('Doja Cat',6,28.2,43),
    ('Doja Cat',7,26.5,49),
    ('Doja Cat',8,24.8,57),
    ('Luke Combs',1,55.8,9),
    ('Luke Combs',2,52.1,14),
    ('Luke Combs',3,54.5,12),
    ('Luke Combs',4,55,12),
    ('Luke Combs',5,52.8,13),
    ('Luke Combs',6,52.4,12),
    ('Luke Combs',7,50.5,12),
    ('Luke Combs',8,50.2,11),
    ('Bad Bunny',1,33.7,25),
    ('Bad Bunny',2,69.6,11),
    ('Bad Bunny',3,59,11),
    ('Bad Bunny',4,49.7,16),
    ('Bad Bunny',5,42.3,20),
    ('Bad Bunny',6,42.8,19),
    ('Bad Bunny',7,41.7,20),
    ('Bad Bunny',8,39.3,21),
    ('Beyoncé',1,26.3,42),
    ('Beyoncé',2,25.9,47),
    ('Beyoncé',3,26.6,46),
    ('Beyoncé',4,26.5,50),
    ('Beyoncé',5,26.3,53),
    ('Beyoncé',6,27.9,45),
    ('Beyoncé',7,27.3,46),
    ('Beyoncé',8,34.3,27),
    ('Lady Gaga',1,15.4,106),
    ('Lady Gaga',2,15.2,112),
    ('Lady Gaga',3,16.6,98),
    ('Lady Gaga',4,21,75),
    ('Lady Gaga',5,64,10),
    ('Lady Gaga',6,36,24),
    ('Lady Gaga',7,30.5,36),
    ('Lady Gaga',8,27,47);
    
-- LEAD LAG functions
-- вывести просмотры за текущую и прошлую неделю, а также динамику просмотров
select
	st.artist,
	st.week,
	st.streams_millions,
	lag(st.streams_millions::text, 1, 'no views') over(order by st.week asc) as views_last_week,
	st.streams_millions - (lag(st.streams_millions, 1, st.streams_millions) over(order by st.week asc)) as views_dynamics
from streams as st
where artist = 'Bad Bunny';


--расчет изменения streams_millions и chart_millions от недели к неделе для всех артистов с помощью оконной функции LAG
--а также вывести динамику места в чарте
select
	st.artist,
	st.week,
	st.streams_millions,
	lag(st.streams_millions::text, 1, 'no views') over(partition by st.artist order by st.week asc) as views_last_week,
	st.streams_millions - (lag(st.streams_millions, 1, st.streams_millions) over(partition by st.artist order by st.week asc)) as views_dynamics,
	st.chart_position,
	(lag(st.chart_position, 1, st.chart_position) over(partition by st.artist order by st.week asc)) - st.chart_position as chart_dynamics
from streams as st;

--то же самое, но с функцией LEAD и на следующую неделю
select
	st.artist,
	st.week,
	st.streams_millions,
	lead(st.streams_millions::text, 1, 'no views') over(partition by st.artist order by st.week asc) as views_next_week,
	(lead(st.streams_millions, 1, st.streams_millions) over(partition by st.artist order by st.week asc)) - st.streams_millions as views_dynamics,
	st.chart_position,
	st.chart_position - (lead(st.chart_position, 1, 0) over(partition by st.artist order by st.week asc)) as chart_dynamics_by_next_week,
	(lead(st.chart_position, 1, 0) over(partition by st.artist order by st.week asc)) as chart_next_week
from streams as st;

--получить строку №30
with artist_cte as
	(select
		st.artist,
		st.week,
		st.streams_millions,
		lead(st.streams_millions::text, 1, 'no views') over(partition by st.artist order by st.week asc) as views_next_week,
		(lead(st.streams_millions, 1, st.streams_millions) over(partition by st.artist order by st.week asc)) - st.streams_millions as views_dynamics,
		st.chart_position,
		st.chart_position - (lead(st.chart_position, 1, 0) over(partition by st.artist order by st.week asc)) as chart_dynamics_by_next_week,
		(lead(st.chart_position, 1, 0) over(partition by st.artist order by st.week asc)) as chart_next_week,
		row_number() over() as row_num
	from streams as st)
select *
from artist_cte
where artist_cte.row_num = 30;

--функция RANK
select
	st.artist,
	st.week,
	st.streams_millions,
	st.chart_position,
	rank() over(order by st.streams_millions) as ranked_by_views,
	dense_rank() over(order by st.streams_millions) as denseranked_by_views
from streams as st;

--функция NTILE
select
	st.artist,
	st.week,
	st.streams_millions,
	ntile(4) over(partition by st.week order by st.streams_millions desc) as quart
from streams as st
order by 4;















drop table streams;