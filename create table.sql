CREATE TABLE IF NOT EXISTS albums (
	album_id serial PRIMARY KEY,
	title varchar(60) NOT NULL,
	year int NOT NULL
);

CREATE TABLE IF NOT EXISTS genres (
	genre_id serial PRIMARY KEY,
	name varchar(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS performers (
	performer_id serial PRIMARY KEY,
	name varchar(50) NOT NULL
);
	
CREATE TABLE IF NOT EXISTS collection (
	collection_id serial PRIMARY KEY,
	title varchar(60) NOT NULL,
	year int NOT NULL
);

CREATE TABLE IF NOT EXISTS tracks (
	track_id serial PRIMARY KEY,
	title varchar(60) NOT NULL,
	duration integer NOT NULL,
	album_id int REFERENCES albums(album_id)
);


CREATE TABLE IF NOT EXISTS collection_tracks (
	collection_tracks_id SERIAL PRIMARY KEY, 
  	collection_id INT NOT NULL, 
  	track_id INT NOT NULL, 
  	CONSTRAINT fk_collection FOREIGN KEY(collection_id) REFERENCES collection(collection_id) ON DELETE CASCADE, 
  	CONSTRAINT fk_track FOREIGN KEY(track_id) REFERENCES tracks(track_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS albums_performers (
	albums_performers_id SERIAL PRIMARY KEY, 
  	album_id INT NOT NULL, 
  	performer_id INT NOT NULL, 
  	CONSTRAINT fk_album FOREIGN KEY(album_id) REFERENCES albums(album_id) ON DELETE CASCADE, 
  	CONSTRAINT fk_performer FOREIGN KEY(performer_id) REFERENCES performers(performer_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS performers_genres (
	performers_genres_id SERIAL PRIMARY KEY, 
  	genre_id INT NOT NULL, 
  	performer_id INT NOT NULL, 
  	CONSTRAINT fk_genre FOREIGN KEY(genre_id) REFERENCES genres(genre_id) ON DELETE CASCADE, 
  	CONSTRAINT fk_performer FOREIGN KEY(performer_id) REFERENCES performers(performer_id) ON DELETE CASCADE
);

