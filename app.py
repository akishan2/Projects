from flask import Flask, render_template, request, redirect, url_for, session, flash
import mysql.connector

app = Flask(__name__)
app.secret_key = 'bookspace_secret_key'
CHATBOT_API_KEY = "bkspc-live-8a9d3c2b1f"

def get_db_connection():
   return mysql.connector.connect(
       host="127.0.0.1",
       user="root",
       password="036189@2",
       database="bookspace_db"
   )

@app.route('/')
def index():
   search_query = request.args.get('search')
   genre_filter = request.args.get('genre')
   conn = get_db_connection()
   cursor = conn.cursor(dictionary=True)
  
   if search_query:
       cursor.execute("SELECT * FROM Books WHERE title LIKE %s OR author LIKE %s", (f'%{search_query}%', f'%{search_query}%'))
   elif genre_filter:
       cursor.execute("SELECT * FROM Books WHERE genre = %s", (genre_filter,))
   else:
       cursor.execute("SELECT * FROM Books")
   books = cursor.fetchall()

   cursor.execute("SELECT DISTINCT genre FROM Books ORDER BY genre")
   genres = [row['genre'] for row in cursor.fetchall()]

   cart_count = 0
   if 'user_id' in session:
       cursor.execute("SELECT COUNT(*) as count FROM Cart WHERE user_id = %s", (session['user_id'],))
       cart_count = cursor.fetchone()['count']
   cursor.close()
   conn.close()
   # Note: Pass the search_query and results_found so the API can use it
   results_found = True if books else False
   return render_template('index.html', books=books, cart_count=cart_count, genres=genres, search_query=search_query, results_found=results_found)

@app.route('/register', methods=['GET', 'POST'])
def register():
   if request.method == 'POST':
       fname = request.form['first_name']
       email = request.form['email']
       password = request.form['password']
       conn = get_db_connection()
       cursor = conn.cursor()
       try:
           cursor.execute("INSERT INTO Users (first_name, email, password_hash) VALUES (%s, %s, %s)", (fname, email, password))
           conn.commit()
           flash("Account created! Log in with your email.", "success")
           return redirect(url_for('login'))
       except:
           flash("Error: Email already exists.", "danger")
       finally:
           cursor.close()
           conn.close()
   return render_template('register.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
   if request.method == 'POST':
       email = request.form['email']
       password = request.form['password']
       conn = get_db_connection()
       cursor = conn.cursor(dictionary=True)
       cursor.execute("SELECT * FROM Users WHERE email = %s AND password_hash = %s", (email, password))
       user = cursor.fetchone()
       cursor.close()
       conn.close()
       if user:
           session['user_id'] = user['user_id']
           session['username'] = user['first_name']
           return redirect(url_for('index'))
       else:
           flash("Invalid email or password!", "danger")
   return render_template('login.html')

@app.route('/cart')
def cart():
   if 'user_id' not in session: return redirect(url_for('login'))
   conn = get_db_connection()
   cursor = conn.cursor(dictionary=True)
   cursor.execute("SELECT Books.*, Cart.cart_id FROM Books JOIN Cart ON Books.book_id = Cart.book_id WHERE Cart.user_id = %s", (session['user_id'],))
   items = cursor.fetchall()
   total = sum(item['price'] for item in items)
   cursor.close()
   conn.close()
   return render_template('cart.html', items=items, total=total)

@app.route('/payment')
def payment():
   if 'user_id' not in session: return redirect(url_for('login'))
   total = request.args.get('total', 0)
   return render_template('payment.html', total=total)

@app.route('/process_payment', methods=['POST'])
def process_payment():
   if 'user_id' not in session: return redirect(url_for('login'))
   conn = get_db_connection()
   cursor = conn.cursor()
   cursor.execute("DELETE FROM Cart WHERE user_id = %s", (session['user_id'],))
   conn.commit()
   cursor.close()
   conn.close()
   flash("Payment Successful! Books ordered.", "success")
   return redirect(url_for('index'))

@app.route('/add_to_cart/<int:book_id>')
def add_to_cart(book_id):
   if 'user_id' not in session:
       flash("Login to add items!", "warning")
       return redirect(url_for('login'))
   conn = get_db_connection()
   cursor = conn.cursor()
   cursor.execute("INSERT INTO Cart (user_id, book_id) VALUES (%s, %s)", (session['user_id'], book_id))
   conn.commit()
   cursor.close()
   conn.close()
   flash("Added to cart successfully!", "success")
   return redirect(url_for('index'))

# NEW FUNCTION: Handles "Buy Now" - adds to cart and redirects to payment
@app.route('/buy_now/<int:book_id>')
def buy_now(book_id):
   if 'user_id' not in session:
       return redirect(url_for('login'))
   conn = get_db_connection()
   cursor = conn.cursor(dictionary=True)
   # Add to cart first
   cursor.execute("INSERT INTO Cart (user_id, book_id) VALUES (%s, %s)", (session['user_id'], book_id))
   # Get price for payment page
   cursor.execute("SELECT price FROM Books WHERE book_id = %s", (book_id,))
   book = cursor.fetchone()
   conn.commit()
   cursor.close()
   conn.close()
   # Redirect straight to payment with the price
   return redirect(url_for('payment', total=book['price']))

@app.route('/remove_from_cart/<int:cart_id>')
def remove_from_cart(cart_id):
   conn = get_db_connection()
   cursor = conn.cursor()
   cursor.execute("DELETE FROM Cart WHERE cart_id = %s", (cart_id,))
   conn.commit()
   cursor.close()
   conn.close()
   return redirect(url_for('cart'))

@app.route('/logout')
def logout():
   session.clear()
   return redirect(url_for('index'))

@app.route('/book/<int:book_id>')
def book_detail(book_id):
   conn = get_db_connection()
   cursor = conn.cursor(dictionary=True)
   cursor.execute("SELECT * FROM Books WHERE book_id = %s", (book_id,))
   book = cursor.fetchone()
   cursor.close()
   conn.close()
   if book:
       return render_template('book_detail.html', book=book)
   return "Book not found", 404

@app.route('/log_click', methods=['POST'])
def log_click():
    data = request.get_json()
    if data:
        el_type = data.get('element_type', 'UNKNOWN')
        txt = data.get('click_text', '')
        page_url = data.get('page_url', 'Unknown Page')
        
        user = session.get('username', 'Anonymous User')
        
        # ANSI Escape Codes for glorious terminal coloring
        CYAN = '\033[96m'
        GREEN = '\033[92m'
        YELLOW = '\033[93m'
        RESET = '\033[0m'
        
        if el_type == "PAGE LOAD":
            print(f"{CYAN}➜ [TRACKER] {GREEN}{user}{CYAN} landed on page: {YELLOW}{page_url}{RESET}")
        else:
            print(f"{CYAN}➜ [TRACKER] {GREEN}{user}{CYAN} clicked {el_type} {YELLOW}\"{txt}\"{CYAN} on page '{page_url}'{RESET}")
            
    return {"status": "ok"}

@app.route('/chatbot', methods=['POST'])
def chatbot():
    api_key = request.headers.get('x-api-key')
    if api_key != CHATBOT_API_KEY:
        return {"error": "Unauthorized Access: Invalid or missing API key."}, 401
        
    data = request.get_json()
    if not data or 'message' not in data:
        return {"reply": "Sorry, I didn't get that."}
        
    user_msg = data['message'].lower().strip()
    
    # Simple Intent Routing
    if user_msg in ['hi', 'hello', 'hey', 'help', 'hi there']:
        reply = "Hello! I'm the BookSpace Bot. I can help you find books or provide info on payments. What are you looking for?"
    elif any(word in user_msg for word in ['pay', 'payment', 'card', 'upi', 'checkout', 'buy']):
        reply = "We accept Credit/Debit cards (16 digits, MM/YY, CVV) and UPI (like PhonePe, GPay) securely on our checkout page. Just add a book to your cart and hit Buy Now!"
    elif any(word in user_msg for word in ['shipping', 'delivery', 'time']):
        reply = "We typically deliver books within 3-5 business days depending on your location."
    else:
        # Assume it's a book search query
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        # Clean up common conversational words for better SQL LIKE matching
        clean_search = user_msg.replace('do you have', '').replace('looking for', '').replace('i want', '').replace('book', '').replace('?', '').strip()
        if not clean_search:
            clean_search = user_msg # fallback
            
        cursor.execute("SELECT * FROM Books WHERE title LIKE %s OR author LIKE %s OR genre LIKE %s LIMIT 3", (f'%{clean_search}%', f'%{clean_search}%', f'%{clean_search}%'))
        books = cursor.fetchall()
        cursor.close()
        conn.close()
        
        if books:
            reply = "I found these matches in our store:<br><br>"
            for b in books:
                reply += f"📚 <a href='/book/{b['book_id']}' style='color:#ff9900'><strong>{b['title']}</strong></a> by {b['author']} - ₹{b['price']}<br>"
            reply += "<br>Click the titles to view more details!"
        else:
            reply = f"I couldn't find exactly what you were looking for. Feel free to use the main search bar on the home page!"
            
    return {"reply": reply}

if __name__ == '__main__':
   app.run(debug=True, port=5001)
