--create database
CREATE DATABASE onlinebookstore
--create table 
DROP TABLE IF EXISTS Books;
CREATE TABLE Books(
   Book_id SERIAL PRIMARY KEY,
   Title VARCHAR(100),
   Author VARCHAR(100),
   Genre VARCHAR(50),
   Published_Year INT,
   Price NUMERIC (10,2),
   Stock INT
);

--CUSTOMERS TABLE
DROP TABLE IF EXISTS Customers;
Create table Customers(
   Customer_id SERIAL PRIMARY KEY,
   NAME VARCHAR(100),
   EMAIL VARCHAR(100),
   PHONE VARCHAR(100),
   CITY VARCHAR(100),
   COUNTRY VARCHAR(100)
);

---CREATE ORDERS TABLE 
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders(
     Order_id SERIAL PRIMARY KEY,
	 CUSTOMER_ID INT REFERENCES Customers(Customer_id),
	 book_id INT REFERENCES Books(Book_id),
	 Order_Date DATE,
	 Quantity INT ,
	 Total_Amount NUMERIC(10,2)

);

SELECT* FROM Books;
SELECT*FROM Customers;
SELECT*FROM Orders;

--import data from files into book table--
COPY Books(Book_ID,Title,Author,Genre,Published_Year,Price,Stock)
FROM C: /Users/Lenovo/Downloads/ST - SQL ALL PRACTICE FILES/All Excel Practice Files
CSV HEADER;
--SHOWING ERROR IN LOADING THE DATA THROUGH THIS METHOD SO USED DIRECT
--METHOD BY CLICKING RIGHT CLICK ON BOOKS AND IMPORTING DATA DIRECLTY

--1) Retrive all the books in the "FICTION" Ggnre:
SELECT * FROM Books
WHERE genre='Fiction';

--2) Find books published after the year1950:
SELECT * FROM Books 
WHERE published_year>1950;

--3) List all customers from canada:
SELECT * FROM Customers
WHERE Country='Canada';

--4) Show orders placed in november 2023:
SELECT * FROM Orders
WHERE Order_date BETWEEN '2023-11-1' AND '2023-11-30';

--5) Retrive the total stocks of books available:
SELECT SUM(stock) as total_stock FROM Books;

--6) Find details of most expensive book:
SELECT * FROM Books
ORDER BY price DESC
LIMIT 1;

--7) Show all the customers who ordered more than one quantity of book:
SELECT * FROM orders
WHERE quantity>1;

--8) Retrive all the orders where the total amount exceeds $20;
SELECT * FROM orders
WHERE total_amount>20;

--9) List all genre available in the book table:
SELECT DISTINCT genre FROM Books;

--10) Find the book with lowest stock:
SELECT *FROM Books
ORDER BY stock asc
LIMIT 1;

--11) Calculate the  total revenue genrated from all the orders:
SELECT SUM(total_amount) AS total_revenue
FROM orders;

--ADVANCE QUESTIONS
-- 1) Retrieve the total number of books sold for each genre:
SELECT * FROM Orders;

SELECT  DISTINCT b.genre, SUM(O.Quantity) AS total_sold
FROM orders o
JOIN Books b ON o.book_id=b.book_id
Group by b.genre
ORDER BY total_sold desc;

-- 2) Find the average price of books in the "Fantasy" genre:
SELECT AVG(price) AS average_price FROM Books
WHERE genre='Fantasy';

SELECT* FROM BOOKS;

-- 3) List customers who have placed at least 2 orders:
SELECT* FROM CUSTOMERS;
SELECT * FROM ORDERS;

SELECT C.customer_id,c.name, COUNT(o.order_id) AS Total_orders
FROM orders o
JOIN customers c ON c.customer_id=o.customer_id
GROUP BY C.Customer_id, c.name
HAVING COUNT(O.ORDER_ID)>=2;


-- 4) Find the most frequently ordered book:
SELECT * FROM books;
SELECT * FROM ORDERS;

SELECT B.book_id,B.title,COUNT(O.order_id) AS total_orders
FROM ORDERS O
JOIN books b ON b.book_id=o.book_id
GROUP BY b.book_id, b.title
ORDER BY total_orders desc limit 1;
-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT * FROM Books;

SELECT * FROM books 
WHERE Genre='Fantasy'
Order by price desc limit 3;


-- 6) Retrieve the total quantity of books sold by each author:
SELECT * FROM Books;
SELECT * FROM orders;

SELECT b.author, SUM(O.quantity) AS total_book_sold
FROM orders o
JOIN BOOKS B ON b.book_id=o.book_id
GROUP BY b.author;


-- 7) List the cities where customers who spent over $30 are located:
SELECT * FROM customers;
SElect * FROM orders;

SELECT DISTINCT c.name , c.city ,o.total_amount
FROM ORDERS O 
JOIN customers c ON c.customer_id=o.customer_id
WHERE o.total_amount>30;


-- 8) Find the customer who spent the most on orders:
SELECT*FROM CUSTOMERS;
SELECT* FROM ORDERS;

SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_spent
FROM orders o 
JOIN customers c ON c.customer_id=o.customer_id
GROUP BY c.customer_id, c.name 
ORDER BY total_spent desc LIMIT 1;
--9) Calculate the stock remaining after fulfilling all orders:
SELECT *FROM Books;
SELECT * FROM orders;

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;


   

