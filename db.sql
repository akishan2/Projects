DROP DATABASE IF EXISTS bookspace_db;
CREATE DATABASE bookspace_db;
USE bookspace_db;

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL
);

CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    genre VARCHAR(100),
    cover_image_url VARCHAR(500),
    long_description TEXT
);

CREATE TABLE Cart (
    cart_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    book_id INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

INSERT INTO Books (title, author, price, genre, cover_image_url, long_description) VALUES 
('The Hobbit', 'J.R.R. Tolkien', 499, 'Fantasy', 'https://m.media-amazon.com/images/I/710+HcoP38L.jpg', 'A great adventure in Middle-earth. Bilbo Baggins is swept into a quest to reclaim the lost Dwarf Kingdom of Erebor from the fearsome dragon Smaug.'),
('Project Hail Mary', 'Andy Weir', 599, 'Science Fiction', 'https://m.media-amazon.com/images/I/81wd66Y9uOL.jpg', 'A lone astronaut must save humanity from an extinction-level threat. Ryland Grace is the sole survivor on a desperate, last-chance mission.'),
('The Alchemist', 'Paulo Coelho', 320, 'Fantasy', 'https://m.media-amazon.com/images/I/71aFt4+OTOL.jpg', 'A magical story about an Andalusian shepherd boy who yearns to travel in search of a worldly treasure. His quest will lead him to riches far different—and far more satisfying—than he ever imagined.'),
('Atomic Habits', 'James Clear', 480, 'Self-Help', 'https://m.media-amazon.com/images/I/91bYsX41DVL.jpg', 'No matter your goals, Atomic Habits offers a proven framework for improving—every day. James Clear reveals exactly how to form good habits and break bad ones.'),
('1984', 'George Orwell', 299.00, 'Science Fiction', 'https://covers.openlibrary.org/b/isbn/9780451524935-L.jpg', 'Among the seminal texts of the 20th century, Nineteen Eighty-Four is a rare work that grows more haunting as its futuristic purgatory becomes more real.'),
('The Great Gatsby', 'F. Scott Fitzgerald', 250.00, 'Classic', 'https://covers.openlibrary.org/b/isbn/9780743273565-L.jpg', 'The story of the fabulously wealthy Jay Gatsby and his love for the beautiful Daisy Buchanan, of lavish parties.'),
('Dune', 'Frank Herbert', 450.00, 'Science Fiction', 'https://covers.openlibrary.org/b/isbn/9780441172719-L.jpg', 'Set on the desert planet Arrakis, Dune is the story of the boy Paul Atreides, heir to a noble family tasked with ruling an inhospitable world.'),
('Thinking, Fast and Slow', 'Daniel Kahneman', 600.00, 'Psychology', 'https://covers.openlibrary.org/b/isbn/9780374533557-L.jpg', 'The phenomenal New York Times Bestseller by Nobel Prize-winner Daniel Kahneman. The book takes us on a groundbreaking tour of the mind.'),
('To Kill a Mockingbird', 'Harper Lee', 350.00, 'Classic', 'https://covers.openlibrary.org/b/isbn/9780060935467-L.jpg', 'The unforgettable novel of a childhood in a sleepy Southern town and the crisis of conscience that rocked it, To Kill A Mockingbird became both an instant bestseller and a critical success when it was first published in 1960.'),
('The Catcher in the Rye', 'J.D. Salinger', 300.00, 'Classic', 'https://covers.openlibrary.org/b/isbn/9780316769488-L.jpg', 'The hero-narrator of The Catcher in the Rye is an ancient child of sixteen, a native New Yorker named Holden Caulfield.'),
('The Lord of the Rings', 'J.R.R. Tolkien', 799.00, 'Fantasy', 'https://covers.openlibrary.org/b/isbn/9780544003415-L.jpg', 'One Ring to rule them all, One Ring to find them, One Ring to bring them all and in the darkness bind them.'),
('The Martian', 'Andy Weir', 550.00, 'Science Fiction', 'https://covers.openlibrary.org/b/isbn/9780804139021-L.jpg', 'Six days ago, astronaut Mark Watney became one of the first people to walk on Mars. Now, he is sure he will be the first person to die there.'),
('Harry Potter and the Sorcerer\'s Stone', 'J.K. Rowling', 499.00, 'Fantasy', 'https://covers.openlibrary.org/b/isbn/9780590353427-L.jpg', 'Harry Potter has never even heard of Hogwarts when the letters start dropping on the doormat at number four, Privet Drive.'),
,
('A town like Alice', 'Nevil Shute', 368.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/489833-L.jpg', 'A highly acclaimed work by Nevil Shute. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('How to live on 24 hours a day', 'Arnold Bennett', 322.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/1760143-L.jpg', 'A highly acclaimed work by Arnold Bennett. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('Think and Grow Rich', 'Napoleon Hill', 288.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/14542536-L.jpg', 'A highly acclaimed work by Napoleon Hill. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('Pollyanna', 'Eleanor Hodgman Porter', 666.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/902113-L.jpg', 'A highly acclaimed work by Eleanor Hodgman Porter. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('La sombra del viento', 'Carlos Ruiz Zafón', 366.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/10107644-L.jpg', 'A highly acclaimed work by Carlos Ruiz Zafón. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('Lilith', 'George MacDonald', 723.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/14364546-L.jpg', 'A highly acclaimed work by George MacDonald. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('Fifty Shades of Grey', 'E. L. James', 339.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/12648183-L.jpg', 'A highly acclaimed work by E. L. James. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('The Good Earth', 'Pearl S. Buck', 382.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/2626823-L.jpg', 'A highly acclaimed work by Pearl S. Buck. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('The Night Before Christmas', 'Clement Clarke Moore', 213.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/8236410-L.jpg', 'A highly acclaimed work by Clement Clarke Moore. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('Howards End', 'E. M. Forster', 317.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/8235207-L.jpg', 'A highly acclaimed work by E. M. Forster. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('The Richest Man in Babylon', 'George S. Clason', 389.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/10491331-L.jpg', 'A highly acclaimed work by George S. Clason. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('Orthodoxy', 'Gilbert Keith Chesterton', 381.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/6268135-L.jpg', 'A highly acclaimed work by Gilbert Keith Chesterton. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('The master key system in twenty-four parts with questionnaire and glossary', 'Charles F. Haanel', 261.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/7308093-L.jpg', 'A highly acclaimed work by Charles F. Haanel. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('Anne of the Island', 'Lucy Maud Montgomery', 732.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/14639028-L.jpg', 'A highly acclaimed work by Lucy Maud Montgomery. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('As a man thinketh', 'James Allen', 165.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/6268048-L.jpg', 'A highly acclaimed work by James Allen. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('Le petit prince', 'Antoine de Saint-Exupéry', 729.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/10708272-L.jpg', 'A highly acclaimed work by Antoine de Saint-Exupéry. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('The Prophet', 'Kahlil Gibran', 617.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/418324-L.jpg', 'A highly acclaimed work by Kahlil Gibran. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('The Castle of Otranto', 'Horace Walpole', 500.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/6468730-L.jpg', 'A highly acclaimed work by Horace Walpole. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('The science of getting rich, or, financial success through creative thought', 'Wallace D. Wattles', 672.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/854989-L.jpg', 'A highly acclaimed work by Wallace D. Wattles. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('The Jungle', 'Upton Sinclair', 765.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/8231790-L.jpg', 'A highly acclaimed work by Upton Sinclair. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('The Two Towers', 'J.R.R. Tolkien', 750.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/14627564-L.jpg', 'A highly acclaimed work by J.R.R. Tolkien. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('The Fellowship of the Ring', 'J.R.R. Tolkien', 465.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/14627060-L.jpg', 'A highly acclaimed work by J.R.R. Tolkien. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('The Return of the King', 'J.R.R. Tolkien', 457.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/14627062-L.jpg', 'A highly acclaimed work by J.R.R. Tolkien. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('The Adventures of Sherlock Holmes [12 stories]', 'Arthur Conan Doyle', 577.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/6717853-L.jpg', 'A highly acclaimed work by Arthur Conan Doyle. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('The Legend of Sleepy Hollow', 'Washington Irving', 207.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/8243083-L.jpg', 'A highly acclaimed work by Washington Irving. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('The Wonderful Wizard of Oz', 'L. Frank Baum', 196.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/552443-L.jpg', 'A highly acclaimed work by L. Frank Baum. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('Romeo and Juliet', 'William Shakespeare', 201.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/8257991-L.jpg', 'A highly acclaimed work by William Shakespeare. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('Breaking Dawn', 'Stephenie Meyer', 493.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/12643419-L.jpg', 'A highly acclaimed work by Stephenie Meyer. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('The Pillars of the Earth', 'Ken Follett', 532.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/9269909-L.jpg', 'A highly acclaimed work by Ken Follett. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('Gulliver''s Travels', 'Jonathan Swift', 491.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/12717083-L.jpg', 'A highly acclaimed work by Jonathan Swift. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('A Tale of Two Cities', 'Charles Dickens', 754.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/13301713-L.jpg', 'A highly acclaimed work by Charles Dickens. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('Angela''s Ashes', 'Frank McCourt', 740.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/8231802-L.jpg', 'A highly acclaimed work by Frank McCourt. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('Ender''s Game', 'Orson Scott Card', 326.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/12996033-L.jpg', 'A highly acclaimed work by Orson Scott Card. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('Dune', 'Frank Herbert', 768.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/11481354-L.jpg', 'A highly acclaimed work by Frank Herbert. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('Beloved', 'Toni Morrison', 607.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/8261367-L.jpg', 'A highly acclaimed work by Toni Morrison. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('Pride and Prejudice', 'Jane Austen', 550.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/14348537-L.jpg', 'A highly acclaimed work by Jane Austen. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('The Picture of Dorian Gray', 'Oscar Wilde', 590.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/14314858-L.jpg', 'A highly acclaimed work by Oscar Wilde. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('The Book Thief', 'Markus Zusak', 319.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/8153054-L.jpg', 'A highly acclaimed work by Markus Zusak. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('Life of Pi', 'Yann Martel', 624.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/12840573-L.jpg', 'A highly acclaimed work by Yann Martel. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('The Kite Runner', 'Khaled Hosseini', 406.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/14846827-L.jpg', 'A highly acclaimed work by Khaled Hosseini. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('Catching Fire', 'Suzanne Collins', 693.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/12646539-L.jpg', 'A highly acclaimed work by Suzanne Collins. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('The Lightning Thief', 'Rick Riordan', 450.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/7239831-L.jpg', 'A highly acclaimed work by Rick Riordan. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('The Lost Symbol', 'Dan Brown', 731.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/8373389-L.jpg', 'A highly acclaimed work by Dan Brown. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('O Alquimista', 'Paulo Coelho', 348.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/7414780-L.jpg', 'A highly acclaimed work by Paulo Coelho. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('The Hunger Games', 'Suzanne Collins', 565.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/12646537-L.jpg', 'A highly acclaimed work by Suzanne Collins. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('Twilight', 'Stephenie Meyer', 152.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/12641977-L.jpg', 'A highly acclaimed work by Stephenie Meyer. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('The BFG', 'Roald Dahl', 630.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/9176033-L.jpg', 'A highly acclaimed work by Roald Dahl. This book explores fascinating themes of literature/fiction and has captivated readers globally.'),
('The Handmaid''s Tale', 'Margaret Atwood', 759.99, 'Literature/Fiction', 'https://covers.openlibrary.org/b/id/8231851-L.jpg', 'A highly acclaimed work by Margaret Atwood. This book explores fascinating themes of literature/fiction and has captivated readers globally.');
