--Название и продолжительность самого длительного трека.
SELECT  
	title "Название трека", 
	concat((duration/60)::TEXT,':',(duration - (duration/60)*60)::TEXT) "Длительность"
FROM tracks 
WHERE duration = (select MAX(duration) from tracks);

--Название треков, продолжительность которых не менее 3,5 минут.
SELECT  
	title "Название трека",
	concat((duration/60)::TEXT,':',(duration - (duration/60)*60)::TEXT) "Длительность"
FROM tracks 
WHERE duration >= 210
ORDER BY
	duration DESC ;

--Названия сборников, вышедших в период с 2018 по 2020 год включительно.
SELECT 
	title "Название сборника", 
	year "Дата выпуска"
FROM collection 
WHERE year between 2018 and 2020
ORDER by year ;

--Исполнители, чьё имя состоит из одного слова.
SELECT  name "Имя"
FROM performers 
WHERE name not like '% %'
;

--Название треков, которые содержат слово «мой» или «my».
select  title "Название"
from tracks 
where lower(title) like '%my%' or lower(title) like '%мой%'
	;


