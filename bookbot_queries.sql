
-- Create Database
CREATE DATABASE bookbot_updated;
USE bookbot_updated;

-- Table Creation
CREATE TABLE user2(
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE,
    email VARCHAR(100) UNIQUE,
    password_hash VARCHAR(255),
    age VARCHAR(20),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE books(
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255),
    author VARCHAR(100),
    genre VARCHAR(50),
    age VARCHAR(20),
    description TEXT,
    cover_image_url VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Audio(
    audio_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    audio_url VARCHAR(255),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

CREATE TABLE Video(
    video_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    video_url VARCHAR(255),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

CREATE TABLE Issue(
    issue_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    book_id INT,
    issue_date DATE,
    return_date DATE,
    extended BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES user2(user_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

CREATE TABLE Purchase(
    purchase_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    book_id INT,
    purchase_date DATETIME,
    FOREIGN KEY (user_id) REFERENCES user2(user_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

CREATE TABLE Downloads(
    download_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    book_id INT,
    download_date DATETIME,
    FOREIGN KEY (user_id) REFERENCES user2(user_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

CREATE TABLE notifications(
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    message TEXT,
    is_read BOOLEAN DEFAULT FALSE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user2(user_id)
);

CREATE TABLE Chatbot(
    message_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    message_text TEXT,
    response_text TEXT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user2(user_id)
);

-- Sample SELECT Queries
SELECT genre, COUNT(*) AS total_books FROM books;

SELECT AVG(age + 0) AS avg_age FROM books;

SELECT title, LENGTH(description) AS description_length
FROM books
ORDER BY description_length DESC
LIMIT 1;

-- SQL JOINs
-- INNER JOIN
SELECT u.username, b.title
FROM user2 u
INNER JOIN Issue i ON u.user_id = i.user_id
INNER JOIN books b ON i.book_id = b.book_id;

-- LEFT JOIN
SELECT u.username, b.title
FROM user2 u
LEFT JOIN Issue i ON u.user_id = i.user_id
LEFT JOIN books b ON i.book_id = b.book_id;

-- RIGHT JOIN
SELECT u.username, b.title
FROM user2 u
RIGHT JOIN Issue i ON u.user_id = i.user_id
RIGHT JOIN books b ON i.book_id = b.book_id;

-- FULL OUTER JOIN (Simulated with UNION)
SELECT u.username, b.title
FROM user2 u
LEFT JOIN Issue i ON u.user_id = i.user_id
LEFT JOIN books b ON i.book_id = b.book_id

UNION

SELECT u.username, b.title
FROM user2 u
RIGHT JOIN Issue i ON u.user_id = i.user_id
RIGHT JOIN books b ON i.book_id = b.book_id;

-- CROSS JOIN
SELECT u.username, b.title
FROM user2 u
CROSS JOIN books b;

-- Normalization Demonstrations
-- 2NF: Issue table
SELECT issue_id, user_id, book_id, issue_date, return_date, extended
FROM Issue;

-- 3NF: user2 table
SELECT user_id, username, email, password_hash, age, created_at
FROM user2;

-- BCNF: books table
SELECT book_id, title, author, genre, age, description, cover_image_url, created_at
FROM books;
