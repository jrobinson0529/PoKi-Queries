--1. What grades are stored in the database?

SELECT *
FROM Grade

--2. What emotions may be associated with a poem?

SELECT *
FROM Emotion

--3. How many poems are in the database?

SELECT COUNT(*) [# of poems in database]
FROM Poem

--4. Sort authors alphabetically by name. What are the names of the top 76 authors?

SELECT TOP 76 *
FROM Author
ORDER BY Name

--5. Starting with the above query, add the grade of each of the authors.

SELECT TOP 76 a.Name, g.Name
FROM Author a
JOIN Grade g
ON g.Id = a.GradeId
ORDER BY a.Name

--6. Starting with the above query, add the recorded gender of each of the authors.

SELECT TOP 76 a.Name, g.Name [Grade], ge.Name [Gender]
FROM Author a
JOIN Grade g
ON g.Id = a.GradeId
JOIN Gender ge
ON ge.Id = a.GenderId
ORDER BY a.Name

--7. What is the total number of words in all poems in the database?

SELECT SUM(WordCount) [# of Words]
FROM Poem

--8. Which poem has the fewest characters?

SELECT TOP 1 *
FROM Poem
ORDER BY CharCount

--9. How many authors are in the third grade?

SELECT COUNT(*) [Authors in third grade]
FROM Author a
WHERE a.GradeId in ( SELECT g.Id
FROM Grade g WHERE g.Id = 3)

--10. How many authors are in the first, second or third grades?

SELECT COUNT(*) [Authors]
FROM Author a
WHERE a.GradeId in (1,2,3)

--11. What is the total number of poems written by fourth graders?

SELECT COUNT(*) [Poems]
FROM Author a, Poem p
WHERE a.GradeId = 4
AND a.Id = p.AuthorId


--12. How many poems are there per grade?

SELECT a.GradeId, COUNT(*) [Poems]
FROM Author a, Poem p
WHERE a.Id = p.AuthorId
GROUP BY a.GradeId
ORDER BY a.GradeId

--13. How many authors are in each grade? (Order your results by grade starting with `1st Grade`)

SELECT g.Name, COUNT(*) [Authors]
FROM Author a
JOIN Grade g
ON a.GradeId = g.Id
GROUP BY g.Name

--14. What is the title of the poem that has the most words?

SELECT TOP 1 Title, CharCount
FROM Poem
ORDER BY CharCount desc

--15. Which author(s) have the most poems? (Remember authors can have the same name.)

SELECT a.Name, a.Id, COUNT(*) [POEMS]
FROM Author a
JOIN Poem p
ON a.Id = p.AuthorId
GROUP BY a.Name, a.Id
ORDER BY POEMS DESC

SELECT Title, Text
FROM Author a
JOIN Poem p
ON a.Id = p.AuthorId
WHERE a.Id = 9189

--16. How many poems have an emotion of sadness?

SELECT COUNT(*) [Poems with sadness]
FROM Poem p
JOIN PoemEmotion pe
ON p.Id = pe.PoemId
JOIN Emotion e
ON pe.EmotionId = e.Id
WHERE e.Id = 3

--17. How many poems are not associated with any emotion?

SELECT COUNT(*) [Poems]
FROM Poem p
LEFT JOIN PoemEmotion pe
ON pe.PoemId = p.Id
WHERE pe.PoemId IS NULL

--18. Which emotion is associated with the least number of poems?

SELECT TOP 1 e.Name, COUNT(*) [POEMS]
FROM Poem p
JOIN PoemEmotion pe
ON p.Id = pe.PoemId
JOIN Emotion e
ON pe.EmotionId = e.Id
GROUP BY e.Name
ORDER BY COUNT(*)

--19. Which grade has the largest number of poems with an emotion of joy?

SELECT a.GradeId, COUNT(*) [poems]
FROM Poem p
JOIN PoemEmotion pe
ON p.Id = pe.PoemId
JOIN Emotion e
ON pe.EmotionId = e.Id
JOIN Author a
ON a.Id = p.AuthorId
WHERE e.Name = 'joy'
GROUP BY a.GradeId

--20. Which gender has the least number of poems with an emotion of fear?

SELECT TOP 1 e.Name, g.Name, COUNT(*) [Poems with fear]
FROM Poem p
JOIN PoemEmotion pe
ON p.Id = pe.PoemId
JOIN Emotion e
ON pe.EmotionId = e.Id
JOIN Author a
ON a.Id = p.AuthorId
JOIN Gender g
ON a.GenderId = g.Id
WHERE e.Name = 'fear'
GROUP BY e.Name, g.Name
ORDER BY COUNT(*)

SELECT *
FROM Author a
JOIN Poem p
ON a.Id = p.AuthorId
WHERE a.GenderId = 1
