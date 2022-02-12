--Создание базы данных
CREATE DATABASE BooksInformation
    CHARACTER SET = 'utf8' COLLATE = utf8_general_ci;
USE BooksInformation;
--Создание таблиц 
CREATE TABLE Books (
    bookId INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(13),
    title VARCHAR(500) NOT NULL,
    numberOfPages INT UNSIGNED,
    publicationDate DATE
);
CREATE TABLE Authors (
    authorId INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(100),
    lastName VARCHAR(100) NOT NULL
);
CREATE TABLE Genres (
    genreId INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    genre VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE BookAuthor (
    bookId INT UNSIGNED NOT NULL,
    authorId INT UNSIGNED NOT NULL,
    PRIMARY KEY (bookId, authorId),
    CONSTRAINT fk_bookId_to_BookAuthor FOREIGN KEY (bookId) REFERENCES Books(bookId),
    CONSTRAINT fk_authorId FOREIGN KEY (authorId) REFERENCES Authors(authorId)
);
CREATE TABLE BookGenre (
    bookId INT UNSIGNED NOT NULL,
    genreId INT UNSIGNED NOT NULL,
    PRIMARY KEY (bookId, genreId),
    CONSTRAINT fk_bookId_to_BookGenre FOREIGN KEY (bookId) REFERENCES Books(bookId),
    CONSTRAINT fk_genreId FOREIGN KEY (genreId) REFERENCES Genres(genreId)
);
--Заполнение тестовым набором данных
INSERT Books (isbn, title, numberOfPages, publicationDate)
VALUES
    ('9785170838998', 'Солярис',288,'2021-07-14'),
    ('9785171121938', 'Сумма технологии',736,'2018-04-20'),
    ('9785170905126', 'Эдем',320,'2021-08-10'),
    ('9785170903344', 'Понедельник начинается в субботу',320,'2021-07-27'),
    ('9785170992676', 'Голова профессора Доуэля',256,'2021-09-12'),

    ('9785170343123', 'Космическая электроника',746,'2015-03-11'),
    (NULL, 'Основы радиолокации',1052,'2011-01-14'),
    (NULL, 'Ракетные системы',582,'2008-02-19'),

    ('9785389047310', 'Мертвые души',352,'2022-01-16'),
    ('9785041159955', 'Война и мир',900,'2017-01-26'),
    ('9785389049352', 'Анна Каренина',864,'2013-08-13');
INSERT Authors (firstName, lastName)
VALUES 
    ('Станислав','Лем'),
    ('Александр','Беляев'),
    ('Борис', 'Стругацкий'),
    ('Аркадий','Стругацкий'),

    ('Дмитрий','Белоус'),
    ('','Савочкин'),
    ('Владислав','Путин'),
    ('Олег','Медведев'),
    ('Сергей','Иванов'),

    ('Николай','Гоголь'),
    ('Лев','Толтой');

INSERT Genres (genre) 
VALUES 
    ('Фантастика'),--4 автора --5 книг
    ('Научная литература'), --5 авторов 3 книги
    ('Классическая'); --2 автора --3 книг
INSERT BookAuthor (bookId, authorId)
VALUES
    (1,1),
    (2,1),
    (3,1),
    (4,3),
    (4,4),
    (5,2),

    (6,5),
    (7,6),
    (8,7),
    (8,8),
    (8,9),

    (9,10),
    (10,11),
    (11,11);
INSERT BookGenre (bookId, genreId)
VALUES
    (1,1),
    (2,1),
    (3,1),
    (4,1),
    (5,1),

    (6,2),
    (7,2),
    (8,2),

    (9,3),
    (10,3),
    (11,3);
--вывод названия книги и ее авторов для жанра "фантастика"
SELECT b.title as `Название`, 
    GROUP_CONCAT(CONCAT(a.firstName,' ', a.lastName) ORDER BY a.firstName SEPARATOR ', ') as `Авторы`
FROM Books as b
    JOIN BookAuthor as ba ON b.bookId = ba.bookId
    JOIN Authors as a ON ba.authorId = a.authorId
    JOIN BookGenre as bg ON b.bookId = bg.bookId
    JOIN Genres as g ON bg.genreId = g.genreId
WHERE g.genre = 'Фантастика'
GROUP BY b.title
ORDER BY b.title, b.bookId;
--вывод автора, который написал больше всего книг
SELECT  y.fullName as `Автор`, MAX(z.num) `Количество книг`
FROM (SELECT COUNT(DISTINCT b.title) as num
    FROM Books as b
        JOIN BookAuthor as ba ON b.bookId = ba.bookId
        JOIN Authors as a ON ba.authorId = a.authorId
    GROUP BY a.authorId
) as z, 
     (SELECT CONCAT(a.firstName,' ', a.lastName) as fullName
    FROM Books as b
        JOIN BookAuthor as ba ON b.bookId = ba.bookId
        JOIN Authors as a ON ba.authorId = a.authorId
    HAVING COUNT(DISTINCT b.title)
) as y;