INSERT INTO albums (title, year)
VALUES
    ('Origins', 2018),
	('Witness Deluxe', 2017),
	('In my Mind', 2018),
	('Sinatra at the Sands', 1966),
	('My Way', 1969),
	('Whoosh!', 2020),
    ('Последний герой', 1989),
	('Горгород', 2015),
  	('Never Really Over', 2019)  
	
RETURNING *;

INSERT INTO genres (name)
VALUES`
	('блюз'),
    ('джаз'),
    ('Ритм-энд-блюз'),
    ('Рок'),
	('поп'),
   	('электронная музыка'), 
    ('рэп')
    
RETURNING *;

INSERT INTO performers (name)
VALUES
    ('Imagine Dragons'),
    ('Katy Perry'),
    ('Nicki Minaj'),
    ('Dynoro'),
    ('Frank Sinatra'),
    ('Григорий Лепс'),   
    ('DEEP PURPLE'), 
    ('Oxxymyron'),
    ('КИНО')

RETURNING *;

INSERT INTO tracks (title, duration, album_id)
VALUES
    ('Natural', 189, 1),	
    ('Swish Swish', 242, 2),	
    ('In my Mind', 184, 3),	
    ('My Kind of Town', 200, 4),	
    ('My Way', 241, 4),	
    ('Dancing in My Sleep', 231, 6),	
    ('Throw My Bones', 218, 6),
    ('Remission Possible', 98, 6),
	('Перемен', 295, 1),	
	('Группа крови', 239, 1),
	('Девочка Пиздец', 163, 9),
	('Где нас нет', 265, 9),
	('Я счастливый', 237, NULL)

RETURNING *;


	
INSERT INTO collection (title, year)
VALUES 
	('Хиты FM 2018', 2018),
	('Best of Frank Sinatra', 1997),
	('Лучшие песни 2020', 2020),
	('Лучшие хиты: 2000-е', 2021),
	('Rap Classics', 2017),
	('Russian Rock Legends Vol. 4', 2018);


INSERT INTO collection_tracks (track_id, collection_id)
VALUES
	(1, 1),
    (2, 1),
    (3, 1),
    (4, 2),
    (5, 2),
    (6, 3),
    (8, 3),
    (9, 6),
    (10, 6),
    (11, 5),
    (12, 5),
    (13, 4);


INSERT INTO performers_genres (performer_id, genre_id)
VALUES 
	(1, 4),
	(2, 1),
    (3, 3),
    (4, 6),
    (5, 2),
    (6, 5),  
    (7, 4),
    (8, 7),
    (9, 4);
   
INSERT INTO albums_performers (performer_id, album_id)
VALUES 
	(1,1),
	(2,2),
	(3,2),
	(4,3),
	(5,4),
	(6,4),
	(7,6),
	(8,8),
	(9,7);

