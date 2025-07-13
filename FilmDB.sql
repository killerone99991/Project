-- ========================
-- CREATE DATABASE
-- ========================
CREATE DATABASE FilmDB;
GO
USE FilmDB;
GO


CREATE TABLE AppUser (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(100) NOT NULL UNIQUE,
    password_hash NVARCHAR(255) NOT NULL,
    email NVARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(15),
    created_at DATETIME DEFAULT GETDATE()
);


CREATE TABLE Distributor (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE Director (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE Genre (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Film (
    id INT IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INT,
    distributor_id INT FOREIGN KEY REFERENCES Distributor(id),
    video_path VARCHAR(500) NULL,
    poster_path VARCHAR(500) NULL
);


CREATE TABLE Film_Director (
    film_id INT NOT NULL,
    director_id INT NOT NULL,
    PRIMARY KEY (film_id, director_id),
    FOREIGN KEY (film_id) REFERENCES Film(id),
    FOREIGN KEY (director_id) REFERENCES Director(id)
);

CREATE TABLE Film_Genre (
    film_id INT NOT NULL,
    genre_id INT NOT NULL,
    PRIMARY KEY (film_id, genre_id),
    FOREIGN KEY (film_id) REFERENCES Film(id),
    FOREIGN KEY (genre_id) REFERENCES Genre(id)
);


CREATE TABLE FilmRating (
    id INT IDENTITY(1,1) PRIMARY KEY,
    film_id INT NOT NULL FOREIGN KEY REFERENCES Film(id),
    user_id INT NULL,  -- cho phép để trống
    score DECIMAL(3,1) NOT NULL CHECK (score >= 0 AND score <= 10),
    FOREIGN KEY (user_id) REFERENCES AppUser(id)
);



INSERT INTO Distributor (name) VALUES
('20th Century Studios'), ('Paramount'), ('Paramount Pictures'),
('Walt Disney Studios Motion Pictures'), ('Walt Disney Pictures'),
('Warner Bros.'), ('Warner Bros. Pictures'), ('Summit Entertainment'),
('Toho'), ('Lionsgate'), ('CJ Entertainment'), ('Neon'),
('Sony Pictures Classics'), ('DreamWorks Distribution'),
('Universal Pictures'), ('20th Century Fox'), ('Marvel Studios');

INSERT INTO Director (name) VALUES
('James Cameron'), ('Francis Ford Coppola'), ('Pete Docter'),
('Ronnie del Carmen'), ('Stanley Kubrick'), ('Jon Favreau'),
('Brad Bird'), ('Jan Pinkava'), ('Chad Stahelski'),
('Christopher Nolan'), ('Hayao Mizayaki'), ('Damien Chazelle'),
('Bong Joon Ho'), ('Ridley Scott'), ('David Fincher'),
('Andy Wachowski'), ('Lana Wachowski'), ('Anthony Russo'),
('Joe Russo'), ('Todd Phillips'), ('Andrew Stanton');

INSERT INTO Genre (name) VALUES
('Action'), ('Adventure'), ('Science Fiction'),
('Crime'), ('Animation'),
('Psychological'), ('Family'), ('Horror'), ('Heist'),
('Mystery'), ('Rom-com'), ('Fantasy'),
('Musical'), ('Thriller'), ('Robot'),
('Epic'), ('Comedy'), ('Drama'), ('Super Hero');
GO

-- Inside Out
INSERT INTO Film (title, release_year, distributor_id) VALUES
('Inside Out', 2015, (SELECT id FROM Distributor WHERE name = 'Walt Disney Studios Motion Pictures'));
DECLARE @f INT = SCOPE_IDENTITY();
INSERT INTO Film_Director VALUES
(@f, (SELECT id FROM Director WHERE name = 'Pete Docter')),
(@f, (SELECT id FROM Director WHERE name = 'Ronnie del Carmen'));
INSERT INTO Film_Genre VALUES
(@f, (SELECT id FROM Genre WHERE name = 'Animation')),
(@f, (SELECT id FROM Genre WHERE name = 'Adventure')),
(@f, (SELECT id FROM Genre WHERE name = 'Psychological')),
(@f, (SELECT id FROM Genre WHERE name = 'Family'));

-- Avatar: The Way of Water
INSERT INTO Film (title, release_year, distributor_id) VALUES
('Avatar: The Way of Water', 2022, (SELECT id FROM Distributor WHERE name = '20th Century Studios'));
SET @f = SCOPE_IDENTITY();
INSERT INTO Film_Director VALUES
(@f, (SELECT id FROM Director WHERE name = 'James Cameron'));
INSERT INTO Film_Genre VALUES
(@f, (SELECT id FROM Genre WHERE name = 'Action')),
(@f, (SELECT id FROM Genre WHERE name = 'Adventure')),
(@f, (SELECT id FROM Genre WHERE name = 'Science Fiction'));

-- The Godfather
INSERT INTO Film (title, release_year, distributor_id) VALUES
('The Godfather', 1972, (SELECT id FROM Distributor WHERE name = 'Paramount'));
SET @f = SCOPE_IDENTITY();
INSERT INTO Film_Director VALUES
(@f, (SELECT id FROM Director WHERE name = 'Francis Ford Coppola'));
INSERT INTO Film_Genre VALUES
(@f, (SELECT id FROM Genre WHERE name = 'Crime')),
(@f, (SELECT id FROM Genre WHERE name = 'Drama'));

-- Ratatouille
INSERT INTO Film (title, release_year, distributor_id) VALUES
('Ratatouille', 2007, (SELECT id FROM Distributor WHERE name = 'Walt Disney Studios Motion Pictures'));
SET @f = SCOPE_IDENTITY();
INSERT INTO Film_Director VALUES
(@f, (SELECT id FROM Director WHERE name = 'Brad Bird')),
(@f, (SELECT id FROM Director WHERE name = 'Jan Pinkava'));
INSERT INTO Film_Genre VALUES
(@f, (SELECT id FROM Genre WHERE name = 'Animation')),
(@f, (SELECT id FROM Genre WHERE name = 'Comedy')),
(@f, (SELECT id FROM Genre WHERE name = 'Drama'));

-- The Matrix
INSERT INTO Film (title, release_year, distributor_id) VALUES
('The Matrix', 1999, (SELECT id FROM Distributor WHERE name = 'Warner Bros.'));
SET @f = SCOPE_IDENTITY();
INSERT INTO Film_Director VALUES
(@f, (SELECT id FROM Director WHERE name = 'Andy Wachowski')),
(@f, (SELECT id FROM Director WHERE name = 'Lana Wachowski'));
INSERT INTO Film_Genre VALUES
(@f, (SELECT id FROM Genre WHERE name = 'Science Fiction')),
(@f, (SELECT id FROM Genre WHERE name = 'Action')),
(@f, (SELECT id FROM Genre WHERE name = 'Adventure'));

-- Avengers: Endgame
INSERT INTO Film (title, release_year, distributor_id) VALUES
('Avengers: Endgame', 2019, (SELECT id FROM Distributor WHERE name = 'Walt Disney Studios Motion Pictures'));
SET @f = SCOPE_IDENTITY();
INSERT INTO Film_Director VALUES
(@f, (SELECT id FROM Director WHERE name = 'Anthony Russo')),
(@f, (SELECT id FROM Director WHERE name = 'Joe Russo'));
INSERT INTO Film_Genre VALUES
(@f, (SELECT id FROM Genre WHERE name = 'Action')),
(@f, (SELECT id FROM Genre WHERE name = 'Adventure')),
(@f, (SELECT id FROM Genre WHERE name = 'Thriller')),
(@f, (SELECT id FROM Genre WHERE name = 'Super Hero'));

-- Joker
INSERT INTO Film (title, release_year, distributor_id) VALUES
('Joker', 2019, (SELECT id FROM Distributor WHERE name = 'Warner Bros. Pictures'));
SET @f = SCOPE_IDENTITY();
INSERT INTO Film_Director VALUES
(@f, (SELECT id FROM Director WHERE name = 'Todd Phillips'));
INSERT INTO Film_Genre VALUES
(@f, (SELECT id FROM Genre WHERE name = 'Psychological')),
(@f, (SELECT id FROM Genre WHERE name = 'Drama')),
(@f, (SELECT id FROM Genre WHERE name = 'Thriller'));

-- WALL·E
INSERT INTO Film (title, release_year, distributor_id) VALUES
('WALL·E', 2008, (SELECT id FROM Distributor WHERE name = 'Walt Disney Pictures'));
SET @f = SCOPE_IDENTITY();
INSERT INTO Film_Director VALUES
(@f, (SELECT id FROM Director WHERE name = 'Andrew Stanton'));
INSERT INTO Film_Genre VALUES
(@f, (SELECT id FROM Genre WHERE name = 'Animation')),
(@f, (SELECT id FROM Genre WHERE name = 'Science Fiction')),
(@f, (SELECT id FROM Genre WHERE name = 'Robot'));

-- Iron Man
INSERT INTO Film (title, release_year, distributor_id) VALUES
('Iron Man', 2008, (SELECT id FROM Distributor WHERE name = 'Marvel Studios'));
SET @f = SCOPE_IDENTITY();
INSERT INTO Film_Director VALUES
(@f, (SELECT id FROM Director WHERE name = 'Jon Favreau'));
INSERT INTO Film_Genre VALUES
(@f, (SELECT id FROM Genre WHERE name = 'Action')),
(@f, (SELECT id FROM Genre WHERE name = 'Science Fiction')),
(@f, (SELECT id FROM Genre WHERE name = 'Super Hero'));

-- The Shining
INSERT INTO Film (title, release_year, distributor_id) VALUES
('The Shining', 1980, (SELECT id FROM Distributor WHERE name = 'Warner Bros.'));
SET @f = SCOPE_IDENTITY();
INSERT INTO Film_Director VALUES
(@f, (SELECT id FROM Director WHERE name = 'Stanley Kubrick'));
INSERT INTO Film_Genre VALUES
(@f, (SELECT id FROM Genre WHERE name = 'Horror')),
(@f, (SELECT id FROM Genre WHERE name = 'Mystery'));

-- John Wick
INSERT INTO Film (title, release_year, distributor_id) VALUES
('John Wick', 2014, (SELECT id FROM Distributor WHERE name = 'Summit Entertainment'));
SET @f = SCOPE_IDENTITY();
INSERT INTO Film_Director VALUES
(@f, (SELECT id FROM Director WHERE name = 'Chad Stahelski'));
INSERT INTO Film_Genre VALUES
(@f, (SELECT id FROM Genre WHERE name = 'Action')),
(@f, (SELECT id FROM Genre WHERE name = 'Heist'));

-- Inception
INSERT INTO Film (title, release_year, distributor_id) VALUES
('Inception', 2010, (SELECT id FROM Distributor WHERE name = 'Warner Bros.'));
SET @f = SCOPE_IDENTITY();
INSERT INTO Film_Director VALUES
(@f, (SELECT id FROM Director WHERE name = 'Christopher Nolan'));
INSERT INTO Film_Genre VALUES
(@f, (SELECT id FROM Genre WHERE name = 'Action')),
(@f, (SELECT id FROM Genre WHERE name = 'Adventure')),
(@f, (SELECT id FROM Genre WHERE name = 'Science Fiction'));

-- Spirited Away
INSERT INTO Film (title, release_year, distributor_id) VALUES
('Spirited Away', 2001, (SELECT id FROM Distributor WHERE name = 'Toho'));
SET @f = SCOPE_IDENTITY();
INSERT INTO Film_Director VALUES
(@f, (SELECT id FROM Director WHERE name = 'Hayao Mizayaki'));
INSERT INTO Film_Genre VALUES
(@f, (SELECT id FROM Genre WHERE name = 'Animation')),
(@f, (SELECT id FROM Genre WHERE name = 'Adventure')),
(@f, (SELECT id FROM Genre WHERE name = 'Fantasy'));

-- La La Land
INSERT INTO Film (title, release_year, distributor_id) VALUES
('La La Land', 2016, (SELECT id FROM Distributor WHERE name = 'Summit Entertainment'));
SET @f = SCOPE_IDENTITY();
INSERT INTO Film_Director VALUES
(@f, (SELECT id FROM Director WHERE name = 'Damien Chazelle'));
INSERT INTO Film_Genre VALUES
(@f, (SELECT id FROM Genre WHERE name = 'Drama')),
(@f, (SELECT id FROM Genre WHERE name = 'Musical')),
(@f, (SELECT id FROM Genre WHERE name = 'Rom-com'));

-- Parasite
INSERT INTO Film (title, release_year, distributor_id) VALUES
('Parasite', 2019, (SELECT id FROM Distributor WHERE name = 'CJ Entertainment'));
SET @f = SCOPE_IDENTITY();
INSERT INTO Film_Director VALUES
(@f, (SELECT id FROM Director WHERE name = 'Bong Joon Ho'));
INSERT INTO Film_Genre VALUES
(@f, (SELECT id FROM Genre WHERE name = 'Psychological')),
(@f, (SELECT id FROM Genre WHERE name = 'Thriller')),
(@f, (SELECT id FROM Genre WHERE name = 'Drama'));

-- The Dark Knight
INSERT INTO Film (title, release_year, distributor_id) VALUES
('The Dark Knight', 2008, (SELECT id FROM Distributor WHERE name = 'Warner Bros.'));
SET @f = SCOPE_IDENTITY();
INSERT INTO Film_Director VALUES
(@f, (SELECT id FROM Director WHERE name = 'Christopher Nolan'));
INSERT INTO Film_Genre VALUES
(@f, (SELECT id FROM Genre WHERE name = 'Action')),
(@f, (SELECT id FROM Genre WHERE name = 'Adventure')),
(@f, (SELECT id FROM Genre WHERE name = 'Super Hero'));

-- Interstellar
INSERT INTO Film (title, release_year, distributor_id) VALUES
('Interstellar', 2014, (SELECT id FROM Distributor WHERE name = 'Paramount Pictures'));
SET @f = SCOPE_IDENTITY();
INSERT INTO Film_Director VALUES
(@f, (SELECT id FROM Director WHERE name = 'Christopher Nolan'));
INSERT INTO Film_Genre VALUES
(@f, (SELECT id FROM Genre WHERE name = 'Science Fiction')),
(@f, (SELECT id FROM Genre WHERE name = 'Drama')),
(@f, (SELECT id FROM Genre WHERE name = 'Action'));

-- Whiplash
INSERT INTO Film (title, release_year, distributor_id) VALUES
('Whiplash', 2014, (SELECT id FROM Distributor WHERE name = 'Sony Pictures Classics'));
SET @f = SCOPE_IDENTITY();
INSERT INTO Film_Director VALUES
(@f, (SELECT id FROM Director WHERE name = 'Damien Chazelle'));
INSERT INTO Film_Genre VALUES
(@f, (SELECT id FROM Genre WHERE name = 'Drama')),
(@f, (SELECT id FROM Genre WHERE name = 'Musical'));

-- Gladiator
INSERT INTO Film (title, release_year, distributor_id) VALUES
('Gladiator', 2000, (SELECT id FROM Distributor WHERE name = 'DreamWorks Distribution'));
SET @f = SCOPE_IDENTITY();
INSERT INTO Film_Director VALUES
(@f, (SELECT id FROM Director WHERE name = 'Ridley Scott'));
INSERT INTO Film_Genre VALUES
(@f, (SELECT id FROM Genre WHERE name = 'Epic')),
(@f, (SELECT id FROM Genre WHERE name = 'Drama')),
(@f, (SELECT id FROM Genre WHERE name = 'Action'));

-- Fight Club
INSERT INTO Film (title, release_year, distributor_id) VALUES
('Fight Club', 1999, (SELECT id FROM Distributor WHERE name = '20th Century Fox'));
SET @f = SCOPE_IDENTITY();
INSERT INTO Film_Director VALUES
(@f, (SELECT id FROM Director WHERE name = 'David Fincher'));
INSERT INTO Film_Genre VALUES
(@f, (SELECT id FROM Genre WHERE name = 'Psychological')),
(@f, (SELECT id FROM Genre WHERE name = 'Thriller'));
