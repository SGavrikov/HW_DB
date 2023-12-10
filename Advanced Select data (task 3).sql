--Количество исполнителей в каждом жанре
SELECT   g.name "Жанр", 
		 count(*) "Количество исполнителей" 
FROM     performers_genres pg 
JOIN     genres g on pg.genre_id = g.genre_id 
GROUP BY "Жанр"
ORDER BY count(*) desc;
 

 --Количество треков, вошедших в альбомы 2019–2020 годов.
 
SELECT   a.year "Год выпуска альбомов",
         count(*) "Количество треков в альбомах"
FROM     tracks t
JOIN     albums a on t.album_id = a.album_id 
WHERE    a.year BETWEEN 2019 AND 2020        
GROUP BY a.year ;

 
 --Средняя продолжительность треков по каждому альбому.
 
SELECT  a.title "Альбом",
        concat(((sum(t.duration)/count(t.track_id))/60)::TEXT,':',((sum(t.duration)/count(t.track_id)) - ((sum(t.duration)/count(t.track_id))/60)*60)::TEXT) "Средняя продолжительность трека"
FROM    tracks t
JOIN    albums a on t.album_id = a.album_id 
 GROUP BY a.title
 
 
-- Все исполнители, которые не выпустили альбомы в 2020 году.
  
SELECT p.name "Исполнитель"
FROM performers p
JOIN albums_performers ap on p.performer_id = ap.performer_id 
JOIN albums a on ap.album_id = a.album_id 
WHERE year <> 2020
 
-- Названия сборников, в которых присутствует конкретный исполнитель 
-- На примере "DEEP PURPLE"
SELECT  c.title "Название сборника"
FROM    collection c
JOIN    collection_tracks c_t on c_t.collection_id = c.collection_id 
WHERE   c_t.track_id IN (SELECT t.track_id FROM tracks t
						 JOIN albums_performers a_p on a_p.album_id = t.album_id
						 JOIN performers p on p.performer_id = a_p.performer_id
						 WHERE lower(p.name) = lower('Deep Purple'))
GROUP BY c.title ;

 