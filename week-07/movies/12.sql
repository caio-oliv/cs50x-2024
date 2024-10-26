SELECT movies.title
FROM movies
JOIN stars stars_1 ON movies.id = stars_1.movie_id
JOIN people people_1 ON stars_1.person_id = people_1.id
JOIN stars stars_2 ON movies.id = stars_2.movie_id
JOIN people people_2 ON stars_2.person_id = people_2.id
WHERE people_1.name = 'Bradley Cooper'
	AND people_2.name = 'Jennifer Lawrence';
