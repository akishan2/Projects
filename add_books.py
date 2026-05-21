import mysql.connector

new_books = [
    (
        "1984", 
        "George Orwell", 
        299.00, 
        "Science Fiction", 
        "https://covers.openlibrary.org/b/isbn/9780451524935-L.jpg", 
        "Among the seminal texts of the 20th century, Nineteen Eighty-Four is a rare work that grows more haunting as its futuristic purgatory becomes more real."
    ),
    (
        "The Great Gatsby", 
        "F. Scott Fitzgerald", 
        250.00, 
        "Classic", 
        "https://covers.openlibrary.org/b/isbn/9780743273565-L.jpg", 
        "The story of the fabulously wealthy Jay Gatsby and his love for the beautiful Daisy Buchanan, of lavish parties on Long Island at a time when The New York Times noted 'gin was the national drink and sex the national obsession.'"
    ),
    (
        "Dune", 
        "Frank Herbert", 
        450.00, 
        "Science Fiction", 
        "https://covers.openlibrary.org/b/isbn/9780441172719-L.jpg", 
        "Set on the desert planet Arrakis, Dune is the story of the boy Paul Atreides, heir to a noble family tasked with ruling an inhospitable world where the only thing of value is the 'spice' melange."
    ),
    (
        "Thinking, Fast and Slow", 
        "Daniel Kahneman", 
        600.00, 
        "Psychology", 
        "https://covers.openlibrary.org/b/isbn/9780374533557-L.jpg", 
        "The phenomenal New York Times Bestseller by Nobel Prize-winner Daniel Kahneman. The book takes us on a groundbreaking tour of the mind and explains the two systems that drive the way we think."
    )
]

try:
    conn = mysql.connector.connect(host="127.0.0.1", user="root", password="036189@2", database="bookspace_db")
    cursor = conn.cursor()
    
    query = "INSERT INTO Books (title, author, price, genre, cover_image_url, long_description) VALUES (%s, %s, %s, %s, %s, %s)"
    
    for book in new_books:
        cursor.execute(query, book)
        
    conn.commit()
    print("Successfully added new books to the database!")
except Exception as e:
    print("Error:", e)
finally:
    if 'cursor' in locals(): cursor.close()
    if 'conn' in locals(): conn.close()
