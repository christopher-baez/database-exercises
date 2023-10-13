-- Use the albums_db database.
USE albums_db;
-- What is the primary key for the albums table?
SELECT * FROM albums; -- ID
-- What does the column named 'name' represent?
SELECT name FROM albums; -- name of album
-- What do you think the sales column represents?
	-- number of sales rounded to the neares M
-- Find the name of all albums by Pink Floyd
SELECT * FROM albums
WHERE artist = "Pink Floyd"; -- the dark side of the moon and the wall
-- What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
SELECT * FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band"; -- 1967
-- What is the genre for the album Nevermind?
SELECT * FROM albums
WHERE name = "Nevermind"; -- Grunge, Alternative rock
-- Which albums were released in the 1990s?
SELECT * FROM albums
WHERE release_date BETWEEN 1990 AND 1999;
-- Which albums had less than 20 million certified sales? Rename this column as low_selling_albums
SELECT 
	name as low_selling_albums
FROM albums
WHERE sales < 20.0;