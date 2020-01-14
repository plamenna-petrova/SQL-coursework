 USE Movies

 GO

 -- 1) Write a query in SQL to find the name and year of the movies

 SELECT MovieTitle, MovieYear
 FROM Movies

 --2) Write a query in SQL to find the year when the movie American Beauty released.

 SELECT MovieYear
 FROM Movies
 WHERE MovieTitle = 'Donnie Darko'

 --3) Write a query in SQL to find the year when the movie American Beauty released.

 SELECT MovieTitle
 FROM Movies
 WHERE MovieYear = 2019
 ORDER BY MovieTitle

 --4) Write a query in SQL to find the year when the movie American Beauty released.

 SELECT MovieTitle
 FROM Movies
 WHERE MovieYear < 1980

 --5) Write a query in SQL with UNION.

 SELECT Reviewers.ReviewerLastName 
 FROM Reviewers
 UNION
 (SELECT Movies.MovieTitle
 FROM Movies)

 --6) Write a query in SQL to find the name of all reviewers who have rated 9 or more stars to their rating.

 SELECT Reviewers.ReviewerFirstName + ' ' + Reviewers.ReviewerLastName AS ReviewerFullName
 FROM Reviewers, Rating
 WHERE Rating.ReviewerID = Reviewers.ReviewerID
 AND Rating.ReviewStars>=9 
 AND Reviewers.ReviewerFirstName IS NOT NULL
 AND Reviewers.ReviewerLastName IS NOT NULL

 --7) Write a query in SQL to find the titles of all movies that have no ratings.

 SELECT MovieTitle
 FROM Movies
 WHERE MovieID NOT IN (
 SELECT MovieID
 FROM Rating
  )

 --8) Write a query in SQL to find the titles of the movies with ID 15, 70, 120, 190, 210, 235.

 SELECT MovieTitle
 FROM Movies
 WHERE MovieID IN (15, 70, 120, 190, 210, 235)

 --9) Write a query in SQL to find the list of all those movies with year which include the words Star Wars.

 SELECT MovieID, MovieTitle, MovieYear
 FROM Movies
 WHERE MovieTitle LIKE '%Star%Wars%'
 ORDER BY MovieYear ASC

 --10) Write a query in SQL to find the ID number for the actor whose first name is 'Benedict' and the last name is 'Cumberbatch'.

 SELECT ActorID
 FROM Actors
 WHERE ActorFirstName = 'Benedict' 
 AND ActorLastName = 'Cumberbatch'

  /* 11) Write a query in SQL 
  to list the first and last names of all the actors who were cast 
  in the movie 'The Lord of the Rings: The Return of the King', and the roles they played in that production */

 SELECT ActorFirstName, ActorLastName, MovieRole
 FROM Actors
 JOIN MoviesCast 
 ON Actors.ActorID = MoviesCast.ActorID
 JOIN Movies 
 ON MoviesCast.MovieID = Movies.MovieID
 AND Movies.MovieTitle = 'The Lord of the Rings: The Return of the King'
 ORDER BY ActorFirstName ASC

 /* 12) Write a query in SQL to find the name of
 movie and director (first and last names) who 
 directed a movie that casted a role for 'Before Sunrise' */

 SELECT DirectorFirstName, DirectorLastName, MovieTitle
 FROM Directors 
 JOIN MoviesDirection 
 ON MoviesDirection.DirectorID = Directors.DirectorID
 JOIN Movies
 ON Movies.MovieID = MoviesDirection.MovieID
 AND MovieTitle = 'Before Sunrise'

 /* 13) Write a query in SQL to find the name of movie and director (first and last names) 
 who directed a movie that casted a role as Jason Bourne. */

 SELECT DirectorFirstName, DirectorLastName, MovieTitle
 FROM  Directors 
 JOIN MoviesDirection
 ON Directors.DirectorID = MoviesDirection.DirectorID
 JOIN Movies
 ON MoviesDirection.MovieID = Movies.MovieID
 JOIN MoviesCast 
 ON MoviesCast.MovieID = Movies.MovieID
 WHERE MovieRole = 'Forrest Gump'

 SELECT DirectorFirstName, DirectorLastName, MovieTitle
 FROM  Directors, MoviesDirection, Movies, MoviesCast
 WHERE Directors.DirectorID=MoviesDirection.DirectorID
 AND MoviesDirection.MovieID=Movies.MovieID
 AND Movies.MovieID=MoviesCast.MovieID
 AND MoviesCast.MovieRole= 'Forrest Gump'

 /* 14)Write a query in SQL to list all 
 the actors who have not acted in any movie 
 between 1960 and 2020. */

 SELECT ActorFirstName, ActorLastName, MovieTitle, MovieYear
 FROM Actors
 JOIN MoviesCast
 ON Actors.ActorID = MoviesCast.ActorID
 JOIN Movies 
 ON MoviesCast.MovieID = Movies.MovieID
 WHERE MovieYear NOT BETWEEN 1960 and 2020
 ORDER BY MovieYear, ActorFirstName

 SELECT a.ActorFirstName, a.ActorLastName, c.MovieTitle, c.MovieYear
 FROM Actors a, MoviesCast b, Movies c
 WHERE a.ActorID = b.ActorID
 AND b.MovieID = c.MovieID
 AND c.MovieYear NOT BETWEEN 1960 and 2020
 ORDER BY MovieYear, ActorFirstName

 /* 15) Write a query in SQL to list first and 
 last name of all the directors with number of 
 genres movies they directed with genres name, 
 and arranged the result alphabetically with the 
 first and last name of the director. */ 

 SELECT  GenreTitle, COUNT(GenreTitle) AS NoMovieGenres
 FROM Genres
 JOIN MoviesGenres
 ON MoviesGenres.GenreID = Genres.GenreID
 JOIN MoviesDirection
 ON MoviesDirection.MovieID = MoviesGenres.MovieID
 JOIN Directors
 ON Directors.DirectorID = MoviesDirection.DirectorID
 WHERE DirectorFirstName = 'Martin' AND DirectorLastName = 'Scorsese'
 GROUP BY GenreTitle
 ORDER BY GenreTitle

 /* 16) Write a query in SQL to list all the movies 
 with of the year 1980 with genres. */

 SELECT MovieTitle, MovieYear, GenreTitle
 FROM Movies
 JOIN MoviesGenres
 ON MoviesGenres.MovieID = Movies.MovieID
 JOIN Genres
 ON Genres.GenreID = MoviesGenres.GenreID
 WHERE MovieYear = 1980

 /* 17) Write a query in SQL to list all the 
 movies with year, genres, and name of the director */

 SELECT MovieTitle, MovieYear, GenreTitle, DirectorFirstName, DirectorLastName
 FROM Movies
 JOIN MoviesGenres 
 ON MoviesGenres.MovieID = Movies.MovieID
 JOIN Genres 
 ON Genres.GenreID = MoviesGenres.GenreID
 JOIN MoviesDirection
 ON MoviesDirection.MovieID = MoviesGenres.MovieID
 JOIN Directors
 ON Directors.DirectorID = MoviesDirection.DirectorID
 WHERE MovieBoxOffice > 1100000000
 ORDER BY MovieBoxOffice DESC

 /* 18) Write a query in SQL to list 
 all the movies with title, 
 year, date of release, movie duration, 
 and first and last name of the director 
 which released before 1st January 1989, 
 and sort the result set 
 according to release date from highest date to lowest */

 SELECT m.MovieTitle, m.MovieYear, m.MovieReleaseDate, m.MovieTime, d.DirectorFirstName, d.DirectorLastName
 FROM Movies AS m
 JOIN MoviesDirection AS md
 ON m.MovieID = md.MovieID
 JOIN Directors AS d
 ON md.DirectorID = d.DirectorID
 WHERE m.MovieReleaseDate > '01/01/2010' AND m.MovieReleaseDate < '12/31/2010'
 ORDER BY MovieReleaseDate DESC

 /* 19) Write a query in SQL to compute a report which contain the genres of those movies with 
 their average time and number of movies for each genres */

 SELECT GenreTitle, AVG(MovieTime) AS AverageMovieTime, COUNT(GenreTitle) AS CountGenreTitle
 FROM Movies
 JOIN MoviesGenres ON
 MoviesGenres.MovieID = Movies.MovieID
 JOIN Genres ON
 Genres.GenreID = MoviesGenres.GenreID
 GROUP BY GenreTitle

 /* 20) Write a query in SQL to find those lowest 
 duration movies along with the year, director's name, 
 actor's name and his/her role in that production */

 SELECT MovieTitle, MovieYear, DirectorFirstName, DirectorLastName, 
 ActorFirstName, ActorLastName, MovieRole
 FROM Movies
 JOIN MoviesDirection
 ON MoviesDirection.MovieID = Movies.MovieID
 JOIN MoviesCast
 ON MoviesCast.MovieID = MoviesDirection.MovieID
 JOIN Directors
 ON Directors.DirectorID = MoviesDirection.DirectorID
 JOIN Actors
 ON Actors.ActorID = MoviesCast.ActorID
 WHERE MovieTime = 
 (SELECT MIN(MovieTime) AS MinMovieTime 
 FROM Movies)

 /*21 Sum of the box office, made by the movies, which are directed
  by Christopher Nolan */

 SELECT SUM(MovieBoxOffice) AS BoxOfficeSum
 FROM Movies
 JOIN MoviesDirection 
 ON MoviesDirection.MovieID = Movies.MovieID
 JOIN Directors
 ON Directors.DirectorID = MoviesDirection.DirectorID
 WHERE DirectorFirstName = 'Christopher' AND DirectorLastName = 'Nolan'

 /*22. Find the maximum Movie rating and minimum metascore. */
 SELECT MAX(ReviewStars) AS MaximumReviewStars, MIN (Metascore) AS SmallestMetascore
 FROM Rating

 /*23. Count the number of male actors in the table actors */
 SELECT COUNT(ActorGender) AS NumberOfMaleActors
 FROM Actors
 WHERE ActorGender = 'M'  AND ActorGender IS NOT NULL

 /*24. Find the average rating of the movies, in which stars Jodie Foster */

 SELECT AVG(ReviewStars) AS AverageReviewStars
 FROM Rating
 JOIN MoviesCast 
 ON MoviesCast.MovieID = Rating.MovieID
 JOIN Actors
 ON Actors.ActorID = MoviesCast.ActorID
 WHERE ActorFirstName = 'Jodie' AND ActorLastName = 'Foster'

 /*25. Find the name of the directors, who have received on average more than 8.0 stars for their movies . */

 SELECT  DirectorFirstName, DirectorLastName, AVG(ReviewStars) AS AverageReviewStars, COUNT(MoviesDirection.MovieID) AS CountOfMovies
 FROM Rating
 JOIN MoviesDirection 
 ON MoviesDirection.MovieID = Rating.MovieID
 JOIN Directors
 ON Directors.DirectorID = MoviesDirection.DirectorID
 GROUP BY DirectorFirstName, DirectorLastName
 HAVING AVG (ReviewStars) > 8.3 AND COUNT(MoviesDirection.MovieID) > 1
 ORDER BY AverageReviewStars DESC

 /*26. Find the title of the movies along with their date of release and release country, in which star more than three actors. */

 SELECT MovieTitle, MovieReleaseDate, MovieReleaseCountry, COUNT(MoviesCast.ActorID) AS NumberOfActors
 FROM Movies
 JOIN MoviesCast
 ON MoviesCast.MovieID = Movies.MovieID
 JOIN Actors
 ON Actors.ActorID = MoviesCast.ActorID
 GROUP BY MovieTitle, MovieReleaseDate, MovieReleaseCountry
 HAVING COUNT(MoviesCast.ActorID) > 5
 ORDER BY COUNT(MoviesCast.ActorID) DESC, MovieReleaseDate

 /*27. Find the maximum metascore, where the reviewers have evaluated one movie. */

 SELECT TOP(3) MAX(Metascore) AS MaxMetascore, COUNT(Rating.ReviewerID) AS ReviewerIDCount, ReviewerFirstName, ReviewerLastName
 FROM Rating
 JOIN Reviewers
 ON Reviewers.ReviewerID = Rating.ReviewerID
 GROUP BY ReviewerFirstName, ReviewerLastName
 HAVING COUNT(Rating.ReviewerID) = 1 
 ORDER BY MAX(Metascore) DESC

 /*28. Find the minimum number of reviews of movies along with their title , where a director has directed more than 4 movies */

 SELECT GenreTitle, COUNT(MoviesGenres.GenreID) AS NumberOfGenres
 FROM Genres
 JOIN MoviesGenres
 ON MoviesGenres.GenreID = Genres.GenreID
 GROUP BY GenreTitle
 HAVING COUNT(MoviesGenres.GenreID) > 15
 ORDER BY COUNT(MoviesGenres.GenreID) DESC

 /*29. Find the minimum number of reviews for movies, where the director has directed more than two movies. */

 SELECT MIN(NumberOfRatings) AS MinNumberOfRatings, COUNT(MoviesDirection.DirectorID) AS CountDirectorID, DirectorFirstName, DirectorLastName
 FROM Rating
 JOIN MoviesDirection 
 ON MoviesDirection.MovieID = Rating.MovieID
 JOIN Directors
 ON Directors.DirectorID = MoviesDirection.DirectorID
 GROUP BY DirectorFirstName, DirectorLastName
 HAVING COUNT(MoviesDirection.DirectorID) > 4
 ORDER BY COUNT(MoviesDirection.DirectorID) ASC, DirectorFirstName ASC

 /*30. Write a query in SQL to list all the information of the actors who 
 played a role in the movie 'The Godfather'. */

 SELECT *
 FROM Actors
 WHERE ActorID IN(
 SELECT ActorID
 FROM MoviesCast
 WHERE MovieID IN(
 SELECT MovieID
 FROM Movies
 WHERE MovieTitle = 'The Godfather'
 ))

 /* 31) Write a query in SQL to find the name of 
 the director (first and last names) who directed a 
 movie that casted a role for Gladiator. */

 SELECT DirectorFirstName, DirectorLastName
 FROM Directors
 WHERE DirectorID IN(
 SELECT DirectorID
 FROM MoviesDirection
 WHERE MovieID IN(
 SELECT MovieID
 FROM MoviesCast WHERE MovieRole = ANY(
 SELECT MovieRole
 FROM MoviesCast
 WHERE MovieID IN(
 SELECT MovieID
 FROM Movies
 WHERE MovieTitle = 'Gladiator'))))

 /* 32)Write a query in SQL to 
 list the first and last names of the actors
 who star in movies, released in any
 country other than USA. */

 SELECT ActorFirstName, ActorLastName
 FROM Actors
 WHERE ActorID IN(
 SELECT ActorID 
 FROM MoviesCast
 WHERE MovieID IN(
 SELECT MovieID
 FROM Movies
 WHERE MovieReleaseCountry <> 'USA'))

 /*33). Write a query in SQL to find the movie title, 
 year, date of release, director and actor for those 
 movies which reviewer is unknown. */

 SELECT MovieTitle, MovieYear, MovieReleaseDate,
 DirectorFirstName, DirectorLastName, ActorFirstName, ActorLastName
 FROM Movies a, MoviesDirection b, Directors c,
 Rating d, Reviewers e, Actors f, MoviesCast g
 WHERE a.MovieID = b.MovieID
 AND b.DirectorID = c.DirectorID
 AND a.MovieID = d.MovieID
 AND d.ReviewerID = e.ReviewerID
 AND a.MovieID = g.MovieID
 AND g.ActorID = f.ActorID
 AND e.ReviewerLastName IS NULL

   /* 34).Write a query in SQL to find 
   the titles of all movies directed by the director 
   whose first and last name are David Fincher. */

   SELECT MovieTitle
   FROM Movies
   WHERE MovieID IN (
   SELECT MovieID
   FROM MoviesDirection
   WHERE DirectorID IN (
   SELECT DirectorID 
   FROM Directors
   WHERE DirectorFirstName = 'David' AND DirectorLastName = 'Fincher'))

   /* 35) Write a query in SQL to find all 
   the years which produced at least one movie 
   and that received a rating of more than 8.6 stars. Show the results in increasing order. */

   SELECT DISTINCT MovieYear
   FROM Movies
   WHERE MovieID IN(
   SELECT MovieID
   FROM Rating
   WHERE ReviewStars > 8.6)
   ORDER BY MovieYear

   /* 36) Write a query in SQL to find the 
   names of all reviewers who have ratings with a NULL value. */

   SELECT DISTINCT ReviewerFirstName
   FROM Reviewers
   WHERE ReviewerID IN(
   SELECT ReviewerID
   FROM Rating
   WHERE ReviewStars IS NULL)

  /* 37) Write a query in SQL to find the names of 
  all reviewers who rated the movie Interstellar. */

  SELECT DISTINCT Reviewers.ReviewerFirstName, Reviewers.ReviewerLastName
  FROM Reviewers, Rating, Movies
  WHERE Reviewers.ReviewerID = Rating.ReviewerID
  AND Movies.MovieID = Rating.MovieID
  AND Movies.MovieTitle = 'Interstellar'

  /* 38) Write a query in SQL to return the reviewer name, movie title, and number 
  of stars for those movies which rating is the lowest one. */

  SELECT Reviewers.ReviewerFirstName + ' ' + Reviewers.ReviewerLastName AS ReviewerFullName,
  Movies.MovieTitle, Rating.ReviewStars
  FROM Reviewers, Movies, Rating
  WHERE Rating.ReviewStars = (
  SELECT MIN(Rating.ReviewStars) 
  FROM Rating
  )
  AND Rating.ReviewerID = Reviewers.ReviewerID
  AND Rating.MovieID = Movies.MovieID

  /* 39) Write a query in SQL to find the name of those movies 
  where one or more actors acted in eight or more movies. */

  SELECT MovieTitle
  FROM Movies
  WHERE MovieID IN(
  SELECT MovieID
  FROM MoviesCast
  WHERE ActorID IN(
  SELECT ActorID
  FROM Actors
  WHERE ActorID IN(
  SELECT ActorID
  FROM MoviesCast
  GROUP BY ActorID
  HAVING COUNT(ActorID) > 8)))


  /* 40) Case expressions example 1 */

  SELECT ReviewStars,
  CASE 
     WHEN ReviewStars BETWEEN 6.6 AND 7.2 THEN 'Very Low'
	 WHEN ReviewStars BETWEEN 7.3 AND 7.6 THEN 'Low'
	 WHEN ReviewStars BETWEEN 7.7 AND 8.0 THEN 'Medium'
	 WHEN ReviewStars BETWEEN 8.1 AND 8.4 THEN 'High'
	 WHEN ReviewStars BETWEEN 8.5 AND 8.8 THEN 'Very High'
	 WHEN ReviewStars BETWEEN 8.9 AND 9.1 THEN 'Excellent'
	 WHEN ReviewStars >= 9.2 THEN 'Perfect'
	 ELSE 'Undefined'
 END AS RatingEvaluation
 FROM Rating
 ORDER BY ReviewStars DESC


 /* 41) Case expressions example 2 */

 SELECT Metascore,
 CASE 
     WHEN Metascore BETWEEN 20 AND 30 THEN 'Awful'
	 WHEN Metascore BETWEEN 31 AND 40 THEN 'Bad'
	 WHEN Metascore BETWEEN 41 AND 50 THEN 'Cheap'
	 WHEN Metascore BETWEEN 51 AND 60 THEN 'Ok'
	 WHEN Metascore BETWEEN 61 AND 70 THEN 'Good'
	 WHEN Metascore BETWEEN 71 AND 80 THEN 'Very Good'
	 WHEN Metascore BETWEEN 81 AND 90 THEN 'Superb'
	 ELSE 'Immaculate'
 END AS MetascoreEvaluation
 FROM Rating
 ORDER BY Metascore ASC


 /* 42) Date functions example 1 */

 SELECT DATEPART(year, MovieReleaseDate) AS DatePartYear
 FROM Movies
 WHERE MovieID = 23

 /* 43) Date functions example 2 */

 SELECT DATEPART(month, MovieReleaseDate) AS DatePartMonth
 FROM Movies
 WHERE MovieID = 101

 /* 44) Date functions example 3 */

 SELECT DATEPART(day, MovieReleaseDate) AS DatePartDay
 FROM Movies
 WHERE MovieID = 179

  /* 45) Date functions example 4 */

 SELECT DATENAME(year, MovieReleaseDate) AS DatePartStringYear
 FROM Movies
 WHERE MovieID = 23

  /* 46) Date functions example 5 */

 SELECT DATENAME(month, MovieReleaseDate) AS DatePartMonth
 FROM Movies
 WHERE MovieID = 101

 /* 47) Date functions example 6 */

 SELECT DATENAME(day, MovieReleaseDate) AS DatePartDay
 FROM Movies
 WHERE MovieID = 179

 /* 48) Date functions example 7 */

 SELECT GETDATE() AS CurrentTime

 /* 49) Date functions example 8 */

 SELECT DATEDIFF(year, '01/01/2019', '01/01/2020') AS DateDiffYear

 /* 50) String Functions  example 1 */

 SELECT LEN(MovieTitle) AS StringLength
 FROM Movies
 WHERE MovieID = 32

 /* 50) String Functions  example 2 */

 SELECT LEFT(MovieTitle, 6) AS LeftString
 FROM Movies
 WHERE MovieID = 65

 /* 51) String Functions  example 3 */

 SELECT RIGHT(MovieTitle, 5) AS RightString
 FROM Movies
 WHERE MovieID = 65

 /* 52) String Functions  example 4 */

 SELECT SUBSTRING(MovieTitle, 7,4) AS [SubString]
 FROM Movies
 WHERE MovieID = 65

 /* 53) String Functions  example 5 */

 SELECT UPPER(MovieTitle) AS UpperString
 FROM Movies
 WHERE MovieID = 207

 /* 54) String Functions  example 6 */

 SELECT LOWER(MovieTitle) AS LowerString
 FROM Movies
 WHERE MovieID = 242

 /* 55) String Functions  example 7 */

 SELECT PATINDEX('%star%', MovieTitle)
 FROM Movies

 /* 56) String Functions  example 8 */

 SELECT REVERSE(MovieTitle) AS ReversedString
 FROM Movies
 WHERE MovieID = 196

 /* 57) Convert datatypes expressions example 1 */

 SELECT CAST(MovieTime AS float) AS MovieTimeFloat
 FROM Movies

 /* 58) Convert datatypes expressions example 2 */

 SELECT CONVERT(float, MovieTime) AS MovieTimeFloat
 FROM Movies

 /* 59) Convert datatypes expressions example 3 */

 SELECT STR(ReviewStars) AS StrFunction
 FROM Rating
 WHERE MovieID = 43

 /* 60) Convert datatypes expressions example 4 */

 SELECT CONVERT(smalldatetime, MovieReleaseDate) AS Smalldate
 FROM Movies
 WHERE MovieID = 52

 /* 61) Convert datatypes expressions example 5 */

 SELECT CAST(MovieReleaseDate AS smalldatetime) AS Smalldate
 FROM Movies
 WHERE MovieID = 52

 /* 62) SQL Views example 1 */

 CREATE VIEW V_SpielbergMovies AS
 SELECT Movies.MovieID, MovieTitle, MovieYear, MovieTime, MovieLanguage, MovieReleaseDate, MovieReleaseCountry, MovieBoxOffice
 FROM Movies
 INNER JOIN MoviesDirection
 ON MoviesDirection.MovieID = Movies.MovieID
 INNER JOIN Directors
 ON Directors.DirectorID = MoviesDirection.DirectorID
 WHERE DirectorFirstName = 'Steven' AND DirectorLastName = 'Spielberg'
 WITH CHECK OPTION

 ALTER VIEW V_SpielbergMovies AS
 SELECT Movies.MovieID, MovieTitle, MovieYear, MovieTime, MovieLanguage, MovieReleaseDate, MovieReleaseCountry, MovieBoxOffice
 FROM Movies
 INNER JOIN MoviesDirection
 ON MoviesDirection.MovieID = Movies.MovieID
 INNER JOIN Directors
 ON Directors.DirectorID = MoviesDirection.DirectorID
 WHERE  DirectorLastName = 'Spielberg' AND MovieYear BETWEEN 1990 AND 2010
 WITH CHECK OPTION

 UPDATE V_SpielbergMovies
 SET MovieTime = 142
 WHERE MovieID = 156

 SELECT * FROM V_SpielbergMovies


 /* 63) SQL Views example 2 */

 CREATE VIEW V_JapaneseMovies AS
 SELECT ActorFirstName, ActorLastName, MovieRole, ReviewStars, NumberOfRatings, Metascore, MovieTitle
 FROM Actors
 INNER JOIN MoviesCast
 ON MoviesCast.ActorID = Actors.ActorID
 INNER JOIN Rating 
 ON Rating.MovieID = MoviesCast.MovieID
 INNER JOIN Movies 
 ON Movies.MovieID = Rating.MovieID
 WHERE MovieLanguage = 'Japanese'
 WITH CHECK OPTION

 ALTER VIEW V_JapaneseMovies AS
 SELECT ActorFirstName, ActorLastName, MovieRole, ReviewStars, Metascore, MovieTitle, GenreTitle
 FROM Actors
 INNER JOIN MoviesCast
 ON MoviesCast.ActorID = Actors.ActorID
 INNER JOIN Rating 
 ON Rating.MovieID = MoviesCast.MovieID
 INNER JOIN Movies 
 ON Movies.MovieID = Rating.MovieID
 INNER JOIN MoviesGenres
 ON MoviesGenres.MovieID = Movies.MovieID
 INNER JOIN Genres
 ON Genres.GenreID = MoviesGenres.GenreID
 WHERE MovieLanguage = 'Japanese'
 WITH CHECK OPTION

 UPDATE V_JapaneseMovies
 SET MovieRole = 'Hauru'
 WHERE ActorFirstName = 'Taku'

 
 UPDATE V_JapaneseMovies
 SET MovieRole = 'Sonoshee'
 WHERE ActorFirstName = 'Yu' AND ActorLastName = 'Aoi'

 UPDATE V_JapaneseMovies
 SET MovieRole = 'Frisbee'
 WHERE ActorFirstName = 'Tadanobu' AND ActorLastName = 'Asano'

 DROP VIEW V_JapaneseMovies

 SELECT *
 FROM V_JapaneseMovies
 WHERE ReviewStars > 8.1 AND Metascore >= 80
 ORDER BY ReviewStars ASC

 SELECT *
 FROM MoviesCast
 WHERE ActorFirstName = 'Taku'

 SELECT *
 FROM Actors
 WHERE ActorFirstName = 'Takuya'

 /* 64) SQL Views Example 3*/

 CREATE VIEW V_MysteryMovies AS
 SELECT MovieTitle, MovieYear, MovieLanguage, ReviewerFirstName + ' ' +ReviewerLastName AS ReviewerFullName
 FROM Movies
 INNER JOIN Rating
 ON Rating.MovieID = Movies.MovieID
 INNER JOIN Reviewers
 ON Reviewers.ReviewerID = Rating.ReviewerID
 INNER JOIN MoviesGenres
 ON MoviesGenres.MovieID = Movies.MovieID
 INNER JOIN Genres
 ON Genres.GenreID = MoviesGenres.GenreID
 WHERE GenreTitle = 'Mystery'

 ALTER VIEW V_MysteryMovies AS
 SELECT MovieTitle, MovieYear, MovieLanguage, DirectorFirstName + ' ' +DirectorLastName AS DirectorFullName, ReviewerFirstName + ' ' +ReviewerLastName AS ReviewerFullName
 FROM Movies
 INNER JOIN MoviesDirection
 ON MoviesDirection.MovieID = Movies.MovieID
 INNER JOIN Directors
 ON Directors.DirectorID = MoviesDirection.DirectorID
 INNER JOIN Rating
 ON Rating.MovieID = Movies.MovieID
 INNER JOIN Reviewers
 ON Reviewers.ReviewerID = Rating.ReviewerID
 INNER JOIN MoviesGenres
 ON MoviesGenres.MovieID = Movies.MovieID
 INNER JOIN Genres
 ON Genres.GenreID = MoviesGenres.GenreID
 WHERE GenreTitle = 'Mystery'
 WITH CHECK OPTION

 SELECT *
 FROM V_MysteryMovies
 WHERE MovieLanguage NOT IN('English')
 ORDER BY MovieYear DESC

 /* 65) SQL Procedures example 1*/

 CREATE PROCEDURE MoviesShortString @MovieTitle VARCHAR(10)
 AS
 SELECT *
 FROM Movies
 WHERE MovieTitle = @MovieTitle
 GO

 EXEC MoviesShortString @MovieTitle = 'K-PAX'

 /* 66) SQL Procedures example 2*/

  CREATE PROCEDURE SmallBoxOffice AS
  SELECT MovieTitle, DirectorFirstName + ' ' +DirectorLastName AS
  DirectorFullName, ReviewStars, Metascore
  FROM Movies
  JOIN MoviesDirection
  ON MoviesDirection.MovieID = Movies.MovieID
  JOIN Directors
  ON Directors.DirectorID = MoviesDirection.DirectorID
  JOIN Rating
  ON Rating.MovieID = Movies.MovieID
  WHERE MovieBoxOffice BETWEEN 100000 AND 10000000
  ORDER BY ReviewStars DESC

  ALTER PROCEDURE SmallBoxOffice AS
  SELECT MovieTitle, DirectorFirstName + ' ' +DirectorLastName AS
  DirectorFullName, ReviewStars, Metascore
  FROM Movies
  JOIN MoviesDirection
  ON MoviesDirection.MovieID = Movies.MovieID
  JOIN Directors
  ON Directors.DirectorID = MoviesDirection.DirectorID
  JOIN Rating
  ON Rating.MovieID = Movies.MovieID
  WHERE MovieBoxOffice BETWEEN 100000 AND 10000000
  AND ReviewStars > 7.5
  ORDER BY ReviewStars DESC

  EXEC SmallBoxOffice

  DROP PROCEDURE SmallBoxOffice

  /* 67) SQL Procedures example 3 */

  CREATE PROCEDURE UnknownReviewerLastName AS
  SELECT MovieID, MovieTitle, MovieYear
  FROM Movies
  WHERE MovieID IN(
  SELECT MovieID
  FROM Rating
  WHERE ReviewerID IN(
  SELECT ReviewerID
  FROM Reviewers
  WHERE ReviewerLastName IS NULL))

  EXEC  UnknownReviewerLastName

  RETURN @@ROWCOUNT

  /* 68) SQL Procedures example 4 */

   ALTER PROCEDURE ActorsProcedure
   @ActorID int
   AS
   SELECT MovieTitle, MovieLanguage, MovieReleaseDate, ActorFirstName + ' ' + ' ' +ActorLastName
   AS ActorFullName
   FROM Movies
   JOIN MoviesDirection
   ON MoviesDirection.MovieID = Movies.MovieID
   JOIN Directors
   ON MoviesDirection.DirectorID = Directors.DirectorID
   JOIN MoviesCast
   ON MoviesCast.MovieID = Movies.MovieID
   JOIN Actors
   ON Actors.ActorID = MoviesCast.ActorID
   WHERE DirectorLastName = 'Zemeckis'
   AND Actors.ActorID = @ActorID
   ORDER BY MovieReleaseDate 

   EXEC ActorsProcedure 197

   ALTER PROCEDURE ActorsProcedure
   @ActorID int = 197
   AS
   SELECT MovieTitle, MovieLanguage, MovieReleaseDate, ActorFirstName + ' ' + ' ' +ActorLastName
   AS ActorFullName
   FROM Movies
   JOIN MoviesDirection
   ON MoviesDirection.MovieID = Movies.MovieID
   JOIN Directors
   ON MoviesDirection.DirectorID = Directors.DirectorID
   JOIN MoviesCast
   ON MoviesCast.MovieID = Movies.MovieID
   JOIN Actors
   ON Actors.ActorID = MoviesCast.ActorID
   WHERE DirectorLastName = 'Zemeckis'
   AND Actors.ActorID = @ActorID
   ORDER BY MovieReleaseDate 

   EXEC ActorsProcedure DEFAULT

   /* 69) SQL Procedures example 5 */

   CREATE PROCEDURE DirectorsProcedure
   @DirectorFirstName VARCHAR(20) = NULL
   AS
   IF @DirectorFirstName IS NOT NULL
   SELECT *
   FROM Directors
   WHERE DirectorFirstName LIKE @DirectorFirstName + '%'
   ELSE
   SELECT *
   FROM Directors
   RETURN @@ROWCOUNT

   EXECUTE DirectorsProcedure

   /* 70) SQL Procedures example 6 */

   ALTER PROCEDURE TopRatedMovies
   @MovieID int
   AS
   SELECT m.MovieID, m.MovieTitle, r.ReviewStars, r.NumberOfRatings, r.Metascore
   FROM Movies AS m
   JOIN Rating AS r
   ON r.MovieID = m.MovieID
   WHERE ReviewStars > 8.5
   AND m.MovieID = @MovieID

   EXEC TopRatedMovies 78

   /* 71) SQL Procedures example 7 */

   CREATE PROCEDURE BestMovies
   @MovieID int, @Metascore int OUTPUT
   AS
   SELECT @Metascore = Metascore
   FROM Rating
   WHERE MovieID = @MovieID

   DECLARE @Metascore int
   EXEC BestMovies 115, @Metascore OUTPUT
   SELECT @Metascore AS HighMetascore

   /* 72) SQL Functions example 1*/
   
   CREATE FUNCTION fnFormatMovieReleaseDate
   (@sdtMovieReleaseDate date)
   RETURNS smalldatetime
   AS
   BEGIN
      DECLARE @sdtDateFormat smalldatetime
	  SET @sdtDateFormat = @sdtMovieReleaseDate
	  RETURN @sdtDateFormat
   END

   SELECT dbo.fnFormatMovieReleaseDate
   ('01/01/2019') AS FormatedMovieReleaseDate

  /* 73) SQL Functions example 2*/

  ALTER FUNCTION fnMoviesByActor
  (@iActorID int)
  RETURNS table
  AS
  RETURN
  ( SELECT m.MovieTitle, m.MovieYear, m.MovieLanguage, m.MovieBoxOffice
    FROM Movies AS m
	JOIN MoviesCast AS mc
    ON mc.MovieID = m.MovieID
	JOIN Actors AS a
	ON a.ActorID = mc.ActorID
	WHERE a.ActorID = @iActorID )

	SELECT *
	FROM fnMoviesByActor (7)
	ORDER BY MovieYear

  /* 74) SQL Functions example 3*/

  ALTER FUNCTION fnMoviesActors
  (@sMovieTitle VARCHAR(30))
  RETURNS table
  AS
  RETURN
  ( SELECT m.MovieTitle, m.MovieYear, m.MovieLanguage, m.MovieBoxOffice, a.ActorID, a.ActorFirstName, a.ActorLastName
    FROM Movies AS m
	JOIN MoviesCast AS mc
	ON mc.MovieID = m.MovieID
	JOIN Actors AS a
	ON a.ActorID = mc.ActorID
	WHERE m.MovieTitle = @sMovieTitle)

	SELECT fn.*, mc.MovieRole
	FROM fnMoviesActors ('Tonari no totoro') fn
	INNER JOIN MoviesCast mc
    ON mc.ActorID = fn.ActorID

  /* 75) SQL Functions example 4 */

  ALTER FUNCTION fnMyFavouriteMovies
  (@iMovieYear int)
  RETURNS @tblFavouriteMovies table
  (MovieTitle VARCHAR(30),
    MovieYear int,
	MovieLanguage VARCHAR(20))
  AS
  BEGIN
    INSERT INTO @tblFavouriteMovies
	       (MovieTitle, MovieYear, MovieLanguage)
	SELECT MovieTitle, MovieYear, MovieLanguage
	FROM Movies
	WHERE MovieYear = @iMovieYear
	ORDER BY MovieYear ASC

	RETURN

  END

  SELECT *
  FROM fnMyFavouriteMovies(1998)

  /* 76) SQL Functions example 5 */

  ALTER FUNCTION fnMyFavouriteMovies
  (@iMovieYear int)
  RETURNS @tblFavouriteMovies table
  (MovieTitle VARCHAR(30),
    MovieYear int,
	MovieLanguage VARCHAR(20))
  AS
  BEGIN
    INSERT INTO @tblFavouriteMovies
	       (MovieTitle, MovieYear, MovieLanguage)
	SELECT MovieTitle, MovieYear, MovieLanguage
	FROM Movies
	WHERE MovieYear = @iMovieYear
	ORDER BY MovieYear ASC

	IF NOT EXISTS (SELECT * FROM @tblFavouriteMovies)
	INSERT INTO @tblFavouriteMovies (MovieLanguage)
	VALUES('Unknown Language')

	RETURN

  END

  /* 77) SQL Triggers example 1 */

  CREATE TRIGGER No_DeleteDirectors
  ON Directors
  INSTEAD OF DELETE
  AS
    IF @@ROWCOUNT = 0 RETURN
	RAISERROR('It is not permitted to delete rows from the table.',11,1)

  DELETE FROM Directors
  WHERE DirectorID = 1
 
 /* 78) SQL Triggers example 2 */

 CREATE TRIGGER MovieDirector
   ON MoviesDirection
   FOR INSERT, 
   UPDATE 
   AS 
   IF @@ROWCOUNT = 0 RETURN
   IF EXISTS 
   ( SELECT * FROM inserted i WHERE 
   i.MovieID NOT IN 
   (SELECT m.MovieID FROM Movies m) 
   ) 
   BEGIN 
     RAISERROR('MoviesDirection must have a valid MovieID.', 16, 1) 
	 ROLLBACK TRANSACTION 
  END

  UPDATE MoviesDirection
  SET DirectorID = 2
  WHERE MovieID = 300

  DROP TRIGGER RatingHasMovieID

  /* 79) SQL Triggers example 3 */

 CREATE TRIGGER RatingHasMovieID
   ON Rating 
   FOR DELETE 
   AS 
   IF @@ROWCOUNT = 0 RETURN
 IF EXISTS 
 ( SELECT * FROM 
  Deleted d
  INNER JOIN Movies m ON d.MovieID = m.MovieID ) 
  BEGIN 
    RAISERROR('The movie has a rating. Deletion is not completed!', 16, 1) 
  ROLLBACK TRANSACTION 
  END

  DELETE FROM
  Rating 
  WHERE MovieID = 250

/* 80) SQL DDL Triggers example 1 */
  
CREATE TABLE EvtLog  
(  
   PostTime DATETIME,  
   LoginName NVARCHAR(100),  
   EventType NVARCHAR(100),  
   TSQLCommand NVARCHAR(2000)   
)  
GO  

CREATE TRIGGER trPreventTblChange   
ON DATABASE   
FOR ALTER_TABLE  
AS  
DECLARE @Data XML  
SET @Data = EventData()  
INSERT EvtLog (PostTime, LoginName, EventType, TSQLCommand)   
VALUES   
   (GETDATE(),   
   CONVERT(NVARCHAR(100), CURRENT_USER),   
   @Data.value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(100)'),   
   @Data.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(2000)') ) ;  
GO  
	
ALTER TABLE Rating 
ADD newColumn SMALLDATETIME NULL  	

SELECT *
FROM Evtlog


/* 81) DDL Triggers example 2 */

CREATE TABLE index_logs (
    log_id INT IDENTITY PRIMARY KEY,
    event_data XML NOT NULL,
    changed_by SYSNAME NOT NULL
)
GO

CREATE TRIGGER trg_index_changes
ON DATABASE
FOR 
    CREATE_INDEX,
    ALTER_INDEX, 
    DROP_INDEX
AS
BEGIN
    SET NOCOUNT ON;
 
    INSERT INTO index_logs (
        event_data,
        changed_by
    )
    VALUES (
        EVENTDATA(),
        USER
    )
END
GO

CREATE NONCLUSTERED INDEX nidx_fname
ON Actors(ActorFirstName);
GO
 
CREATE NONCLUSTERED INDEX nidx_lname
ON Actors(ActorLastName);
GO

SELECT 
    *
FROM index_logs


/* The result :
<EVENT_INSTANCE>
  <EventType>CREATE_INDEX</EventType>
  <PostTime>2020-01-05T00:29:11.573</PostTime>
  <SPID>54</SPID>
  <ServerName>LAPTOP-HJMIKUD0</ServerName>
  <LoginName>LAPTOP-HJMIKUD0\Plamenna Petrova</LoginName>
  <UserName>dbo</UserName>
  <DatabaseName>Movies</DatabaseName>
  <SchemaName>dbo</SchemaName>
  <ObjectName>nidx_fname</ObjectName>
  <ObjectType>INDEX</ObjectType>
  <TargetObjectName>Actors</TargetObjectName>
  <TargetObjectType>TABLE</TargetObjectType>
  <TSQLCommand>
    <SetOptions ANSI_NULLS="ON" ANSI_NULL_DEFAULT="ON" ANSI_PADDING="ON" QUOTED_IDENTIFIER="ON" ENCRYPTED="FALSE" />
    <CommandText>CREATE NONCLUSTERED INDEX nidx_fname
ON Actors(ActorFirstName)</CommandText>
  </TSQLCommand>
</EVENT_INSTANCE>

*/





	












 














 



   
 


  





  
  




   


   










   


