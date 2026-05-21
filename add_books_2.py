import mysql.connector

new_books = [
    (
        "To Kill a Mockingbird", 
        "Harper Lee", 
        350.00, 
        "Classic", 
        "https://covers.openlibrary.org/b/isbn/9780060935467-L.jpg", 
        "The unforgettable novel of a childhood in a sleepy Southern town and the crisis of conscience that rocked it, To Kill A Mockingbird became both an instant bestseller and a critical success when it was first published in 1960."
    ),
    (
        "The Catcher in the Rye", 
        "J.D. Salinger", 
        300.00, 
        "Classic", 
        "https://covers.openlibrary.org/b/isbn/9780316769488-L.jpg", 
        "The hero-narrator of The Catcher in the Rye is an ancient child of sixteen, a native New Yorker named Holden Caulfield. Through circumstances that tend to preclude adult, secondhand description, he leaves his prep school in Pennsylvania and goes underground in New York City for three days."
    ),
    (
        "The Lord of the Rings", 
        "J.R.R. Tolkien", 
        799.00, 
        "Fantasy", 
        "https://covers.openlibrary.org/b/isbn/9780544003415-L.jpg", 
        "One Ring to rule them all, One Ring to find them, One Ring to bring them all and in the darkness bind them. In ancient times the Rings of Power were crafted by the Elven-smiths, and Sauron, the Dark Lord, forged the One Ring, filling it with his own power."
    ),
    (
        "The Martian", 
        "Andy Weir", 
        550.00, 
        "Science Fiction", 
        "https://covers.openlibrary.org/b/isbn/9780804139021-L.jpg", 
        "Six days ago, astronaut Mark Watney became one of the first people to walk on Mars. Now, he's sure he'll be the first person to die there. After a dust storm nearly kills him and forces his crew to evacuate while thinking him dead, Mark finds himself stranded and completely alone with no way to even signal Earth that he’s alive."
    ),
    (
        "Harry Potter and the Sorcerer's Stone", 
        "J.K. Rowling", 
        499.00, 
        "Fantasy", 
        "https://covers.openlibrary.org/b/isbn/9780590353427-L.jpg", 
        "Harry Potter has never even heard of Hogwarts when the letters start dropping on the doormat at number four, Privet Drive. Addressed in green ink on yellowish parchment with a purple seal, they are swiftly confiscated by his grisly aunt and uncle."
    )
]

try:
    conn = mysql.connector.connect(host="127.0.0.1", user="root", password="036189@2", database="bookspace_db")
    cursor = conn.cursor()
    
    query = "INSERT INTO Books (title, author, price, genre, cover_image_url, long_description) VALUES (%s, %s, %s, %s, %s, %s)"
    
    for book in new_books:
        cursor.execute(query, book)
        
    conn.commit()
    print("Successfully added MORE new books to the database!")
except Exception as e:
    print("Error:", e)
finally:
    if 'cursor' in locals(): cursor.close()
    if 'conn' in locals(): conn.close()
