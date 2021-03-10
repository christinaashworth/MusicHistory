SELECT
    Id,
    Title,
    SongLength,
    ReleaseDate,
    GenreId,
    ArtistId,
    AlbumId
FROM Song s;

-- Query all of the entries in the Genre table

SELECT * FROM Genre g;
    

-- Query all the entries in the Artist table and order by the artist's name. HINT: use the ORDER BY keywords

SELECT * FROM Artist a
ORDER BY ArtistName;

-- Write a SELECT query that lists all the songs in the Song table and include the Artist name

SELECT s.title,
a.ArtistName
FROM Song s
    LEFT JOIN Artist a ON s.ArtistId = a.id;

-- Write a SELECT query that lists all the Artists that have a Pop Album

SELECT DISTINCT
a.ArtistName
FROM Album
    JOIN Artist a ON ArtistId = a.id
    JOIN Genre g ON GenreId = g.id
    WHERE g.[Label] = 'Pop';

-- Write a SELECT query that lists all the Artists that have a Jazz or Rock Album

SELECT DISTINCT 
a.ArtistName
FROM Album 
    JOIN Artist a ON ArtistId = a.id
    JOIN Genre g ON GenreId = g.id
    WHERE g.[Label] = 'Jazz' or g.[Label] = 'Rock'

-- Write a SELECT statement that lists the Albums with no songs

SELECT album.title 
FROM Album
    JOIN Song a ON AlbumId = a.id

-- Using the INSERT statement, add one of your favorite artists to the Artist table.

INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Prince', 1999);

-- Using the INSERT statement, add one, or more, albums by your artist to the Album table.

INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Purple Rain', '06/25/1984', 1999, 'Warner Records', 28, 7);

-- Using the INSERT statement, add some songs that are on that album to the Song table.

INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Purple Rain', 1000, '06/25/1984', 7, 28, 23);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('When Doves Cry', 80, '06/25/1984', 7, 28, 23);

-- Write a SELECT query that provides the song titles, album title, and artist name for all of the data you just entered in. Use the LEFT JOIN keyword sequence to connect the tables, and the WHERE keyword to filter the results to the album and artist you added.

SELECT s.Title as SongTitle, al.Title as AlbumTitle, ar.ArtistName 
  FROM song s
    LEFT JOIN album al ON s.AlbumId = al.id
    LEFT JOIN artist ar ON s.ArtistId = ar.id
  WHERE al.Title = 'Purple Rain';

-- Reminder: Direction of join matters. Try the following statements and see the difference in results.

/* SELECT a.Title, s.Title FROM Album a LEFT JOIN Song s ON s.AlbumId = a.Id;
SELECT a.Title, s.Title FROM Song s LEFT JOIN Album a ON s.AlbumId = a.Id; */

-- Write a SELECT statement to display how many songs exist for each album. You'll need to use the COUNT() function and the GROUP BY keyword sequence. 

SELECT count(s.id), al.Title
FROM song s
    LEFT JOIN Album al on s.AlbumId = al.id
GROUP BY al.Title;

-- Write a SELECT statement to display how many songs exist for each artist. You'll need to use the COUNT() function and the GROUP BY keyword sequence.

SELECT count(s.Id), ar.ArtistName
FROM song s 
    LEFT JOIN Artist ar on s.ArtistId = ar.Id
GROUP BY ar.ArtistName;

-- Write a SELECT statement to display how many songs exist for each genre. You'll need to use the COUNT() function and the GROUP BY keyword sequence.

SELECT count(s.Id), g.Label
FROM song s
    LEFT JOIN Genre g on s.GenreId = g.Id
GROUP BY g.Label;

-- Write a SELECT query that lists the Artists that have put out records on more than one record label. Hint: When using GROUP BY instead of using a WHERE clause, use the HAVING keyword

SELECT count(distinct al.label), ar.ArtistName
FROM Artist ar JOIN Album al on ar.id = al.ArtistId
GROUP BY ar.ArtistName
HAVING count(distinct al.label) > 1;

-- Using MAX() function, write a select statement to find the album with the longest duration. The result should display the album title and the duration.

SELECT al.Title, al.AlbumLength
FROM album al
WHERE al.AlbumLength = (
    SELECT max(al.AlbumLength)
    FROM album al
);


-- Using MAX() function, write a select statement to find the song with the longest duration. The result should display the song title and the duration.

SELECT s.Title, s.SongLength, al.Title as AlbumTitle
FROM song s
    LEFT JOIN album al on s.AlbumId = al.Id 
WHERE s.SongLength = (
    SELECT max(s.SongLength)
    FROM song s
);

SELECT top 1 s.Title, s.SongLength
FROM song s
ORDER BY s.SongLength desc;

-- Modify the previous query to also display the title of the album.