-- Brandon Kelly
-- CPSC 321 - 02
-- Assignment 2
-- Description: Implementing homework 1's music database in SQL.

SET sql_mode = STRICT_ALL_TABLES;

DROP TABLE IF EXISTS album;
DROP TABLE IF EXISTS band;
DROP TABLE IF EXISTS member;
DROP TABLE IF EXISTS song;
DROP TABLE IF EXISTS genre;
DROP TABLE IF EXISTS genre_album;

CREATE TABLE band (
   group_id INT,
   name TEXT NOT NULL,
   label TEXT NOT NULL,
   PRIMARY KEY (group_id)
) ENGINE = InnoDB;

CREATE TABLE genre (
   genre_id INT,
   name TEXT NOT NULL,
   PRIMARY KEY (genre_id)
) ENGINE = InnoDB;

CREATE TABLE album (
   album_id INT,
   group_id INT,
   title TEXT NOT NULL,
   year INT NOT NULL,
   PRIMARY KEY (album_id),
   FOREIGN KEY (group_id) REFERENCES band (group_id)
) ENGINE = InnoDB;

CREATE TABLE member (
   member_id INT,
   name TEXT NOT NULL,
   own_group INT NOT NULL,
   start_year INT NOT NULL,
   end_year INT NOT NULL,
   PRIMARY KEY (member_id),
   FOREIGN KEY (own_group) REFERENCES band (group_id)
) ENGINE = InnoDB;

CREATE TABLE song (
   song_id INT,
   album_id INT NOT NULL,
   name TEXT NOT NULL,
   listing INT NOT NULL,
   PRIMARY KEY (song_id),
   FOREIGN KEY (album_id) REFERENCES album (album_id)
) ENGINE = InnoDB;

CREATE TABLE genre_album (
   genre_id INT NOT NULL,
   group_id INT NOT NULL,
   FOREIGN KEY (genre_id) REFERENCES genre (genre_id),
   FOREIGN KEY (group_id) REFERENCES band (group_id)
) ENGINE = InnoDB;

INSERT INTO genre VALUES
(0, 'rock'),
(1, 'rap'),
(2, 'blues');

INSERT INTO band VALUES
(0, 'Winners', 'RCA'),
(1, 'Loser', 'FBR');


INSERT INTO member VALUES
(0,'Blink-182', 0, 2000, 2005),
(1,'Sam Smith', 0, 2000, 2005),
(2,'Jason Aldean', 1, 2000, 2005),
(3,'Michael Jackson', 1, 2000, 2005);

INSERT INTO album VALUES
(0, 0, 'Good Album', 2000),
(1, 0, 'Bad Album', 2002),
(2, 1, 'Okay Album', 2000),
(3, 1, 'Bleh Album', 2005);

INSERT INTO song VALUES
(0, 0, 'Good song', 0),
(1, 0, 'Okay song', 1),
(2, 1, 'Bad song', 0),
(3, 1, 'Bleh song', 1);

INSERT INTO genre_album VALUES
(0, 0),
(1, 0),
(0, 1),
(2, 1);
